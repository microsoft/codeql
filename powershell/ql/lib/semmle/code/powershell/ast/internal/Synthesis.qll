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
private import ChildIndex
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
  predicate child(Ast parent, ChildIndex i, Child child) { none() }

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
    private predicate child(Ast parent, ChildIndex i, Child child, Raw::Parameter p) {
      (
        exists(Raw::ParamBlock pb, int index |
          i = funParam(index) and
          pb.getParameter(index) = p and
          pb.getScriptBlock() = toRaw(parent)
        )
        or
        exists(Raw::FunctionDefinitionStmt func, int index |
          i = funParam(index) and
          func.getParameter(index) = p and
          func.getBody() = toRaw(parent)
        )
      ) and
      child = SynthChild(ParameterRealKind())
    }

    final override predicate child(Ast parent, ChildIndex i, Child child) {
      this.child(parent, i, child, _)
      or
      exists(Raw::Parameter q, Ast scriptBlock, ChildIndex j |
        parent = TParameterSynth(scriptBlock, j) and
        this.child(scriptBlock, j, SynthChild(ParameterRealKind()), q)
      |
        i = paramDefaultVal() and
        child = childRef(fromRaw(q.getDefaultValue()))
        or
        exists(int index |
          i = paramAttr(index) and
          child = childRef(fromRaw(q.getAttribute(index)))
        )
      )
    }

    final override Location getLocation(Ast n) {
      exists(Ast parent, ChildIndex i, Raw::Parameter p |
        this.child(parent, i, _, p) and
        n = TParameterSynth(parent, i) and
        result = p.getLocation()
      )
    }

    final override predicate parameterName(Parameter n, string name) {
      exists(Ast parent, ChildIndex i, Raw::Parameter p |
        this.child(parent, i, SynthChild(ParameterRealKind()), p) and
        n = TParameterSynth(parent, i) and
        name = p.getName()
      )
    }
  }

  private class DontCareSynth extends Synthesis {
    final override predicate child(Ast parent, ChildIndex i, Child child) {
      child = SynthChild(DontCareParameterKind()) and
      exists(Raw::VarAccess va |
        i = dontCareParam() and
        va.getUserPath() = ["_", "PSItem"] and
        va.getScope() = toRaw(parent)
      )
    }

    final override string toString(Ast n) {
      exists(Ast parent, ChildIndex i |
        this.child(parent, i, SynthChild(DontCareParameterKind())) and
        n = TDontCareParameterSynth(parent, i) and
        result = "_"
      )
    }

    final override Location getLocation(Ast n) {
      exists(Ast parent, ChildIndex i |
        this.child(parent, i, SynthChild(DontCareParameterKind())) and
        n = TDontCareParameterSynth(parent, i) and
        result = parent.getLocation() // TODO: Better location
      )
    }
  }
}

private predicate mustHaveExprChild(Raw::Ast n, Raw::Ast child) {
  n.(Raw::AssignStmt).getRightHandSide() = child
  or
  n.(Raw::Pipeline).getAComponent() = child
  or
  n.(Raw::ReturnStmt).getPipeline() = child
  or
  n.(Raw::HashTableExpr).getAStmt() = child
  or
  n.(Raw::ParenExpr).getBase() = child
  or
  n.(Raw::DoUntilStmt).getCondition() = child
  or
  n.(Raw::DoWhileStmt).getCondition() = child
  or
  n.(Raw::ExitStmt).getPipeline() = child
  or
  n.(Raw::ForEachStmt).getIterableExpr() = child
  or
  // TODO: What to do about initializer and iterator?
  exists(Raw::ForStmt for | n = for | for.getCondition() = child)
  or
  n.(Raw::IfStmt).getACondition() = child
  or
  n.(Raw::SwitchStmt).getCondition() = child
  or
  n.(Raw::ThrowStmt).getPipeline() = child
  or
  n.(Raw::WhileStmt).getCondition() = child
}

private predicate rawStmtShouldBeExpr(Raw::Ast n) {
  n instanceof Raw::Cmd or
  n instanceof Raw::Pipeline or
  n instanceof Raw::PipelineChain or
  n instanceof Raw::IfStmt
}

private module ExprToStmtSynth {
  private class ExprToStmtSynth extends Synthesis {
    private predicate child(Ast parent, ChildIndex i, Child child, Expr e) {
      child = SynthChild(ExprStmtKind()) and
      exists(Raw::Ast rawParent, Raw::Ast stmt |
        stmt = toRaw(e) and
        rawStmtShouldBeExpr(stmt) and
        toRaw(parent) = rawParent and
        rawParent.getChild(toRawChildIndex(i)) = stmt and
        not mustHaveExprChild(rawParent, stmt)
      )
    }

    final override predicate child(Ast parent, ChildIndex i, Child child) {
      this.child(parent, i, child, _)
    }

    override predicate exprStmtExpr(ExprStmt s, Expr e) {
      exists(Ast parent, ChildIndex i |
        s = TExprStmtSynth(parent, i) and
        this.child(parent, i, SynthChild(ExprStmtKind()), e)
      )
    }
  }
}

private module PipelineVariableSynth {
  private class PipelineIteratorVariableSynth extends Synthesis {
    override predicate child(Ast parent, ChildIndex i, Child child) {
      i = pipelineIteratorVariable() and
      child = SynthChild(PipelineIteratorVariableKind()) and
      toRaw(parent) instanceof Raw::ProcessBlock
    }
  }
}

private module FunctionSynth {
  private class FunctionSynth extends Synthesis {
    private predicate child(
      Ast parent, ChildIndex i, Child child, Raw::FunctionDefinitionStmt fundefStmt
    ) {
      i = funDefFun() and
      toRaw(parent) = fundefStmt and
      child = SynthChild(FunctionSynthKind())
    }

    override predicate child(Ast parent, ChildIndex i, Child child) {
      this.child(parent, i, child, _)
    }

    override predicate functionName(Function f, string name) {
      exists(Ast parent, ChildIndex i, Raw::FunctionDefinitionStmt fundefStmt |
        f = TFunctionSynth(parent, i) and
        this.child(parent, i, SynthChild(FunctionSynthKind()), fundefStmt) and
        fundefStmt.getName() = name
      )
    }

    override predicate functionScriptBlock(Function f, ScriptBlock block) {
      exists(Ast parent, ChildIndex i, Raw::FunctionDefinitionStmt fundefStmt |
        f = TFunctionSynth(parent, i) and
        this.child(parent, i, SynthChild(FunctionSynthKind()), fundefStmt) and
        fundefStmt.getBody() = toRaw(block)
      )
    }

    override Location getLocation(Ast n) {
      exists(Ast parent, ChildIndex i, Raw::FunctionDefinitionStmt fundefStmt |
        n = TFunctionSynth(parent, i) and
        this.child(parent, i, SynthChild(FunctionSynthKind()), fundefStmt) and
        result = fundefStmt.getLocation()
      )
    }
  }
}

private module CmdExprRemoval {
  private class CmdExprRemoval extends Synthesis {
    override predicate child(Ast parent, ChildIndex i, Child child) {
      exists(Raw::Ast rawParent, Raw::CmdExpr e |
        toRaw(parent) = rawParent and
        rawParent.getChild(toRawChildIndex(i)) = e and
        if mustHaveExprChild(rawParent, e)
        then child = childRef(fromRaw(e.getExpr())) // TODO: Add file redirection synthesis for this expr
        else child = SynthChild(ExprStmtKind())
      )
      or
      exists(int index, Raw::CmdExpr e |
        toRaw(parent) = e.getExpr() and
        i = exprRedirection(index) and
        child = childRef(fromRaw(e.getRedirection(index)))
      )
    }

    pragma[nomagic]
    private predicate parentHasCmdExpr(Ast parent, ChildIndex i, Raw::CmdExpr cmdExpr) {
      exists(Raw::Ast rawParent, Raw::ChildIndex rawIndex |
        toRaw(parent) = rawParent and
        rawIndex = toRawChildIndex(i) and
        rawParent.getChild(rawIndex) = cmdExpr and
        not mustHaveExprChild(rawParent, cmdExpr)
      )
    }

    override predicate exprStmtExpr(ExprStmt s, Expr e) {
      exists(Ast parent, ChildIndex i, Raw::CmdExpr cmdExpr |
        s = TExprStmtSynth(parent, i) and
        this.parentHasCmdExpr(parent, i, cmdExpr) and
        e = fromRaw(cmdExpr.getExpr())
      )
    }
  }
}

private module CmdArguments {
  private class CmdParameterRemoval extends Synthesis {
    override predicate child(Ast parent, ChildIndex i, Child child) {
      exists(Raw::Cmd cmd, Raw::Expr e |
        this.rawChild(toRaw(parent), i, e) and
        toRaw(parent) = cmd and
        child = childRef(fromRaw(e))
      )
    }

    private predicate rawChild(Raw::Ast parent, ChildIndex i, Raw::Expr child) {
      exists(Raw::Cmd cmd, int index |
        parent = cmd and
        i = cmdArgument(index) and
        child = getRawCmdArgument(cmd, index)
      )
    }

    override predicate isNamedArgument(CmdCall call, int i, string name) {
      exists(Raw::Ast parent, Raw::Cmd cmd, Raw::Expr e, Raw::CmdParameter p |
        parent = cmd and
        this.rawChild(parent, cmdArgument(i), e) and
        toRaw(call) = cmd and
        p.getName() = name
      |
        p.getExpr() = e
        or
        exists(ChildIndex j, int jndex |
          j = cmdElement_(jndex) and
          not exists(p.getExpr()) and
          cmd.getChild(toRawChildIndex(j)) = p and
          cmd.getChild(toRawChildIndex(cmdElement_(jndex + 1))) = e
        )
      )
    }
  }
}
