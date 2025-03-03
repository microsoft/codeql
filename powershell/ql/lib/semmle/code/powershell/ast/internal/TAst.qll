private import Raw.Raw as Raw
private import Location
private import Ast as Ast
private import Synthesis
private import Expr
private import ChildIndex

private predicate mkSynthChild(SynthKind kind, Ast::Ast parent, ChildIndex i) {
  any(Synthesis s).child(parent, i, SynthChild(kind))
}

cached
private module Cached {
  private predicate excludeStringConstExpr(Raw::StringConstExpr e) {
    // i.e., "Node" or "Script"
    dynamic_keyword_statement_command_elements(_, 0, e)
  }

  private predicate excludeFunctionDefinitionStmt(Raw::FunctionDefinitionStmt f) {
    // We don't care about function definition statements which define methods
    // because they live inside a type anyway (and we don't have control-flow
    // inside a type).
    parent(f, any(Raw::Method m))
  }

  cached
  newtype TAst =
    TAttributedExpr(Raw::AttributedExpr a) or
    TArrayExpr(Raw::ArrayExpr e) or
    TArrayLiteral(Raw::ArrayLiteral lit) or
    TAssignStmt(Raw::AssignStmt s) or
    TAttribute(Raw::Attribute a) or
    TBinaryExpr(Raw::BinaryExpr bin) or
    TBreakStmt(Raw::BreakStmt br) or
    TCatchClause(Raw::CatchClause cc) or
    TCmd(Raw::Cmd c) or
    TExprStmtSynth(Ast::Ast parent, ChildIndex i) { mkSynthChild(ExprStmtKind(), parent, i) } or
    TParameterSynth(Ast::Ast parent, ChildIndex i) { mkSynthChild(ParameterRealKind(), parent, i) } or
    TDontCareParameterSynth(Ast::Ast parent, ChildIndex i) {
      mkSynthChild(DontCareParameterKind(), parent, i)
    } or
    TPipelineIteratorVariableSynth(Ast::Ast parent, ChildIndex i) {
      mkSynthChild(PipelineIteratorVariableKind(), parent, i)
    } or
    TPipelineByPropertyNameIteratorVariableSynth(Ast::Ast parent, ChildIndex i) {
      mkSynthChild(PipelineByPropertyNameIteratorVariableKind(), parent, i)
    } or
    TFunctionSynth(Ast::Ast parent, ChildIndex i) { mkSynthChild(FunctionSynthKind(), parent, i) } or
    TConfiguration(Raw::Configuration c) or
    TConstExpr(Raw::ConstExpr c) or
    TContinueStmt(Raw::ContinueStmt c) or
    TConvertExpr(Raw::ConvertExpr c) or
    TDataStmt(Raw::DataStmt d) or
    TDoUntilStmt(Raw::DoUntilStmt d) or
    TDoWhileStmt(Raw::DoWhileStmt d) or
    TDynamicStmt(Raw::DynamicStmt d) or
    TErrorExpr(Raw::ErrorExpr e) or
    TErrorStmt(Raw::ErrorStmt e) or
    TExitStmt(Raw::ExitStmt e) or
    TExpandableStringExpr(Raw::ExpandableStringExpr e) or
    TFunctionDefinitionStmt(Raw::FunctionDefinitionStmt f) { not excludeFunctionDefinitionStmt(f) } or
    TForEachStmt(Raw::ForEachStmt f) or
    TForStmt(Raw::ForStmt f) or
    TGotoStmt(Raw::GotoStmt g) or
    THashTableExpr(Raw::HashTableExpr h) or
    TIf(Raw::IfStmt i) or
    TIndexExpr(Raw::IndexExpr i) or
    TInvokeMemberExpr(Raw::InvokeMemberExpr i) or
    TMethod(Raw::Method m) or
    TMemberExpr(Raw::MemberExpr m) or
    TNamedAttributeArgument(Raw::NamedAttributeArgument n) or
    TNamedBlock(Raw::NamedBlock n) or
    TParenExpr(Raw::ParenExpr p) or
    TPipeline(Raw::Pipeline p) or
    TPipelineChain(Raw::PipelineChain p) or
    TPropertyMember(Raw::PropertyMember p) or
    TRedirection(Raw::Redirection r) or
    TReturnStmt(Raw::ReturnStmt r) or
    TScriptBlock(Raw::ScriptBlock s) or
    TScriptBlockExpr(Raw::ScriptBlockExpr s) or
    TExpandableSubExpr(Raw::ExpandableSubExpr e) or
    TStmtBlock(Raw::StmtBlock s) or
    TStringConstExpr(Raw::StringConstExpr s) { not excludeStringConstExpr(s) } or
    TSwitchStmt(Raw::SwitchStmt s) or
    TConditionalExpr(Raw::ConditionalExpr t) or
    TThrowStmt(Raw::ThrowStmt t) or
    TTrapStmt(Raw::TrapStmt t) or
    TTryStmt(Raw::TryStmt t) or
    TTypeStmt(Raw::TypeStmt t) or
    TTypeConstraint(Raw::TypeConstraint t) or
    TUnaryExpr(Raw::UnaryExpr u) or
    TUsingStmt(Raw::UsingStmt u) or
    TVarAccess(Raw::VarAccess va) { not parameter(_, va, _, _) } or
    TWhileStmt(Raw::WhileStmt w) or
    TTypeNameExpr(Raw::TypeNameExpr t) or
    TUsingExpr(Raw::UsingExpr u)

  class TAstReal =
    TArrayExpr or TArrayLiteral or TAssignStmt or TAttribute or TBinaryExpr or TBreakStmt or
        TCatchClause or TCmd or TConfiguration or TConstExpr or TContinueStmt or TConvertExpr or
        TDataStmt or TDoUntilStmt or TDoWhileStmt or TDynamicStmt or TErrorExpr or TErrorStmt or
        TExitStmt or TExpandableStringExpr or TForEachStmt or TForStmt or TGotoStmt or
        THashTableExpr or TIf or TIndexExpr or TInvokeMemberExpr or TMemberExpr or
        TNamedAttributeArgument or TNamedBlock or TParenExpr or TPipeline or TPipelineChain or
        TPropertyMember or TRedirection or TReturnStmt or TScriptBlock or TScriptBlockExpr or
        TStmtBlock or TStringConstExpr or TSwitchStmt or TConditionalExpr or TThrowStmt or
        TTrapStmt or TTryStmt or TTypeStmt or TTypeConstraint or TUnaryExpr or TUsingStmt or
        TVarAccess or TWhileStmt or TFunctionDefinitionStmt or TExpandableSubExpr or TMethod or
        TTypeNameExpr or TAttributedExpr or TUsingExpr;

  class TAstSynth =
    TParameterSynth or TExprStmtSynth or TDontCareParameterSynth or
        TPipelineIteratorVariableSynth or TPipelineByPropertyNameIteratorVariableSynth;

  class TExpr =
    TArrayExpr or TArrayLiteral or TBinaryExpr or TConstExpr or TConvertExpr or TErrorExpr or
        THashTableExpr or TIndexExpr or TInvokeMemberExpr or TCmd or TMemberExpr or TParenExpr or
        TPipeline or TPipelineChain or TPropertyMember or TStringConstExpr or TConditionalExpr or
        TUnaryExpr or TVarAccess or TExpandableStringExpr or TScriptBlockExpr or
        TExpandableSubExpr or TTypeNameExpr or TUsingExpr or TAttributedExpr or TIf;

  class TStmt =
    TArrayExpr or TAssignStmt or TBreakStmt or TContinueStmt or TDataStmt or TDoUntilStmt or
        TDoWhileStmt or TDynamicStmt or TErrorStmt or TExitStmt or TForEachStmt or TForStmt or
        TGotoStmt or TReturnStmt or TStmtBlock or TSwitchStmt or TThrowStmt or TTrapStmt or
        TTryStmt or TUsingStmt or TWhileStmt or TConfiguration or TTypeStmt or
        TFunctionDefinitionStmt or TExprStmt;

  class TMember = TPropertyMember or TMethod;

  class TParameter = TParameterSynth or TDontCareParameterSynth;

  class TExprStmt = TExprStmtSynth;

  class TAttributeBase = TAttribute or TTypeConstraint;

  class TFunction = TFunctionSynth or TMethod;

  class TAttributedExprBase = TAttributedExpr or TConvertExpr;

  class TCallExpr = TCmd or TInvokeMemberExpr;

  class TLoopStmt = TDoUntilStmt or TDoWhileStmt or TForEachStmt or TForStmt or TWhileStmt;

  cached
  Raw::Ast toRaw(TAstReal n) {
    n = TArrayExpr(result) or
    n = TArrayLiteral(result) or
    n = TAssignStmt(result) or
    n = TAttribute(result) or
    n = TBinaryExpr(result) or
    n = TBreakStmt(result) or
    n = TCatchClause(result) or
    n = TCmd(result) or
    n = TConfiguration(result) or
    n = TConstExpr(result) or
    n = TContinueStmt(result) or
    n = TConvertExpr(result) or
    n = TDataStmt(result) or
    n = TDoUntilStmt(result) or
    n = TDoWhileStmt(result) or
    n = TDynamicStmt(result) or
    n = TErrorExpr(result) or
    n = TErrorStmt(result) or
    n = TExitStmt(result) or
    n = TExpandableStringExpr(result) or
    n = TForEachStmt(result) or
    n = TForStmt(result) or
    n = TGotoStmt(result) or
    n = THashTableExpr(result) or
    n = TIf(result) or
    n = TIndexExpr(result) or
    n = TInvokeMemberExpr(result) or
    n = TMemberExpr(result) or
    n = TNamedAttributeArgument(result) or
    n = TNamedBlock(result) or
    n = TParenExpr(result) or
    n = TPipeline(result) or
    n = TPipelineChain(result) or
    n = TPropertyMember(result) or
    n = TRedirection(result) or
    n = TReturnStmt(result) or
    n = TScriptBlock(result) or
    n = TScriptBlockExpr(result) or
    n = TStmtBlock(result) or
    n = TStringConstExpr(result) or
    n = TSwitchStmt(result) or
    n = TConditionalExpr(result) or
    n = TThrowStmt(result) or
    n = TTrapStmt(result) or
    n = TTryStmt(result) or
    n = TTypeStmt(result) or
    n = TTypeConstraint(result) or
    n = TUnaryExpr(result) or
    n = TUsingStmt(result) or
    n = TVarAccess(result) or
    n = TWhileStmt(result) or
    n = TFunctionDefinitionStmt(result) or
    n = TExpandableSubExpr(result) or
    n = TTypeNameExpr(result) or
    n = TMethod(result) or
    n = TAttributedExpr(result) or
    n = TUsingExpr(result)
  }

  cached
  TAstReal fromRaw(Raw::Ast a) { toRaw(result) = a }

  cached
  Ast::Ast getSynthChild(Ast::Ast parent, ChildIndex i) {
    result = TParameterSynth(parent, i) or
    result = TExprStmtSynth(parent, i) or
    result = TDontCareParameterSynth(parent, i) or
    result = TPipelineIteratorVariableSynth(parent, i) or
    result = TPipelineByPropertyNameIteratorVariableSynth(parent, i) or
    result = TFunctionSynth(parent, i)
  }

  cached
  predicate synthChild(Ast::Ast parent, ChildIndex i, Ast::Ast child) {
    child = getSynthChild(parent, i)
    or
    any(Synthesis s).child(parent, i, RealChildRef(child))
    or
    any(Synthesis s).child(parent, i, SynthChildRef(child))
  }
}

import Cached
