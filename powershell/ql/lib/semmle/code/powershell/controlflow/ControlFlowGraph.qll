/** Provides classes representing the control flow graph. */

private import powershell
private import BasicBlocks
private import SuccessorTypes
private import internal.ControlFlowGraphImpl as CfgImpl
private import internal.Splitting as Splitting
private import internal.Completion
private import internal.Scope

/**
 * An AST node with an associated control-flow graph.
 *
 * Top-levels, methods, blocks, and lambdas are all CFG scopes.
 *
 * Note that module declarations are not themselves CFG scopes, as they are part of
 * the CFG of the enclosing top-level or callable.
 */
class CfgScope extends Scope instanceof CfgImpl::CfgScope { }

/**
 * A control flow node.
 *
 * A control flow node is a node in the control flow graph (CFG). There is a
 * many-to-one relationship between CFG nodes and AST nodes.
 *
 * Only nodes that can be reached from an entry point are included in the CFG.
 */
class CfgNode extends CfgImpl::Node {
  /** Gets the name of the primary QL class for this node. */
  string getAPrimaryQlClass() { none() }

  /** Gets the file of this control flow node. */
  final File getFile() { result = this.getLocation().getFile() }

  /** DEPRECATED: Use `getAstNode` instead. */
  deprecated Ast getNode() { result = this.getAstNode() }

  /** Gets a successor node of a given type, if any. */
  final CfgNode getASuccessor(SuccessorType t) { result = super.getASuccessor(t) }

  /** Gets an immediate successor, if any. */
  final CfgNode getASuccessor() { result = this.getASuccessor(_) }

  /** Gets an immediate predecessor node of a given flow type, if any. */
  final CfgNode getAPredecessor(SuccessorType t) { result.getASuccessor(t) = this }

  /** Gets an immediate predecessor, if any. */
  final CfgNode getAPredecessor() { result = this.getAPredecessor(_) }

  /** Gets the basic block that this control flow node belongs to. */
  BasicBlock getBasicBlock() { result.getANode() = this }
}

/** The type of a control flow successor. */
class SuccessorType extends CfgImpl::TSuccessorType {
  /** Gets a textual representation of successor type. */
  string toString() { none() }
}

/** Provides different types of control flow successor types. */
module SuccessorTypes {
  /** A normal control flow successor. */
  class NormalSuccessor extends SuccessorType, CfgImpl::TSuccessorSuccessor {
    final override string toString() { result = "successor" }
  }

  /**
   * A conditional control flow successor. Either a Boolean successor (`BooleanSuccessor`)
   * or a matching successor (`MatchingSuccessor`)
   */
  class ConditionalSuccessor extends SuccessorType {
    boolean value;

    ConditionalSuccessor() { this = CfgImpl::TBooleanSuccessor(value) }

    /** Gets the Boolean value of this successor. */
    final boolean getValue() { result = value }

    override string toString() { result = this.getValue().toString() }
  }

  class BooleanSuccessor extends ConditionalSuccessor, CfgImpl::TBooleanSuccessor { }

  class ReturnSuccessor extends SuccessorType, CfgImpl::TReturnSuccessor {
    final override string toString() { result = "return" }
  }

  class BreakSuccessor extends SuccessorType, CfgImpl::TBreakSuccessor {
    final override string toString() { result = "break" }
  }

  class ContinueSuccessor extends SuccessorType, CfgImpl::TContinueSuccessor {
    final override string toString() { result = "continue" }
  }

  class RaiseSuccessor extends SuccessorType, CfgImpl::TRaiseSuccessor {
    final override string toString() { result = "raise" }
  }

  class ExitSuccessor extends SuccessorType, CfgImpl::TExitSuccessor {
    final override string toString() { result = "exit" }
  }
}

class Split = Splitting::Split;

/** Provides different kinds of control flow graph splittings. */
module Split {
  class ConditionalCompletionSplit = Splitting::ConditionalCompletionSplit;
}
