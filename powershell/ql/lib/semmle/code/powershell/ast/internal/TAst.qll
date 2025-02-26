private import Raw.Raw as Raw
private import Location
private import Ast as Ast
private import Synthesis

private predicate mkSynthChild(SynthKind kind, Ast::Ast parent, int i) {
  any(Synthesis s).child(parent, i, SynthChild(kind))
}

cached
private module Cached {
  cached
  newtype TAst =
    TArrayExpr(Raw::ArrayExpr e) or
    TArrayLiteral(Raw::ArrayLiteral lit) or
    TAssignStmt(Raw::AssignStmt s) or
    TAttribute(Raw::Attribute a) or
    TBinaryExpr(Raw::BinaryExpr bin) or
    TBreakStmt(Raw::BreakStmt br) or
    TCatchClause(Raw::CatchClause cc) or
    TCmd(Raw::Cmd c) or
    TCmdExpr(Raw::CmdExpr ce) or
    TCmdParameter(Raw::CmdParameter p) or
    TParameterSynth(Ast::Ast parent, int i) { mkSynthChild(ParameterSynthKind(), parent, i) } or
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
    TFunctionDefinitionStmt(Raw::FunctionDefinition f) or
    TForEachStmt(Raw::ForEachStmt f) or
    TForStmt(Raw::ForStmt f) or
    TGotoStmt(Raw::GotoStmt g) or
    THashTableExpr(Raw::HashTableExpr h) or
    TIfStmt(Raw::IfStmt i) or
    TIndexExpr(Raw::IndexExpr i) or
    TInvokeMemberExpr(Raw::InvokeMemberExpr i) or
    TMember(Raw::Member m) or
    TMemberExpr(Raw::MemberExpr m) or
    TNamedAttributeArgument(Raw::NamedAttributeArgument n) or
    TNamedBlock(Raw::NamedBlock n) or
    TParamBlock(Raw::ParamBlock p) or
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
    TStringConstExpr(Raw::StringConstExpr s) or
    TSubExpr(Raw::SubExpr s) or
    TSwitchStmt(Raw::SwitchStmt s) or
    TConditionalExpr(Raw::ConditionalExpr t) or
    TThrowStmt(Raw::ThrowStmt t) or
    TTrapStmt(Raw::TrapStmt t) or
    TTryStmt(Raw::TryStmt t) or
    TType(Raw::Type t) or
    TTypeConstraint(Raw::TypeConstraint t) or
    TUnaryExpr(Raw::UnaryExpr u) or
    TUsingStmt(Raw::UsingStmt u) or
    TVarAccess(Raw::VarAccess va) or
    TWhileStmt(Raw::WhileStmt w) or
    TTypeNameExpr(Raw::TypeNameExpr t) or
    TUsingExpr(Raw::UsingExpr u)

  class TAstReal =
    TArrayExpr or TArrayLiteral or TAssignStmt or TAttribute or TBinaryExpr or TBreakStmt or
        TCatchClause or TCmd or TCmdExpr or TCmdParameter or TConfiguration or TConstExpr or
        TContinueStmt or TConvertExpr or TDataStmt or TDoUntilStmt or TDoWhileStmt or
        TDynamicStmt or TErrorExpr or TErrorStmt or TExitStmt or TExpandableStringExpr or
        TForEachStmt or TForStmt or TGotoStmt or THashTableExpr or TIfStmt or TIndexExpr or
        TInvokeMemberExpr or TMemberExpr or TNamedAttributeArgument or TNamedBlock or TParamBlock or
        TParenExpr or TPipeline or TPipelineChain or TPropertyMember or TRedirection or
        TReturnStmt or TScriptBlock or TScriptBlockExpr or TStmtBlock or TStringConstExpr or
        TSubExpr or TSwitchStmt or TConditionalExpr or TThrowStmt or TTrapStmt or TTryStmt or
        TType or TTypeConstraint or TUnaryExpr or TUsingStmt or TVarAccess or TWhileStmt or
        TFunctionDefinitionStmt;

  class TAstSynth = TParameterSynth;

  class TExpr =
    TArrayExpr or TArrayLiteral or TBinaryExpr or TConstExpr or TConvertExpr or TErrorExpr or
        THashTableExpr or TIndexExpr or TInvokeMemberExpr or TCmd or TMemberExpr or TParenExpr or
        TPipeline or TPipelineChain or TPropertyMember or TStringConstExpr or TSubExpr or
        TConditionalExpr or TUnaryExpr or TVarAccess or TExpandableStringExpr or TScriptBlockExpr or
        TExpandableSubExpr or TTypeNameExpr or TUsingExpr;

  class TStmt =
    TArrayExpr or TAssignStmt or TBreakStmt or TContinueStmt or TDataStmt or TDoUntilStmt or
        TDoWhileStmt or TDynamicStmt or TErrorStmt or TExitStmt or TForEachStmt or TForStmt or
        TGotoStmt or TIfStmt or TReturnStmt or TStmtBlock or TSwitchStmt or TThrowStmt or
        TTrapStmt or TTryStmt or TUsingStmt or TWhileStmt or TConfiguration or TType or
        TFunctionDefinitionStmt;

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
    n = TCmdExpr(result) or
    n = TCmdParameter(result) or
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
    n = TIfStmt(result) or
    n = TIndexExpr(result) or
    n = TInvokeMemberExpr(result) or
    n = TMemberExpr(result) or
    n = TNamedAttributeArgument(result) or
    n = TNamedBlock(result) or
    n = TParamBlock(result) or
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
    n = TSubExpr(result) or
    n = TSwitchStmt(result) or
    n = TConditionalExpr(result) or
    n = TThrowStmt(result) or
    n = TTrapStmt(result) or
    n = TTryStmt(result) or
    n = TType(result) or
    n = TTypeConstraint(result) or
    n = TUnaryExpr(result) or
    n = TUsingStmt(result) or
    n = TVarAccess(result) or
    n = TWhileStmt(result) or
    n = TFunctionDefinitionStmt(result)
  }

  cached
  Ast::Ast getSynthChild(Ast::Ast parent, int i) {
    result = TParameterSynth(parent, i) or
    none()
  }

  cached
  predicate synthChild(Ast::Ast parent, int i, Ast::Ast child) {
    child = getSynthChild(parent, i)
    or
    any(Synthesis s).child(parent, i, RealChildRef(child))
    or
    any(Synthesis s).child(parent, i, SynthChildRef(child))
  }

  cached
  Location getLocation(Ast::Ast n) { result = toRaw(n).getLocation() }
}

import Cached

class TCallExpr = TCmd or TInvokeMemberExpr;

class TLoopStmt = TDoUntilStmt or TDoWhileStmt or TForEachStmt or TForStmt or TWhileStmt;
