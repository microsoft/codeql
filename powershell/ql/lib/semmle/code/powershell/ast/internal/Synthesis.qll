private import TAst
private import Ast
private import Location
private import Variable
private import TypeConstraint
private import Expr
private import Parameter
private import ExprStmt
private import NamedBlock
private import Function
private import ScriptBlock
private import Raw.Raw as Raw

newtype SynthKind =
  ExprStmtKind() or
  ParameterRealKind() or
  LocalVariableAccessRealKind(LocalVariableReal v) or
  LocalVariableAccessSynthKind(TLocalVariableSynth v) or
  DontCareParameterKind() or
  PipelineIteratorVariableKind() or
  PipelineByPropertyNameIteratorVariableKind() or // TODO
  FunctionSynthKind()

newtype Child =
  SynthChild(SynthKind kind) or
  RealChildRef(TAstReal n) or
  SynthChildRef(TAstSynth n)

pragma[inline]
private Child childRef(TAst n) {
  result = RealChildRef(n)
  or
  result = SynthChildRef(n)
}

private newtype TSynthesis = MkSynthesis()

class Synthesis extends TSynthesis {
  predicate child(Ast parent, int i, Child child) { none() }

  Location getLocation(Ast n) { none() }

  string toString(Ast n) { none() }

  predicate localVariable(Ast n, int i) { none() }

  predicate parameterDefaultValue(Parameter p, Expr e) { none() }

  predicate exprStmtExpr(ExprStmt s, Expr e) { none() }

  predicate functionName(Function f, string name) { none() }

  predicate functionScriptBlock(Function f, ScriptBlock block) { none() }

  final string toString() { none() }
}

private module ParameterSynth {
  private class ParameterSynth extends Synthesis {
    private predicate child(Ast parent, int i, Child child, Raw::Parameter p) {
      (
        // even indices are block parameters
        exists(Raw::ParamBlock pb, int k |
          i = k * 2 and
          pb.getParameter(k) = p and
          pb.getScriptBlock() = toRaw(parent)
        )
        or
        // odd indices are function parameters
        exists(Raw::FunctionDefinitionStmt func, int k |
          i = k * 2 + 1 and
          func.getParameter(k) = p and
          func.getBody() = toRaw(parent)
        )
      ) and
      child = SynthChild(ParameterRealKind())
    }

    final override predicate child(Ast parent, int i, Child child) {
      this.child(parent, i, child, _)
    }

    final override Location getLocation(Ast n) {
      exists(Ast parent, int i, Raw::Parameter p |
        this.child(parent, i, _, p) and
        n = TParameterSynth(parent, i) and
        result = p.getLocation()
      )
    }

    final override predicate parameterDefaultValue(Parameter p, Expr e) {
      exists(Ast parent, int i, Raw::Parameter q |
        p = TParameterSynth(parent, i) and
        this.child(parent, i, SynthChild(ParameterRealKind()), q) and
        toRaw(e) = q.getDefaultValue()
      )
    }

    final override string toString(Ast n) {
      exists(Ast parent, int i, Raw::Parameter p |
        this.child(parent, i, _, p) and
        n = TParameterSynth(parent, i) and
        result = p.toString()
      )
    }
  }

  private class DontCareSynth extends Synthesis {
    final override predicate child(Ast parent, int i, Child child) {
      child = SynthChild(DontCareParameterKind()) and
      exists(Raw::VarAccess va |
        i = 0 and
        va.getUserPath() = ["_", "PSItem"] and
        va.getScope() = toRaw(parent)
      )
    }

    final override string toString(Ast n) {
      exists(Ast parent, int i |
        this.child(parent, i, SynthChild(DontCareParameterKind())) and
        n = TDontCareParameterSynth(parent, i) and
        result = "_"
      )
    }

    final override Location getLocation(Ast n) {
      exists(Ast parent, int i |
        this.child(parent, i, SynthChild(DontCareParameterKind())) and
        n = TDontCareParameterSynth(parent, i) and
        result = parent.getLocation() // TODO: Better location
      )
    }
  }
}

private module ExprToStmtSynth {
  private class ExprToStmtSynth extends Synthesis {
    private predicate child(Ast parent, int i, Child child, Expr e) {
      child = SynthChild(ExprStmtKind()) and
      exists(Raw::Ast rawParent |
        toRaw(parent) = rawParent and
        rawParent.getChild(i) = toRaw(e) and
        // When a cmd occurs in a block we want to have an expr-to-stmt
        // conversion. However, powershell also allows commands to occur on the
        // right-hand side of assignments. and there we don't want to convert
        // to a statement.
        not rawParent instanceof Raw::AssignStmt and
        not rawParent instanceof Raw::Pipeline
      |
        toRaw(e) instanceof Raw::Cmd or
        toRaw(e) instanceof Raw::Pipeline or
        toRaw(e) instanceof Raw::PipelineChain
      )
    }

    final override predicate child(Ast parent, int i, Child child) {
      this.child(parent, i, child, _)
    }

    override predicate exprStmtExpr(ExprStmt s, Expr e) {
      exists(Ast parent, int i |
        s = TExprStmtSynth(parent, i) and
        this.child(parent, i, SynthChild(ExprStmtKind()), e)
      )
    }
  }
}

private module PipelineVariableSynth {
  private class PipelineIteratorVariableSynth extends Synthesis {
    override predicate child(Ast parent, int i, Child child) {
      i = -1 and
      child = SynthChild(PipelineIteratorVariableKind()) and
      toRaw(parent) instanceof Raw::ProcessBlock
    }
  }
}

private module FunctionSynth {
  private class FunctionSynth extends Synthesis {
    private predicate child(Ast parent, int i, Child child, Raw::FunctionDefinitionStmt fundefStmt) {
      exists(Raw::Ast rawParent |
        toRaw(parent) = rawParent and
        fundefStmt = rawParent.getChild(i) and
        child = SynthChild(FunctionSynthKind())
      )
    }

    override predicate child(Ast parent, int i, Child child) { this.child(parent, i, child, _) }

    override predicate functionName(Function f, string name) {
      exists(Ast parent, int i, Raw::FunctionDefinitionStmt fundefStmt |
        f = TFunctionSynth(parent, i) and
        this.child(parent, i, SynthChild(FunctionSynthKind()), fundefStmt) and
        fundefStmt.getName() = name
      )
    }

    override predicate functionScriptBlock(Function f, ScriptBlock block) {
      exists(Ast parent, int i, Raw::FunctionDefinitionStmt fundefStmt |
        f = TFunctionSynth(parent, i) and
        this.child(parent, i, SynthChild(FunctionSynthKind()), fundefStmt) and
        fundefStmt.getBody() = toRaw(block)
      )
    }
  }
}
