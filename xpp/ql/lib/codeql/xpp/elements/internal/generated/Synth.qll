/**
 * INTERNAL: Do not use.
 * This module defines the IPA layer on top of raw DB entities, and the conversions between the two
 * layers.
 */

private import codeql.xpp.elements.internal.generated.SynthConstructors
private import codeql.xpp.elements.internal.generated.Raw

module Synth {
  /**
   * INTERNAL: Do not use.
   * The synthesized type of all elements.
   */
  cached
  newtype TElement =
    /**
     * INTERNAL: Do not use.
     */
    TAddExpression(Raw::AddExpression id) { constructAddExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAllFieldsSelection(Raw::AllFieldsSelection id) { constructAllFieldsSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAndExpression(Raw::AndExpression id) { constructAndExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAnyType(Raw::AnyType id) { constructAnyType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TArraySpecification(Raw::ArraySpecification id) { constructArraySpecification(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAsClrExpression(Raw::AsClrExpression id) { constructAsClrExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAsExpression(Raw::AsExpression id) { constructAsExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignDecrementStatement(Raw::AssignDecrementStatement id) {
      constructAssignDecrementStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignDivideStatement(Raw::AssignDivideStatement id) { constructAssignDivideStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignEqualStatement(Raw::AssignEqualStatement id) { constructAssignEqualStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignIncrementStatement(Raw::AssignIncrementStatement id) {
      constructAssignIncrementStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignMultipleFieldStatement(Raw::AssignMultipleFieldStatement id) {
      constructAssignMultipleFieldStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignMultiplyStatement(Raw::AssignMultiplyStatement id) {
      constructAssignMultiplyStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignPostDecrementStatement(Raw::AssignPostDecrementStatement id) {
      constructAssignPostDecrementStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignPostIncrementStatement(Raw::AssignPostIncrementStatement id) {
      constructAssignPostIncrementStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignPreDecrementStatement(Raw::AssignPreDecrementStatement id) {
      constructAssignPreDecrementStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignPreIncrementStatement(Raw::AssignPreIncrementStatement id) {
      constructAssignPreIncrementStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignmentEventHandlerClr(Raw::AssignmentEventHandlerClr id) {
      constructAssignmentEventHandlerClr(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAssignmentEventHandlerInstance(Raw::AssignmentEventHandlerInstance id) {
      constructAssignmentEventHandlerInstance(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAttribute(Raw::Attribute id) { constructAttribute(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAttributeExpression(Raw::AttributeExpression id) { constructAttributeExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAttributeList(Raw::AttributeList id) { constructAttributeList(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TAttributeNamedParameterEntry(Raw::AttributeNamedParameterEntry id) {
      constructAttributeNamedParameterEntry(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TAvgAggregateSelection(Raw::AvgAggregateSelection id) { constructAvgAggregateSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TBooleanAttributeLiteral(Raw::BooleanAttributeLiteral id) {
      constructBooleanAttributeLiteral(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TBooleanLiteralExpression(Raw::BooleanLiteralExpression id) {
      constructBooleanLiteralExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TBooleanType(Raw::BooleanType id) { constructBooleanType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TBreakStatement(Raw::BreakStatement id) { constructBreakStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TBreakpointStatement(Raw::BreakpointStatement id) { constructBreakpointStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCaseDefault(Raw::CaseDefault id) { constructCaseDefault(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCaseValues(Raw::CaseValues id) { constructCaseValues(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCatchAllValues(Raw::CatchAllValues id) { constructCatchAllValues(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCatchExpression(Raw::CatchExpression id) { constructCatchExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCatchUpdateConflict(Raw::CatchUpdateConflict id) { constructCatchUpdateConflict(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TChangeCompanyStatement(Raw::ChangeCompanyStatement id) { constructChangeCompanyStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TClass(Raw::Class id) { constructClass(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TClassAccessModifier(Raw::ClassAccessModifier id) { constructClassAccessModifier(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TClrEnumerationLiteralExpression(Raw::ClrEnumerationLiteralExpression id) {
      constructClrEnumerationLiteralExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TClrType(Raw::ClrType id) { constructClrType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TComment(Raw::Comment id) { constructComment(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCompilationUnitRegionEntry(Raw::CompilationUnitRegionEntry id) {
      constructCompilationUnitRegionEntry(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TCompoundStatement(Raw::CompoundStatement id) { constructCompoundStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TConditionalExpression(Raw::ConditionalExpression id) { constructConditionalExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TContainerAttributeLiteral(Raw::ContainerAttributeLiteral id) {
      constructContainerAttributeLiteral(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TContainerLiteralExpression(Raw::ContainerLiteralExpression id) {
      constructContainerLiteralExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TContainerType(Raw::ContainerType id) { constructContainerType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TContinueStatement(Raw::ContinueStatement id) { constructContinueStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCountAggregateSelection(Raw::CountAggregateSelection id) {
      constructCountAggregateSelection(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TCrossCompanyAll(Raw::CrossCompanyAll id) { constructCrossCompanyAll(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TCrossCompanyContainer(Raw::CrossCompanyContainer id) { constructCrossCompanyContainer(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDateAttributeLiteral(Raw::DateAttributeLiteral id) { constructDateAttributeLiteral(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDateLiteralExpression(Raw::DateLiteralExpression id) { constructDateLiteralExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDateTimeAttributeLiteral(Raw::DateTimeAttributeLiteral id) {
      constructDateTimeAttributeLiteral(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TDateTimeLiteralExpression(Raw::DateTimeLiteralExpression id) {
      constructDateTimeLiteralExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TDateTimeType(Raw::DateTimeType id) { constructDateTimeType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDateType(Raw::DateType id) { constructDateType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDblAttributeLiteral(Raw::DblAttributeLiteral id) { constructDblAttributeLiteral(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDblType(Raw::DblType id) { constructDblType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDelegate(Raw::Delegate id) { constructDelegate(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDeleteStatement(Raw::DeleteStatement id) { constructDeleteStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDivideExpression(Raw::DivideExpression id) { constructDivideExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TDoWhileStatement(Raw::DoWhileStatement id) { constructDoWhileStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TEmptyExpression(Raw::EmptyExpression id) { constructEmptyExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TEmptyStatement(Raw::EmptyStatement id) { constructEmptyStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TEnumAttributeLiteral(Raw::EnumAttributeLiteral id) { constructEnumAttributeLiteral(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TEnumerationLiteralExpression(Raw::EnumerationLiteralExpression id) {
      constructEnumerationLiteralExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TEnumerationType(Raw::EnumerationType id) { constructEnumerationType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TEqualExpression(Raw::EqualExpression id) { constructEqualExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TEvaluationActualParameterEntry(Raw::EvaluationActualParameterEntry id) {
      constructEvaluationActualParameterEntry(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TExplicitSelection(Raw::ExplicitSelection id) { constructExplicitSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TExpressionCompilationUnit(Raw::ExpressionCompilationUnit id) {
      constructExpressionCompilationUnit(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TExpressionQualifier(Raw::ExpressionQualifier id) { constructExpressionQualifier(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TExpressionStatement(Raw::ExpressionStatement id) { constructExpressionStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFieldAssignment(Raw::FieldAssignment id) { constructFieldAssignment(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFieldSelection(Raw::FieldSelection id) { constructFieldSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFile(Raw::File id) { constructFile(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFindStatement(Raw::FindStatement id) { constructFindStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFlushStatement(Raw::FlushStatement id) { constructFlushStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TForDeclarationAssign(Raw::ForDeclarationAssign id) { constructForDeclarationAssign(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TForFieldAssign(Raw::ForFieldAssign id) { constructForFieldAssign(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TForFieldDecrementAssign(Raw::ForFieldDecrementAssign id) {
      constructForFieldDecrementAssign(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TForFieldIncrementAssign(Raw::ForFieldIncrementAssign id) {
      constructForFieldIncrementAssign(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TForFieldPostDecrement(Raw::ForFieldPostDecrement id) { constructForFieldPostDecrement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TForFieldPostIncrement(Raw::ForFieldPostIncrement id) { constructForFieldPostIncrement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TForFieldPreDecrement(Raw::ForFieldPreDecrement id) { constructForFieldPreDecrement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TForFieldPreIncrement(Raw::ForFieldPreIncrement id) { constructForFieldPreIncrement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TForStatement(Raw::ForStatement id) { constructForStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFormControl(Raw::FormControl id) { constructFormControl(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFormDataField(Raw::FormDataField id) { constructFormDataField(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFormDataSource(Raw::FormDataSource id) { constructFormDataSource(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFormElementType(Raw::FormElementType id) { constructFormElementType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFormModelElement(Raw::FormModelElement id) { constructFormModelElement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFunctionCall(Raw::FunctionCall id) { constructFunctionCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TFunctionDeclaration(Raw::FunctionDeclaration id) { constructFunctionDeclaration(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TGlobalOrderElement(Raw::GlobalOrderElement id) { constructGlobalOrderElement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TGreaterThanExpression(Raw::GreaterThanExpression id) { constructGreaterThanExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TGreaterThanOrEqualExpression(Raw::GreaterThanOrEqualExpression id) {
      constructGreaterThanOrEqualExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TGuidAttributeLiteral(Raw::GuidAttributeLiteral id) { constructGuidAttributeLiteral(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TGuidType(Raw::GuidType id) { constructGuidType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIfStatement(Raw::IfStatement id) { constructIfStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIfThenElseStatement(Raw::IfThenElseStatement id) { constructIfThenElseStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TImplicitSelection(Raw::ImplicitSelection id) { constructImplicitSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TInExpression(Raw::InExpression id) { constructInExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TInsertFieldSpecification(Raw::InsertFieldSpecification id) {
      constructInsertFieldSpecification(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TInsertStatement(Raw::InsertStatement id) { constructInsertStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TInt64AttributeLiteral(Raw::Int64AttributeLiteral id) { constructInt64AttributeLiteral(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TInt64LiteralExpression(Raw::Int64LiteralExpression id) { constructInt64LiteralExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TInt64Type(Raw::Int64Type id) { constructInt64Type(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIntAttributeLiteral(Raw::IntAttributeLiteral id) { constructIntAttributeLiteral(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIntLiteralExpression(Raw::IntLiteralExpression id) { constructIntLiteralExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIntType(Raw::IntType id) { constructIntType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIntegerDivideExpression(Raw::IntegerDivideExpression id) {
      constructIntegerDivideExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TInterface(Raw::Interface id) { constructInterface(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIntrinsic(Raw::Intrinsic id) { constructIntrinsic(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIntrinsicAttributeLiteral(Raw::IntrinsicAttributeLiteral id) {
      constructIntrinsicAttributeLiteral(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TIsClrExpression(Raw::IsClrExpression id) { constructIsClrExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TIsExpression(Raw::IsExpression id) { constructIsExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TJoinSpecification(Raw::JoinSpecification id) { constructJoinSpecification(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TLessThanExpression(Raw::LessThanExpression id) { constructLessThanExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TLessThanOrEqualExpression(Raw::LessThanOrEqualExpression id) {
      constructLessThanOrEqualExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TLikeExpression(Raw::LikeExpression id) { constructLikeExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TLocalDeclarationsStatement(Raw::LocalDeclarationsStatement id) {
      constructLocalDeclarationsStatement(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TLocation(Raw::Location id) { constructLocation(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TMaxAggregateSelection(Raw::MaxAggregateSelection id) { constructMaxAggregateSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TMethod(Raw::Method id) { constructMethod(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TMinAggregateSelection(Raw::MinAggregateSelection id) { constructMinAggregateSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TModExpression(Raw::ModExpression id) { constructModExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TModelElementUsingEntry(Raw::ModelElementUsingEntry id) { constructModelElementUsingEntry(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TModifier(Raw::Modifier id) { constructModifier(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TMoveCursorStatement(Raw::MoveCursorStatement id) { constructMoveCursorStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TMultiplyExpression(Raw::MultiplyExpression id) { constructMultiplyExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNamedFieldReference(Raw::NamedFieldReference id) { constructNamedFieldReference(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNewCall(Raw::NewCall id) { constructNewCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNewClrArrayExpression(Raw::NewClrArrayExpression id) { constructNewClrArrayExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNewClrCall(Raw::NewClrCall id) { constructNewClrCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNextExpression(Raw::NextExpression id) { constructNextExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNotEqualExpression(Raw::NotEqualExpression id) { constructNotEqualExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNotExpression(Raw::NotExpression id) { constructNotExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNullLiteralExpression(Raw::NullLiteralExpression id) { constructNullLiteralExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TNumberedFieldReference(Raw::NumberedFieldReference id) { constructNumberedFieldReference(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TOrExpression(Raw::OrExpression id) { constructOrExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TParameterDeclaration(Raw::ParameterDeclaration id) { constructParameterDeclaration(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TPhysicalAndExpression(Raw::PhysicalAndExpression id) { constructPhysicalAndExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TPhysicalNotExpression(Raw::PhysicalNotExpression id) { constructPhysicalNotExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TPhysicalOrExpression(Raw::PhysicalOrExpression id) { constructPhysicalOrExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TPhysicalXorExpression(Raw::PhysicalXorExpression id) { constructPhysicalXorExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TPlaceholder(Raw::Placeholder id) { constructPlaceholder(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TPrintStatement(Raw::PrintStatement id) { constructPrintStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TProvidedType(Raw::ProvidedType id) { constructProvidedType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TProvidedTypeStaticCall(Raw::ProvidedTypeStaticCall id) { constructProvidedTypeStaticCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQualifiedCall(Raw::QualifiedCall id) { constructQualifiedCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQualifiedField(Raw::QualifiedField id) { constructQualifiedField(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQualifiedInstanceName(Raw::QualifiedInstanceName id) { constructQualifiedInstanceName(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQualifiedNumberedField(Raw::QualifiedNumberedField id) { constructQualifiedNumberedField(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQualifiedStaticCall(Raw::QualifiedStaticCall id) { constructQualifiedStaticCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQualifiedStaticField(Raw::QualifiedStaticField id) { constructQualifiedStaticField(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQualifiedStaticFieldExpression(Raw::QualifiedStaticFieldExpression id) {
      constructQualifiedStaticFieldExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TQuery(Raw::Query id) { constructQuery(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQueryDataSource(Raw::QueryDataSource id) { constructQueryDataSource(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQueryDataSourceHaving(Raw::QueryDataSourceHaving id) { constructQueryDataSourceHaving(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQueryDataSourceRange(Raw::QueryDataSourceRange id) { constructQueryDataSourceRange(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TQueryDataSourceRelation(Raw::QueryDataSourceRelation id) {
      constructQueryDataSourceRelation(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TQueryModelElement(Raw::QueryModelElement id) { constructQueryModelElement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TRealLiteralExpression(Raw::RealLiteralExpression id) { constructRealLiteralExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TRetryStatement(Raw::RetryStatement id) { constructRetryStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TReturnStatement(Raw::ReturnStatement id) { constructReturnStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSearchStatement(Raw::SearchStatement id) { constructSearchStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TShiftLeftExpression(Raw::ShiftLeftExpression id) { constructShiftLeftExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TShiftRightExpression(Raw::ShiftRightExpression id) { constructShiftRightExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSimpleField(Raw::SimpleField id) { constructSimpleField(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSimpleInstanceName(Raw::SimpleInstanceName id) { constructSimpleInstanceName(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSimpleOrderElement(Raw::SimpleOrderElement id) { constructSimpleOrderElement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TStaticField(Raw::StaticField id) { constructStaticField(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TStaticMethodCall(Raw::StaticMethodCall id) { constructStaticMethodCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TStaticQualifier(Raw::StaticQualifier id) { constructStaticQualifier(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TStringAttributeLiteral(Raw::StringAttributeLiteral id) { constructStringAttributeLiteral(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TStringLengthType(Raw::StringLengthType id) { constructStringLengthType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TStringLiteralExpression(Raw::StringLiteralExpression id) {
      constructStringLiteralExpression(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TSubtractExpression(Raw::SubtractExpression id) { constructSubtractExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSumAggregateSelection(Raw::SumAggregateSelection id) { constructSumAggregateSelection(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSuperCall(Raw::SuperCall id) { constructSuperCall(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSwitchCase(Raw::SwitchCase id) { constructSwitchCase(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSwitchStatement(Raw::SwitchStatement id) { constructSwitchStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TSwitchStatementCaseEntry(Raw::SwitchStatementCaseEntry id) {
      constructSwitchStatementCaseEntry(id)
    } or
    /**
     * INTERNAL: Do not use.
     */
    TTable(Raw::Table id) { constructTable(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TTableFieldDeclaration(Raw::TableFieldDeclaration id) { constructTableFieldDeclaration(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TTableLookupExpression(Raw::TableLookupExpression id) { constructTableLookupExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TThrowStatement(Raw::ThrowStatement id) { constructThrowStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TTryStatement(Raw::TryStatement id) { constructTryStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TTryStatementCatchEntry(Raw::TryStatementCatchEntry id) { constructTryStatementCatchEntry(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TTtsAbortStatement(Raw::TtsAbortStatement id) { constructTtsAbortStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TTtsBeginStatement(Raw::TtsBeginStatement id) { constructTtsBeginStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TTtsEndStatement(Raw::TtsEndStatement id) { constructTtsEndStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TUnaryMinusExpression(Raw::UnaryMinusExpression id) { constructUnaryMinusExpression(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TUncheckedStatement(Raw::UncheckedStatement id) { constructUncheckedStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TUnspecifiedElement(Raw::UnspecifiedElement id) { constructUnspecifiedElement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TUpdateStatement(Raw::UpdateStatement id) { constructUpdateStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TUsingStatement(Raw::UsingStatement id) { constructUsingStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TValidTimeStateDate(Raw::ValidTimeStateDate id) { constructValidTimeStateDate(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TValidTimeStateRange(Raw::ValidTimeStateRange id) { constructValidTimeStateRange(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TVarType(Raw::VarType id) { constructVarType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TVoidType(Raw::VoidType id) { constructVoidType(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TWhileStatement(Raw::WhileStatement id) { constructWhileStatement(id) } or
    /**
     * INTERNAL: Do not use.
     */
    TXppTypeCompilationUnit(Raw::XppTypeCompilationUnit id) { constructXppTypeCompilationUnit(id) }

  /**
   * INTERNAL: Do not use.
   */
  class TAggregateSelection =
    TAvgAggregateSelection or TCountAggregateSelection or TMaxAggregateSelection or
        TMinAggregateSelection or TSumAggregateSelection;

  /**
   * INTERNAL: Do not use.
   */
  class TAssignmentBinary =
    TAssignDecrementStatement or TAssignDivideStatement or TAssignEqualStatement or
        TAssignIncrementStatement or TAssignMultiplyStatement;

  /**
   * INTERNAL: Do not use.
   */
  class TAssignmentEventHandlerBase =
    TAssignmentEventHandlerInstance or TAssignmentEventHandlerStatic;

  /**
   * INTERNAL: Do not use.
   */
  class TAssignmentEventHandlerStatic = TAssignmentEventHandlerClr;

  /**
   * INTERNAL: Do not use.
   */
  class TAssignmentSingleField =
    TAssignPostDecrementStatement or TAssignPostIncrementStatement or
        TAssignPreDecrementStatement or TAssignPreIncrementStatement or TAssignmentBinary or
        TAssignmentEventHandlerBase;

  /**
   * INTERNAL: Do not use.
   */
  class TAssignmentStatement = TAssignMultipleFieldStatement or TAssignmentSingleField;

  /**
   * INTERNAL: Do not use.
   */
  class TAst =
    TArraySpecification or TAttribute or TAttributeExpression or TAttributeList or
        TAttributeLiteral or TCase or TCatch or TClassAccessModifier or TCompilationUnit or
        TCrossCompany or TExpression or TFieldAssignment or TFieldSpecification or TForAssign or
        TInsertFieldSpecification or TInstanceName or TJoinSpecification or TModifier or
        TOrderElement or TQualifier or TQuery or TQueryDataSource or TQueryDataSourceHaving or
        TQueryDataSourceRange or TQueryDataSourceRelation or TSelection or TSelectionField or
        TStatement or TSwitchCase or TTableFieldReference or TValidTimeState or TXppType;

  /**
   * INTERNAL: Do not use.
   */
  class TAttributeLiteral =
    TContainerAttributeLiteral or TDefaultTypeAttributeLiteral or TEnumAttributeLiteral or
        TIntrinsicAttributeLiteral;

  /**
   * INTERNAL: Do not use.
   */
  class TBinaryExpression =
    TAddExpression or TAndExpression or TDivideExpression or TInExpression or
        TIntegerDivideExpression or TModExpression or TMultiplyExpression or TOrExpression or
        TPhysicalAndExpression or TPhysicalOrExpression or TPhysicalXorExpression or
        TRelationalExpression or TShiftLeftExpression or TShiftRightExpression or
        TSubtractExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TCase = TCaseDefault or TCaseValues;

  /**
   * INTERNAL: Do not use.
   */
  class TCatch = TCatchAllValues or TCatchExpression or TCatchUpdateConflict;

  /**
   * INTERNAL: Do not use.
   */
  class TChangeStatement = TChangeCompanyStatement;

  /**
   * INTERNAL: Do not use.
   */
  class TClassOrInterface = TClass or TInterface;

  /**
   * INTERNAL: Do not use.
   */
  class TCompilationUnit =
    TDeclaration or TExpressionCompilationUnit or TMethodOrDelegate or TModelElement or
        TXppTypeCompilationUnit;

  /**
   * INTERNAL: Do not use.
   */
  class TCrossCompany = TCrossCompanyAll or TCrossCompanyContainer;

  /**
   * INTERNAL: Do not use.
   */
  class TDeclaration = TFieldDeclaration or TLocalDeclaration;

  /**
   * INTERNAL: Do not use.
   */
  class TDefaultTypeAttributeLiteral =
    TBooleanAttributeLiteral or TDateAttributeLiteral or TDateTimeAttributeLiteral or
        TDblAttributeLiteral or TGuidAttributeLiteral or TInt64AttributeLiteral or
        TIntAttributeLiteral or TStringAttributeLiteral;

  /**
   * INTERNAL: Do not use.
   */
  class TDefaultTypeLiteralExpression =
    TBooleanLiteralExpression or TDateLiteralExpression or TDateTimeLiteralExpression or
        TInt64LiteralExpression or TIntLiteralExpression or TRealLiteralExpression or
        TStringLiteralExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TErrorElement = TUnspecifiedElement;

  /**
   * INTERNAL: Do not use.
   */
  class TEvaluation =
    TGenericEvaluation or TNewCall or TNextExpression or TProvidedTypeStaticCall or TSuperCall;

  /**
   * INTERNAL: Do not use.
   */
  class TExpression =
    TBinaryExpression or TConditionalExpression or TEmptyExpression or TEvaluation or
        TFieldExpression or TIntrinsic or TIsAsExpression or TLiteralExpression or
        TNewClrArrayExpression or TPlaceholder or TTableLookupExpression or TUnaryExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TFieldDeclaration = TTableFieldDeclaration;

  /**
   * INTERNAL: Do not use.
   */
  class TFieldExpression = TQualifiedStaticFieldExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TFieldSpecification =
    TQualifiedField or TQualifiedNumberedField or TQualifiedStaticField or TSimpleField or
        TStaticField;

  /**
   * INTERNAL: Do not use.
   */
  class TForAssign =
    TForDeclarationAssign or TForExpressionAssign or TForFieldPostDecrement or
        TForFieldPostIncrement or TForFieldPreDecrement or TForFieldPreIncrement;

  /**
   * INTERNAL: Do not use.
   */
  class TForExpressionAssign =
    TForFieldAssign or TForFieldDecrementAssign or TForFieldIncrementAssign;

  /**
   * INTERNAL: Do not use.
   */
  class TFormNestedElement = TFormControl or TFormDataField or TFormDataSource;

  /**
   * INTERNAL: Do not use.
   */
  class TGenericEvaluation =
    TFunctionCall or TNewClrCall or TQualifiedCall or TQualifiedStaticCall or TStaticMethodCall;

  /**
   * INTERNAL: Do not use.
   */
  class TGenericXppType = TClrType or TNamedType;

  /**
   * INTERNAL: Do not use.
   */
  class TInstanceName = TQualifiedInstanceName or TSimpleInstanceName;

  /**
   * INTERNAL: Do not use.
   */
  class TIsAsExpression = TAsClrExpression or TAsExpression or TIsClrExpression or TIsExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TLiteralExpression =
    TClrEnumerationLiteralExpression or TContainerLiteralExpression or
        TDefaultTypeLiteralExpression or TEnumerationLiteralExpression or TNullLiteralExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TLocalDeclaration = TFunctionDeclaration or TVariableDeclaration;

  /**
   * INTERNAL: Do not use.
   */
  class TLocatable = TAst or TComment or TErrorElement or TXppTuple;

  /**
   * INTERNAL: Do not use.
   */
  class TMethodOrDelegate = TDelegate or TMethod;

  /**
   * INTERNAL: Do not use.
   */
  class TModelElement =
    TClassOrInterface or TFormModelElement or TFormNestedElement or TQueryModelElement or TTable;

  /**
   * INTERNAL: Do not use.
   */
  class TNamedType = TFormElementType;

  /**
   * INTERNAL: Do not use.
   */
  class TOrderElement = TGlobalOrderElement or TSimpleOrderElement;

  /**
   * INTERNAL: Do not use.
   */
  class TQualifier = TExpressionQualifier or TSimpleQualifier;

  /**
   * INTERNAL: Do not use.
   */
  class TRelationalExpression =
    TEqualExpression or TGreaterThanExpression or TGreaterThanOrEqualExpression or
        TLessThanExpression or TLessThanOrEqualExpression or TLikeExpression or TNotEqualExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TSelection = TAllFieldsSelection or TExplicitSelection or TImplicitSelection;

  /**
   * INTERNAL: Do not use.
   */
  class TSelectionField = TAggregateSelection or TFieldSelection;

  /**
   * INTERNAL: Do not use.
   */
  class TSimpleQualifier = TStaticQualifier;

  /**
   * INTERNAL: Do not use.
   */
  class TStatement =
    TAssignmentStatement or TBreakStatement or TBreakpointStatement or TChangeStatement or
        TCompoundStatement or TContinueStatement or TDeleteStatement or TDoWhileStatement or
        TEmptyStatement or TExpressionStatement or TFindStatement or TFlushStatement or
        TForStatement or TIfStatement or TIfThenElseStatement or TInsertStatement or
        TLocalDeclarationsStatement or TMoveCursorStatement or TPrintStatement or TRetryStatement or
        TReturnStatement or TSearchStatement or TSwitchStatement or TThrowStatement or
        TTryStatement or TTtsStatement or TUncheckedStatement or TUpdateStatement or
        TUsingStatement or TWhileStatement;

  /**
   * INTERNAL: Do not use.
   */
  class TStringType = TStringLengthType;

  /**
   * INTERNAL: Do not use.
   */
  class TTableFieldReference = TNamedFieldReference or TNumberedFieldReference;

  /**
   * INTERNAL: Do not use.
   */
  class TTtsStatement = TTtsAbortStatement or TTtsBeginStatement or TTtsEndStatement;

  /**
   * INTERNAL: Do not use.
   */
  class TUnaryExpression = TNotExpression or TPhysicalNotExpression or TUnaryMinusExpression;

  /**
   * INTERNAL: Do not use.
   */
  class TValidTimeState = TValidTimeStateDate or TValidTimeStateRange;

  /**
   * INTERNAL: Do not use.
   */
  class TVariableDeclaration = TParameterDeclaration;

  /**
   * INTERNAL: Do not use.
   */
  class TXppTuple =
    TAttributeNamedParameterEntry or TCompilationUnitRegionEntry or
        TEvaluationActualParameterEntry or TModelElementUsingEntry or TSwitchStatementCaseEntry or
        TTryStatementCatchEntry;

  /**
   * INTERNAL: Do not use.
   */
  class TXppType =
    TAnyType or TBooleanType or TContainerType or TDateTimeType or TDateType or TDblType or
        TEnumerationType or TGenericXppType or TGuidType or TInt64Type or TIntType or
        TProvidedType or TStringType or TVarType or TVoidType;

  /**
   * INTERNAL: Do not use.
   *
   * Gets the parent of synthetic element `e`.
   */
  Raw::Element getSynthParent(TElement e) { none() }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAddExpression`, if possible.
   */
  TAddExpression convertAddExpressionFromRaw(Raw::Element e) { result = TAddExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAllFieldsSelection`, if possible.
   */
  TAllFieldsSelection convertAllFieldsSelectionFromRaw(Raw::Element e) {
    result = TAllFieldsSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAndExpression`, if possible.
   */
  TAndExpression convertAndExpressionFromRaw(Raw::Element e) { result = TAndExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAnyType`, if possible.
   */
  TAnyType convertAnyTypeFromRaw(Raw::Element e) { result = TAnyType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TArraySpecification`, if possible.
   */
  TArraySpecification convertArraySpecificationFromRaw(Raw::Element e) {
    result = TArraySpecification(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAsClrExpression`, if possible.
   */
  TAsClrExpression convertAsClrExpressionFromRaw(Raw::Element e) { result = TAsClrExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAsExpression`, if possible.
   */
  TAsExpression convertAsExpressionFromRaw(Raw::Element e) { result = TAsExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignDecrementStatement`, if possible.
   */
  TAssignDecrementStatement convertAssignDecrementStatementFromRaw(Raw::Element e) {
    result = TAssignDecrementStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignDivideStatement`, if possible.
   */
  TAssignDivideStatement convertAssignDivideStatementFromRaw(Raw::Element e) {
    result = TAssignDivideStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignEqualStatement`, if possible.
   */
  TAssignEqualStatement convertAssignEqualStatementFromRaw(Raw::Element e) {
    result = TAssignEqualStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignIncrementStatement`, if possible.
   */
  TAssignIncrementStatement convertAssignIncrementStatementFromRaw(Raw::Element e) {
    result = TAssignIncrementStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignMultipleFieldStatement`, if possible.
   */
  TAssignMultipleFieldStatement convertAssignMultipleFieldStatementFromRaw(Raw::Element e) {
    result = TAssignMultipleFieldStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignMultiplyStatement`, if possible.
   */
  TAssignMultiplyStatement convertAssignMultiplyStatementFromRaw(Raw::Element e) {
    result = TAssignMultiplyStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignPostDecrementStatement`, if possible.
   */
  TAssignPostDecrementStatement convertAssignPostDecrementStatementFromRaw(Raw::Element e) {
    result = TAssignPostDecrementStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignPostIncrementStatement`, if possible.
   */
  TAssignPostIncrementStatement convertAssignPostIncrementStatementFromRaw(Raw::Element e) {
    result = TAssignPostIncrementStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignPreDecrementStatement`, if possible.
   */
  TAssignPreDecrementStatement convertAssignPreDecrementStatementFromRaw(Raw::Element e) {
    result = TAssignPreDecrementStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignPreIncrementStatement`, if possible.
   */
  TAssignPreIncrementStatement convertAssignPreIncrementStatementFromRaw(Raw::Element e) {
    result = TAssignPreIncrementStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignmentEventHandlerClr`, if possible.
   */
  TAssignmentEventHandlerClr convertAssignmentEventHandlerClrFromRaw(Raw::Element e) {
    result = TAssignmentEventHandlerClr(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAssignmentEventHandlerInstance`, if possible.
   */
  TAssignmentEventHandlerInstance convertAssignmentEventHandlerInstanceFromRaw(Raw::Element e) {
    result = TAssignmentEventHandlerInstance(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAttribute`, if possible.
   */
  TAttribute convertAttributeFromRaw(Raw::Element e) { result = TAttribute(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAttributeExpression`, if possible.
   */
  TAttributeExpression convertAttributeExpressionFromRaw(Raw::Element e) {
    result = TAttributeExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAttributeList`, if possible.
   */
  TAttributeList convertAttributeListFromRaw(Raw::Element e) { result = TAttributeList(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAttributeNamedParameterEntry`, if possible.
   */
  TAttributeNamedParameterEntry convertAttributeNamedParameterEntryFromRaw(Raw::Element e) {
    result = TAttributeNamedParameterEntry(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TAvgAggregateSelection`, if possible.
   */
  TAvgAggregateSelection convertAvgAggregateSelectionFromRaw(Raw::Element e) {
    result = TAvgAggregateSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TBooleanAttributeLiteral`, if possible.
   */
  TBooleanAttributeLiteral convertBooleanAttributeLiteralFromRaw(Raw::Element e) {
    result = TBooleanAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TBooleanLiteralExpression`, if possible.
   */
  TBooleanLiteralExpression convertBooleanLiteralExpressionFromRaw(Raw::Element e) {
    result = TBooleanLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TBooleanType`, if possible.
   */
  TBooleanType convertBooleanTypeFromRaw(Raw::Element e) { result = TBooleanType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TBreakStatement`, if possible.
   */
  TBreakStatement convertBreakStatementFromRaw(Raw::Element e) { result = TBreakStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TBreakpointStatement`, if possible.
   */
  TBreakpointStatement convertBreakpointStatementFromRaw(Raw::Element e) {
    result = TBreakpointStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCaseDefault`, if possible.
   */
  TCaseDefault convertCaseDefaultFromRaw(Raw::Element e) { result = TCaseDefault(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCaseValues`, if possible.
   */
  TCaseValues convertCaseValuesFromRaw(Raw::Element e) { result = TCaseValues(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCatchAllValues`, if possible.
   */
  TCatchAllValues convertCatchAllValuesFromRaw(Raw::Element e) { result = TCatchAllValues(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCatchExpression`, if possible.
   */
  TCatchExpression convertCatchExpressionFromRaw(Raw::Element e) { result = TCatchExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCatchUpdateConflict`, if possible.
   */
  TCatchUpdateConflict convertCatchUpdateConflictFromRaw(Raw::Element e) {
    result = TCatchUpdateConflict(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TChangeCompanyStatement`, if possible.
   */
  TChangeCompanyStatement convertChangeCompanyStatementFromRaw(Raw::Element e) {
    result = TChangeCompanyStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TClass`, if possible.
   */
  TClass convertClassFromRaw(Raw::Element e) { result = TClass(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TClassAccessModifier`, if possible.
   */
  TClassAccessModifier convertClassAccessModifierFromRaw(Raw::Element e) {
    result = TClassAccessModifier(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TClrEnumerationLiteralExpression`, if possible.
   */
  TClrEnumerationLiteralExpression convertClrEnumerationLiteralExpressionFromRaw(Raw::Element e) {
    result = TClrEnumerationLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TClrType`, if possible.
   */
  TClrType convertClrTypeFromRaw(Raw::Element e) { result = TClrType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TComment`, if possible.
   */
  TComment convertCommentFromRaw(Raw::Element e) { result = TComment(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCompilationUnitRegionEntry`, if possible.
   */
  TCompilationUnitRegionEntry convertCompilationUnitRegionEntryFromRaw(Raw::Element e) {
    result = TCompilationUnitRegionEntry(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCompoundStatement`, if possible.
   */
  TCompoundStatement convertCompoundStatementFromRaw(Raw::Element e) {
    result = TCompoundStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TConditionalExpression`, if possible.
   */
  TConditionalExpression convertConditionalExpressionFromRaw(Raw::Element e) {
    result = TConditionalExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TContainerAttributeLiteral`, if possible.
   */
  TContainerAttributeLiteral convertContainerAttributeLiteralFromRaw(Raw::Element e) {
    result = TContainerAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TContainerLiteralExpression`, if possible.
   */
  TContainerLiteralExpression convertContainerLiteralExpressionFromRaw(Raw::Element e) {
    result = TContainerLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TContainerType`, if possible.
   */
  TContainerType convertContainerTypeFromRaw(Raw::Element e) { result = TContainerType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TContinueStatement`, if possible.
   */
  TContinueStatement convertContinueStatementFromRaw(Raw::Element e) {
    result = TContinueStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCountAggregateSelection`, if possible.
   */
  TCountAggregateSelection convertCountAggregateSelectionFromRaw(Raw::Element e) {
    result = TCountAggregateSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCrossCompanyAll`, if possible.
   */
  TCrossCompanyAll convertCrossCompanyAllFromRaw(Raw::Element e) { result = TCrossCompanyAll(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TCrossCompanyContainer`, if possible.
   */
  TCrossCompanyContainer convertCrossCompanyContainerFromRaw(Raw::Element e) {
    result = TCrossCompanyContainer(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDateAttributeLiteral`, if possible.
   */
  TDateAttributeLiteral convertDateAttributeLiteralFromRaw(Raw::Element e) {
    result = TDateAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDateLiteralExpression`, if possible.
   */
  TDateLiteralExpression convertDateLiteralExpressionFromRaw(Raw::Element e) {
    result = TDateLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDateTimeAttributeLiteral`, if possible.
   */
  TDateTimeAttributeLiteral convertDateTimeAttributeLiteralFromRaw(Raw::Element e) {
    result = TDateTimeAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDateTimeLiteralExpression`, if possible.
   */
  TDateTimeLiteralExpression convertDateTimeLiteralExpressionFromRaw(Raw::Element e) {
    result = TDateTimeLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDateTimeType`, if possible.
   */
  TDateTimeType convertDateTimeTypeFromRaw(Raw::Element e) { result = TDateTimeType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDateType`, if possible.
   */
  TDateType convertDateTypeFromRaw(Raw::Element e) { result = TDateType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDblAttributeLiteral`, if possible.
   */
  TDblAttributeLiteral convertDblAttributeLiteralFromRaw(Raw::Element e) {
    result = TDblAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDblType`, if possible.
   */
  TDblType convertDblTypeFromRaw(Raw::Element e) { result = TDblType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDelegate`, if possible.
   */
  TDelegate convertDelegateFromRaw(Raw::Element e) { result = TDelegate(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDeleteStatement`, if possible.
   */
  TDeleteStatement convertDeleteStatementFromRaw(Raw::Element e) { result = TDeleteStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDivideExpression`, if possible.
   */
  TDivideExpression convertDivideExpressionFromRaw(Raw::Element e) { result = TDivideExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TDoWhileStatement`, if possible.
   */
  TDoWhileStatement convertDoWhileStatementFromRaw(Raw::Element e) { result = TDoWhileStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TEmptyExpression`, if possible.
   */
  TEmptyExpression convertEmptyExpressionFromRaw(Raw::Element e) { result = TEmptyExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TEmptyStatement`, if possible.
   */
  TEmptyStatement convertEmptyStatementFromRaw(Raw::Element e) { result = TEmptyStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TEnumAttributeLiteral`, if possible.
   */
  TEnumAttributeLiteral convertEnumAttributeLiteralFromRaw(Raw::Element e) {
    result = TEnumAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TEnumerationLiteralExpression`, if possible.
   */
  TEnumerationLiteralExpression convertEnumerationLiteralExpressionFromRaw(Raw::Element e) {
    result = TEnumerationLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TEnumerationType`, if possible.
   */
  TEnumerationType convertEnumerationTypeFromRaw(Raw::Element e) { result = TEnumerationType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TEqualExpression`, if possible.
   */
  TEqualExpression convertEqualExpressionFromRaw(Raw::Element e) { result = TEqualExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TEvaluationActualParameterEntry`, if possible.
   */
  TEvaluationActualParameterEntry convertEvaluationActualParameterEntryFromRaw(Raw::Element e) {
    result = TEvaluationActualParameterEntry(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TExplicitSelection`, if possible.
   */
  TExplicitSelection convertExplicitSelectionFromRaw(Raw::Element e) {
    result = TExplicitSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TExpressionCompilationUnit`, if possible.
   */
  TExpressionCompilationUnit convertExpressionCompilationUnitFromRaw(Raw::Element e) {
    result = TExpressionCompilationUnit(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TExpressionQualifier`, if possible.
   */
  TExpressionQualifier convertExpressionQualifierFromRaw(Raw::Element e) {
    result = TExpressionQualifier(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TExpressionStatement`, if possible.
   */
  TExpressionStatement convertExpressionStatementFromRaw(Raw::Element e) {
    result = TExpressionStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFieldAssignment`, if possible.
   */
  TFieldAssignment convertFieldAssignmentFromRaw(Raw::Element e) { result = TFieldAssignment(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFieldSelection`, if possible.
   */
  TFieldSelection convertFieldSelectionFromRaw(Raw::Element e) { result = TFieldSelection(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFile`, if possible.
   */
  TFile convertFileFromRaw(Raw::Element e) { result = TFile(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFindStatement`, if possible.
   */
  TFindStatement convertFindStatementFromRaw(Raw::Element e) { result = TFindStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFlushStatement`, if possible.
   */
  TFlushStatement convertFlushStatementFromRaw(Raw::Element e) { result = TFlushStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForDeclarationAssign`, if possible.
   */
  TForDeclarationAssign convertForDeclarationAssignFromRaw(Raw::Element e) {
    result = TForDeclarationAssign(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForFieldAssign`, if possible.
   */
  TForFieldAssign convertForFieldAssignFromRaw(Raw::Element e) { result = TForFieldAssign(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForFieldDecrementAssign`, if possible.
   */
  TForFieldDecrementAssign convertForFieldDecrementAssignFromRaw(Raw::Element e) {
    result = TForFieldDecrementAssign(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForFieldIncrementAssign`, if possible.
   */
  TForFieldIncrementAssign convertForFieldIncrementAssignFromRaw(Raw::Element e) {
    result = TForFieldIncrementAssign(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForFieldPostDecrement`, if possible.
   */
  TForFieldPostDecrement convertForFieldPostDecrementFromRaw(Raw::Element e) {
    result = TForFieldPostDecrement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForFieldPostIncrement`, if possible.
   */
  TForFieldPostIncrement convertForFieldPostIncrementFromRaw(Raw::Element e) {
    result = TForFieldPostIncrement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForFieldPreDecrement`, if possible.
   */
  TForFieldPreDecrement convertForFieldPreDecrementFromRaw(Raw::Element e) {
    result = TForFieldPreDecrement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForFieldPreIncrement`, if possible.
   */
  TForFieldPreIncrement convertForFieldPreIncrementFromRaw(Raw::Element e) {
    result = TForFieldPreIncrement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TForStatement`, if possible.
   */
  TForStatement convertForStatementFromRaw(Raw::Element e) { result = TForStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFormControl`, if possible.
   */
  TFormControl convertFormControlFromRaw(Raw::Element e) { result = TFormControl(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFormDataField`, if possible.
   */
  TFormDataField convertFormDataFieldFromRaw(Raw::Element e) { result = TFormDataField(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFormDataSource`, if possible.
   */
  TFormDataSource convertFormDataSourceFromRaw(Raw::Element e) { result = TFormDataSource(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFormElementType`, if possible.
   */
  TFormElementType convertFormElementTypeFromRaw(Raw::Element e) { result = TFormElementType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFormModelElement`, if possible.
   */
  TFormModelElement convertFormModelElementFromRaw(Raw::Element e) { result = TFormModelElement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFunctionCall`, if possible.
   */
  TFunctionCall convertFunctionCallFromRaw(Raw::Element e) { result = TFunctionCall(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TFunctionDeclaration`, if possible.
   */
  TFunctionDeclaration convertFunctionDeclarationFromRaw(Raw::Element e) {
    result = TFunctionDeclaration(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TGlobalOrderElement`, if possible.
   */
  TGlobalOrderElement convertGlobalOrderElementFromRaw(Raw::Element e) {
    result = TGlobalOrderElement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TGreaterThanExpression`, if possible.
   */
  TGreaterThanExpression convertGreaterThanExpressionFromRaw(Raw::Element e) {
    result = TGreaterThanExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TGreaterThanOrEqualExpression`, if possible.
   */
  TGreaterThanOrEqualExpression convertGreaterThanOrEqualExpressionFromRaw(Raw::Element e) {
    result = TGreaterThanOrEqualExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TGuidAttributeLiteral`, if possible.
   */
  TGuidAttributeLiteral convertGuidAttributeLiteralFromRaw(Raw::Element e) {
    result = TGuidAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TGuidType`, if possible.
   */
  TGuidType convertGuidTypeFromRaw(Raw::Element e) { result = TGuidType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIfStatement`, if possible.
   */
  TIfStatement convertIfStatementFromRaw(Raw::Element e) { result = TIfStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIfThenElseStatement`, if possible.
   */
  TIfThenElseStatement convertIfThenElseStatementFromRaw(Raw::Element e) {
    result = TIfThenElseStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TImplicitSelection`, if possible.
   */
  TImplicitSelection convertImplicitSelectionFromRaw(Raw::Element e) {
    result = TImplicitSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TInExpression`, if possible.
   */
  TInExpression convertInExpressionFromRaw(Raw::Element e) { result = TInExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TInsertFieldSpecification`, if possible.
   */
  TInsertFieldSpecification convertInsertFieldSpecificationFromRaw(Raw::Element e) {
    result = TInsertFieldSpecification(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TInsertStatement`, if possible.
   */
  TInsertStatement convertInsertStatementFromRaw(Raw::Element e) { result = TInsertStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TInt64AttributeLiteral`, if possible.
   */
  TInt64AttributeLiteral convertInt64AttributeLiteralFromRaw(Raw::Element e) {
    result = TInt64AttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TInt64LiteralExpression`, if possible.
   */
  TInt64LiteralExpression convertInt64LiteralExpressionFromRaw(Raw::Element e) {
    result = TInt64LiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TInt64Type`, if possible.
   */
  TInt64Type convertInt64TypeFromRaw(Raw::Element e) { result = TInt64Type(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIntAttributeLiteral`, if possible.
   */
  TIntAttributeLiteral convertIntAttributeLiteralFromRaw(Raw::Element e) {
    result = TIntAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIntLiteralExpression`, if possible.
   */
  TIntLiteralExpression convertIntLiteralExpressionFromRaw(Raw::Element e) {
    result = TIntLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIntType`, if possible.
   */
  TIntType convertIntTypeFromRaw(Raw::Element e) { result = TIntType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIntegerDivideExpression`, if possible.
   */
  TIntegerDivideExpression convertIntegerDivideExpressionFromRaw(Raw::Element e) {
    result = TIntegerDivideExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TInterface`, if possible.
   */
  TInterface convertInterfaceFromRaw(Raw::Element e) { result = TInterface(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIntrinsic`, if possible.
   */
  TIntrinsic convertIntrinsicFromRaw(Raw::Element e) { result = TIntrinsic(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIntrinsicAttributeLiteral`, if possible.
   */
  TIntrinsicAttributeLiteral convertIntrinsicAttributeLiteralFromRaw(Raw::Element e) {
    result = TIntrinsicAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIsClrExpression`, if possible.
   */
  TIsClrExpression convertIsClrExpressionFromRaw(Raw::Element e) { result = TIsClrExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TIsExpression`, if possible.
   */
  TIsExpression convertIsExpressionFromRaw(Raw::Element e) { result = TIsExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TJoinSpecification`, if possible.
   */
  TJoinSpecification convertJoinSpecificationFromRaw(Raw::Element e) {
    result = TJoinSpecification(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TLessThanExpression`, if possible.
   */
  TLessThanExpression convertLessThanExpressionFromRaw(Raw::Element e) {
    result = TLessThanExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TLessThanOrEqualExpression`, if possible.
   */
  TLessThanOrEqualExpression convertLessThanOrEqualExpressionFromRaw(Raw::Element e) {
    result = TLessThanOrEqualExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TLikeExpression`, if possible.
   */
  TLikeExpression convertLikeExpressionFromRaw(Raw::Element e) { result = TLikeExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TLocalDeclarationsStatement`, if possible.
   */
  TLocalDeclarationsStatement convertLocalDeclarationsStatementFromRaw(Raw::Element e) {
    result = TLocalDeclarationsStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TLocation`, if possible.
   */
  TLocation convertLocationFromRaw(Raw::Element e) { result = TLocation(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TMaxAggregateSelection`, if possible.
   */
  TMaxAggregateSelection convertMaxAggregateSelectionFromRaw(Raw::Element e) {
    result = TMaxAggregateSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TMethod`, if possible.
   */
  TMethod convertMethodFromRaw(Raw::Element e) { result = TMethod(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TMinAggregateSelection`, if possible.
   */
  TMinAggregateSelection convertMinAggregateSelectionFromRaw(Raw::Element e) {
    result = TMinAggregateSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TModExpression`, if possible.
   */
  TModExpression convertModExpressionFromRaw(Raw::Element e) { result = TModExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TModelElementUsingEntry`, if possible.
   */
  TModelElementUsingEntry convertModelElementUsingEntryFromRaw(Raw::Element e) {
    result = TModelElementUsingEntry(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TModifier`, if possible.
   */
  TModifier convertModifierFromRaw(Raw::Element e) { result = TModifier(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TMoveCursorStatement`, if possible.
   */
  TMoveCursorStatement convertMoveCursorStatementFromRaw(Raw::Element e) {
    result = TMoveCursorStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TMultiplyExpression`, if possible.
   */
  TMultiplyExpression convertMultiplyExpressionFromRaw(Raw::Element e) {
    result = TMultiplyExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNamedFieldReference`, if possible.
   */
  TNamedFieldReference convertNamedFieldReferenceFromRaw(Raw::Element e) {
    result = TNamedFieldReference(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNewCall`, if possible.
   */
  TNewCall convertNewCallFromRaw(Raw::Element e) { result = TNewCall(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNewClrArrayExpression`, if possible.
   */
  TNewClrArrayExpression convertNewClrArrayExpressionFromRaw(Raw::Element e) {
    result = TNewClrArrayExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNewClrCall`, if possible.
   */
  TNewClrCall convertNewClrCallFromRaw(Raw::Element e) { result = TNewClrCall(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNextExpression`, if possible.
   */
  TNextExpression convertNextExpressionFromRaw(Raw::Element e) { result = TNextExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNotEqualExpression`, if possible.
   */
  TNotEqualExpression convertNotEqualExpressionFromRaw(Raw::Element e) {
    result = TNotEqualExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNotExpression`, if possible.
   */
  TNotExpression convertNotExpressionFromRaw(Raw::Element e) { result = TNotExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNullLiteralExpression`, if possible.
   */
  TNullLiteralExpression convertNullLiteralExpressionFromRaw(Raw::Element e) {
    result = TNullLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TNumberedFieldReference`, if possible.
   */
  TNumberedFieldReference convertNumberedFieldReferenceFromRaw(Raw::Element e) {
    result = TNumberedFieldReference(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TOrExpression`, if possible.
   */
  TOrExpression convertOrExpressionFromRaw(Raw::Element e) { result = TOrExpression(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TParameterDeclaration`, if possible.
   */
  TParameterDeclaration convertParameterDeclarationFromRaw(Raw::Element e) {
    result = TParameterDeclaration(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TPhysicalAndExpression`, if possible.
   */
  TPhysicalAndExpression convertPhysicalAndExpressionFromRaw(Raw::Element e) {
    result = TPhysicalAndExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TPhysicalNotExpression`, if possible.
   */
  TPhysicalNotExpression convertPhysicalNotExpressionFromRaw(Raw::Element e) {
    result = TPhysicalNotExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TPhysicalOrExpression`, if possible.
   */
  TPhysicalOrExpression convertPhysicalOrExpressionFromRaw(Raw::Element e) {
    result = TPhysicalOrExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TPhysicalXorExpression`, if possible.
   */
  TPhysicalXorExpression convertPhysicalXorExpressionFromRaw(Raw::Element e) {
    result = TPhysicalXorExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TPlaceholder`, if possible.
   */
  TPlaceholder convertPlaceholderFromRaw(Raw::Element e) { result = TPlaceholder(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TPrintStatement`, if possible.
   */
  TPrintStatement convertPrintStatementFromRaw(Raw::Element e) { result = TPrintStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TProvidedType`, if possible.
   */
  TProvidedType convertProvidedTypeFromRaw(Raw::Element e) { result = TProvidedType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TProvidedTypeStaticCall`, if possible.
   */
  TProvidedTypeStaticCall convertProvidedTypeStaticCallFromRaw(Raw::Element e) {
    result = TProvidedTypeStaticCall(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQualifiedCall`, if possible.
   */
  TQualifiedCall convertQualifiedCallFromRaw(Raw::Element e) { result = TQualifiedCall(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQualifiedField`, if possible.
   */
  TQualifiedField convertQualifiedFieldFromRaw(Raw::Element e) { result = TQualifiedField(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQualifiedInstanceName`, if possible.
   */
  TQualifiedInstanceName convertQualifiedInstanceNameFromRaw(Raw::Element e) {
    result = TQualifiedInstanceName(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQualifiedNumberedField`, if possible.
   */
  TQualifiedNumberedField convertQualifiedNumberedFieldFromRaw(Raw::Element e) {
    result = TQualifiedNumberedField(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQualifiedStaticCall`, if possible.
   */
  TQualifiedStaticCall convertQualifiedStaticCallFromRaw(Raw::Element e) {
    result = TQualifiedStaticCall(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQualifiedStaticField`, if possible.
   */
  TQualifiedStaticField convertQualifiedStaticFieldFromRaw(Raw::Element e) {
    result = TQualifiedStaticField(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQualifiedStaticFieldExpression`, if possible.
   */
  TQualifiedStaticFieldExpression convertQualifiedStaticFieldExpressionFromRaw(Raw::Element e) {
    result = TQualifiedStaticFieldExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQuery`, if possible.
   */
  TQuery convertQueryFromRaw(Raw::Element e) { result = TQuery(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQueryDataSource`, if possible.
   */
  TQueryDataSource convertQueryDataSourceFromRaw(Raw::Element e) { result = TQueryDataSource(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQueryDataSourceHaving`, if possible.
   */
  TQueryDataSourceHaving convertQueryDataSourceHavingFromRaw(Raw::Element e) {
    result = TQueryDataSourceHaving(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQueryDataSourceRange`, if possible.
   */
  TQueryDataSourceRange convertQueryDataSourceRangeFromRaw(Raw::Element e) {
    result = TQueryDataSourceRange(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQueryDataSourceRelation`, if possible.
   */
  TQueryDataSourceRelation convertQueryDataSourceRelationFromRaw(Raw::Element e) {
    result = TQueryDataSourceRelation(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TQueryModelElement`, if possible.
   */
  TQueryModelElement convertQueryModelElementFromRaw(Raw::Element e) {
    result = TQueryModelElement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TRealLiteralExpression`, if possible.
   */
  TRealLiteralExpression convertRealLiteralExpressionFromRaw(Raw::Element e) {
    result = TRealLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TRetryStatement`, if possible.
   */
  TRetryStatement convertRetryStatementFromRaw(Raw::Element e) { result = TRetryStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TReturnStatement`, if possible.
   */
  TReturnStatement convertReturnStatementFromRaw(Raw::Element e) { result = TReturnStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSearchStatement`, if possible.
   */
  TSearchStatement convertSearchStatementFromRaw(Raw::Element e) { result = TSearchStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TShiftLeftExpression`, if possible.
   */
  TShiftLeftExpression convertShiftLeftExpressionFromRaw(Raw::Element e) {
    result = TShiftLeftExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TShiftRightExpression`, if possible.
   */
  TShiftRightExpression convertShiftRightExpressionFromRaw(Raw::Element e) {
    result = TShiftRightExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSimpleField`, if possible.
   */
  TSimpleField convertSimpleFieldFromRaw(Raw::Element e) { result = TSimpleField(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSimpleInstanceName`, if possible.
   */
  TSimpleInstanceName convertSimpleInstanceNameFromRaw(Raw::Element e) {
    result = TSimpleInstanceName(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSimpleOrderElement`, if possible.
   */
  TSimpleOrderElement convertSimpleOrderElementFromRaw(Raw::Element e) {
    result = TSimpleOrderElement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TStaticField`, if possible.
   */
  TStaticField convertStaticFieldFromRaw(Raw::Element e) { result = TStaticField(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TStaticMethodCall`, if possible.
   */
  TStaticMethodCall convertStaticMethodCallFromRaw(Raw::Element e) { result = TStaticMethodCall(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TStaticQualifier`, if possible.
   */
  TStaticQualifier convertStaticQualifierFromRaw(Raw::Element e) { result = TStaticQualifier(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TStringAttributeLiteral`, if possible.
   */
  TStringAttributeLiteral convertStringAttributeLiteralFromRaw(Raw::Element e) {
    result = TStringAttributeLiteral(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TStringLengthType`, if possible.
   */
  TStringLengthType convertStringLengthTypeFromRaw(Raw::Element e) { result = TStringLengthType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TStringLiteralExpression`, if possible.
   */
  TStringLiteralExpression convertStringLiteralExpressionFromRaw(Raw::Element e) {
    result = TStringLiteralExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSubtractExpression`, if possible.
   */
  TSubtractExpression convertSubtractExpressionFromRaw(Raw::Element e) {
    result = TSubtractExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSumAggregateSelection`, if possible.
   */
  TSumAggregateSelection convertSumAggregateSelectionFromRaw(Raw::Element e) {
    result = TSumAggregateSelection(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSuperCall`, if possible.
   */
  TSuperCall convertSuperCallFromRaw(Raw::Element e) { result = TSuperCall(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSwitchCase`, if possible.
   */
  TSwitchCase convertSwitchCaseFromRaw(Raw::Element e) { result = TSwitchCase(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSwitchStatement`, if possible.
   */
  TSwitchStatement convertSwitchStatementFromRaw(Raw::Element e) { result = TSwitchStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TSwitchStatementCaseEntry`, if possible.
   */
  TSwitchStatementCaseEntry convertSwitchStatementCaseEntryFromRaw(Raw::Element e) {
    result = TSwitchStatementCaseEntry(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTable`, if possible.
   */
  TTable convertTableFromRaw(Raw::Element e) { result = TTable(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTableFieldDeclaration`, if possible.
   */
  TTableFieldDeclaration convertTableFieldDeclarationFromRaw(Raw::Element e) {
    result = TTableFieldDeclaration(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTableLookupExpression`, if possible.
   */
  TTableLookupExpression convertTableLookupExpressionFromRaw(Raw::Element e) {
    result = TTableLookupExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TThrowStatement`, if possible.
   */
  TThrowStatement convertThrowStatementFromRaw(Raw::Element e) { result = TThrowStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTryStatement`, if possible.
   */
  TTryStatement convertTryStatementFromRaw(Raw::Element e) { result = TTryStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTryStatementCatchEntry`, if possible.
   */
  TTryStatementCatchEntry convertTryStatementCatchEntryFromRaw(Raw::Element e) {
    result = TTryStatementCatchEntry(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTtsAbortStatement`, if possible.
   */
  TTtsAbortStatement convertTtsAbortStatementFromRaw(Raw::Element e) {
    result = TTtsAbortStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTtsBeginStatement`, if possible.
   */
  TTtsBeginStatement convertTtsBeginStatementFromRaw(Raw::Element e) {
    result = TTtsBeginStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TTtsEndStatement`, if possible.
   */
  TTtsEndStatement convertTtsEndStatementFromRaw(Raw::Element e) { result = TTtsEndStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TUnaryMinusExpression`, if possible.
   */
  TUnaryMinusExpression convertUnaryMinusExpressionFromRaw(Raw::Element e) {
    result = TUnaryMinusExpression(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TUncheckedStatement`, if possible.
   */
  TUncheckedStatement convertUncheckedStatementFromRaw(Raw::Element e) {
    result = TUncheckedStatement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TUnspecifiedElement`, if possible.
   */
  TUnspecifiedElement convertUnspecifiedElementFromRaw(Raw::Element e) {
    result = TUnspecifiedElement(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TUpdateStatement`, if possible.
   */
  TUpdateStatement convertUpdateStatementFromRaw(Raw::Element e) { result = TUpdateStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TUsingStatement`, if possible.
   */
  TUsingStatement convertUsingStatementFromRaw(Raw::Element e) { result = TUsingStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TValidTimeStateDate`, if possible.
   */
  TValidTimeStateDate convertValidTimeStateDateFromRaw(Raw::Element e) {
    result = TValidTimeStateDate(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TValidTimeStateRange`, if possible.
   */
  TValidTimeStateRange convertValidTimeStateRangeFromRaw(Raw::Element e) {
    result = TValidTimeStateRange(e)
  }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TVarType`, if possible.
   */
  TVarType convertVarTypeFromRaw(Raw::Element e) { result = TVarType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TVoidType`, if possible.
   */
  TVoidType convertVoidTypeFromRaw(Raw::Element e) { result = TVoidType(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TWhileStatement`, if possible.
   */
  TWhileStatement convertWhileStatementFromRaw(Raw::Element e) { result = TWhileStatement(e) }

  /**
   * INTERNAL: Do not use.
   *
   * Converts a raw element to a synthesized `TXppTypeCompilationUnit`, if possible.
   */
  TXppTypeCompilationUnit convertXppTypeCompilationUnitFromRaw(Raw::Element e) {
    result = TXppTypeCompilationUnit(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAggregateSelection`, if possible.
   */
  TAggregateSelection convertAggregateSelectionFromRaw(Raw::Element e) {
    result = convertAvgAggregateSelectionFromRaw(e)
    or
    result = convertCountAggregateSelectionFromRaw(e)
    or
    result = convertMaxAggregateSelectionFromRaw(e)
    or
    result = convertMinAggregateSelectionFromRaw(e)
    or
    result = convertSumAggregateSelectionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAssignmentBinary`, if possible.
   */
  TAssignmentBinary convertAssignmentBinaryFromRaw(Raw::Element e) {
    result = convertAssignDecrementStatementFromRaw(e)
    or
    result = convertAssignDivideStatementFromRaw(e)
    or
    result = convertAssignEqualStatementFromRaw(e)
    or
    result = convertAssignIncrementStatementFromRaw(e)
    or
    result = convertAssignMultiplyStatementFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAssignmentEventHandlerBase`, if possible.
   */
  TAssignmentEventHandlerBase convertAssignmentEventHandlerBaseFromRaw(Raw::Element e) {
    result = convertAssignmentEventHandlerInstanceFromRaw(e)
    or
    result = convertAssignmentEventHandlerStaticFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAssignmentEventHandlerStatic`, if possible.
   */
  TAssignmentEventHandlerStatic convertAssignmentEventHandlerStaticFromRaw(Raw::Element e) {
    result = convertAssignmentEventHandlerClrFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAssignmentSingleField`, if possible.
   */
  TAssignmentSingleField convertAssignmentSingleFieldFromRaw(Raw::Element e) {
    result = convertAssignPostDecrementStatementFromRaw(e)
    or
    result = convertAssignPostIncrementStatementFromRaw(e)
    or
    result = convertAssignPreDecrementStatementFromRaw(e)
    or
    result = convertAssignPreIncrementStatementFromRaw(e)
    or
    result = convertAssignmentBinaryFromRaw(e)
    or
    result = convertAssignmentEventHandlerBaseFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAssignmentStatement`, if possible.
   */
  TAssignmentStatement convertAssignmentStatementFromRaw(Raw::Element e) {
    result = convertAssignMultipleFieldStatementFromRaw(e)
    or
    result = convertAssignmentSingleFieldFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAst`, if possible.
   */
  TAst convertAstFromRaw(Raw::Element e) {
    result = convertArraySpecificationFromRaw(e)
    or
    result = convertAttributeFromRaw(e)
    or
    result = convertAttributeExpressionFromRaw(e)
    or
    result = convertAttributeListFromRaw(e)
    or
    result = convertAttributeLiteralFromRaw(e)
    or
    result = convertCaseFromRaw(e)
    or
    result = convertCatchFromRaw(e)
    or
    result = convertClassAccessModifierFromRaw(e)
    or
    result = convertCompilationUnitFromRaw(e)
    or
    result = convertCrossCompanyFromRaw(e)
    or
    result = convertExpressionFromRaw(e)
    or
    result = convertFieldAssignmentFromRaw(e)
    or
    result = convertFieldSpecificationFromRaw(e)
    or
    result = convertForAssignFromRaw(e)
    or
    result = convertInsertFieldSpecificationFromRaw(e)
    or
    result = convertInstanceNameFromRaw(e)
    or
    result = convertJoinSpecificationFromRaw(e)
    or
    result = convertModifierFromRaw(e)
    or
    result = convertOrderElementFromRaw(e)
    or
    result = convertQualifierFromRaw(e)
    or
    result = convertQueryFromRaw(e)
    or
    result = convertQueryDataSourceFromRaw(e)
    or
    result = convertQueryDataSourceHavingFromRaw(e)
    or
    result = convertQueryDataSourceRangeFromRaw(e)
    or
    result = convertQueryDataSourceRelationFromRaw(e)
    or
    result = convertSelectionFromRaw(e)
    or
    result = convertSelectionFieldFromRaw(e)
    or
    result = convertStatementFromRaw(e)
    or
    result = convertSwitchCaseFromRaw(e)
    or
    result = convertTableFieldReferenceFromRaw(e)
    or
    result = convertValidTimeStateFromRaw(e)
    or
    result = convertXppTypeFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TAttributeLiteral`, if possible.
   */
  TAttributeLiteral convertAttributeLiteralFromRaw(Raw::Element e) {
    result = convertContainerAttributeLiteralFromRaw(e)
    or
    result = convertDefaultTypeAttributeLiteralFromRaw(e)
    or
    result = convertEnumAttributeLiteralFromRaw(e)
    or
    result = convertIntrinsicAttributeLiteralFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TBinaryExpression`, if possible.
   */
  TBinaryExpression convertBinaryExpressionFromRaw(Raw::Element e) {
    result = convertAddExpressionFromRaw(e)
    or
    result = convertAndExpressionFromRaw(e)
    or
    result = convertDivideExpressionFromRaw(e)
    or
    result = convertInExpressionFromRaw(e)
    or
    result = convertIntegerDivideExpressionFromRaw(e)
    or
    result = convertModExpressionFromRaw(e)
    or
    result = convertMultiplyExpressionFromRaw(e)
    or
    result = convertOrExpressionFromRaw(e)
    or
    result = convertPhysicalAndExpressionFromRaw(e)
    or
    result = convertPhysicalOrExpressionFromRaw(e)
    or
    result = convertPhysicalXorExpressionFromRaw(e)
    or
    result = convertRelationalExpressionFromRaw(e)
    or
    result = convertShiftLeftExpressionFromRaw(e)
    or
    result = convertShiftRightExpressionFromRaw(e)
    or
    result = convertSubtractExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TCase`, if possible.
   */
  TCase convertCaseFromRaw(Raw::Element e) {
    result = convertCaseDefaultFromRaw(e)
    or
    result = convertCaseValuesFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TCatch`, if possible.
   */
  TCatch convertCatchFromRaw(Raw::Element e) {
    result = convertCatchAllValuesFromRaw(e)
    or
    result = convertCatchExpressionFromRaw(e)
    or
    result = convertCatchUpdateConflictFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TChangeStatement`, if possible.
   */
  TChangeStatement convertChangeStatementFromRaw(Raw::Element e) {
    result = convertChangeCompanyStatementFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TClassOrInterface`, if possible.
   */
  TClassOrInterface convertClassOrInterfaceFromRaw(Raw::Element e) {
    result = convertClassFromRaw(e)
    or
    result = convertInterfaceFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TCompilationUnit`, if possible.
   */
  TCompilationUnit convertCompilationUnitFromRaw(Raw::Element e) {
    result = convertDeclarationFromRaw(e)
    or
    result = convertExpressionCompilationUnitFromRaw(e)
    or
    result = convertMethodOrDelegateFromRaw(e)
    or
    result = convertModelElementFromRaw(e)
    or
    result = convertXppTypeCompilationUnitFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TCrossCompany`, if possible.
   */
  TCrossCompany convertCrossCompanyFromRaw(Raw::Element e) {
    result = convertCrossCompanyAllFromRaw(e)
    or
    result = convertCrossCompanyContainerFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TDeclaration`, if possible.
   */
  TDeclaration convertDeclarationFromRaw(Raw::Element e) {
    result = convertFieldDeclarationFromRaw(e)
    or
    result = convertLocalDeclarationFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TDefaultTypeAttributeLiteral`, if possible.
   */
  TDefaultTypeAttributeLiteral convertDefaultTypeAttributeLiteralFromRaw(Raw::Element e) {
    result = convertBooleanAttributeLiteralFromRaw(e)
    or
    result = convertDateAttributeLiteralFromRaw(e)
    or
    result = convertDateTimeAttributeLiteralFromRaw(e)
    or
    result = convertDblAttributeLiteralFromRaw(e)
    or
    result = convertGuidAttributeLiteralFromRaw(e)
    or
    result = convertInt64AttributeLiteralFromRaw(e)
    or
    result = convertIntAttributeLiteralFromRaw(e)
    or
    result = convertStringAttributeLiteralFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TDefaultTypeLiteralExpression`, if possible.
   */
  TDefaultTypeLiteralExpression convertDefaultTypeLiteralExpressionFromRaw(Raw::Element e) {
    result = convertBooleanLiteralExpressionFromRaw(e)
    or
    result = convertDateLiteralExpressionFromRaw(e)
    or
    result = convertDateTimeLiteralExpressionFromRaw(e)
    or
    result = convertInt64LiteralExpressionFromRaw(e)
    or
    result = convertIntLiteralExpressionFromRaw(e)
    or
    result = convertRealLiteralExpressionFromRaw(e)
    or
    result = convertStringLiteralExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TElement`, if possible.
   */
  TElement convertElementFromRaw(Raw::Element e) {
    result = convertFileFromRaw(e)
    or
    result = convertLocatableFromRaw(e)
    or
    result = convertLocationFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TErrorElement`, if possible.
   */
  TErrorElement convertErrorElementFromRaw(Raw::Element e) {
    result = convertUnspecifiedElementFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TEvaluation`, if possible.
   */
  TEvaluation convertEvaluationFromRaw(Raw::Element e) {
    result = convertGenericEvaluationFromRaw(e)
    or
    result = convertNewCallFromRaw(e)
    or
    result = convertNextExpressionFromRaw(e)
    or
    result = convertProvidedTypeStaticCallFromRaw(e)
    or
    result = convertSuperCallFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TExpression`, if possible.
   */
  TExpression convertExpressionFromRaw(Raw::Element e) {
    result = convertBinaryExpressionFromRaw(e)
    or
    result = convertConditionalExpressionFromRaw(e)
    or
    result = convertEmptyExpressionFromRaw(e)
    or
    result = convertEvaluationFromRaw(e)
    or
    result = convertFieldExpressionFromRaw(e)
    or
    result = convertIntrinsicFromRaw(e)
    or
    result = convertIsAsExpressionFromRaw(e)
    or
    result = convertLiteralExpressionFromRaw(e)
    or
    result = convertNewClrArrayExpressionFromRaw(e)
    or
    result = convertPlaceholderFromRaw(e)
    or
    result = convertTableLookupExpressionFromRaw(e)
    or
    result = convertUnaryExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TFieldDeclaration`, if possible.
   */
  TFieldDeclaration convertFieldDeclarationFromRaw(Raw::Element e) {
    result = convertTableFieldDeclarationFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TFieldExpression`, if possible.
   */
  TFieldExpression convertFieldExpressionFromRaw(Raw::Element e) {
    result = convertQualifiedStaticFieldExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TFieldSpecification`, if possible.
   */
  TFieldSpecification convertFieldSpecificationFromRaw(Raw::Element e) {
    result = convertQualifiedFieldFromRaw(e)
    or
    result = convertQualifiedNumberedFieldFromRaw(e)
    or
    result = convertQualifiedStaticFieldFromRaw(e)
    or
    result = convertSimpleFieldFromRaw(e)
    or
    result = convertStaticFieldFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TForAssign`, if possible.
   */
  TForAssign convertForAssignFromRaw(Raw::Element e) {
    result = convertForDeclarationAssignFromRaw(e)
    or
    result = convertForExpressionAssignFromRaw(e)
    or
    result = convertForFieldPostDecrementFromRaw(e)
    or
    result = convertForFieldPostIncrementFromRaw(e)
    or
    result = convertForFieldPreDecrementFromRaw(e)
    or
    result = convertForFieldPreIncrementFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TForExpressionAssign`, if possible.
   */
  TForExpressionAssign convertForExpressionAssignFromRaw(Raw::Element e) {
    result = convertForFieldAssignFromRaw(e)
    or
    result = convertForFieldDecrementAssignFromRaw(e)
    or
    result = convertForFieldIncrementAssignFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TFormNestedElement`, if possible.
   */
  TFormNestedElement convertFormNestedElementFromRaw(Raw::Element e) {
    result = convertFormControlFromRaw(e)
    or
    result = convertFormDataFieldFromRaw(e)
    or
    result = convertFormDataSourceFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TGenericEvaluation`, if possible.
   */
  TGenericEvaluation convertGenericEvaluationFromRaw(Raw::Element e) {
    result = convertFunctionCallFromRaw(e)
    or
    result = convertNewClrCallFromRaw(e)
    or
    result = convertQualifiedCallFromRaw(e)
    or
    result = convertQualifiedStaticCallFromRaw(e)
    or
    result = convertStaticMethodCallFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TGenericXppType`, if possible.
   */
  TGenericXppType convertGenericXppTypeFromRaw(Raw::Element e) {
    result = convertClrTypeFromRaw(e)
    or
    result = convertNamedTypeFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TInstanceName`, if possible.
   */
  TInstanceName convertInstanceNameFromRaw(Raw::Element e) {
    result = convertQualifiedInstanceNameFromRaw(e)
    or
    result = convertSimpleInstanceNameFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TIsAsExpression`, if possible.
   */
  TIsAsExpression convertIsAsExpressionFromRaw(Raw::Element e) {
    result = convertAsClrExpressionFromRaw(e)
    or
    result = convertAsExpressionFromRaw(e)
    or
    result = convertIsClrExpressionFromRaw(e)
    or
    result = convertIsExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TLiteralExpression`, if possible.
   */
  TLiteralExpression convertLiteralExpressionFromRaw(Raw::Element e) {
    result = convertClrEnumerationLiteralExpressionFromRaw(e)
    or
    result = convertContainerLiteralExpressionFromRaw(e)
    or
    result = convertDefaultTypeLiteralExpressionFromRaw(e)
    or
    result = convertEnumerationLiteralExpressionFromRaw(e)
    or
    result = convertNullLiteralExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TLocalDeclaration`, if possible.
   */
  TLocalDeclaration convertLocalDeclarationFromRaw(Raw::Element e) {
    result = convertFunctionDeclarationFromRaw(e)
    or
    result = convertVariableDeclarationFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TLocatable`, if possible.
   */
  TLocatable convertLocatableFromRaw(Raw::Element e) {
    result = convertAstFromRaw(e)
    or
    result = convertCommentFromRaw(e)
    or
    result = convertErrorElementFromRaw(e)
    or
    result = convertXppTupleFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TMethodOrDelegate`, if possible.
   */
  TMethodOrDelegate convertMethodOrDelegateFromRaw(Raw::Element e) {
    result = convertDelegateFromRaw(e)
    or
    result = convertMethodFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TModelElement`, if possible.
   */
  TModelElement convertModelElementFromRaw(Raw::Element e) {
    result = convertClassOrInterfaceFromRaw(e)
    or
    result = convertFormModelElementFromRaw(e)
    or
    result = convertFormNestedElementFromRaw(e)
    or
    result = convertQueryModelElementFromRaw(e)
    or
    result = convertTableFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TNamedType`, if possible.
   */
  TNamedType convertNamedTypeFromRaw(Raw::Element e) { result = convertFormElementTypeFromRaw(e) }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TOrderElement`, if possible.
   */
  TOrderElement convertOrderElementFromRaw(Raw::Element e) {
    result = convertGlobalOrderElementFromRaw(e)
    or
    result = convertSimpleOrderElementFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TQualifier`, if possible.
   */
  TQualifier convertQualifierFromRaw(Raw::Element e) {
    result = convertExpressionQualifierFromRaw(e)
    or
    result = convertSimpleQualifierFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TRelationalExpression`, if possible.
   */
  TRelationalExpression convertRelationalExpressionFromRaw(Raw::Element e) {
    result = convertEqualExpressionFromRaw(e)
    or
    result = convertGreaterThanExpressionFromRaw(e)
    or
    result = convertGreaterThanOrEqualExpressionFromRaw(e)
    or
    result = convertLessThanExpressionFromRaw(e)
    or
    result = convertLessThanOrEqualExpressionFromRaw(e)
    or
    result = convertLikeExpressionFromRaw(e)
    or
    result = convertNotEqualExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TSelection`, if possible.
   */
  TSelection convertSelectionFromRaw(Raw::Element e) {
    result = convertAllFieldsSelectionFromRaw(e)
    or
    result = convertExplicitSelectionFromRaw(e)
    or
    result = convertImplicitSelectionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TSelectionField`, if possible.
   */
  TSelectionField convertSelectionFieldFromRaw(Raw::Element e) {
    result = convertAggregateSelectionFromRaw(e)
    or
    result = convertFieldSelectionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TSimpleQualifier`, if possible.
   */
  TSimpleQualifier convertSimpleQualifierFromRaw(Raw::Element e) {
    result = convertStaticQualifierFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TStatement`, if possible.
   */
  TStatement convertStatementFromRaw(Raw::Element e) {
    result = convertAssignmentStatementFromRaw(e)
    or
    result = convertBreakStatementFromRaw(e)
    or
    result = convertBreakpointStatementFromRaw(e)
    or
    result = convertChangeStatementFromRaw(e)
    or
    result = convertCompoundStatementFromRaw(e)
    or
    result = convertContinueStatementFromRaw(e)
    or
    result = convertDeleteStatementFromRaw(e)
    or
    result = convertDoWhileStatementFromRaw(e)
    or
    result = convertEmptyStatementFromRaw(e)
    or
    result = convertExpressionStatementFromRaw(e)
    or
    result = convertFindStatementFromRaw(e)
    or
    result = convertFlushStatementFromRaw(e)
    or
    result = convertForStatementFromRaw(e)
    or
    result = convertIfStatementFromRaw(e)
    or
    result = convertIfThenElseStatementFromRaw(e)
    or
    result = convertInsertStatementFromRaw(e)
    or
    result = convertLocalDeclarationsStatementFromRaw(e)
    or
    result = convertMoveCursorStatementFromRaw(e)
    or
    result = convertPrintStatementFromRaw(e)
    or
    result = convertRetryStatementFromRaw(e)
    or
    result = convertReturnStatementFromRaw(e)
    or
    result = convertSearchStatementFromRaw(e)
    or
    result = convertSwitchStatementFromRaw(e)
    or
    result = convertThrowStatementFromRaw(e)
    or
    result = convertTryStatementFromRaw(e)
    or
    result = convertTtsStatementFromRaw(e)
    or
    result = convertUncheckedStatementFromRaw(e)
    or
    result = convertUpdateStatementFromRaw(e)
    or
    result = convertUsingStatementFromRaw(e)
    or
    result = convertWhileStatementFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TStringType`, if possible.
   */
  TStringType convertStringTypeFromRaw(Raw::Element e) {
    result = convertStringLengthTypeFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TTableFieldReference`, if possible.
   */
  TTableFieldReference convertTableFieldReferenceFromRaw(Raw::Element e) {
    result = convertNamedFieldReferenceFromRaw(e)
    or
    result = convertNumberedFieldReferenceFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TTtsStatement`, if possible.
   */
  TTtsStatement convertTtsStatementFromRaw(Raw::Element e) {
    result = convertTtsAbortStatementFromRaw(e)
    or
    result = convertTtsBeginStatementFromRaw(e)
    or
    result = convertTtsEndStatementFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TUnaryExpression`, if possible.
   */
  TUnaryExpression convertUnaryExpressionFromRaw(Raw::Element e) {
    result = convertNotExpressionFromRaw(e)
    or
    result = convertPhysicalNotExpressionFromRaw(e)
    or
    result = convertUnaryMinusExpressionFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TValidTimeState`, if possible.
   */
  TValidTimeState convertValidTimeStateFromRaw(Raw::Element e) {
    result = convertValidTimeStateDateFromRaw(e)
    or
    result = convertValidTimeStateRangeFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TVariableDeclaration`, if possible.
   */
  TVariableDeclaration convertVariableDeclarationFromRaw(Raw::Element e) {
    result = convertParameterDeclarationFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TXppTuple`, if possible.
   */
  TXppTuple convertXppTupleFromRaw(Raw::Element e) {
    result = convertAttributeNamedParameterEntryFromRaw(e)
    or
    result = convertCompilationUnitRegionEntryFromRaw(e)
    or
    result = convertEvaluationActualParameterEntryFromRaw(e)
    or
    result = convertModelElementUsingEntryFromRaw(e)
    or
    result = convertSwitchStatementCaseEntryFromRaw(e)
    or
    result = convertTryStatementCatchEntryFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a raw DB element to a synthesized `TXppType`, if possible.
   */
  TXppType convertXppTypeFromRaw(Raw::Element e) {
    result = convertAnyTypeFromRaw(e)
    or
    result = convertBooleanTypeFromRaw(e)
    or
    result = convertContainerTypeFromRaw(e)
    or
    result = convertDateTimeTypeFromRaw(e)
    or
    result = convertDateTypeFromRaw(e)
    or
    result = convertDblTypeFromRaw(e)
    or
    result = convertEnumerationTypeFromRaw(e)
    or
    result = convertGenericXppTypeFromRaw(e)
    or
    result = convertGuidTypeFromRaw(e)
    or
    result = convertInt64TypeFromRaw(e)
    or
    result = convertIntTypeFromRaw(e)
    or
    result = convertProvidedTypeFromRaw(e)
    or
    result = convertStringTypeFromRaw(e)
    or
    result = convertVarTypeFromRaw(e)
    or
    result = convertVoidTypeFromRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAddExpression` to a raw DB element, if possible.
   */
  Raw::Element convertAddExpressionToRaw(TAddExpression e) { e = TAddExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAllFieldsSelection` to a raw DB element, if possible.
   */
  Raw::Element convertAllFieldsSelectionToRaw(TAllFieldsSelection e) {
    e = TAllFieldsSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAndExpression` to a raw DB element, if possible.
   */
  Raw::Element convertAndExpressionToRaw(TAndExpression e) { e = TAndExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAnyType` to a raw DB element, if possible.
   */
  Raw::Element convertAnyTypeToRaw(TAnyType e) { e = TAnyType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TArraySpecification` to a raw DB element, if possible.
   */
  Raw::Element convertArraySpecificationToRaw(TArraySpecification e) {
    e = TArraySpecification(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAsClrExpression` to a raw DB element, if possible.
   */
  Raw::Element convertAsClrExpressionToRaw(TAsClrExpression e) { e = TAsClrExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAsExpression` to a raw DB element, if possible.
   */
  Raw::Element convertAsExpressionToRaw(TAsExpression e) { e = TAsExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignDecrementStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignDecrementStatementToRaw(TAssignDecrementStatement e) {
    e = TAssignDecrementStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignDivideStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignDivideStatementToRaw(TAssignDivideStatement e) {
    e = TAssignDivideStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignEqualStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignEqualStatementToRaw(TAssignEqualStatement e) {
    e = TAssignEqualStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignIncrementStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignIncrementStatementToRaw(TAssignIncrementStatement e) {
    e = TAssignIncrementStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignMultipleFieldStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignMultipleFieldStatementToRaw(TAssignMultipleFieldStatement e) {
    e = TAssignMultipleFieldStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignMultiplyStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignMultiplyStatementToRaw(TAssignMultiplyStatement e) {
    e = TAssignMultiplyStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignPostDecrementStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignPostDecrementStatementToRaw(TAssignPostDecrementStatement e) {
    e = TAssignPostDecrementStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignPostIncrementStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignPostIncrementStatementToRaw(TAssignPostIncrementStatement e) {
    e = TAssignPostIncrementStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignPreDecrementStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignPreDecrementStatementToRaw(TAssignPreDecrementStatement e) {
    e = TAssignPreDecrementStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignPreIncrementStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignPreIncrementStatementToRaw(TAssignPreIncrementStatement e) {
    e = TAssignPreIncrementStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignmentEventHandlerClr` to a raw DB element, if possible.
   */
  Raw::Element convertAssignmentEventHandlerClrToRaw(TAssignmentEventHandlerClr e) {
    e = TAssignmentEventHandlerClr(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignmentEventHandlerInstance` to a raw DB element, if possible.
   */
  Raw::Element convertAssignmentEventHandlerInstanceToRaw(TAssignmentEventHandlerInstance e) {
    e = TAssignmentEventHandlerInstance(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAttribute` to a raw DB element, if possible.
   */
  Raw::Element convertAttributeToRaw(TAttribute e) { e = TAttribute(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAttributeExpression` to a raw DB element, if possible.
   */
  Raw::Element convertAttributeExpressionToRaw(TAttributeExpression e) {
    e = TAttributeExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAttributeList` to a raw DB element, if possible.
   */
  Raw::Element convertAttributeListToRaw(TAttributeList e) { e = TAttributeList(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAttributeNamedParameterEntry` to a raw DB element, if possible.
   */
  Raw::Element convertAttributeNamedParameterEntryToRaw(TAttributeNamedParameterEntry e) {
    e = TAttributeNamedParameterEntry(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAvgAggregateSelection` to a raw DB element, if possible.
   */
  Raw::Element convertAvgAggregateSelectionToRaw(TAvgAggregateSelection e) {
    e = TAvgAggregateSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TBooleanAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertBooleanAttributeLiteralToRaw(TBooleanAttributeLiteral e) {
    e = TBooleanAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TBooleanLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertBooleanLiteralExpressionToRaw(TBooleanLiteralExpression e) {
    e = TBooleanLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TBooleanType` to a raw DB element, if possible.
   */
  Raw::Element convertBooleanTypeToRaw(TBooleanType e) { e = TBooleanType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TBreakStatement` to a raw DB element, if possible.
   */
  Raw::Element convertBreakStatementToRaw(TBreakStatement e) { e = TBreakStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TBreakpointStatement` to a raw DB element, if possible.
   */
  Raw::Element convertBreakpointStatementToRaw(TBreakpointStatement e) {
    e = TBreakpointStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCaseDefault` to a raw DB element, if possible.
   */
  Raw::Element convertCaseDefaultToRaw(TCaseDefault e) { e = TCaseDefault(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCaseValues` to a raw DB element, if possible.
   */
  Raw::Element convertCaseValuesToRaw(TCaseValues e) { e = TCaseValues(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCatchAllValues` to a raw DB element, if possible.
   */
  Raw::Element convertCatchAllValuesToRaw(TCatchAllValues e) { e = TCatchAllValues(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCatchExpression` to a raw DB element, if possible.
   */
  Raw::Element convertCatchExpressionToRaw(TCatchExpression e) { e = TCatchExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCatchUpdateConflict` to a raw DB element, if possible.
   */
  Raw::Element convertCatchUpdateConflictToRaw(TCatchUpdateConflict e) {
    e = TCatchUpdateConflict(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TChangeCompanyStatement` to a raw DB element, if possible.
   */
  Raw::Element convertChangeCompanyStatementToRaw(TChangeCompanyStatement e) {
    e = TChangeCompanyStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TClass` to a raw DB element, if possible.
   */
  Raw::Element convertClassToRaw(TClass e) { e = TClass(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TClassAccessModifier` to a raw DB element, if possible.
   */
  Raw::Element convertClassAccessModifierToRaw(TClassAccessModifier e) {
    e = TClassAccessModifier(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TClrEnumerationLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertClrEnumerationLiteralExpressionToRaw(TClrEnumerationLiteralExpression e) {
    e = TClrEnumerationLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TClrType` to a raw DB element, if possible.
   */
  Raw::Element convertClrTypeToRaw(TClrType e) { e = TClrType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TComment` to a raw DB element, if possible.
   */
  Raw::Element convertCommentToRaw(TComment e) { e = TComment(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCompilationUnitRegionEntry` to a raw DB element, if possible.
   */
  Raw::Element convertCompilationUnitRegionEntryToRaw(TCompilationUnitRegionEntry e) {
    e = TCompilationUnitRegionEntry(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCompoundStatement` to a raw DB element, if possible.
   */
  Raw::Element convertCompoundStatementToRaw(TCompoundStatement e) {
    e = TCompoundStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TConditionalExpression` to a raw DB element, if possible.
   */
  Raw::Element convertConditionalExpressionToRaw(TConditionalExpression e) {
    e = TConditionalExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TContainerAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertContainerAttributeLiteralToRaw(TContainerAttributeLiteral e) {
    e = TContainerAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TContainerLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertContainerLiteralExpressionToRaw(TContainerLiteralExpression e) {
    e = TContainerLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TContainerType` to a raw DB element, if possible.
   */
  Raw::Element convertContainerTypeToRaw(TContainerType e) { e = TContainerType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TContinueStatement` to a raw DB element, if possible.
   */
  Raw::Element convertContinueStatementToRaw(TContinueStatement e) {
    e = TContinueStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCountAggregateSelection` to a raw DB element, if possible.
   */
  Raw::Element convertCountAggregateSelectionToRaw(TCountAggregateSelection e) {
    e = TCountAggregateSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCrossCompanyAll` to a raw DB element, if possible.
   */
  Raw::Element convertCrossCompanyAllToRaw(TCrossCompanyAll e) { e = TCrossCompanyAll(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCrossCompanyContainer` to a raw DB element, if possible.
   */
  Raw::Element convertCrossCompanyContainerToRaw(TCrossCompanyContainer e) {
    e = TCrossCompanyContainer(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDateAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertDateAttributeLiteralToRaw(TDateAttributeLiteral e) {
    e = TDateAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDateLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertDateLiteralExpressionToRaw(TDateLiteralExpression e) {
    e = TDateLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDateTimeAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertDateTimeAttributeLiteralToRaw(TDateTimeAttributeLiteral e) {
    e = TDateTimeAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDateTimeLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertDateTimeLiteralExpressionToRaw(TDateTimeLiteralExpression e) {
    e = TDateTimeLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDateTimeType` to a raw DB element, if possible.
   */
  Raw::Element convertDateTimeTypeToRaw(TDateTimeType e) { e = TDateTimeType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDateType` to a raw DB element, if possible.
   */
  Raw::Element convertDateTypeToRaw(TDateType e) { e = TDateType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDblAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertDblAttributeLiteralToRaw(TDblAttributeLiteral e) {
    e = TDblAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDblType` to a raw DB element, if possible.
   */
  Raw::Element convertDblTypeToRaw(TDblType e) { e = TDblType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDelegate` to a raw DB element, if possible.
   */
  Raw::Element convertDelegateToRaw(TDelegate e) { e = TDelegate(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDeleteStatement` to a raw DB element, if possible.
   */
  Raw::Element convertDeleteStatementToRaw(TDeleteStatement e) { e = TDeleteStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDivideExpression` to a raw DB element, if possible.
   */
  Raw::Element convertDivideExpressionToRaw(TDivideExpression e) { e = TDivideExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDoWhileStatement` to a raw DB element, if possible.
   */
  Raw::Element convertDoWhileStatementToRaw(TDoWhileStatement e) { e = TDoWhileStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEmptyExpression` to a raw DB element, if possible.
   */
  Raw::Element convertEmptyExpressionToRaw(TEmptyExpression e) { e = TEmptyExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEmptyStatement` to a raw DB element, if possible.
   */
  Raw::Element convertEmptyStatementToRaw(TEmptyStatement e) { e = TEmptyStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEnumAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertEnumAttributeLiteralToRaw(TEnumAttributeLiteral e) {
    e = TEnumAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEnumerationLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertEnumerationLiteralExpressionToRaw(TEnumerationLiteralExpression e) {
    e = TEnumerationLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEnumerationType` to a raw DB element, if possible.
   */
  Raw::Element convertEnumerationTypeToRaw(TEnumerationType e) { e = TEnumerationType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEqualExpression` to a raw DB element, if possible.
   */
  Raw::Element convertEqualExpressionToRaw(TEqualExpression e) { e = TEqualExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEvaluationActualParameterEntry` to a raw DB element, if possible.
   */
  Raw::Element convertEvaluationActualParameterEntryToRaw(TEvaluationActualParameterEntry e) {
    e = TEvaluationActualParameterEntry(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TExplicitSelection` to a raw DB element, if possible.
   */
  Raw::Element convertExplicitSelectionToRaw(TExplicitSelection e) {
    e = TExplicitSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TExpressionCompilationUnit` to a raw DB element, if possible.
   */
  Raw::Element convertExpressionCompilationUnitToRaw(TExpressionCompilationUnit e) {
    e = TExpressionCompilationUnit(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TExpressionQualifier` to a raw DB element, if possible.
   */
  Raw::Element convertExpressionQualifierToRaw(TExpressionQualifier e) {
    e = TExpressionQualifier(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TExpressionStatement` to a raw DB element, if possible.
   */
  Raw::Element convertExpressionStatementToRaw(TExpressionStatement e) {
    e = TExpressionStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFieldAssignment` to a raw DB element, if possible.
   */
  Raw::Element convertFieldAssignmentToRaw(TFieldAssignment e) { e = TFieldAssignment(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFieldSelection` to a raw DB element, if possible.
   */
  Raw::Element convertFieldSelectionToRaw(TFieldSelection e) { e = TFieldSelection(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFile` to a raw DB element, if possible.
   */
  Raw::Element convertFileToRaw(TFile e) { e = TFile(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFindStatement` to a raw DB element, if possible.
   */
  Raw::Element convertFindStatementToRaw(TFindStatement e) { e = TFindStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFlushStatement` to a raw DB element, if possible.
   */
  Raw::Element convertFlushStatementToRaw(TFlushStatement e) { e = TFlushStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForDeclarationAssign` to a raw DB element, if possible.
   */
  Raw::Element convertForDeclarationAssignToRaw(TForDeclarationAssign e) {
    e = TForDeclarationAssign(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForFieldAssign` to a raw DB element, if possible.
   */
  Raw::Element convertForFieldAssignToRaw(TForFieldAssign e) { e = TForFieldAssign(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForFieldDecrementAssign` to a raw DB element, if possible.
   */
  Raw::Element convertForFieldDecrementAssignToRaw(TForFieldDecrementAssign e) {
    e = TForFieldDecrementAssign(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForFieldIncrementAssign` to a raw DB element, if possible.
   */
  Raw::Element convertForFieldIncrementAssignToRaw(TForFieldIncrementAssign e) {
    e = TForFieldIncrementAssign(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForFieldPostDecrement` to a raw DB element, if possible.
   */
  Raw::Element convertForFieldPostDecrementToRaw(TForFieldPostDecrement e) {
    e = TForFieldPostDecrement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForFieldPostIncrement` to a raw DB element, if possible.
   */
  Raw::Element convertForFieldPostIncrementToRaw(TForFieldPostIncrement e) {
    e = TForFieldPostIncrement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForFieldPreDecrement` to a raw DB element, if possible.
   */
  Raw::Element convertForFieldPreDecrementToRaw(TForFieldPreDecrement e) {
    e = TForFieldPreDecrement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForFieldPreIncrement` to a raw DB element, if possible.
   */
  Raw::Element convertForFieldPreIncrementToRaw(TForFieldPreIncrement e) {
    e = TForFieldPreIncrement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForStatement` to a raw DB element, if possible.
   */
  Raw::Element convertForStatementToRaw(TForStatement e) { e = TForStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFormControl` to a raw DB element, if possible.
   */
  Raw::Element convertFormControlToRaw(TFormControl e) { e = TFormControl(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFormDataField` to a raw DB element, if possible.
   */
  Raw::Element convertFormDataFieldToRaw(TFormDataField e) { e = TFormDataField(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFormDataSource` to a raw DB element, if possible.
   */
  Raw::Element convertFormDataSourceToRaw(TFormDataSource e) { e = TFormDataSource(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFormElementType` to a raw DB element, if possible.
   */
  Raw::Element convertFormElementTypeToRaw(TFormElementType e) { e = TFormElementType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFormModelElement` to a raw DB element, if possible.
   */
  Raw::Element convertFormModelElementToRaw(TFormModelElement e) { e = TFormModelElement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFunctionCall` to a raw DB element, if possible.
   */
  Raw::Element convertFunctionCallToRaw(TFunctionCall e) { e = TFunctionCall(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFunctionDeclaration` to a raw DB element, if possible.
   */
  Raw::Element convertFunctionDeclarationToRaw(TFunctionDeclaration e) {
    e = TFunctionDeclaration(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TGlobalOrderElement` to a raw DB element, if possible.
   */
  Raw::Element convertGlobalOrderElementToRaw(TGlobalOrderElement e) {
    e = TGlobalOrderElement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TGreaterThanExpression` to a raw DB element, if possible.
   */
  Raw::Element convertGreaterThanExpressionToRaw(TGreaterThanExpression e) {
    e = TGreaterThanExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TGreaterThanOrEqualExpression` to a raw DB element, if possible.
   */
  Raw::Element convertGreaterThanOrEqualExpressionToRaw(TGreaterThanOrEqualExpression e) {
    e = TGreaterThanOrEqualExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TGuidAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertGuidAttributeLiteralToRaw(TGuidAttributeLiteral e) {
    e = TGuidAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TGuidType` to a raw DB element, if possible.
   */
  Raw::Element convertGuidTypeToRaw(TGuidType e) { e = TGuidType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIfStatement` to a raw DB element, if possible.
   */
  Raw::Element convertIfStatementToRaw(TIfStatement e) { e = TIfStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIfThenElseStatement` to a raw DB element, if possible.
   */
  Raw::Element convertIfThenElseStatementToRaw(TIfThenElseStatement e) {
    e = TIfThenElseStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TImplicitSelection` to a raw DB element, if possible.
   */
  Raw::Element convertImplicitSelectionToRaw(TImplicitSelection e) {
    e = TImplicitSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInExpression` to a raw DB element, if possible.
   */
  Raw::Element convertInExpressionToRaw(TInExpression e) { e = TInExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInsertFieldSpecification` to a raw DB element, if possible.
   */
  Raw::Element convertInsertFieldSpecificationToRaw(TInsertFieldSpecification e) {
    e = TInsertFieldSpecification(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInsertStatement` to a raw DB element, if possible.
   */
  Raw::Element convertInsertStatementToRaw(TInsertStatement e) { e = TInsertStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInt64AttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertInt64AttributeLiteralToRaw(TInt64AttributeLiteral e) {
    e = TInt64AttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInt64LiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertInt64LiteralExpressionToRaw(TInt64LiteralExpression e) {
    e = TInt64LiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInt64Type` to a raw DB element, if possible.
   */
  Raw::Element convertInt64TypeToRaw(TInt64Type e) { e = TInt64Type(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIntAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertIntAttributeLiteralToRaw(TIntAttributeLiteral e) {
    e = TIntAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIntLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertIntLiteralExpressionToRaw(TIntLiteralExpression e) {
    e = TIntLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIntType` to a raw DB element, if possible.
   */
  Raw::Element convertIntTypeToRaw(TIntType e) { e = TIntType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIntegerDivideExpression` to a raw DB element, if possible.
   */
  Raw::Element convertIntegerDivideExpressionToRaw(TIntegerDivideExpression e) {
    e = TIntegerDivideExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInterface` to a raw DB element, if possible.
   */
  Raw::Element convertInterfaceToRaw(TInterface e) { e = TInterface(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIntrinsic` to a raw DB element, if possible.
   */
  Raw::Element convertIntrinsicToRaw(TIntrinsic e) { e = TIntrinsic(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIntrinsicAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertIntrinsicAttributeLiteralToRaw(TIntrinsicAttributeLiteral e) {
    e = TIntrinsicAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIsClrExpression` to a raw DB element, if possible.
   */
  Raw::Element convertIsClrExpressionToRaw(TIsClrExpression e) { e = TIsClrExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIsExpression` to a raw DB element, if possible.
   */
  Raw::Element convertIsExpressionToRaw(TIsExpression e) { e = TIsExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TJoinSpecification` to a raw DB element, if possible.
   */
  Raw::Element convertJoinSpecificationToRaw(TJoinSpecification e) {
    e = TJoinSpecification(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLessThanExpression` to a raw DB element, if possible.
   */
  Raw::Element convertLessThanExpressionToRaw(TLessThanExpression e) {
    e = TLessThanExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLessThanOrEqualExpression` to a raw DB element, if possible.
   */
  Raw::Element convertLessThanOrEqualExpressionToRaw(TLessThanOrEqualExpression e) {
    e = TLessThanOrEqualExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLikeExpression` to a raw DB element, if possible.
   */
  Raw::Element convertLikeExpressionToRaw(TLikeExpression e) { e = TLikeExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLocalDeclarationsStatement` to a raw DB element, if possible.
   */
  Raw::Element convertLocalDeclarationsStatementToRaw(TLocalDeclarationsStatement e) {
    e = TLocalDeclarationsStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLocation` to a raw DB element, if possible.
   */
  Raw::Element convertLocationToRaw(TLocation e) { e = TLocation(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TMaxAggregateSelection` to a raw DB element, if possible.
   */
  Raw::Element convertMaxAggregateSelectionToRaw(TMaxAggregateSelection e) {
    e = TMaxAggregateSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TMethod` to a raw DB element, if possible.
   */
  Raw::Element convertMethodToRaw(TMethod e) { e = TMethod(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TMinAggregateSelection` to a raw DB element, if possible.
   */
  Raw::Element convertMinAggregateSelectionToRaw(TMinAggregateSelection e) {
    e = TMinAggregateSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TModExpression` to a raw DB element, if possible.
   */
  Raw::Element convertModExpressionToRaw(TModExpression e) { e = TModExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TModelElementUsingEntry` to a raw DB element, if possible.
   */
  Raw::Element convertModelElementUsingEntryToRaw(TModelElementUsingEntry e) {
    e = TModelElementUsingEntry(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TModifier` to a raw DB element, if possible.
   */
  Raw::Element convertModifierToRaw(TModifier e) { e = TModifier(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TMoveCursorStatement` to a raw DB element, if possible.
   */
  Raw::Element convertMoveCursorStatementToRaw(TMoveCursorStatement e) {
    e = TMoveCursorStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TMultiplyExpression` to a raw DB element, if possible.
   */
  Raw::Element convertMultiplyExpressionToRaw(TMultiplyExpression e) {
    e = TMultiplyExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNamedFieldReference` to a raw DB element, if possible.
   */
  Raw::Element convertNamedFieldReferenceToRaw(TNamedFieldReference e) {
    e = TNamedFieldReference(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNewCall` to a raw DB element, if possible.
   */
  Raw::Element convertNewCallToRaw(TNewCall e) { e = TNewCall(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNewClrArrayExpression` to a raw DB element, if possible.
   */
  Raw::Element convertNewClrArrayExpressionToRaw(TNewClrArrayExpression e) {
    e = TNewClrArrayExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNewClrCall` to a raw DB element, if possible.
   */
  Raw::Element convertNewClrCallToRaw(TNewClrCall e) { e = TNewClrCall(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNextExpression` to a raw DB element, if possible.
   */
  Raw::Element convertNextExpressionToRaw(TNextExpression e) { e = TNextExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNotEqualExpression` to a raw DB element, if possible.
   */
  Raw::Element convertNotEqualExpressionToRaw(TNotEqualExpression e) {
    e = TNotEqualExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNotExpression` to a raw DB element, if possible.
   */
  Raw::Element convertNotExpressionToRaw(TNotExpression e) { e = TNotExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNullLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertNullLiteralExpressionToRaw(TNullLiteralExpression e) {
    e = TNullLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNumberedFieldReference` to a raw DB element, if possible.
   */
  Raw::Element convertNumberedFieldReferenceToRaw(TNumberedFieldReference e) {
    e = TNumberedFieldReference(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TOrExpression` to a raw DB element, if possible.
   */
  Raw::Element convertOrExpressionToRaw(TOrExpression e) { e = TOrExpression(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TParameterDeclaration` to a raw DB element, if possible.
   */
  Raw::Element convertParameterDeclarationToRaw(TParameterDeclaration e) {
    e = TParameterDeclaration(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TPhysicalAndExpression` to a raw DB element, if possible.
   */
  Raw::Element convertPhysicalAndExpressionToRaw(TPhysicalAndExpression e) {
    e = TPhysicalAndExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TPhysicalNotExpression` to a raw DB element, if possible.
   */
  Raw::Element convertPhysicalNotExpressionToRaw(TPhysicalNotExpression e) {
    e = TPhysicalNotExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TPhysicalOrExpression` to a raw DB element, if possible.
   */
  Raw::Element convertPhysicalOrExpressionToRaw(TPhysicalOrExpression e) {
    e = TPhysicalOrExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TPhysicalXorExpression` to a raw DB element, if possible.
   */
  Raw::Element convertPhysicalXorExpressionToRaw(TPhysicalXorExpression e) {
    e = TPhysicalXorExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TPlaceholder` to a raw DB element, if possible.
   */
  Raw::Element convertPlaceholderToRaw(TPlaceholder e) { e = TPlaceholder(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TPrintStatement` to a raw DB element, if possible.
   */
  Raw::Element convertPrintStatementToRaw(TPrintStatement e) { e = TPrintStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TProvidedType` to a raw DB element, if possible.
   */
  Raw::Element convertProvidedTypeToRaw(TProvidedType e) { e = TProvidedType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TProvidedTypeStaticCall` to a raw DB element, if possible.
   */
  Raw::Element convertProvidedTypeStaticCallToRaw(TProvidedTypeStaticCall e) {
    e = TProvidedTypeStaticCall(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifiedCall` to a raw DB element, if possible.
   */
  Raw::Element convertQualifiedCallToRaw(TQualifiedCall e) { e = TQualifiedCall(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifiedField` to a raw DB element, if possible.
   */
  Raw::Element convertQualifiedFieldToRaw(TQualifiedField e) { e = TQualifiedField(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifiedInstanceName` to a raw DB element, if possible.
   */
  Raw::Element convertQualifiedInstanceNameToRaw(TQualifiedInstanceName e) {
    e = TQualifiedInstanceName(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifiedNumberedField` to a raw DB element, if possible.
   */
  Raw::Element convertQualifiedNumberedFieldToRaw(TQualifiedNumberedField e) {
    e = TQualifiedNumberedField(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifiedStaticCall` to a raw DB element, if possible.
   */
  Raw::Element convertQualifiedStaticCallToRaw(TQualifiedStaticCall e) {
    e = TQualifiedStaticCall(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifiedStaticField` to a raw DB element, if possible.
   */
  Raw::Element convertQualifiedStaticFieldToRaw(TQualifiedStaticField e) {
    e = TQualifiedStaticField(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifiedStaticFieldExpression` to a raw DB element, if possible.
   */
  Raw::Element convertQualifiedStaticFieldExpressionToRaw(TQualifiedStaticFieldExpression e) {
    e = TQualifiedStaticFieldExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQuery` to a raw DB element, if possible.
   */
  Raw::Element convertQueryToRaw(TQuery e) { e = TQuery(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQueryDataSource` to a raw DB element, if possible.
   */
  Raw::Element convertQueryDataSourceToRaw(TQueryDataSource e) { e = TQueryDataSource(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQueryDataSourceHaving` to a raw DB element, if possible.
   */
  Raw::Element convertQueryDataSourceHavingToRaw(TQueryDataSourceHaving e) {
    e = TQueryDataSourceHaving(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQueryDataSourceRange` to a raw DB element, if possible.
   */
  Raw::Element convertQueryDataSourceRangeToRaw(TQueryDataSourceRange e) {
    e = TQueryDataSourceRange(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQueryDataSourceRelation` to a raw DB element, if possible.
   */
  Raw::Element convertQueryDataSourceRelationToRaw(TQueryDataSourceRelation e) {
    e = TQueryDataSourceRelation(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQueryModelElement` to a raw DB element, if possible.
   */
  Raw::Element convertQueryModelElementToRaw(TQueryModelElement e) {
    e = TQueryModelElement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TRealLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertRealLiteralExpressionToRaw(TRealLiteralExpression e) {
    e = TRealLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TRetryStatement` to a raw DB element, if possible.
   */
  Raw::Element convertRetryStatementToRaw(TRetryStatement e) { e = TRetryStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TReturnStatement` to a raw DB element, if possible.
   */
  Raw::Element convertReturnStatementToRaw(TReturnStatement e) { e = TReturnStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSearchStatement` to a raw DB element, if possible.
   */
  Raw::Element convertSearchStatementToRaw(TSearchStatement e) { e = TSearchStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TShiftLeftExpression` to a raw DB element, if possible.
   */
  Raw::Element convertShiftLeftExpressionToRaw(TShiftLeftExpression e) {
    e = TShiftLeftExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TShiftRightExpression` to a raw DB element, if possible.
   */
  Raw::Element convertShiftRightExpressionToRaw(TShiftRightExpression e) {
    e = TShiftRightExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSimpleField` to a raw DB element, if possible.
   */
  Raw::Element convertSimpleFieldToRaw(TSimpleField e) { e = TSimpleField(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSimpleInstanceName` to a raw DB element, if possible.
   */
  Raw::Element convertSimpleInstanceNameToRaw(TSimpleInstanceName e) {
    e = TSimpleInstanceName(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSimpleOrderElement` to a raw DB element, if possible.
   */
  Raw::Element convertSimpleOrderElementToRaw(TSimpleOrderElement e) {
    e = TSimpleOrderElement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStaticField` to a raw DB element, if possible.
   */
  Raw::Element convertStaticFieldToRaw(TStaticField e) { e = TStaticField(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStaticMethodCall` to a raw DB element, if possible.
   */
  Raw::Element convertStaticMethodCallToRaw(TStaticMethodCall e) { e = TStaticMethodCall(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStaticQualifier` to a raw DB element, if possible.
   */
  Raw::Element convertStaticQualifierToRaw(TStaticQualifier e) { e = TStaticQualifier(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStringAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertStringAttributeLiteralToRaw(TStringAttributeLiteral e) {
    e = TStringAttributeLiteral(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStringLengthType` to a raw DB element, if possible.
   */
  Raw::Element convertStringLengthTypeToRaw(TStringLengthType e) { e = TStringLengthType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStringLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertStringLiteralExpressionToRaw(TStringLiteralExpression e) {
    e = TStringLiteralExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSubtractExpression` to a raw DB element, if possible.
   */
  Raw::Element convertSubtractExpressionToRaw(TSubtractExpression e) {
    e = TSubtractExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSumAggregateSelection` to a raw DB element, if possible.
   */
  Raw::Element convertSumAggregateSelectionToRaw(TSumAggregateSelection e) {
    e = TSumAggregateSelection(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSuperCall` to a raw DB element, if possible.
   */
  Raw::Element convertSuperCallToRaw(TSuperCall e) { e = TSuperCall(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSwitchCase` to a raw DB element, if possible.
   */
  Raw::Element convertSwitchCaseToRaw(TSwitchCase e) { e = TSwitchCase(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSwitchStatement` to a raw DB element, if possible.
   */
  Raw::Element convertSwitchStatementToRaw(TSwitchStatement e) { e = TSwitchStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSwitchStatementCaseEntry` to a raw DB element, if possible.
   */
  Raw::Element convertSwitchStatementCaseEntryToRaw(TSwitchStatementCaseEntry e) {
    e = TSwitchStatementCaseEntry(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTable` to a raw DB element, if possible.
   */
  Raw::Element convertTableToRaw(TTable e) { e = TTable(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTableFieldDeclaration` to a raw DB element, if possible.
   */
  Raw::Element convertTableFieldDeclarationToRaw(TTableFieldDeclaration e) {
    e = TTableFieldDeclaration(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTableLookupExpression` to a raw DB element, if possible.
   */
  Raw::Element convertTableLookupExpressionToRaw(TTableLookupExpression e) {
    e = TTableLookupExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TThrowStatement` to a raw DB element, if possible.
   */
  Raw::Element convertThrowStatementToRaw(TThrowStatement e) { e = TThrowStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTryStatement` to a raw DB element, if possible.
   */
  Raw::Element convertTryStatementToRaw(TTryStatement e) { e = TTryStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTryStatementCatchEntry` to a raw DB element, if possible.
   */
  Raw::Element convertTryStatementCatchEntryToRaw(TTryStatementCatchEntry e) {
    e = TTryStatementCatchEntry(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTtsAbortStatement` to a raw DB element, if possible.
   */
  Raw::Element convertTtsAbortStatementToRaw(TTtsAbortStatement e) {
    e = TTtsAbortStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTtsBeginStatement` to a raw DB element, if possible.
   */
  Raw::Element convertTtsBeginStatementToRaw(TTtsBeginStatement e) {
    e = TTtsBeginStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTtsEndStatement` to a raw DB element, if possible.
   */
  Raw::Element convertTtsEndStatementToRaw(TTtsEndStatement e) { e = TTtsEndStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TUnaryMinusExpression` to a raw DB element, if possible.
   */
  Raw::Element convertUnaryMinusExpressionToRaw(TUnaryMinusExpression e) {
    e = TUnaryMinusExpression(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TUncheckedStatement` to a raw DB element, if possible.
   */
  Raw::Element convertUncheckedStatementToRaw(TUncheckedStatement e) {
    e = TUncheckedStatement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TUnspecifiedElement` to a raw DB element, if possible.
   */
  Raw::Element convertUnspecifiedElementToRaw(TUnspecifiedElement e) {
    e = TUnspecifiedElement(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TUpdateStatement` to a raw DB element, if possible.
   */
  Raw::Element convertUpdateStatementToRaw(TUpdateStatement e) { e = TUpdateStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TUsingStatement` to a raw DB element, if possible.
   */
  Raw::Element convertUsingStatementToRaw(TUsingStatement e) { e = TUsingStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TValidTimeStateDate` to a raw DB element, if possible.
   */
  Raw::Element convertValidTimeStateDateToRaw(TValidTimeStateDate e) {
    e = TValidTimeStateDate(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TValidTimeStateRange` to a raw DB element, if possible.
   */
  Raw::Element convertValidTimeStateRangeToRaw(TValidTimeStateRange e) {
    e = TValidTimeStateRange(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TVarType` to a raw DB element, if possible.
   */
  Raw::Element convertVarTypeToRaw(TVarType e) { e = TVarType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TVoidType` to a raw DB element, if possible.
   */
  Raw::Element convertVoidTypeToRaw(TVoidType e) { e = TVoidType(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TWhileStatement` to a raw DB element, if possible.
   */
  Raw::Element convertWhileStatementToRaw(TWhileStatement e) { e = TWhileStatement(result) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TXppTypeCompilationUnit` to a raw DB element, if possible.
   */
  Raw::Element convertXppTypeCompilationUnitToRaw(TXppTypeCompilationUnit e) {
    e = TXppTypeCompilationUnit(result)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAggregateSelection` to a raw DB element, if possible.
   */
  Raw::Element convertAggregateSelectionToRaw(TAggregateSelection e) {
    result = convertAvgAggregateSelectionToRaw(e)
    or
    result = convertCountAggregateSelectionToRaw(e)
    or
    result = convertMaxAggregateSelectionToRaw(e)
    or
    result = convertMinAggregateSelectionToRaw(e)
    or
    result = convertSumAggregateSelectionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignmentBinary` to a raw DB element, if possible.
   */
  Raw::Element convertAssignmentBinaryToRaw(TAssignmentBinary e) {
    result = convertAssignDecrementStatementToRaw(e)
    or
    result = convertAssignDivideStatementToRaw(e)
    or
    result = convertAssignEqualStatementToRaw(e)
    or
    result = convertAssignIncrementStatementToRaw(e)
    or
    result = convertAssignMultiplyStatementToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignmentEventHandlerBase` to a raw DB element, if possible.
   */
  Raw::Element convertAssignmentEventHandlerBaseToRaw(TAssignmentEventHandlerBase e) {
    result = convertAssignmentEventHandlerInstanceToRaw(e)
    or
    result = convertAssignmentEventHandlerStaticToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignmentEventHandlerStatic` to a raw DB element, if possible.
   */
  Raw::Element convertAssignmentEventHandlerStaticToRaw(TAssignmentEventHandlerStatic e) {
    result = convertAssignmentEventHandlerClrToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignmentSingleField` to a raw DB element, if possible.
   */
  Raw::Element convertAssignmentSingleFieldToRaw(TAssignmentSingleField e) {
    result = convertAssignPostDecrementStatementToRaw(e)
    or
    result = convertAssignPostIncrementStatementToRaw(e)
    or
    result = convertAssignPreDecrementStatementToRaw(e)
    or
    result = convertAssignPreIncrementStatementToRaw(e)
    or
    result = convertAssignmentBinaryToRaw(e)
    or
    result = convertAssignmentEventHandlerBaseToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAssignmentStatement` to a raw DB element, if possible.
   */
  Raw::Element convertAssignmentStatementToRaw(TAssignmentStatement e) {
    result = convertAssignMultipleFieldStatementToRaw(e)
    or
    result = convertAssignmentSingleFieldToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAst` to a raw DB element, if possible.
   */
  Raw::Element convertAstToRaw(TAst e) {
    result = convertArraySpecificationToRaw(e)
    or
    result = convertAttributeToRaw(e)
    or
    result = convertAttributeExpressionToRaw(e)
    or
    result = convertAttributeListToRaw(e)
    or
    result = convertAttributeLiteralToRaw(e)
    or
    result = convertCaseToRaw(e)
    or
    result = convertCatchToRaw(e)
    or
    result = convertClassAccessModifierToRaw(e)
    or
    result = convertCompilationUnitToRaw(e)
    or
    result = convertCrossCompanyToRaw(e)
    or
    result = convertExpressionToRaw(e)
    or
    result = convertFieldAssignmentToRaw(e)
    or
    result = convertFieldSpecificationToRaw(e)
    or
    result = convertForAssignToRaw(e)
    or
    result = convertInsertFieldSpecificationToRaw(e)
    or
    result = convertInstanceNameToRaw(e)
    or
    result = convertJoinSpecificationToRaw(e)
    or
    result = convertModifierToRaw(e)
    or
    result = convertOrderElementToRaw(e)
    or
    result = convertQualifierToRaw(e)
    or
    result = convertQueryToRaw(e)
    or
    result = convertQueryDataSourceToRaw(e)
    or
    result = convertQueryDataSourceHavingToRaw(e)
    or
    result = convertQueryDataSourceRangeToRaw(e)
    or
    result = convertQueryDataSourceRelationToRaw(e)
    or
    result = convertSelectionToRaw(e)
    or
    result = convertSelectionFieldToRaw(e)
    or
    result = convertStatementToRaw(e)
    or
    result = convertSwitchCaseToRaw(e)
    or
    result = convertTableFieldReferenceToRaw(e)
    or
    result = convertValidTimeStateToRaw(e)
    or
    result = convertXppTypeToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertAttributeLiteralToRaw(TAttributeLiteral e) {
    result = convertContainerAttributeLiteralToRaw(e)
    or
    result = convertDefaultTypeAttributeLiteralToRaw(e)
    or
    result = convertEnumAttributeLiteralToRaw(e)
    or
    result = convertIntrinsicAttributeLiteralToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TBinaryExpression` to a raw DB element, if possible.
   */
  Raw::Element convertBinaryExpressionToRaw(TBinaryExpression e) {
    result = convertAddExpressionToRaw(e)
    or
    result = convertAndExpressionToRaw(e)
    or
    result = convertDivideExpressionToRaw(e)
    or
    result = convertInExpressionToRaw(e)
    or
    result = convertIntegerDivideExpressionToRaw(e)
    or
    result = convertModExpressionToRaw(e)
    or
    result = convertMultiplyExpressionToRaw(e)
    or
    result = convertOrExpressionToRaw(e)
    or
    result = convertPhysicalAndExpressionToRaw(e)
    or
    result = convertPhysicalOrExpressionToRaw(e)
    or
    result = convertPhysicalXorExpressionToRaw(e)
    or
    result = convertRelationalExpressionToRaw(e)
    or
    result = convertShiftLeftExpressionToRaw(e)
    or
    result = convertShiftRightExpressionToRaw(e)
    or
    result = convertSubtractExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCase` to a raw DB element, if possible.
   */
  Raw::Element convertCaseToRaw(TCase e) {
    result = convertCaseDefaultToRaw(e)
    or
    result = convertCaseValuesToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCatch` to a raw DB element, if possible.
   */
  Raw::Element convertCatchToRaw(TCatch e) {
    result = convertCatchAllValuesToRaw(e)
    or
    result = convertCatchExpressionToRaw(e)
    or
    result = convertCatchUpdateConflictToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TChangeStatement` to a raw DB element, if possible.
   */
  Raw::Element convertChangeStatementToRaw(TChangeStatement e) {
    result = convertChangeCompanyStatementToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TClassOrInterface` to a raw DB element, if possible.
   */
  Raw::Element convertClassOrInterfaceToRaw(TClassOrInterface e) {
    result = convertClassToRaw(e)
    or
    result = convertInterfaceToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCompilationUnit` to a raw DB element, if possible.
   */
  Raw::Element convertCompilationUnitToRaw(TCompilationUnit e) {
    result = convertDeclarationToRaw(e)
    or
    result = convertExpressionCompilationUnitToRaw(e)
    or
    result = convertMethodOrDelegateToRaw(e)
    or
    result = convertModelElementToRaw(e)
    or
    result = convertXppTypeCompilationUnitToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TCrossCompany` to a raw DB element, if possible.
   */
  Raw::Element convertCrossCompanyToRaw(TCrossCompany e) {
    result = convertCrossCompanyAllToRaw(e)
    or
    result = convertCrossCompanyContainerToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDeclaration` to a raw DB element, if possible.
   */
  Raw::Element convertDeclarationToRaw(TDeclaration e) {
    result = convertFieldDeclarationToRaw(e)
    or
    result = convertLocalDeclarationToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDefaultTypeAttributeLiteral` to a raw DB element, if possible.
   */
  Raw::Element convertDefaultTypeAttributeLiteralToRaw(TDefaultTypeAttributeLiteral e) {
    result = convertBooleanAttributeLiteralToRaw(e)
    or
    result = convertDateAttributeLiteralToRaw(e)
    or
    result = convertDateTimeAttributeLiteralToRaw(e)
    or
    result = convertDblAttributeLiteralToRaw(e)
    or
    result = convertGuidAttributeLiteralToRaw(e)
    or
    result = convertInt64AttributeLiteralToRaw(e)
    or
    result = convertIntAttributeLiteralToRaw(e)
    or
    result = convertStringAttributeLiteralToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TDefaultTypeLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertDefaultTypeLiteralExpressionToRaw(TDefaultTypeLiteralExpression e) {
    result = convertBooleanLiteralExpressionToRaw(e)
    or
    result = convertDateLiteralExpressionToRaw(e)
    or
    result = convertDateTimeLiteralExpressionToRaw(e)
    or
    result = convertInt64LiteralExpressionToRaw(e)
    or
    result = convertIntLiteralExpressionToRaw(e)
    or
    result = convertRealLiteralExpressionToRaw(e)
    or
    result = convertStringLiteralExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TElement` to a raw DB element, if possible.
   */
  Raw::Element convertElementToRaw(TElement e) {
    result = convertFileToRaw(e)
    or
    result = convertLocatableToRaw(e)
    or
    result = convertLocationToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TErrorElement` to a raw DB element, if possible.
   */
  Raw::Element convertErrorElementToRaw(TErrorElement e) {
    result = convertUnspecifiedElementToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TEvaluation` to a raw DB element, if possible.
   */
  Raw::Element convertEvaluationToRaw(TEvaluation e) {
    result = convertGenericEvaluationToRaw(e)
    or
    result = convertNewCallToRaw(e)
    or
    result = convertNextExpressionToRaw(e)
    or
    result = convertProvidedTypeStaticCallToRaw(e)
    or
    result = convertSuperCallToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TExpression` to a raw DB element, if possible.
   */
  Raw::Element convertExpressionToRaw(TExpression e) {
    result = convertBinaryExpressionToRaw(e)
    or
    result = convertConditionalExpressionToRaw(e)
    or
    result = convertEmptyExpressionToRaw(e)
    or
    result = convertEvaluationToRaw(e)
    or
    result = convertFieldExpressionToRaw(e)
    or
    result = convertIntrinsicToRaw(e)
    or
    result = convertIsAsExpressionToRaw(e)
    or
    result = convertLiteralExpressionToRaw(e)
    or
    result = convertNewClrArrayExpressionToRaw(e)
    or
    result = convertPlaceholderToRaw(e)
    or
    result = convertTableLookupExpressionToRaw(e)
    or
    result = convertUnaryExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFieldDeclaration` to a raw DB element, if possible.
   */
  Raw::Element convertFieldDeclarationToRaw(TFieldDeclaration e) {
    result = convertTableFieldDeclarationToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFieldExpression` to a raw DB element, if possible.
   */
  Raw::Element convertFieldExpressionToRaw(TFieldExpression e) {
    result = convertQualifiedStaticFieldExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFieldSpecification` to a raw DB element, if possible.
   */
  Raw::Element convertFieldSpecificationToRaw(TFieldSpecification e) {
    result = convertQualifiedFieldToRaw(e)
    or
    result = convertQualifiedNumberedFieldToRaw(e)
    or
    result = convertQualifiedStaticFieldToRaw(e)
    or
    result = convertSimpleFieldToRaw(e)
    or
    result = convertStaticFieldToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForAssign` to a raw DB element, if possible.
   */
  Raw::Element convertForAssignToRaw(TForAssign e) {
    result = convertForDeclarationAssignToRaw(e)
    or
    result = convertForExpressionAssignToRaw(e)
    or
    result = convertForFieldPostDecrementToRaw(e)
    or
    result = convertForFieldPostIncrementToRaw(e)
    or
    result = convertForFieldPreDecrementToRaw(e)
    or
    result = convertForFieldPreIncrementToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TForExpressionAssign` to a raw DB element, if possible.
   */
  Raw::Element convertForExpressionAssignToRaw(TForExpressionAssign e) {
    result = convertForFieldAssignToRaw(e)
    or
    result = convertForFieldDecrementAssignToRaw(e)
    or
    result = convertForFieldIncrementAssignToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TFormNestedElement` to a raw DB element, if possible.
   */
  Raw::Element convertFormNestedElementToRaw(TFormNestedElement e) {
    result = convertFormControlToRaw(e)
    or
    result = convertFormDataFieldToRaw(e)
    or
    result = convertFormDataSourceToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TGenericEvaluation` to a raw DB element, if possible.
   */
  Raw::Element convertGenericEvaluationToRaw(TGenericEvaluation e) {
    result = convertFunctionCallToRaw(e)
    or
    result = convertNewClrCallToRaw(e)
    or
    result = convertQualifiedCallToRaw(e)
    or
    result = convertQualifiedStaticCallToRaw(e)
    or
    result = convertStaticMethodCallToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TGenericXppType` to a raw DB element, if possible.
   */
  Raw::Element convertGenericXppTypeToRaw(TGenericXppType e) {
    result = convertClrTypeToRaw(e)
    or
    result = convertNamedTypeToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TInstanceName` to a raw DB element, if possible.
   */
  Raw::Element convertInstanceNameToRaw(TInstanceName e) {
    result = convertQualifiedInstanceNameToRaw(e)
    or
    result = convertSimpleInstanceNameToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TIsAsExpression` to a raw DB element, if possible.
   */
  Raw::Element convertIsAsExpressionToRaw(TIsAsExpression e) {
    result = convertAsClrExpressionToRaw(e)
    or
    result = convertAsExpressionToRaw(e)
    or
    result = convertIsClrExpressionToRaw(e)
    or
    result = convertIsExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLiteralExpression` to a raw DB element, if possible.
   */
  Raw::Element convertLiteralExpressionToRaw(TLiteralExpression e) {
    result = convertClrEnumerationLiteralExpressionToRaw(e)
    or
    result = convertContainerLiteralExpressionToRaw(e)
    or
    result = convertDefaultTypeLiteralExpressionToRaw(e)
    or
    result = convertEnumerationLiteralExpressionToRaw(e)
    or
    result = convertNullLiteralExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLocalDeclaration` to a raw DB element, if possible.
   */
  Raw::Element convertLocalDeclarationToRaw(TLocalDeclaration e) {
    result = convertFunctionDeclarationToRaw(e)
    or
    result = convertVariableDeclarationToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TLocatable` to a raw DB element, if possible.
   */
  Raw::Element convertLocatableToRaw(TLocatable e) {
    result = convertAstToRaw(e)
    or
    result = convertCommentToRaw(e)
    or
    result = convertErrorElementToRaw(e)
    or
    result = convertXppTupleToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TMethodOrDelegate` to a raw DB element, if possible.
   */
  Raw::Element convertMethodOrDelegateToRaw(TMethodOrDelegate e) {
    result = convertDelegateToRaw(e)
    or
    result = convertMethodToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TModelElement` to a raw DB element, if possible.
   */
  Raw::Element convertModelElementToRaw(TModelElement e) {
    result = convertClassOrInterfaceToRaw(e)
    or
    result = convertFormModelElementToRaw(e)
    or
    result = convertFormNestedElementToRaw(e)
    or
    result = convertQueryModelElementToRaw(e)
    or
    result = convertTableToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TNamedType` to a raw DB element, if possible.
   */
  Raw::Element convertNamedTypeToRaw(TNamedType e) { result = convertFormElementTypeToRaw(e) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TOrderElement` to a raw DB element, if possible.
   */
  Raw::Element convertOrderElementToRaw(TOrderElement e) {
    result = convertGlobalOrderElementToRaw(e)
    or
    result = convertSimpleOrderElementToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TQualifier` to a raw DB element, if possible.
   */
  Raw::Element convertQualifierToRaw(TQualifier e) {
    result = convertExpressionQualifierToRaw(e)
    or
    result = convertSimpleQualifierToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TRelationalExpression` to a raw DB element, if possible.
   */
  Raw::Element convertRelationalExpressionToRaw(TRelationalExpression e) {
    result = convertEqualExpressionToRaw(e)
    or
    result = convertGreaterThanExpressionToRaw(e)
    or
    result = convertGreaterThanOrEqualExpressionToRaw(e)
    or
    result = convertLessThanExpressionToRaw(e)
    or
    result = convertLessThanOrEqualExpressionToRaw(e)
    or
    result = convertLikeExpressionToRaw(e)
    or
    result = convertNotEqualExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSelection` to a raw DB element, if possible.
   */
  Raw::Element convertSelectionToRaw(TSelection e) {
    result = convertAllFieldsSelectionToRaw(e)
    or
    result = convertExplicitSelectionToRaw(e)
    or
    result = convertImplicitSelectionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSelectionField` to a raw DB element, if possible.
   */
  Raw::Element convertSelectionFieldToRaw(TSelectionField e) {
    result = convertAggregateSelectionToRaw(e)
    or
    result = convertFieldSelectionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TSimpleQualifier` to a raw DB element, if possible.
   */
  Raw::Element convertSimpleQualifierToRaw(TSimpleQualifier e) {
    result = convertStaticQualifierToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStatement` to a raw DB element, if possible.
   */
  Raw::Element convertStatementToRaw(TStatement e) {
    result = convertAssignmentStatementToRaw(e)
    or
    result = convertBreakStatementToRaw(e)
    or
    result = convertBreakpointStatementToRaw(e)
    or
    result = convertChangeStatementToRaw(e)
    or
    result = convertCompoundStatementToRaw(e)
    or
    result = convertContinueStatementToRaw(e)
    or
    result = convertDeleteStatementToRaw(e)
    or
    result = convertDoWhileStatementToRaw(e)
    or
    result = convertEmptyStatementToRaw(e)
    or
    result = convertExpressionStatementToRaw(e)
    or
    result = convertFindStatementToRaw(e)
    or
    result = convertFlushStatementToRaw(e)
    or
    result = convertForStatementToRaw(e)
    or
    result = convertIfStatementToRaw(e)
    or
    result = convertIfThenElseStatementToRaw(e)
    or
    result = convertInsertStatementToRaw(e)
    or
    result = convertLocalDeclarationsStatementToRaw(e)
    or
    result = convertMoveCursorStatementToRaw(e)
    or
    result = convertPrintStatementToRaw(e)
    or
    result = convertRetryStatementToRaw(e)
    or
    result = convertReturnStatementToRaw(e)
    or
    result = convertSearchStatementToRaw(e)
    or
    result = convertSwitchStatementToRaw(e)
    or
    result = convertThrowStatementToRaw(e)
    or
    result = convertTryStatementToRaw(e)
    or
    result = convertTtsStatementToRaw(e)
    or
    result = convertUncheckedStatementToRaw(e)
    or
    result = convertUpdateStatementToRaw(e)
    or
    result = convertUsingStatementToRaw(e)
    or
    result = convertWhileStatementToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TStringType` to a raw DB element, if possible.
   */
  Raw::Element convertStringTypeToRaw(TStringType e) { result = convertStringLengthTypeToRaw(e) }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTableFieldReference` to a raw DB element, if possible.
   */
  Raw::Element convertTableFieldReferenceToRaw(TTableFieldReference e) {
    result = convertNamedFieldReferenceToRaw(e)
    or
    result = convertNumberedFieldReferenceToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TTtsStatement` to a raw DB element, if possible.
   */
  Raw::Element convertTtsStatementToRaw(TTtsStatement e) {
    result = convertTtsAbortStatementToRaw(e)
    or
    result = convertTtsBeginStatementToRaw(e)
    or
    result = convertTtsEndStatementToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TUnaryExpression` to a raw DB element, if possible.
   */
  Raw::Element convertUnaryExpressionToRaw(TUnaryExpression e) {
    result = convertNotExpressionToRaw(e)
    or
    result = convertPhysicalNotExpressionToRaw(e)
    or
    result = convertUnaryMinusExpressionToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TValidTimeState` to a raw DB element, if possible.
   */
  Raw::Element convertValidTimeStateToRaw(TValidTimeState e) {
    result = convertValidTimeStateDateToRaw(e)
    or
    result = convertValidTimeStateRangeToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TVariableDeclaration` to a raw DB element, if possible.
   */
  Raw::Element convertVariableDeclarationToRaw(TVariableDeclaration e) {
    result = convertParameterDeclarationToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TXppTuple` to a raw DB element, if possible.
   */
  Raw::Element convertXppTupleToRaw(TXppTuple e) {
    result = convertAttributeNamedParameterEntryToRaw(e)
    or
    result = convertCompilationUnitRegionEntryToRaw(e)
    or
    result = convertEvaluationActualParameterEntryToRaw(e)
    or
    result = convertModelElementUsingEntryToRaw(e)
    or
    result = convertSwitchStatementCaseEntryToRaw(e)
    or
    result = convertTryStatementCatchEntryToRaw(e)
  }

  /**
   * INTERNAL: Do not use.
   * Converts a synthesized `TXppType` to a raw DB element, if possible.
   */
  Raw::Element convertXppTypeToRaw(TXppType e) {
    result = convertAnyTypeToRaw(e)
    or
    result = convertBooleanTypeToRaw(e)
    or
    result = convertContainerTypeToRaw(e)
    or
    result = convertDateTimeTypeToRaw(e)
    or
    result = convertDateTypeToRaw(e)
    or
    result = convertDblTypeToRaw(e)
    or
    result = convertEnumerationTypeToRaw(e)
    or
    result = convertGenericXppTypeToRaw(e)
    or
    result = convertGuidTypeToRaw(e)
    or
    result = convertInt64TypeToRaw(e)
    or
    result = convertIntTypeToRaw(e)
    or
    result = convertProvidedTypeToRaw(e)
    or
    result = convertStringTypeToRaw(e)
    or
    result = convertVarTypeToRaw(e)
    or
    result = convertVoidTypeToRaw(e)
  }
}
