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
private import Command
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

  predicate parameterName(Parameter p, string name) { none() }

  predicate exprStmtExpr(ExprStmt s, Expr e) { none() }

  predicate functionName(Function f, string name) { none() }

  predicate functionScriptBlock(Function f, ScriptBlock block) { none() }

  predicate isNamedArgument(CmdCall call, int i, string name) { none() }

  final string toString() { none() }
}

private module ParameterSynth {
  private class ParameterSynth extends Synthesis {
    private predicate child(Ast parent, int i, Child child, Raw::Parameter p) {
      (
        // even indices are block parameters
        exists(Raw::ParamBlock pb |
          pb.getParameter(i) = p and
          pb.getScriptBlock() = toRaw(parent)
        )
        or
        // odd indices are function parameters
        exists(Raw::FunctionDefinitionStmt func |
          func.getParameter(i) = p and
          func.getBody() = toRaw(parent)
        )
      ) and
      child = SynthChild(ParameterRealKind())
    }

    final override predicate child(Ast parent, int i, Child child) {
      this.child(parent, i, child, _)
      or
      exists(Raw::Parameter q, Ast scriptBlock, int j |
        parent = TParameterSynth(scriptBlock, j) and
        this.child(scriptBlock, j, SynthChild(ParameterRealKind()), q)
      |
        i = -1 and
        child = childRef(fromRaw(q.getDefaultValue()))
        or
        child = childRef(fromRaw(q.getAttribute(i)))
      )
    }

    final override Location getLocation(Ast n) {
      exists(Ast parent, int i, Raw::Parameter p |
        this.child(parent, i, _, p) and
        n = TParameterSynth(parent, i) and
        result = p.getLocation()
      )
    }

    final override predicate parameterName(Parameter n, string name) {
      exists(Ast parent, int i, Raw::Parameter p |
        this.child(parent, i, SynthChild(ParameterRealKind()), p) and
        n = TParameterSynth(parent, i) and
        name = p.getName()
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

private predicate mustHaveExprChild(Raw::Ast n) {
  n instanceof Raw::AssignStmt or
  n instanceof Raw::Pipeline
}

private predicate rawStmtShouldBeExpr(Raw::Ast n) {
  n instanceof Raw::Cmd or
  n instanceof Raw::Pipeline or
  n instanceof Raw::PipelineChain
}

private module ExprToStmtSynth {
  private class ExprToStmtSynth extends Synthesis {
    private predicate child(Ast parent, int i, Child child, Expr e) {
      child = SynthChild(ExprStmtKind()) and
      rawStmtShouldBeExpr(toRaw(e)) and
      exists(Raw::Ast rawParent |
        toRaw(parent) = rawParent and
        rawParent.getChild(i) = toRaw(e) and
        not mustHaveExprChild(rawParent)
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

    override Location getLocation(Ast n) {
      exists(Ast parent, int i, Raw::FunctionDefinitionStmt fundefStmt |
        n = TFunctionSynth(parent, i) and
        this.child(parent, i, SynthChild(FunctionSynthKind()), fundefStmt) and
        result = fundefStmt.getLocation()
      )
    }
  }
}

private module CmdExprRemoval {
  private class CmdExprRemoval extends Synthesis {
    override predicate child(Ast parent, int i, Child child) {
      exists(Raw::Ast rawParent, Raw::CmdExpr e |
        toRaw(parent) = rawParent and
        rawParent.getChild(i) = e and
        if mustHaveExprChild(rawParent)
        then child = childRef(fromRaw(e.getExpr()))
        else child = SynthChild(ExprStmtKind())
      )
    }

    pragma[nomagic]
    private predicate parentHasCmdExpr(Ast parent, int i, Raw::CmdExpr cmdExpr) {
      exists(Raw::Ast rawParent |
        toRaw(parent) = rawParent and
        rawParent.getChild(i) = cmdExpr and
        not mustHaveExprChild(rawParent)
      )
    }

    override predicate exprStmtExpr(ExprStmt s, Expr e) {
      exists(Ast parent, int i, Raw::CmdExpr cmdExpr |
        s = TExprStmtSynth(parent, i) and
        this.parentHasCmdExpr(parent, i, cmdExpr) and
        e = fromRaw(cmdExpr.getExpr())
      )
    }
  }
}

private module CmdArguments {
  private class CmdParameterRemoval extends Synthesis {
    private Raw::Expr getArgument(Raw::Cmd cmd, int i) {
      result =
        rank[i + 1](Raw::CmdElement e, Raw::Expr r, int j |
          j > 0 and // 0'th element is the command name itself
          e = cmd.getElement(j) and
          (
            not e instanceof Raw::CmdParameter and
            r = e
            or
            r = e.(Raw::CmdParameter).getExpr()
          )
        |
          r order by j
        )
    }

    override predicate child(Ast parent, int i, Child child) {
      exists(Raw::Cmd cmd, Raw::Expr e |
        this.rawChild(toRaw(parent), i, e) and
        toRaw(parent) = cmd and
        child = childRef(fromRaw(e))
      )
    }

    private predicate rawChild(Raw::Ast parent, int i, Raw::Expr child) {
      exists(Raw::Cmd cmd |
        parent = cmd and
        child = this.getArgument(cmd, i)
      )
    }

    override predicate isNamedArgument(CmdCall call, int i, string name) {
      exists(Raw::Ast parent, Raw::Cmd cmd, Raw::Expr e, Raw::CmdParameter p |
        parent = cmd and
        this.rawChild(parent, i, e) and
        toRaw(call) = cmd and
        p.getName() = name
      |
        p.getExpr() = e
        or
        exists(int j |
          not exists(p.getExpr()) and
          cmd.getChild(j) = p and
          cmd.getChild(j + 1) = e
        )
      )
    }
  }
}
