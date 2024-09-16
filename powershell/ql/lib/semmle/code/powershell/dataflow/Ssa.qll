/**
 * Provides the module `Ssa` for working with static single assignment (SSA) form.
 */

/**
 * Provides classes for working with static single assignment (SSA) form.
 */
module Ssa {
  private import semmle.code.powershell.Cfg
  private import powershell
  private import internal.SsaImpl as SsaImpl
  private import CfgNodes::ExprNodes

  /** A static single assignment (SSA) definition. */
  class Definition extends SsaImpl::Definition {
    /**
     * Gets the control flow node of this SSA definition, if any. Phi nodes are
     * examples of SSA definitions without a control flow node, as they are
     * modeled at index `-1` in the relevant basic block.
     */
    final CfgNode getControlFlowNode() {
      exists(BasicBlock bb, int i | this.definesAt(_, bb, i) | result = bb.getNode(i))
    }

    /** Gets a control-flow node that reads the value of this SSA definition. */
    final VarReadAccessCfgNode getARead() { result = SsaImpl::getARead(this) }

    /**
     * Gets a first control-flow node that reads the value of this SSA definition.
     * That is, a read that can be reached from this definition without passing
     * through other reads.
     */
    final VarReadAccessCfgNode getAFirstRead() { SsaImpl::firstRead(this, result) }

    /**
     * Gets a last control-flow node that reads the value of this SSA definition.
     * That is, a read that can reach the end of the enclosing CFG scope, or another
     * SSA definition for the source variable, without passing through any other read.
     */
    final VarReadAccessCfgNode getALastRead() { SsaImpl::lastRead(this, result) }

    /**
     * Holds if `read1` and `read2` are adjacent reads of this SSA definition.
     * That is, `read2` can be reached from `read1` without passing through
     * another read.
     */
    final predicate hasAdjacentReads(
      VarReadAccessCfgNode read1, VarReadAccessCfgNode read2
    ) {
      SsaImpl::adjacentReadPair(this, read1, read2)
    }

    /**
     * Gets an SSA definition whose value can flow to this one in one step. This
     * includes inputs to phi nodes and the prior definitions of uncertain writes.
     */
    private Definition getAPhiInputOrPriorDefinition() { result = this.(PhiNode).getAnInput() }

    /**
     * Gets a definition that ultimately defines this SSA definition and is
     * not itself a phi node.
     */
    final Definition getAnUltimateDefinition() {
      result = this.getAPhiInputOrPriorDefinition*() and
      not result instanceof PhiNode
    }

    override string toString() { result = this.getControlFlowNode().toString() }

    /** Gets the scope of this SSA definition. */
    CfgScope getScope() { result = this.getBasicBlock().getScope() }
  }

  /**
   * An SSA definition that corresponds to a write.
   */
  class WriteDefinition extends Definition, SsaImpl::WriteDefinition {
    private VarWriteAccessCfgNode write;

    WriteDefinition() {
      exists(BasicBlock bb, int i, Variable v |
        this.definesAt(v, bb, i) and
        SsaImpl::variableWriteActual(bb, i, v, write)
      )
    }

    /** Gets the underlying write access. */
    final VarWriteAccessCfgNode getWriteAccess() { result = write }

    /**
     * Holds if this SSA definition assigns `value` to the underlying variable.
     */
    predicate assigns(CfgNodes::StmtCfgNode value) {
      exists(CfgNodes::StmtNodes::AssignStmtCfgNode a, BasicBlock bb, int i |
        this.definesAt(_, bb, i) and
        a = bb.getNode(i) and
        value = a.getRightHandSide()
      )
    }

    final override string toString() { result = write.toString() }

    final override Location getLocation() { result = write.getLocation() }
  }

  class ParameterDefinition extends Definition, SsaImpl::WriteDefinition {
    private Variable v;

    ParameterDefinition() {
      exists(BasicBlock bb, int i |
        this.definesAt(v, bb, i) and
        SsaImpl::parameterWrite(bb, i, v)
      )
    }

    final override string toString() { result = "<parameter> " + v }

    final override Location getLocation() { result = v.getLocation() }
  }

  /**
   * An SSA definition inserted at the beginning of a scope to represent an
   * uninitialized local variable.
   */
  class UninitializedDefinition extends Definition, SsaImpl::WriteDefinition {
    private Variable v;

    UninitializedDefinition() {
      exists(BasicBlock bb, int i |
        this.definesAt(v, bb, i) and
        SsaImpl::uninitializedWrite(bb, i, v)
      )
    }

    final override string toString() { result = "<uninitialized> " + v }

    final override Location getLocation() { result = this.getBasicBlock().getLocation() }
  }

  /** A phi node. */
  class PhiNode extends Definition, SsaImpl::PhiNode {
    /** Gets an input of this phi node. */
    final Definition getAnInput() { this.hasInputFromBlock(result, _) }

    /** Holds if `inp` is an input to this phi node along the edge originating in `bb`. */
    predicate hasInputFromBlock(Definition inp, BasicBlock bb) {
      inp = SsaImpl::phiHasInputFromBlock(this, bb)
    }

    override string toString() { result = "phi" }

    /**
     * The location of a phi node is the same as the location of the first node
     * in the basic block in which it is defined.
     *
     * Strictly speaking, the node is *before* the first node, but such a location
     * does not exist in the source program.
     */
    final override Location getLocation() {
      result = this.getBasicBlock().getFirstNode().getLocation()
    }
  }
}
