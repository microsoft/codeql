/**
 * INTERNAL: Do not use.
 * This module holds thin fully generated class definitions around DB entities.
 */
module Raw {
  /**
   * INTERNAL: Do not use.
   */
  class Element extends @element {
    string toString() { none() }

    /**
     * Holds if this element is unknown.
     */
    predicate isUnknown() { element_is_unknown(this) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class File extends @file, Element {
    override string toString() { result = "File" }

    /**
     * Gets the name of this file.
     */
    string getName() { files(this, result) }
  }

  private Element getImmediateChildOfFile(File e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class Locatable extends @locatable, Element {
    /**
     * Gets the location associated with this element in the code, if it exists.
     */
    Location getLocation() { locatable_locations(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class Location extends @location, Element {
    override string toString() { result = "Location" }

    /**
     * Gets the file of this location.
     */
    File getFile() { locations(this, result, _, _, _, _) }

    /**
     * Gets the start line of this location.
     */
    int getStartLine() { locations(this, _, result, _, _, _) }

    /**
     * Gets the start column of this location.
     */
    int getStartColumn() { locations(this, _, _, result, _, _) }

    /**
     * Gets the end line of this location.
     */
    int getEndLine() { locations(this, _, _, _, result, _) }

    /**
     * Gets the end column of this location.
     */
    int getEndColumn() { locations(this, _, _, _, _, result) }
  }

  private Element getImmediateChildOfLocation(Location e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   * Root of the X++ abstract syntax tree.
   *
   * This mirrors `Microsoft.Dynamics.AX.Metadata.XppCompiler.Ast`, the base class of the
   * X++ compiler's own AST.
   */
  class Ast extends @ast, Locatable { }

  /**
   * INTERNAL: Do not use.
   * A comment in X++ source.
   */
  class Comment extends @comment, Locatable {
    override string toString() { result = "Comment" }

    /**
     * Gets the text of this comment, if it exists.
     */
    string getText() { comment_texts(this, result) }
  }

  private Element getImmediateChildOfComment(Comment e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   * The superclass of all elements indicating some kind of error.
   */
  class ErrorElement extends @error_element, Locatable { }

  /**
   * INTERNAL: Do not use.
   * Base of the classes standing in for tuples in the compiler's AST.
   *
   * The X++ compiler uses CLR tuples for a handful of grouped values, such as a `catch`
   * together with its handler body. The schema has no tuple type, so the generator emits a
   * named class per tuple-valued property instead.
   */
  class XppTuple extends @xpp_tuple, Locatable { }

  /**
   * INTERNAL: Do not use.
   */
  class ArraySpecification extends @array_specification, Ast {
    override string toString() { result = "ArraySpecification" }

    /**
     * Gets the index1 of this array specification, if it exists.
     */
    Expression getIndex1() { array_specification_index1s(this, result) }

    /**
     * Gets the index2 of this array specification, if it exists.
     */
    Expression getIndex2() { array_specification_index2s(this, result) }
  }

  private Element getImmediateChildOfArraySpecification(ArraySpecification e, int index) {
    exists(int n, int nIndex1, int nIndex2 |
      n = 0 and
      nIndex1 = n + 1 and
      nIndex2 = nIndex1 + 1 and
      (
        none()
        or
        index = n and result = e.getIndex1()
        or
        index = nIndex1 and result = e.getIndex2()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Attribute extends @attribute, Ast {
    override string toString() { result = "Attribute" }

    /**
     * Gets the name of this attribute, if it exists.
     */
    string getName() { attribute_names(this, result) }

    /**
     * Gets the `index`th named parameter of this attribute (0-based).
     */
    AttributeNamedParameterEntry getNamedParameter(int index) {
      attribute_named_parameters(this, index, result)
    }

    /**
     * Gets the number of named parameters of this attribute.
     */
    int getNumberOfNamedParameters() {
      result = count(int i | attribute_named_parameters(this, i, _))
    }

    /**
     * Gets the non fully qualified name of this attribute, if it exists.
     */
    string getNonFullyQualifiedName() { attribute_non_fully_qualified_names(this, result) }

    /**
     * Gets the `index`th parameter of this attribute (0-based).
     */
    AttributeExpression getParameter(int index) { attribute_parameters(this, index, result) }

    /**
     * Gets the number of parameters of this attribute.
     */
    int getNumberOfParameters() { result = count(int i | attribute_parameters(this, i, _)) }
  }

  private Element getImmediateChildOfAttribute(Attribute e, int index) {
    exists(int n, int nNamedParameter, int nParameter |
      n = 0 and
      nNamedParameter = n + e.getNumberOfNamedParameters() and
      nParameter = nNamedParameter + e.getNumberOfParameters() and
      (
        none()
        or
        result = e.getNamedParameter(index - n)
        or
        result = e.getParameter(index - nNamedParameter)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AttributeExpression extends @attribute_expression, Ast {
    override string toString() { result = "AttributeExpression" }

    /**
     * Gets the literal of this attribute expression, if it exists.
     */
    AttributeLiteral getLiteral() { attribute_expression_literals(this, result) }
  }

  private Element getImmediateChildOfAttributeExpression(AttributeExpression e, int index) {
    exists(int n, int nLiteral |
      n = 0 and
      nLiteral = n + 1 and
      (
        none()
        or
        index = n and result = e.getLiteral()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AttributeList extends @attribute_list, Ast {
    override string toString() { result = "AttributeList" }

    /**
     * Gets the `index`th attribute of this attribute list (0-based).
     */
    Attribute getAttribute(int index) { attribute_list_attributes(this, index, result) }

    /**
     * Gets the number of attributes of this attribute list.
     */
    int getNumberOfAttributes() { result = count(int i | attribute_list_attributes(this, i, _)) }

    /**
     * Holds if this attribute list contains internal use only attribute.
     */
    predicate containsInternalUseOnlyAttribute() {
      attribute_list_contains_internal_use_only_attribute(this)
    }
  }

  private Element getImmediateChildOfAttributeList(AttributeList e, int index) {
    exists(int n, int nAttribute |
      n = 0 and
      nAttribute = n + e.getNumberOfAttributes() and
      (
        none()
        or
        result = e.getAttribute(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AttributeLiteral extends @attribute_literal, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class AttributeNamedParameterEntry extends @attribute_named_parameter_entry, XppTuple {
    override string toString() { result = "AttributeNamedParameterEntry" }

    /**
     * Gets the item1 of this attribute named parameter entry, if it exists.
     */
    string getItem1() { attribute_named_parameter_entry_item1s(this, result) }

    /**
     * Gets the attribute expression of this attribute named parameter entry, if it exists.
     */
    AttributeExpression getAttributeExpression() {
      attribute_named_parameter_entry_attribute_expressions(this, result)
    }
  }

  private Element getImmediateChildOfAttributeNamedParameterEntry(
    AttributeNamedParameterEntry e, int index
  ) {
    exists(int n, int nAttributeExpression |
      n = 0 and
      nAttributeExpression = n + 1 and
      (
        none()
        or
        index = n and result = e.getAttributeExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Case extends @case, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class Catch extends @catch, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class ClassAccessModifier extends @class_access_modifier, Ast {
    override string toString() { result = "ClassAccessModifier" }

    /**
     * Gets the class modifiers of this class access modifier, if it exists.
     */
    string getClassModifiers() { class_access_modifier_class_modifiers(this, result) }
  }

  private Element getImmediateChildOfClassAccessModifier(ClassAccessModifier e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class CompilationUnit extends @compilation_unit, Ast {
    /**
     * Gets the comments of this compilation unit, if it exists.
     */
    Comment getComments() { compilation_unit_comments(this, result) }

    /**
     * Holds if this compilation unit is name escaped.
     */
    predicate isNameEscaped() { compilation_unit_is_name_escaped(this) }

    /**
     * Gets the name of this compilation unit, if it exists.
     */
    string getName() { compilation_unit_names(this, result) }

    /**
     * Holds if this compilation unit needs transformation.
     */
    predicate needsTransformation() { compilation_unit_needs_transformation(this) }

    /**
     * Gets the `index`th region of this compilation unit (0-based).
     */
    CompilationUnitRegionEntry getRegion(int index) {
      compilation_unit_regions(this, index, result)
    }

    /**
     * Gets the number of regions of this compilation unit.
     */
    int getNumberOfRegions() { result = count(int i | compilation_unit_regions(this, i, _)) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class CompilationUnitRegionEntry extends @compilation_unit_region_entry, XppTuple {
    override string toString() { result = "CompilationUnitRegionEntry" }

    /**
     * Gets the comment of this compilation unit region entry, if it exists.
     */
    Comment getComment() { compilation_unit_region_entry_comments(this, result) }

    /**
     * Gets the comment2 of this compilation unit region entry, if it exists.
     */
    Comment getComment2() { compilation_unit_region_entry_comment2s(this, result) }
  }

  private Element getImmediateChildOfCompilationUnitRegionEntry(
    CompilationUnitRegionEntry e, int index
  ) {
    exists(int n, int nComment, int nComment2 |
      n = 0 and
      nComment = n + 1 and
      nComment2 = nComment + 1 and
      (
        none()
        or
        index = n and result = e.getComment()
        or
        index = nComment and result = e.getComment2()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class CrossCompany extends @cross_company, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class EvaluationActualParameterEntry extends @evaluation_actual_parameter_entry, XppTuple {
    override string toString() { result = "EvaluationActualParameterEntry" }

    /**
     * Holds if this evaluation actual parameter entry item1.
     */
    predicate item1() { evaluation_actual_parameter_entry_item1(this) }

    /**
     * Gets the expression of this evaluation actual parameter entry, if it exists.
     */
    Expression getExpression() { evaluation_actual_parameter_entry_expressions(this, result) }
  }

  private Element getImmediateChildOfEvaluationActualParameterEntry(
    EvaluationActualParameterEntry e, int index
  ) {
    exists(int n, int nExpression |
      n = 0 and
      nExpression = n + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Expression extends @expression, Ast {
    /**
     * Holds if this expression is const.
     */
    predicate isConst() { expression_is_const(this) }

    /**
     * Gets the transformation of this expression, if it exists.
     */
    Expression getTransformation() { expression_transformations(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class FieldAssignment extends @field_assignment, Ast {
    override string toString() { result = "FieldAssignment" }

    /**
     * Gets the expression of this field assignment, if it exists.
     */
    Expression getExpression() { field_assignment_expressions(this, result) }

    /**
     * Gets the extension name of this field assignment, if it exists.
     */
    string getExtensionName() { field_assignment_extension_names(this, result) }

    /**
     * Gets the field name of this field assignment, if it exists.
     */
    string getFieldName() { field_assignment_field_names(this, result) }

    /**
     * Gets the index of this field assignment, if it exists.
     */
    int getIndex() { field_assignment_indices(this, result) }
  }

  private Element getImmediateChildOfFieldAssignment(FieldAssignment e, int index) {
    exists(int n, int nExpression |
      n = 0 and
      nExpression = n + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FieldSpecification extends @field_specification, Ast {
    /**
     * Gets the array index of this field specification, if it exists.
     */
    Expression getArrayIndex() { field_specification_array_indices(this, result) }

    /**
     * Gets the element type name of this field specification, if it exists.
     */
    string getElementTypeName() { field_specification_element_type_names(this, result) }

    /**
     * Holds if this field specification is const.
     */
    predicate isConst() { field_specification_is_const(this) }

    /**
     * Holds if this field specification is internal.
     */
    predicate isInternal() { field_specification_is_internal(this) }

    /**
     * Holds if this field specification is private.
     */
    predicate isPrivate() { field_specification_is_private(this) }

    /**
     * Holds if this field specification is protected.
     */
    predicate isProtected() { field_specification_is_protected(this) }

    /**
     * Holds if this field specification is public.
     */
    predicate isPublic() { field_specification_is_public(this) }

    /**
     * Holds if this field specification is read only.
     */
    predicate isReadOnly() { field_specification_is_read_only(this) }

    /**
     * Holds if this field specification is static.
     */
    predicate isStatic() { field_specification_is_static(this) }

    /**
     * Gets the qualifier of this field specification, if it exists.
     */
    Qualifier getQualifier() { field_specification_qualifiers(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForAssign extends @for_assign, Ast {
    /**
     * Gets the field specification of this for assign, if it exists.
     */
    FieldSpecification getFieldSpecification() { for_assign_field_specifications(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class InsertFieldSpecification extends @insert_field_specification, Ast {
    override string toString() { result = "InsertFieldSpecification" }

    /**
     * Gets the array index of this insert field specification, if it exists.
     */
    int getArrayIndex() { insert_field_specification_array_indices(this, result) }

    /**
     * Gets the extension name of this insert field specification, if it exists.
     */
    string getExtensionName() { insert_field_specification_extension_names(this, result) }

    /**
     * Holds if this insert field specification is extension.
     */
    predicate isExtension() { insert_field_specification_is_extension(this) }

    /**
     * Gets the name of this insert field specification, if it exists.
     */
    string getName() { insert_field_specification_names(this, result) }
  }

  private Element getImmediateChildOfInsertFieldSpecification(InsertFieldSpecification e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class InstanceName extends @instance_name, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class JoinSpecification extends @join_specification, Ast {
    override string toString() { result = "JoinSpecification" }

    /**
     * Gets the kind of this join specification, if it exists.
     */
    string getKind() { join_specification_kinds(this, result) }

    /**
     * Gets the query of this join specification, if it exists.
     */
    Query getQuery() { join_specification_queries(this, result) }
  }

  private Element getImmediateChildOfJoinSpecification(JoinSpecification e, int index) {
    exists(int n, int nQuery |
      n = 0 and
      nQuery = n + 1 and
      (
        none()
        or
        index = n and result = e.getQuery()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ModelElementUsingEntry extends @model_element_using_entry, XppTuple {
    override string toString() { result = "ModelElementUsingEntry" }

    /**
     * Gets the item2 of this model element using entry, if it exists.
     */
    string getItem2() { model_element_using_entry_item2s(this, result) }

    /**
     * Gets the item3 of this model element using entry, if it exists.
     */
    string getItem3() { model_element_using_entry_item3s(this, result) }
  }

  private Element getImmediateChildOfModelElementUsingEntry(ModelElementUsingEntry e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class Modifier extends @modifier, Ast {
    override string toString() { result = "Modifier" }

    /**
     * Gets the modifiers of this modifier, if it exists.
     */
    string getModifiers() { modifier_modifiers(this, result) }
  }

  private Element getImmediateChildOfModifier(Modifier e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class OrderElement extends @order_element, Ast {
    /**
     * Gets the direction of this order element, if it exists.
     */
    string getDirection() { order_element_directions(this, result) }

    /**
     * Gets the field of this order element, if it exists.
     */
    string getField() { order_element_fields(this, result) }

    /**
     * Gets the index of this order element, if it exists.
     */
    int getIndex() { order_element_indices(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class Qualifier extends @qualifier, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class Query extends @query, Ast {
    override string toString() { result = "Query" }

    /**
     * Gets the buffer name of this query, if it exists.
     */
    string getBufferName() { query_buffer_names(this, result) }

    /**
     * Gets the cross company of this query, if it exists.
     */
    CrossCompany getCrossCompany() { query_cross_companies(this, result) }

    /**
     * Gets the `index`th group by element of this query (0-based).
     */
    OrderElement getGroupByElement(int index) { query_group_by_elements(this, index, result) }

    /**
     * Gets the number of group by elements of this query.
     */
    int getNumberOfGroupByElements() { result = count(int i | query_group_by_elements(this, i, _)) }

    /**
     * Gets the index name of this query, if it exists.
     */
    string getIndexName() { query_index_names(this, result) }

    /**
     * Gets the joins of this query, if it exists.
     */
    JoinSpecification getJoins() { query_joins(this, result) }

    /**
     * Gets the `index`th order by element of this query (0-based).
     */
    OrderElement getOrderByElement(int index) { query_order_by_elements(this, index, result) }

    /**
     * Gets the number of order by elements of this query.
     */
    int getNumberOfOrderByElements() { result = count(int i | query_order_by_elements(this, i, _)) }

    /**
     * Gets the selection of this query, if it exists.
     */
    Selection getSelection() { query_selections(this, result) }

    /**
     * Gets the `index`th selection hint of this query (0-based).
     */
    string getSelectionHint(int index) { query_selection_hints(this, index, result) }

    /**
     * Gets the number of selection hints of this query.
     */
    int getNumberOfSelectionHints() { result = count(int i | query_selection_hints(this, i, _)) }

    /**
     * Holds if this query uses hint.
     */
    predicate usesHint() { query_uses_hint(this) }

    /**
     * Gets the valid time state of this query, if it exists.
     */
    ValidTimeState getValidTimeState() { query_valid_time_states(this, result) }

    /**
     * Gets the where of this query, if it exists.
     */
    Expression getWhere() { query_wheres(this, result) }
  }

  private Element getImmediateChildOfQuery(Query e, int index) {
    exists(
      int n, int nCrossCompany, int nGroupByElement, int nJoins, int nOrderByElement,
      int nSelection, int nValidTimeState, int nWhere
    |
      n = 0 and
      nCrossCompany = n + 1 and
      nGroupByElement = nCrossCompany + e.getNumberOfGroupByElements() and
      nJoins = nGroupByElement + 1 and
      nOrderByElement = nJoins + e.getNumberOfOrderByElements() and
      nSelection = nOrderByElement + 1 and
      nValidTimeState = nSelection + 1 and
      nWhere = nValidTimeState + 1 and
      (
        none()
        or
        index = n and result = e.getCrossCompany()
        or
        result = e.getGroupByElement(index - nCrossCompany)
        or
        index = nGroupByElement and result = e.getJoins()
        or
        result = e.getOrderByElement(index - nJoins)
        or
        index = nOrderByElement and result = e.getSelection()
        or
        index = nSelection and result = e.getValidTimeState()
        or
        index = nValidTimeState and result = e.getWhere()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QueryDataSource extends @query_data_source, Ast {
    override string toString() { result = "QueryDataSource" }

    /**
     * Gets the `index`th data source of this query data source (0-based).
     */
    QueryDataSource getDataSource(int index) { query_data_source_data_sources(this, index, result) }

    /**
     * Gets the number of data sources of this query data source.
     */
    int getNumberOfDataSources() {
      result = count(int i | query_data_source_data_sources(this, i, _))
    }

    /**
     * Gets the element type name of this query data source, if it exists.
     */
    string getElementTypeName() { query_data_source_element_type_names(this, result) }

    /**
     * Gets the fetch mode of this query data source, if it exists.
     */
    string getFetchMode() { query_data_source_fetch_modes(this, result) }

    /**
     * Gets the `index`th field of this query data source (0-based).
     */
    string getField(int index) { query_data_source_fields(this, index, result) }

    /**
     * Gets the number of fields of this query data source.
     */
    int getNumberOfFields() { result = count(int i | query_data_source_fields(this, i, _)) }

    /**
     * Holds if this query data source first fast.
     */
    predicate firstFast() { query_data_source_first_fast(this) }

    /**
     * Holds if this query data source first only.
     */
    predicate firstOnly() { query_data_source_first_only(this) }

    /**
     * Gets the `index`th group by of this query data source (0-based).
     */
    GlobalOrderElement getGroupBy(int index) { query_data_source_group_bies(this, index, result) }

    /**
     * Gets the number of group bies of this query data source.
     */
    int getNumberOfGroupBies() { result = count(int i | query_data_source_group_bies(this, i, _)) }

    /**
     * Gets the `index`th having of this query data source (0-based).
     */
    QueryDataSourceHaving getHaving(int index) {
      query_data_source_having_prop(this, index, result)
    }

    /**
     * Gets the number of havings of this query data source.
     */
    int getNumberOfHavings() { result = count(int i | query_data_source_having_prop(this, i, _)) }

    /**
     * Gets the join mode of this query data source, if it exists.
     */
    string getJoinMode() { query_data_source_join_modes(this, result) }

    /**
     * Gets the name of this query data source, if it exists.
     */
    string getName() { query_data_source_names(this, result) }

    /**
     * Gets the `index`th order by of this query data source (0-based).
     */
    GlobalOrderElement getOrderBy(int index) { query_data_source_order_bies(this, index, result) }

    /**
     * Gets the number of order bies of this query data source.
     */
    int getNumberOfOrderBies() { result = count(int i | query_data_source_order_bies(this, i, _)) }

    /**
     * Gets the parent data source of this query data source, if it exists.
     */
    QueryDataSource getParentDataSource() { query_data_source_parent_data_sources(this, result) }

    /**
     * Gets the path contribution of this query data source, if it exists.
     */
    string getPathContribution() { query_data_source_path_contributions(this, result) }

    /**
     * Gets the `index`th range of this query data source (0-based).
     */
    QueryDataSourceRange getRange(int index) { query_data_source_ranges_prop(this, index, result) }

    /**
     * Gets the number of ranges of this query data source.
     */
    int getNumberOfRanges() { result = count(int i | query_data_source_ranges_prop(this, i, _)) }

    /**
     * Gets the `index`th relation of this query data source (0-based).
     */
    QueryDataSourceRelation getRelation(int index) {
      query_data_source_relations_prop(this, index, result)
    }

    /**
     * Gets the number of relations of this query data source.
     */
    int getNumberOfRelations() {
      result = count(int i | query_data_source_relations_prop(this, i, _))
    }

    /**
     * Holds if this query data source select with repeatable read.
     */
    predicate selectWithRepeatableRead() { query_data_source_select_with_repeatable_read(this) }

    /**
     * Gets the table of this query data source, if it exists.
     */
    string getTable() { query_data_source_tables(this, result) }

    /**
     * Holds if this query data source update.
     */
    predicate update() { query_data_source_update(this) }
  }

  private Element getImmediateChildOfQueryDataSource(QueryDataSource e, int index) {
    exists(
      int n, int nDataSource, int nGroupBy, int nHaving, int nOrderBy, int nParentDataSource,
      int nRange, int nRelation
    |
      n = 0 and
      nDataSource = n + e.getNumberOfDataSources() and
      nGroupBy = nDataSource + e.getNumberOfGroupBies() and
      nHaving = nGroupBy + e.getNumberOfHavings() and
      nOrderBy = nHaving + e.getNumberOfOrderBies() and
      nParentDataSource = nOrderBy + 1 and
      nRange = nParentDataSource + e.getNumberOfRanges() and
      nRelation = nRange + e.getNumberOfRelations() and
      (
        none()
        or
        result = e.getDataSource(index - n)
        or
        result = e.getGroupBy(index - nDataSource)
        or
        result = e.getHaving(index - nGroupBy)
        or
        result = e.getOrderBy(index - nHaving)
        or
        index = nOrderBy and result = e.getParentDataSource()
        or
        result = e.getRange(index - nParentDataSource)
        or
        result = e.getRelation(index - nRange)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QueryDataSourceHaving extends @query_data_source_having, Ast {
    override string toString() { result = "QueryDataSourceHaving" }

    /**
     * Gets the data source name of this query data source having, if it exists.
     */
    string getDataSourceName() { query_data_source_having_data_source_names(this, result) }

    /**
     * Gets the selection of this query data source having, if it exists.
     */
    SelectionField getSelection() { query_data_source_having_selections(this, result) }

    /**
     * Gets the value of this query data source having, if it exists.
     */
    string getValue() { query_data_source_having_values(this, result) }
  }

  private Element getImmediateChildOfQueryDataSourceHaving(QueryDataSourceHaving e, int index) {
    exists(int n, int nSelection |
      n = 0 and
      nSelection = n + 1 and
      (
        none()
        or
        index = n and result = e.getSelection()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QueryDataSourceRange extends @query_data_source_range, Ast {
    override string toString() { result = "QueryDataSourceRange" }

    /**
     * Gets the field of this query data source range, if it exists.
     */
    string getField() { query_data_source_range_fields(this, result) }

    /**
     * Gets the value of this query data source range, if it exists.
     */
    string getValue() { query_data_source_range_values(this, result) }
  }

  private Element getImmediateChildOfQueryDataSourceRange(QueryDataSourceRange e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class QueryDataSourceRelation extends @query_data_source_relation, Ast {
    override string toString() { result = "QueryDataSourceRelation" }

    /**
     * Gets the field of this query data source relation, if it exists.
     */
    string getField() { query_data_source_relation_fields(this, result) }

    /**
     * Gets the join data source of this query data source relation, if it exists.
     */
    string getJoinDataSource() { query_data_source_relation_join_data_sources(this, result) }

    /**
     * Gets the related field of this query data source relation, if it exists.
     */
    string getRelatedField() { query_data_source_relation_related_fields(this, result) }
  }

  private Element getImmediateChildOfQueryDataSourceRelation(QueryDataSourceRelation e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class Selection extends @selection, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class SelectionField extends @selection_field, Ast {
    /**
     * Gets the extension name of this selection field, if it exists.
     */
    string getExtensionName() { selection_field_extension_names(this, result) }

    /**
     * Gets the field of this selection field, if it exists.
     */
    string getField() { selection_field_fields(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class Statement extends @statement, Ast {
    /**
     * Gets the comments of this statement, if it exists.
     */
    string getComments() { statement_comments(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class SwitchCase extends @switch_case, Ast {
    override string toString() { result = "SwitchCase" }
  }

  private Element getImmediateChildOfSwitchCase(SwitchCase e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class SwitchStatementCaseEntry extends @switch_statement_case_entry, XppTuple {
    override string toString() { result = "SwitchStatementCaseEntry" }

    /**
     * Gets the case of this switch statement case entry, if it exists.
     */
    Case getCase() { switch_statement_case_entry_cases(this, result) }

    /**
     * Gets the `index`th statement of this switch statement case entry (0-based).
     */
    Statement getStatement(int index) {
      switch_statement_case_entry_statements(this, index, result)
    }

    /**
     * Gets the number of statements of this switch statement case entry.
     */
    int getNumberOfStatements() {
      result = count(int i | switch_statement_case_entry_statements(this, i, _))
    }
  }

  private Element getImmediateChildOfSwitchStatementCaseEntry(SwitchStatementCaseEntry e, int index) {
    exists(int n, int nCase, int nStatement |
      n = 0 and
      nCase = n + 1 and
      nStatement = nCase + e.getNumberOfStatements() and
      (
        none()
        or
        index = n and result = e.getCase()
        or
        result = e.getStatement(index - nCase)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class TableFieldReference extends @table_field_reference, Ast {
    /**
     * Gets the index of this table field reference, if it exists.
     */
    Expression getIndex() { table_field_reference_indices(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class TryStatementCatchEntry extends @try_statement_catch_entry, XppTuple {
    override string toString() { result = "TryStatementCatchEntry" }

    /**
     * Gets the catch of this try statement catch entry, if it exists.
     */
    Catch getCatch() { try_statement_catch_entry_catches(this, result) }

    /**
     * Gets the statement of this try statement catch entry, if it exists.
     */
    Statement getStatement() { try_statement_catch_entry_statements(this, result) }
  }

  private Element getImmediateChildOfTryStatementCatchEntry(TryStatementCatchEntry e, int index) {
    exists(int n, int nCatch, int nStatement |
      n = 0 and
      nCatch = n + 1 and
      nStatement = nCatch + 1 and
      (
        none()
        or
        index = n and result = e.getCatch()
        or
        index = nCatch and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   * A node that could not be extracted, for example because of a syntax error.
   */
  class UnspecifiedElement extends @unspecified_element, ErrorElement {
    override string toString() { result = "UnspecifiedElement" }

    /**
     * Gets the parent of this unspecified element, if it exists.
     */
    Element getParent() { unspecified_element_parents(this, result) }

    /**
     * Gets the property of this unspecified element.
     */
    string getProperty() { unspecified_elements(this, result, _) }

    /**
     * Gets the index of this unspecified element, if it exists.
     */
    int getIndex() { unspecified_element_indices(this, result) }

    /**
     * Gets the error of this unspecified element.
     */
    string getError() { unspecified_elements(this, _, result) }
  }

  private Element getImmediateChildOfUnspecifiedElement(UnspecifiedElement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class ValidTimeState extends @valid_time_state, Ast { }

  /**
   * INTERNAL: Do not use.
   */
  class XppType extends @xpp_type, Ast {
    /**
     * Gets the element type name of this xpp type, if it exists.
     */
    string getElementTypeName() { xpp_type_element_type_names(this, result) }

    /**
     * Holds if this xpp type is obsolete.
     */
    predicate isObsolete() { xpp_type_is_obsolete(this) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class AggregateSelection extends @aggregate_selection, SelectionField { }

  /**
   * INTERNAL: Do not use.
   */
  class AllFieldsSelection extends @all_fields_selection, Selection {
    override string toString() { result = "AllFieldsSelection" }
  }

  private Element getImmediateChildOfAllFieldsSelection(AllFieldsSelection e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class AnyType extends @any_type, XppType {
    override string toString() { result = "AnyType" }
  }

  private Element getImmediateChildOfAnyType(AnyType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class AssignmentStatement extends @assignment_statement, Statement { }

  /**
   * INTERNAL: Do not use.
   */
  class BinaryExpression extends @binary_expression, Expression {
    /**
     * Gets the left of this binary expression, if it exists.
     */
    Expression getLeft() { binary_expression_lefts(this, result) }

    /**
     * Gets the right of this binary expression, if it exists.
     */
    Expression getRight() { binary_expression_rights(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class BooleanType extends @boolean_type, XppType {
    override string toString() { result = "BooleanType" }
  }

  private Element getImmediateChildOfBooleanType(BooleanType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class BreakStatement extends @break_statement, Statement {
    override string toString() { result = "BreakStatement" }
  }

  private Element getImmediateChildOfBreakStatement(BreakStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class BreakpointStatement extends @breakpoint_statement, Statement {
    override string toString() { result = "BreakpointStatement" }
  }

  private Element getImmediateChildOfBreakpointStatement(BreakpointStatement e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class CaseDefault extends @case_default, Case {
    override string toString() { result = "CaseDefault" }
  }

  private Element getImmediateChildOfCaseDefault(CaseDefault e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class CaseValues extends @case_values, Case {
    override string toString() { result = "CaseValues" }

    /**
     * Gets the `index`th value of this case values (0-based).
     */
    Expression getValue(int index) { case_values_values(this, index, result) }

    /**
     * Gets the number of values of this case values.
     */
    int getNumberOfValues() { result = count(int i | case_values_values(this, i, _)) }
  }

  private Element getImmediateChildOfCaseValues(CaseValues e, int index) {
    exists(int n, int nValue |
      n = 0 and
      nValue = n + e.getNumberOfValues() and
      (
        none()
        or
        result = e.getValue(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class CatchAllValues extends @catch_all_values, Catch {
    override string toString() { result = "CatchAllValues" }
  }

  private Element getImmediateChildOfCatchAllValues(CatchAllValues e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class CatchExpression extends @catch_expression, Catch {
    override string toString() { result = "CatchExpression" }

    /**
     * Gets the expression of this catch expression, if it exists.
     */
    Expression getExpression() { catch_expression_expressions(this, result) }
  }

  private Element getImmediateChildOfCatchExpression(CatchExpression e, int index) {
    exists(int n, int nExpression |
      n = 0 and
      nExpression = n + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class CatchUpdateConflict extends @catch_update_conflict, Catch {
    override string toString() { result = "CatchUpdateConflict" }

    /**
     * Gets the expression of this catch update conflict, if it exists.
     */
    Expression getExpression() { catch_update_conflict_expressions(this, result) }

    /**
     * Gets the instance of this catch update conflict, if it exists.
     */
    InstanceName getInstance() { catch_update_conflict_instances(this, result) }
  }

  private Element getImmediateChildOfCatchUpdateConflict(CatchUpdateConflict e, int index) {
    exists(int n, int nExpression, int nInstance |
      n = 0 and
      nExpression = n + 1 and
      nInstance = nExpression + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
        or
        index = nExpression and result = e.getInstance()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ChangeStatement extends @change_statement, Statement {
    /**
     * Gets the expression of this change statement, if it exists.
     */
    Expression getExpression() { change_statement_expressions(this, result) }

    /**
     * Gets the statement of this change statement, if it exists.
     */
    Statement getStatement() { change_statement_statements(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class CompoundStatement extends @compound_statement, Statement {
    override string toString() { result = "CompoundStatement" }

    /**
     * Gets the `index`th content of this compound statement (0-based).
     */
    Statement getContent(int index) { compound_statement_contents(this, index, result) }

    /**
     * Gets the number of contents of this compound statement.
     */
    int getNumberOfContents() { result = count(int i | compound_statement_contents(this, i, _)) }
  }

  private Element getImmediateChildOfCompoundStatement(CompoundStatement e, int index) {
    exists(int n, int nContent |
      n = 0 and
      nContent = n + e.getNumberOfContents() and
      (
        none()
        or
        result = e.getContent(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ConditionalExpression extends @conditional_expression, Expression {
    override string toString() { result = "ConditionalExpression" }

    /**
     * Gets the condition of this conditional expression, if it exists.
     */
    Expression getCondition() { conditional_expression_conditions(this, result) }

    /**
     * Gets the else part of this conditional expression, if it exists.
     */
    Expression getElsePart() { conditional_expression_else_parts(this, result) }

    /**
     * Gets the if part of this conditional expression, if it exists.
     */
    Expression getIfPart() { conditional_expression_if_parts(this, result) }
  }

  private Element getImmediateChildOfConditionalExpression(ConditionalExpression e, int index) {
    exists(int n, int nTransformation, int nCondition, int nElsePart, int nIfPart |
      n = 0 and
      nTransformation = n + 1 and
      nCondition = nTransformation + 1 and
      nElsePart = nCondition + 1 and
      nIfPart = nElsePart + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getCondition()
        or
        index = nCondition and result = e.getElsePart()
        or
        index = nElsePart and result = e.getIfPart()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ContainerAttributeLiteral extends @container_attribute_literal, AttributeLiteral {
    override string toString() { result = "ContainerAttributeLiteral" }

    /**
     * Gets the `index`th value of this container attribute literal (0-based).
     */
    AttributeExpression getValue(int index) {
      container_attribute_literal_values(this, index, result)
    }

    /**
     * Gets the number of values of this container attribute literal.
     */
    int getNumberOfValues() {
      result = count(int i | container_attribute_literal_values(this, i, _))
    }
  }

  private Element getImmediateChildOfContainerAttributeLiteral(
    ContainerAttributeLiteral e, int index
  ) {
    exists(int n, int nValue |
      n = 0 and
      nValue = n + e.getNumberOfValues() and
      (
        none()
        or
        result = e.getValue(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ContainerType extends @container_type, XppType {
    override string toString() { result = "ContainerType" }
  }

  private Element getImmediateChildOfContainerType(ContainerType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class ContinueStatement extends @continue_statement, Statement {
    override string toString() { result = "ContinueStatement" }
  }

  private Element getImmediateChildOfContinueStatement(ContinueStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class CrossCompanyAll extends @cross_company_all, CrossCompany {
    override string toString() { result = "CrossCompanyAll" }
  }

  private Element getImmediateChildOfCrossCompanyAll(CrossCompanyAll e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class CrossCompanyContainer extends @cross_company_container, CrossCompany {
    override string toString() { result = "CrossCompanyContainer" }

    /**
     * Gets the container of this cross company container, if it exists.
     */
    Expression getContainer() { cross_company_container_containers(this, result) }
  }

  private Element getImmediateChildOfCrossCompanyContainer(CrossCompanyContainer e, int index) {
    exists(int n, int nContainer |
      n = 0 and
      nContainer = n + 1 and
      (
        none()
        or
        index = n and result = e.getContainer()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class DateTimeType extends @date_time_type, XppType {
    override string toString() { result = "DateTimeType" }
  }

  private Element getImmediateChildOfDateTimeType(DateTimeType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class DateType extends @date_type, XppType {
    override string toString() { result = "DateType" }
  }

  private Element getImmediateChildOfDateType(DateType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class DblType extends @dbl_type, XppType {
    override string toString() { result = "DblType" }
  }

  private Element getImmediateChildOfDblType(DblType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class Declaration extends @declaration, CompilationUnit {
    /**
     * Gets the array specification of this declaration, if it exists.
     */
    ArraySpecification getArraySpecification() { declaration_array_specifications(this, result) }

    /**
     * Gets the `index`th modifier list of this declaration (0-based).
     */
    Modifier getModifierList(int index) { declaration_modifier_lists(this, index, result) }

    /**
     * Gets the number of modifier lists of this declaration.
     */
    int getNumberOfModifierLists() {
      result = count(int i | declaration_modifier_lists(this, i, _))
    }

    /**
     * Gets the modifiers of this declaration, if it exists.
     */
    string getModifiers() { declaration_modifiers(this, result) }

    /**
     * Gets the type of this declaration, if it exists.
     */
    XppType getType() { declaration_types(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class DefaultTypeAttributeLiteral extends @default_type_attribute_literal, AttributeLiteral {
    /**
     * Gets the scanned literal value of this default type attribute literal, if it exists.
     */
    string getScannedLiteralValue() {
      default_type_attribute_literal_scanned_literal_values(this, result)
    }
  }

  /**
   * INTERNAL: Do not use.
   */
  class DeleteStatement extends @delete_statement, Statement {
    override string toString() { result = "DeleteStatement" }

    /**
     * Gets the query of this delete statement, if it exists.
     */
    Query getQuery() { delete_statement_queries(this, result) }
  }

  private Element getImmediateChildOfDeleteStatement(DeleteStatement e, int index) {
    exists(int n, int nQuery |
      n = 0 and
      nQuery = n + 1 and
      (
        none()
        or
        index = n and result = e.getQuery()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class DoWhileStatement extends @do_while_statement, Statement {
    override string toString() { result = "DoWhileStatement" }

    /**
     * Gets the condition of this do while statement, if it exists.
     */
    Expression getCondition() { do_while_statement_conditions(this, result) }

    /**
     * Gets the statement of this do while statement, if it exists.
     */
    Statement getStatement() { do_while_statement_statements(this, result) }
  }

  private Element getImmediateChildOfDoWhileStatement(DoWhileStatement e, int index) {
    exists(int n, int nCondition, int nStatement |
      n = 0 and
      nCondition = n + 1 and
      nStatement = nCondition + 1 and
      (
        none()
        or
        index = n and result = e.getCondition()
        or
        index = nCondition and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class EmptyExpression extends @empty_expression, Expression {
    override string toString() { result = "EmptyExpression" }
  }

  private Element getImmediateChildOfEmptyExpression(EmptyExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class EmptyStatement extends @empty_statement, Statement {
    override string toString() { result = "EmptyStatement" }
  }

  private Element getImmediateChildOfEmptyStatement(EmptyStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class EnumAttributeLiteral extends @enum_attribute_literal, AttributeLiteral {
    override string toString() { result = "EnumAttributeLiteral" }

    /**
     * Gets the literal of this enum attribute literal, if it exists.
     */
    string getLiteral() { enum_attribute_literal_literals(this, result) }

    /**
     * Gets the type name of this enum attribute literal, if it exists.
     */
    string getTypeName() { enum_attribute_literal_type_names(this, result) }
  }

  private Element getImmediateChildOfEnumAttributeLiteral(EnumAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class EnumerationType extends @enumeration_type, XppType {
    override string toString() { result = "EnumerationType" }

    /**
     * Gets the enumerated type of this enumeration type, if it exists.
     */
    string getEnumeratedType() { enumeration_type_enumerated_types(this, result) }

    /**
     * Gets the full name of this enumeration type, if it exists.
     */
    string getFullName() { enumeration_type_full_names(this, result) }

    /**
     * Gets the namespace of this enumeration type, if it exists.
     */
    string getNamespace() { enumeration_type_namespaces(this, result) }
  }

  private Element getImmediateChildOfEnumerationType(EnumerationType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class Evaluation extends @evaluation, Expression {
    /**
     * Gets the `index`th actual parameter of this evaluation (0-based).
     */
    EvaluationActualParameterEntry getActualParameter(int index) {
      evaluation_actual_parameters(this, index, result)
    }

    /**
     * Gets the number of actual parameters of this evaluation.
     */
    int getNumberOfActualParameters() {
      result = count(int i | evaluation_actual_parameters(this, i, _))
    }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ExplicitSelection extends @explicit_selection, Selection {
    override string toString() { result = "ExplicitSelection" }

    /**
     * Gets the `index`th field of this explicit selection (0-based).
     */
    SelectionField getField(int index) { explicit_selection_fields(this, index, result) }

    /**
     * Gets the number of fields of this explicit selection.
     */
    int getNumberOfFields() { result = count(int i | explicit_selection_fields(this, i, _)) }
  }

  private Element getImmediateChildOfExplicitSelection(ExplicitSelection e, int index) {
    exists(int n, int nField |
      n = 0 and
      nField = n + e.getNumberOfFields() and
      (
        none()
        or
        result = e.getField(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ExpressionCompilationUnit extends @expression_compilation_unit, CompilationUnit {
    override string toString() { result = "ExpressionCompilationUnit" }

    /**
     * Gets the expression of this expression compilation unit, if it exists.
     */
    Expression getExpression() { expression_compilation_unit_expressions(this, result) }

    /**
     * Gets the path contribution of this expression compilation unit, if it exists.
     */
    string getPathContribution() { expression_compilation_unit_path_contributions(this, result) }
  }

  private Element getImmediateChildOfExpressionCompilationUnit(
    ExpressionCompilationUnit e, int index
  ) {
    exists(int n, int nComments, int nRegion, int nExpression |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nExpression = nRegion + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        index = nRegion and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ExpressionQualifier extends @expression_qualifier, Qualifier {
    override string toString() { result = "ExpressionQualifier" }

    /**
     * Gets the expression of this expression qualifier, if it exists.
     */
    Expression getExpression() { expression_qualifier_expressions(this, result) }
  }

  private Element getImmediateChildOfExpressionQualifier(ExpressionQualifier e, int index) {
    exists(int n, int nExpression |
      n = 0 and
      nExpression = n + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ExpressionStatement extends @expression_statement, Statement {
    override string toString() { result = "ExpressionStatement" }

    /**
     * Gets the element type name of this expression statement, if it exists.
     */
    string getElementTypeName() { expression_statement_element_type_names(this, result) }

    /**
     * Gets the expression of this expression statement, if it exists.
     */
    Expression getExpression() { expression_statement_expressions(this, result) }
  }

  private Element getImmediateChildOfExpressionStatement(ExpressionStatement e, int index) {
    exists(int n, int nExpression |
      n = 0 and
      nExpression = n + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FieldExpression extends @field_expression, Expression {
    /**
     * Gets the field of this field expression, if it exists.
     */
    FieldSpecification getField() { field_expression_fields(this, result) }

    /**
     * Holds if this field expression is enum.
     */
    predicate isEnum() { field_expression_is_enum(this) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class FieldSelection extends @field_selection, SelectionField {
    override string toString() { result = "FieldSelection" }

    /**
     * Gets the index of this field selection, if it exists.
     */
    int getIndex() { field_selection_indices(this, result) }
  }

  private Element getImmediateChildOfFieldSelection(FieldSelection e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class FindStatement extends @find_statement, Statement {
    override string toString() { result = "FindStatement" }

    /**
     * Gets the query of this find statement, if it exists.
     */
    Query getQuery() { find_statement_queries(this, result) }
  }

  private Element getImmediateChildOfFindStatement(FindStatement e, int index) {
    exists(int n, int nQuery |
      n = 0 and
      nQuery = n + 1 and
      (
        none()
        or
        index = n and result = e.getQuery()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FlushStatement extends @flush_statement, Statement {
    override string toString() { result = "FlushStatement" }

    /**
     * Gets the `index`th id list of this flush statement (0-based).
     */
    string getIdList(int index) { flush_statement_id_lists(this, index, result) }

    /**
     * Gets the number of id lists of this flush statement.
     */
    int getNumberOfIdLists() { result = count(int i | flush_statement_id_lists(this, i, _)) }
  }

  private Element getImmediateChildOfFlushStatement(FlushStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class ForDeclarationAssign extends @for_declaration_assign, ForAssign {
    override string toString() { result = "ForDeclarationAssign" }

    /**
     * Gets the `index`th initialization declaration of this for declaration assign (0-based).
     */
    VariableDeclaration getInitializationDeclaration(int index) {
      for_declaration_assign_initialization_declarations(this, index, result)
    }

    /**
     * Gets the number of initialization declarations of this for declaration assign.
     */
    int getNumberOfInitializationDeclarations() {
      result = count(int i | for_declaration_assign_initialization_declarations(this, i, _))
    }
  }

  private Element getImmediateChildOfForDeclarationAssign(ForDeclarationAssign e, int index) {
    exists(int n, int nFieldSpecification, int nInitializationDeclaration |
      n = 0 and
      nFieldSpecification = n + 1 and
      nInitializationDeclaration = nFieldSpecification + e.getNumberOfInitializationDeclarations() and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
        or
        result = e.getInitializationDeclaration(index - nFieldSpecification)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForExpressionAssign extends @for_expression_assign, ForAssign {
    /**
     * Gets the expression of this for expression assign, if it exists.
     */
    Expression getExpression() { for_expression_assign_expressions(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForFieldPostDecrement extends @for_field_post_decrement, ForAssign {
    override string toString() { result = "ForFieldPostDecrement" }
  }

  private Element getImmediateChildOfForFieldPostDecrement(ForFieldPostDecrement e, int index) {
    exists(int n, int nFieldSpecification |
      n = 0 and
      nFieldSpecification = n + 1 and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForFieldPostIncrement extends @for_field_post_increment, ForAssign {
    override string toString() { result = "ForFieldPostIncrement" }
  }

  private Element getImmediateChildOfForFieldPostIncrement(ForFieldPostIncrement e, int index) {
    exists(int n, int nFieldSpecification |
      n = 0 and
      nFieldSpecification = n + 1 and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForFieldPreDecrement extends @for_field_pre_decrement, ForAssign {
    override string toString() { result = "ForFieldPreDecrement" }
  }

  private Element getImmediateChildOfForFieldPreDecrement(ForFieldPreDecrement e, int index) {
    exists(int n, int nFieldSpecification |
      n = 0 and
      nFieldSpecification = n + 1 and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForFieldPreIncrement extends @for_field_pre_increment, ForAssign {
    override string toString() { result = "ForFieldPreIncrement" }
  }

  private Element getImmediateChildOfForFieldPreIncrement(ForFieldPreIncrement e, int index) {
    exists(int n, int nFieldSpecification |
      n = 0 and
      nFieldSpecification = n + 1 and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForStatement extends @for_statement, Statement {
    override string toString() { result = "ForStatement" }

    /**
     * Gets the condition of this for statement, if it exists.
     */
    Expression getCondition() { for_statement_conditions(this, result) }

    /**
     * Gets the initialization of this for statement, if it exists.
     */
    ForAssign getInitialization() { for_statement_initializations(this, result) }

    /**
     * Gets the statement of this for statement, if it exists.
     */
    Statement getStatement() { for_statement_statements(this, result) }

    /**
     * Gets the update of this for statement, if it exists.
     */
    ForAssign getUpdate() { for_statement_updates(this, result) }
  }

  private Element getImmediateChildOfForStatement(ForStatement e, int index) {
    exists(int n, int nCondition, int nInitialization, int nStatement, int nUpdate |
      n = 0 and
      nCondition = n + 1 and
      nInitialization = nCondition + 1 and
      nStatement = nInitialization + 1 and
      nUpdate = nStatement + 1 and
      (
        none()
        or
        index = n and result = e.getCondition()
        or
        index = nCondition and result = e.getInitialization()
        or
        index = nInitialization and result = e.getStatement()
        or
        index = nStatement and result = e.getUpdate()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class GenericXppType extends @generic_xpp_type, XppType {
    /**
     * Gets the `index`th type argument list of this generic xpp type (0-based).
     */
    XppType getTypeArgumentList(int index) {
      generic_xpp_type_type_argument_lists(this, index, result)
    }

    /**
     * Gets the number of type argument lists of this generic xpp type.
     */
    int getNumberOfTypeArgumentLists() {
      result = count(int i | generic_xpp_type_type_argument_lists(this, i, _))
    }
  }

  /**
   * INTERNAL: Do not use.
   */
  class GlobalOrderElement extends @global_order_element, OrderElement {
    override string toString() { result = "GlobalOrderElement" }

    /**
     * Gets the extension name of this global order element, if it exists.
     */
    string getExtensionName() { global_order_element_extension_names(this, result) }

    /**
     * Gets the table of this global order element, if it exists.
     */
    string getTable() { global_order_element_tables(this, result) }
  }

  private Element getImmediateChildOfGlobalOrderElement(GlobalOrderElement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class GuidType extends @guid_type, XppType {
    override string toString() { result = "GuidType" }
  }

  private Element getImmediateChildOfGuidType(GuidType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class IfStatement extends @if_statement, Statement {
    override string toString() { result = "IfStatement" }

    /**
     * Gets the condition of this if statement, if it exists.
     */
    Expression getCondition() { if_statement_conditions(this, result) }

    /**
     * Gets the consequent of this if statement, if it exists.
     */
    Statement getConsequent() { if_statement_consequents(this, result) }
  }

  private Element getImmediateChildOfIfStatement(IfStatement e, int index) {
    exists(int n, int nCondition, int nConsequent |
      n = 0 and
      nCondition = n + 1 and
      nConsequent = nCondition + 1 and
      (
        none()
        or
        index = n and result = e.getCondition()
        or
        index = nCondition and result = e.getConsequent()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class IfThenElseStatement extends @if_then_else_statement, Statement {
    override string toString() { result = "IfThenElseStatement" }

    /**
     * Gets the antecedent of this if then else statement, if it exists.
     */
    Statement getAntecedent() { if_then_else_statement_antecedents(this, result) }

    /**
     * Gets the condition of this if then else statement, if it exists.
     */
    Expression getCondition() { if_then_else_statement_conditions(this, result) }

    /**
     * Gets the consequent of this if then else statement, if it exists.
     */
    Statement getConsequent() { if_then_else_statement_consequents(this, result) }
  }

  private Element getImmediateChildOfIfThenElseStatement(IfThenElseStatement e, int index) {
    exists(int n, int nAntecedent, int nCondition, int nConsequent |
      n = 0 and
      nAntecedent = n + 1 and
      nCondition = nAntecedent + 1 and
      nConsequent = nCondition + 1 and
      (
        none()
        or
        index = n and result = e.getAntecedent()
        or
        index = nAntecedent and result = e.getCondition()
        or
        index = nCondition and result = e.getConsequent()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ImplicitSelection extends @implicit_selection, Selection {
    override string toString() { result = "ImplicitSelection" }
  }

  private Element getImmediateChildOfImplicitSelection(ImplicitSelection e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class InsertStatement extends @insert_statement, Statement {
    override string toString() { result = "InsertStatement" }

    /**
     * Gets the cross company of this insert statement, if it exists.
     */
    CrossCompany getCrossCompany() { insert_statement_cross_companies(this, result) }

    /**
     * Gets the `index`th field of this insert statement (0-based).
     */
    InsertFieldSpecification getField(int index) { insert_statement_fields(this, index, result) }

    /**
     * Gets the number of fields of this insert statement.
     */
    int getNumberOfFields() { result = count(int i | insert_statement_fields(this, i, _)) }

    /**
     * Gets the query of this insert statement, if it exists.
     */
    Query getQuery() { insert_statement_queries(this, result) }

    /**
     * Gets the table of this insert statement, if it exists.
     */
    string getTable() { insert_statement_tables(this, result) }
  }

  private Element getImmediateChildOfInsertStatement(InsertStatement e, int index) {
    exists(int n, int nCrossCompany, int nField, int nQuery |
      n = 0 and
      nCrossCompany = n + 1 and
      nField = nCrossCompany + e.getNumberOfFields() and
      nQuery = nField + 1 and
      (
        none()
        or
        index = n and result = e.getCrossCompany()
        or
        result = e.getField(index - nCrossCompany)
        or
        index = nField and result = e.getQuery()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Int64Type extends @int64_type, XppType {
    override string toString() { result = "Int64Type" }
  }

  private Element getImmediateChildOfInt64Type(Int64Type e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class IntType extends @int_type, XppType {
    override string toString() { result = "IntType" }
  }

  private Element getImmediateChildOfIntType(IntType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class Intrinsic extends @intrinsic, Expression {
    override string toString() { result = "Intrinsic" }

    /**
     * Gets the arg1 of this intrinsic, if it exists.
     */
    string getArg1() { intrinsic_arg1s(this, result) }

    /**
     * Gets the arg2 of this intrinsic, if it exists.
     */
    string getArg2() { intrinsic_arg2s(this, result) }

    /**
     * Gets the arg3 of this intrinsic, if it exists.
     */
    string getArg3() { intrinsic_arg3s(this, result) }

    /**
     * Gets the name of this intrinsic, if it exists.
     */
    string getName() { intrinsic_names(this, result) }
  }

  private Element getImmediateChildOfIntrinsic(Intrinsic e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class IntrinsicAttributeLiteral extends @intrinsic_attribute_literal, AttributeLiteral {
    override string toString() { result = "IntrinsicAttributeLiteral" }

    /**
     * Gets the arg1 of this intrinsic attribute literal, if it exists.
     */
    string getArg1() { intrinsic_attribute_literal_arg1s(this, result) }

    /**
     * Gets the arg2 of this intrinsic attribute literal, if it exists.
     */
    string getArg2() { intrinsic_attribute_literal_arg2s(this, result) }

    /**
     * Gets the arg3 of this intrinsic attribute literal, if it exists.
     */
    string getArg3() { intrinsic_attribute_literal_arg3s(this, result) }

    /**
     * Gets the function name of this intrinsic attribute literal, if it exists.
     */
    string getFunctionName() { intrinsic_attribute_literal_function_names(this, result) }
  }

  private Element getImmediateChildOfIntrinsicAttributeLiteral(
    IntrinsicAttributeLiteral e, int index
  ) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class IsAsExpression extends @is_as_expression, Expression {
    /**
     * Gets the expression of this is as expression, if it exists.
     */
    Expression getExpression() { is_as_expression_expressions(this, result) }

    /**
     * Gets the type name of this is as expression, if it exists.
     */
    string getTypeName() { is_as_expression_type_names(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class LiteralExpression extends @literal_expression, Expression { }

  /**
   * INTERNAL: Do not use.
   */
  class LocalDeclarationsStatement extends @local_declarations_statement, Statement {
    override string toString() { result = "LocalDeclarationsStatement" }

    /**
     * Gets the `index`th declaration of this local declarations statement (0-based).
     */
    LocalDeclaration getDeclaration(int index) {
      local_declarations_statement_declarations(this, index, result)
    }

    /**
     * Gets the number of declarations of this local declarations statement.
     */
    int getNumberOfDeclarations() {
      result = count(int i | local_declarations_statement_declarations(this, i, _))
    }
  }

  private Element getImmediateChildOfLocalDeclarationsStatement(
    LocalDeclarationsStatement e, int index
  ) {
    exists(int n, int nDeclaration |
      n = 0 and
      nDeclaration = n + e.getNumberOfDeclarations() and
      (
        none()
        or
        result = e.getDeclaration(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class MethodOrDelegate extends @method_or_delegate, CompilationUnit {
    /**
     * Gets the attributes of this method or delegate, if it exists.
     */
    AttributeList getAttributes() { method_or_delegate_attributes(this, result) }

    /**
     * Gets the `index`th modifier list of this method or delegate (0-based).
     */
    Modifier getModifierList(int index) { method_or_delegate_modifier_lists(this, index, result) }

    /**
     * Gets the number of modifier lists of this method or delegate.
     */
    int getNumberOfModifierLists() {
      result = count(int i | method_or_delegate_modifier_lists(this, i, _))
    }

    /**
     * Gets the `index`th parameter of this method or delegate (0-based).
     */
    ParameterDeclaration getParameter(int index) {
      method_or_delegate_parameters(this, index, result)
    }

    /**
     * Gets the number of parameters of this method or delegate.
     */
    int getNumberOfParameters() {
      result = count(int i | method_or_delegate_parameters(this, i, _))
    }

    /**
     * Gets the path contribution of this method or delegate, if it exists.
     */
    string getPathContribution() { method_or_delegate_path_contributions(this, result) }

    /**
     * Gets the type of this method or delegate, if it exists.
     */
    XppType getType() { method_or_delegate_types(this, result) }

    /**
     * Gets the `index`th type parameter of this method or delegate (0-based).
     */
    string getTypeParameter(int index) { method_or_delegate_type_parameters(this, index, result) }

    /**
     * Gets the number of type parameters of this method or delegate.
     */
    int getNumberOfTypeParameters() {
      result = count(int i | method_or_delegate_type_parameters(this, i, _))
    }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ModelElement extends @model_element, CompilationUnit {
    /**
     * Gets the `index`th base method of this model element (0-based).
     */
    MethodOrDelegate getBaseMethod(int index) { model_element_base_methods(this, index, result) }

    /**
     * Gets the number of base methods of this model element.
     */
    int getNumberOfBaseMethods() { result = count(int i | model_element_base_methods(this, i, _)) }

    /**
     * Gets the `index`th extend generic parameter of this model element (0-based).
     */
    XppType getExtendGenericParameter(int index) {
      model_element_extend_generic_parameters(this, index, result)
    }

    /**
     * Gets the number of extend generic parameters of this model element.
     */
    int getNumberOfExtendGenericParameters() {
      result = count(int i | model_element_extend_generic_parameters(this, i, _))
    }

    /**
     * Gets the full name of this model element, if it exists.
     */
    string getFullName() { model_element_full_names(this, result) }

    /**
     * Gets the full name no default namespace of this model element, if it exists.
     */
    string getFullNameNoDefaultNamespace() {
      model_element_full_name_no_default_namespaces(this, result)
    }

    /**
     * Holds if this model element is internal.
     */
    predicate isInternal() { model_element_is_internal(this) }

    /**
     * Holds if this model element is kernel.
     */
    predicate isKernel() { model_element_is_kernel(this) }

    /**
     * Holds if this model element is obsolete.
     */
    predicate isObsolete() { model_element_is_obsolete(this) }

    /**
     * Holds if this model element is private.
     */
    predicate isPrivate() { model_element_is_private(this) }

    /**
     * Holds if this model element is public.
     */
    predicate isPublic() { model_element_is_public(this) }

    /**
     * Gets the `index`th method of this model element (0-based).
     */
    MethodOrDelegate getMethod(int index) { model_element_methods(this, index, result) }

    /**
     * Gets the number of methods of this model element.
     */
    int getNumberOfMethods() { result = count(int i | model_element_methods(this, i, _)) }

    /**
     * Gets the model of this model element, if it exists.
     */
    int getModelId() { model_element_model_ids(this, result) }

    /**
     * Gets the `index`th modifier list of this model element (0-based).
     */
    ClassAccessModifier getModifierList(int index) {
      model_element_modifier_lists(this, index, result)
    }

    /**
     * Gets the number of modifier lists of this model element.
     */
    int getNumberOfModifierLists() {
      result = count(int i | model_element_modifier_lists(this, i, _))
    }

    /**
     * Gets the modifiers of this model element, if it exists.
     */
    string getModifiers() { model_element_modifiers(this, result) }

    /**
     * Gets the namespace of this model element, if it exists.
     */
    string getNamespace() { model_element_namespaces(this, result) }

    /**
     * Gets the `index`th nested class of this model element (0-based).
     */
    ClassOrInterface getNestedClass(int index) { model_element_nested_classes(this, index, result) }

    /**
     * Gets the number of nested classes of this model element.
     */
    int getNumberOfNestedClasses() {
      result = count(int i | model_element_nested_classes(this, i, _))
    }

    /**
     * Gets the path contribution of this model element, if it exists.
     */
    string getPathContribution() { model_element_path_contributions(this, result) }

    /**
     * Gets the `index`th type parameter of this model element (0-based).
     */
    string getTypeParameter(int index) { model_element_type_parameters(this, index, result) }

    /**
     * Gets the number of type parameters of this model element.
     */
    int getNumberOfTypeParameters() {
      result = count(int i | model_element_type_parameters(this, i, _))
    }

    /**
     * Gets the `index`th using of this model element (0-based).
     */
    ModelElementUsingEntry getUsing(int index) { model_element_usings(this, index, result) }

    /**
     * Gets the number of usings of this model element.
     */
    int getNumberOfUsings() { result = count(int i | model_element_usings(this, i, _)) }

    /**
     * Gets the visibility of this model element, if it exists.
     */
    string getVisibility() { model_element_visibilities(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class MoveCursorStatement extends @move_cursor_statement, Statement {
    override string toString() { result = "MoveCursorStatement" }

    /**
     * Gets the selection of this move cursor statement, if it exists.
     */
    Selection getSelection() { move_cursor_statement_selections(this, result) }

    /**
     * Gets the table of this move cursor statement, if it exists.
     */
    string getTable() { move_cursor_statement_tables(this, result) }
  }

  private Element getImmediateChildOfMoveCursorStatement(MoveCursorStatement e, int index) {
    exists(int n, int nSelection |
      n = 0 and
      nSelection = n + 1 and
      (
        none()
        or
        index = n and result = e.getSelection()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NamedFieldReference extends @named_field_reference, TableFieldReference {
    override string toString() { result = "NamedFieldReference" }

    /**
     * Gets the extension name of this named field reference, if it exists.
     */
    string getExtensionName() { named_field_reference_extension_names(this, result) }

    /**
     * Gets the field name of this named field reference, if it exists.
     */
    string getFieldName() { named_field_reference_field_names(this, result) }
  }

  private Element getImmediateChildOfNamedFieldReference(NamedFieldReference e, int index) {
    exists(int n, int nIndex |
      n = 0 and
      nIndex = n + 1 and
      (
        none()
        or
        index = n and result = e.getIndex()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NewClrArrayExpression extends @new_clr_array_expression, Expression {
    override string toString() { result = "NewClrArrayExpression" }

    /**
     * Gets the full name of this new clr array expression, if it exists.
     */
    string getFullName() { new_clr_array_expression_full_names(this, result) }

    /**
     * Gets the `index`th rectangular dimension of this new clr array expression (0-based).
     */
    int getRectangularDimension(int index) {
      new_clr_array_expression_rectangular_dimensions(this, index, result)
    }

    /**
     * Gets the number of rectangular dimensions of this new clr array expression.
     */
    int getNumberOfRectangularDimensions() {
      result = count(int i | new_clr_array_expression_rectangular_dimensions(this, i, _))
    }

    /**
     * Gets the `index`th size of this new clr array expression (0-based).
     */
    Expression getSize(int index) { new_clr_array_expression_sizes(this, index, result) }

    /**
     * Gets the number of sizes of this new clr array expression.
     */
    int getNumberOfSizes() { result = count(int i | new_clr_array_expression_sizes(this, i, _)) }

    /**
     * Gets the `index`th type argument list of this new clr array expression (0-based).
     */
    XppType getTypeArgumentList(int index) {
      new_clr_array_expression_type_argument_lists(this, index, result)
    }

    /**
     * Gets the number of type argument lists of this new clr array expression.
     */
    int getNumberOfTypeArgumentLists() {
      result = count(int i | new_clr_array_expression_type_argument_lists(this, i, _))
    }
  }

  private Element getImmediateChildOfNewClrArrayExpression(NewClrArrayExpression e, int index) {
    exists(int n, int nTransformation, int nSize, int nTypeArgumentList |
      n = 0 and
      nTransformation = n + 1 and
      nSize = nTransformation + e.getNumberOfSizes() and
      nTypeArgumentList = nSize + e.getNumberOfTypeArgumentLists() and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getSize(index - nTransformation)
        or
        result = e.getTypeArgumentList(index - nSize)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NumberedFieldReference extends @numbered_field_reference, TableFieldReference {
    override string toString() { result = "NumberedFieldReference" }

    /**
     * Gets the field number of this numbered field reference, if it exists.
     */
    Expression getFieldNumber() { numbered_field_reference_field_numbers(this, result) }
  }

  private Element getImmediateChildOfNumberedFieldReference(NumberedFieldReference e, int index) {
    exists(int n, int nIndex, int nFieldNumber |
      n = 0 and
      nIndex = n + 1 and
      nFieldNumber = nIndex + 1 and
      (
        none()
        or
        index = n and result = e.getIndex()
        or
        index = nIndex and result = e.getFieldNumber()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Placeholder extends @placeholder, Expression {
    override string toString() { result = "Placeholder" }
  }

  private Element getImmediateChildOfPlaceholder(Placeholder e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class PrintStatement extends @print_statement, Statement {
    override string toString() { result = "PrintStatement" }

    /**
     * Gets the `index`th expression of this print statement (0-based).
     */
    Expression getExpression(int index) { print_statement_expressions(this, index, result) }

    /**
     * Gets the number of expressions of this print statement.
     */
    int getNumberOfExpressions() { result = count(int i | print_statement_expressions(this, i, _)) }
  }

  private Element getImmediateChildOfPrintStatement(PrintStatement e, int index) {
    exists(int n, int nExpression |
      n = 0 and
      nExpression = n + e.getNumberOfExpressions() and
      (
        none()
        or
        result = e.getExpression(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ProvidedType extends @provided_type, XppType {
    override string toString() { result = "ProvidedType" }

    /**
     * Gets the `index`th argument list of this provided type (0-based).
     */
    Expression getArgumentList(int index) { provided_type_argument_lists(this, index, result) }

    /**
     * Gets the number of argument lists of this provided type.
     */
    int getNumberOfArgumentLists() {
      result = count(int i | provided_type_argument_lists(this, i, _))
    }

    /**
     * Gets the name of this provided type, if it exists.
     */
    string getName() { provided_type_names(this, result) }
  }

  private Element getImmediateChildOfProvidedType(ProvidedType e, int index) {
    exists(int n, int nArgumentList |
      n = 0 and
      nArgumentList = n + e.getNumberOfArgumentLists() and
      (
        none()
        or
        result = e.getArgumentList(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QualifiedField extends @qualified_field, FieldSpecification {
    override string toString() { result = "QualifiedField" }

    /**
     * Gets the extension name of this qualified field, if it exists.
     */
    string getExtensionName() { qualified_field_extension_names(this, result) }

    /**
     * Gets the name of this qualified field, if it exists.
     */
    string getName() { qualified_field_names(this, result) }
  }

  private Element getImmediateChildOfQualifiedField(QualifiedField e, int index) {
    exists(int n, int nArrayIndex, int nQualifier |
      n = 0 and
      nArrayIndex = n + 1 and
      nQualifier = nArrayIndex + 1 and
      (
        none()
        or
        index = n and result = e.getArrayIndex()
        or
        index = nArrayIndex and result = e.getQualifier()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QualifiedInstanceName extends @qualified_instance_name, InstanceName {
    override string toString() { result = "QualifiedInstanceName" }

    /**
     * Gets the index of this qualified instance name, if it exists.
     */
    Expression getIndex() { qualified_instance_name_indices(this, result) }

    /**
     * Gets the name of this qualified instance name, if it exists.
     */
    string getName() { qualified_instance_name_names(this, result) }

    /**
     * Gets the qualifier of this qualified instance name, if it exists.
     */
    Qualifier getQualifier() { qualified_instance_name_qualifiers(this, result) }
  }

  private Element getImmediateChildOfQualifiedInstanceName(QualifiedInstanceName e, int index) {
    exists(int n, int nIndex, int nQualifier |
      n = 0 and
      nIndex = n + 1 and
      nQualifier = nIndex + 1 and
      (
        none()
        or
        index = n and result = e.getIndex()
        or
        index = nIndex and result = e.getQualifier()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QualifiedNumberedField extends @qualified_numbered_field, FieldSpecification {
    override string toString() { result = "QualifiedNumberedField" }

    /**
     * Gets the field number of this qualified numbered field, if it exists.
     */
    Expression getFieldNumber() { qualified_numbered_field_field_numbers(this, result) }
  }

  private Element getImmediateChildOfQualifiedNumberedField(QualifiedNumberedField e, int index) {
    exists(int n, int nArrayIndex, int nQualifier, int nFieldNumber |
      n = 0 and
      nArrayIndex = n + 1 and
      nQualifier = nArrayIndex + 1 and
      nFieldNumber = nQualifier + 1 and
      (
        none()
        or
        index = n and result = e.getArrayIndex()
        or
        index = nArrayIndex and result = e.getQualifier()
        or
        index = nQualifier and result = e.getFieldNumber()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QualifiedStaticField extends @qualified_static_field, FieldSpecification {
    override string toString() { result = "QualifiedStaticField" }

    /**
     * Gets the class name of this qualified static field, if it exists.
     */
    string getClassName() { qualified_static_field_class_names(this, result) }

    /**
     * Holds if this qualified static field is enum.
     */
    predicate isEnum() { qualified_static_field_is_enum(this) }

    /**
     * Gets the name of this qualified static field, if it exists.
     */
    string getName() { qualified_static_field_names(this, result) }
  }

  private Element getImmediateChildOfQualifiedStaticField(QualifiedStaticField e, int index) {
    exists(int n, int nArrayIndex, int nQualifier |
      n = 0 and
      nArrayIndex = n + 1 and
      nQualifier = nArrayIndex + 1 and
      (
        none()
        or
        index = n and result = e.getArrayIndex()
        or
        index = nArrayIndex and result = e.getQualifier()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class RetryStatement extends @retry_statement, Statement {
    override string toString() { result = "RetryStatement" }
  }

  private Element getImmediateChildOfRetryStatement(RetryStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class ReturnStatement extends @return_statement, Statement {
    override string toString() { result = "ReturnStatement" }

    /**
     * Gets the expression of this return statement, if it exists.
     */
    Expression getExpression() { return_statement_expressions(this, result) }
  }

  private Element getImmediateChildOfReturnStatement(ReturnStatement e, int index) {
    exists(int n, int nExpression |
      n = 0 and
      nExpression = n + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class SearchStatement extends @search_statement, Statement {
    override string toString() { result = "SearchStatement" }

    /**
     * Gets the query of this search statement, if it exists.
     */
    Query getQuery() { search_statement_queries(this, result) }

    /**
     * Gets the statement of this search statement, if it exists.
     */
    Statement getStatement() { search_statement_statements(this, result) }
  }

  private Element getImmediateChildOfSearchStatement(SearchStatement e, int index) {
    exists(int n, int nQuery, int nStatement |
      n = 0 and
      nQuery = n + 1 and
      nStatement = nQuery + 1 and
      (
        none()
        or
        index = n and result = e.getQuery()
        or
        index = nQuery and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class SimpleField extends @simple_field, FieldSpecification {
    override string toString() { result = "SimpleField" }

    /**
     * Gets the extension name of this simple field, if it exists.
     */
    string getExtensionName() { simple_field_extension_names(this, result) }

    /**
     * Holds if this simple field is name escaped.
     */
    predicate isNameEscaped() { simple_field_is_name_escaped(this) }

    /**
     * Gets the name of this simple field, if it exists.
     */
    string getName() { simple_field_names(this, result) }
  }

  private Element getImmediateChildOfSimpleField(SimpleField e, int index) {
    exists(int n, int nArrayIndex, int nQualifier |
      n = 0 and
      nArrayIndex = n + 1 and
      nQualifier = nArrayIndex + 1 and
      (
        none()
        or
        index = n and result = e.getArrayIndex()
        or
        index = nArrayIndex and result = e.getQualifier()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class SimpleInstanceName extends @simple_instance_name, InstanceName {
    override string toString() { result = "SimpleInstanceName" }

    /**
     * Gets the index of this simple instance name, if it exists.
     */
    Expression getIndex() { simple_instance_name_indices(this, result) }

    /**
     * Gets the name of this simple instance name, if it exists.
     */
    string getName() { simple_instance_name_names(this, result) }
  }

  private Element getImmediateChildOfSimpleInstanceName(SimpleInstanceName e, int index) {
    exists(int n, int nIndex |
      n = 0 and
      nIndex = n + 1 and
      (
        none()
        or
        index = n and result = e.getIndex()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class SimpleOrderElement extends @simple_order_element, OrderElement {
    override string toString() { result = "SimpleOrderElement" }

    /**
     * Gets the extension name of this simple order element, if it exists.
     */
    string getExtensionName() { simple_order_element_extension_names(this, result) }
  }

  private Element getImmediateChildOfSimpleOrderElement(SimpleOrderElement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class SimpleQualifier extends @simple_qualifier, Qualifier {
    /**
     * Gets the name of this simple qualifier, if it exists.
     */
    string getName() { simple_qualifier_names(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class StaticField extends @static_field, FieldSpecification {
    override string toString() { result = "StaticField" }

    /**
     * Gets the class name of this static field, if it exists.
     */
    string getClassName() { static_field_class_names(this, result) }

    /**
     * Gets the name of this static field, if it exists.
     */
    string getName() { static_field_names(this, result) }
  }

  private Element getImmediateChildOfStaticField(StaticField e, int index) {
    exists(int n, int nArrayIndex, int nQualifier |
      n = 0 and
      nArrayIndex = n + 1 and
      nQualifier = nArrayIndex + 1 and
      (
        none()
        or
        index = n and result = e.getArrayIndex()
        or
        index = nArrayIndex and result = e.getQualifier()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class StringType extends @string_type, XppType { }

  /**
   * INTERNAL: Do not use.
   */
  class SwitchStatement extends @switch_statement, Statement {
    override string toString() { result = "SwitchStatement" }

    /**
     * Gets the `index`th case of this switch statement (0-based).
     */
    SwitchStatementCaseEntry getCase(int index) { switch_statement_cases(this, index, result) }

    /**
     * Gets the number of cases of this switch statement.
     */
    int getNumberOfCases() { result = count(int i | switch_statement_cases(this, i, _)) }

    /**
     * Gets the selector of this switch statement, if it exists.
     */
    Expression getSelector() { switch_statement_selectors(this, result) }
  }

  private Element getImmediateChildOfSwitchStatement(SwitchStatement e, int index) {
    exists(int n, int nCase, int nSelector |
      n = 0 and
      nCase = n + e.getNumberOfCases() and
      nSelector = nCase + 1 and
      (
        none()
        or
        result = e.getCase(index - n)
        or
        index = nCase and result = e.getSelector()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class TableLookupExpression extends @table_lookup_expression, Expression {
    override string toString() { result = "TableLookupExpression" }

    /**
     * Gets the field of this table lookup expression, if it exists.
     */
    TableFieldReference getField() { table_lookup_expression_fields(this, result) }

    /**
     * Gets the query of this table lookup expression, if it exists.
     */
    Query getQuery() { table_lookup_expression_queries(this, result) }
  }

  private Element getImmediateChildOfTableLookupExpression(TableLookupExpression e, int index) {
    exists(int n, int nTransformation, int nField, int nQuery |
      n = 0 and
      nTransformation = n + 1 and
      nField = nTransformation + 1 and
      nQuery = nField + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getField()
        or
        index = nField and result = e.getQuery()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ThrowStatement extends @throw_statement, Statement {
    override string toString() { result = "ThrowStatement" }

    /**
     * Gets the exception of this throw statement, if it exists.
     */
    Expression getException() { throw_statement_exceptions(this, result) }
  }

  private Element getImmediateChildOfThrowStatement(ThrowStatement e, int index) {
    exists(int n, int nException |
      n = 0 and
      nException = n + 1 and
      (
        none()
        or
        index = n and result = e.getException()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class TryStatement extends @try_statement, Statement {
    override string toString() { result = "TryStatement" }

    /**
     * Gets the `index`th catch of this try statement (0-based).
     */
    TryStatementCatchEntry getCatch(int index) { try_statement_catches(this, index, result) }

    /**
     * Gets the number of catches of this try statement.
     */
    int getNumberOfCatches() { result = count(int i | try_statement_catches(this, i, _)) }

    /**
     * Gets the finally of this try statement, if it exists.
     */
    Statement getFinally() { try_statement_finallies(this, result) }

    /**
     * Gets the statement of this try statement, if it exists.
     */
    Statement getStatement() { try_statement_statements(this, result) }
  }

  private Element getImmediateChildOfTryStatement(TryStatement e, int index) {
    exists(int n, int nCatch, int nFinally, int nStatement |
      n = 0 and
      nCatch = n + e.getNumberOfCatches() and
      nFinally = nCatch + 1 and
      nStatement = nFinally + 1 and
      (
        none()
        or
        result = e.getCatch(index - n)
        or
        index = nCatch and result = e.getFinally()
        or
        index = nFinally and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class TtsStatement extends @tts_statement, Statement { }

  /**
   * INTERNAL: Do not use.
   */
  class UnaryExpression extends @unary_expression, Expression {
    /**
     * Gets the expression of this unary expression, if it exists.
     */
    Expression getExpression() { unary_expression_expressions(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class UncheckedStatement extends @unchecked_statement, Statement {
    override string toString() { result = "UncheckedStatement" }

    /**
     * Gets the expression of this unchecked statement, if it exists.
     */
    Expression getExpression() { unchecked_statement_expressions(this, result) }

    /**
     * Gets the statement of this unchecked statement, if it exists.
     */
    Statement getStatement() { unchecked_statement_statements(this, result) }
  }

  private Element getImmediateChildOfUncheckedStatement(UncheckedStatement e, int index) {
    exists(int n, int nExpression, int nStatement |
      n = 0 and
      nExpression = n + 1 and
      nStatement = nExpression + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
        or
        index = nExpression and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class UpdateStatement extends @update_statement, Statement {
    override string toString() { result = "UpdateStatement" }

    /**
     * Gets the cross company of this update statement, if it exists.
     */
    CrossCompany getCrossCompany() { update_statement_cross_companies(this, result) }

    /**
     * Gets the `index`th field assignment of this update statement (0-based).
     */
    FieldAssignment getFieldAssignment(int index) {
      update_statement_field_assignments(this, index, result)
    }

    /**
     * Gets the number of field assignments of this update statement.
     */
    int getNumberOfFieldAssignments() {
      result = count(int i | update_statement_field_assignments(this, i, _))
    }

    /**
     * Gets the `index`th hint of this update statement (0-based).
     */
    string getHint(int index) { update_statement_hints(this, index, result) }

    /**
     * Gets the number of hints of this update statement.
     */
    int getNumberOfHints() { result = count(int i | update_statement_hints(this, i, _)) }

    /**
     * Gets the joins of this update statement, if it exists.
     */
    JoinSpecification getJoins() { update_statement_joins(this, result) }

    /**
     * Gets the table of this update statement, if it exists.
     */
    string getTable() { update_statement_tables(this, result) }

    /**
     * Gets the where of this update statement, if it exists.
     */
    Expression getWhere() { update_statement_wheres(this, result) }
  }

  private Element getImmediateChildOfUpdateStatement(UpdateStatement e, int index) {
    exists(int n, int nCrossCompany, int nFieldAssignment, int nJoins, int nWhere |
      n = 0 and
      nCrossCompany = n + 1 and
      nFieldAssignment = nCrossCompany + e.getNumberOfFieldAssignments() and
      nJoins = nFieldAssignment + 1 and
      nWhere = nJoins + 1 and
      (
        none()
        or
        index = n and result = e.getCrossCompany()
        or
        result = e.getFieldAssignment(index - nCrossCompany)
        or
        index = nFieldAssignment and result = e.getJoins()
        or
        index = nJoins and result = e.getWhere()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class UsingStatement extends @using_statement, Statement {
    override string toString() { result = "UsingStatement" }

    /**
     * Gets the `index`th disposable object initializer of this using statement (0-based).
     */
    VariableDeclaration getDisposableObjectInitializer(int index) {
      using_statement_disposable_object_initializers(this, index, result)
    }

    /**
     * Gets the number of disposable object initializers of this using statement.
     */
    int getNumberOfDisposableObjectInitializers() {
      result = count(int i | using_statement_disposable_object_initializers(this, i, _))
    }

    /**
     * Gets the statement of this using statement, if it exists.
     */
    Statement getStatement() { using_statement_statements(this, result) }
  }

  private Element getImmediateChildOfUsingStatement(UsingStatement e, int index) {
    exists(int n, int nDisposableObjectInitializer, int nStatement |
      n = 0 and
      nDisposableObjectInitializer = n + e.getNumberOfDisposableObjectInitializers() and
      nStatement = nDisposableObjectInitializer + 1 and
      (
        none()
        or
        result = e.getDisposableObjectInitializer(index - n)
        or
        index = nDisposableObjectInitializer and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ValidTimeStateDate extends @valid_time_state_date, ValidTimeState {
    override string toString() { result = "ValidTimeStateDate" }

    /**
     * Gets the date variable of this valid time state date, if it exists.
     */
    string getDateVariable() { valid_time_state_date_date_variables(this, result) }
  }

  private Element getImmediateChildOfValidTimeStateDate(ValidTimeStateDate e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class ValidTimeStateRange extends @valid_time_state_range, ValidTimeState {
    override string toString() { result = "ValidTimeStateRange" }

    /**
     * Gets the from date variable of this valid time state range, if it exists.
     */
    string getFromDateVariable() { valid_time_state_range_from_date_variables(this, result) }

    /**
     * Gets the to date variable of this valid time state range, if it exists.
     */
    string getToDateVariable() { valid_time_state_range_to_date_variables(this, result) }
  }

  private Element getImmediateChildOfValidTimeStateRange(ValidTimeStateRange e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class VarType extends @var_type, XppType {
    override string toString() { result = "VarType" }
  }

  private Element getImmediateChildOfVarType(VarType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class VoidType extends @void_type, XppType {
    override string toString() { result = "VoidType" }
  }

  private Element getImmediateChildOfVoidType(VoidType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class WhileStatement extends @while_statement, Statement {
    override string toString() { result = "WhileStatement" }

    /**
     * Gets the condition of this while statement, if it exists.
     */
    Expression getCondition() { while_statement_conditions(this, result) }

    /**
     * Gets the statement of this while statement, if it exists.
     */
    Statement getStatement() { while_statement_statements(this, result) }
  }

  private Element getImmediateChildOfWhileStatement(WhileStatement e, int index) {
    exists(int n, int nCondition, int nStatement |
      n = 0 and
      nCondition = n + 1 and
      nStatement = nCondition + 1 and
      (
        none()
        or
        index = n and result = e.getCondition()
        or
        index = nCondition and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class XppTypeCompilationUnit extends @xpp_type_compilation_unit, CompilationUnit {
    override string toString() { result = "XppTypeCompilationUnit" }

    /**
     * Gets the type of this xpp type compilation unit, if it exists.
     */
    XppType getType() { xpp_type_compilation_unit_types(this, result) }
  }

  private Element getImmediateChildOfXppTypeCompilationUnit(XppTypeCompilationUnit e, int index) {
    exists(int n, int nComments, int nRegion, int nType |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nType = nRegion + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        index = nRegion and result = e.getType()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AddExpression extends @add_expression, BinaryExpression {
    override string toString() { result = "AddExpression" }
  }

  private Element getImmediateChildOfAddExpression(AddExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AndExpression extends @and_expression, BinaryExpression {
    override string toString() { result = "AndExpression" }
  }

  private Element getImmediateChildOfAndExpression(AndExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AsClrExpression extends @as_clr_expression, IsAsExpression {
    override string toString() { result = "AsClrExpression" }
  }

  private Element getImmediateChildOfAsClrExpression(AsClrExpression e, int index) {
    exists(int n, int nTransformation, int nExpression |
      n = 0 and
      nTransformation = n + 1 and
      nExpression = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AsExpression extends @as_expression, IsAsExpression {
    override string toString() { result = "AsExpression" }
  }

  private Element getImmediateChildOfAsExpression(AsExpression e, int index) {
    exists(int n, int nTransformation, int nExpression |
      n = 0 and
      nTransformation = n + 1 and
      nExpression = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignMultipleFieldStatement extends @assign_multiple_field_statement, AssignmentStatement {
    override string toString() { result = "AssignMultipleFieldStatement" }

    /**
     * Gets the expression of this assign multiple field statement, if it exists.
     */
    Expression getExpression() { assign_multiple_field_statement_expressions(this, result) }

    /**
     * Gets the `index`th field of this assign multiple field statement (0-based).
     */
    FieldSpecification getField(int index) {
      assign_multiple_field_statement_fields(this, index, result)
    }

    /**
     * Gets the number of fields of this assign multiple field statement.
     */
    int getNumberOfFields() {
      result = count(int i | assign_multiple_field_statement_fields(this, i, _))
    }
  }

  private Element getImmediateChildOfAssignMultipleFieldStatement(
    AssignMultipleFieldStatement e, int index
  ) {
    exists(int n, int nExpression, int nField |
      n = 0 and
      nExpression = n + 1 and
      nField = nExpression + e.getNumberOfFields() and
      (
        none()
        or
        index = n and result = e.getExpression()
        or
        result = e.getField(index - nExpression)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignmentSingleField extends @assignment_single_field, AssignmentStatement {
    /**
     * Gets the field of this assignment single field, if it exists.
     */
    FieldSpecification getField() { assignment_single_field_fields(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class AvgAggregateSelection extends @avg_aggregate_selection, AggregateSelection {
    override string toString() { result = "AvgAggregateSelection" }
  }

  private Element getImmediateChildOfAvgAggregateSelection(AvgAggregateSelection e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class BooleanAttributeLiteral extends @boolean_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "BooleanAttributeLiteral" }
  }

  private Element getImmediateChildOfBooleanAttributeLiteral(BooleanAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class ChangeCompanyStatement extends @change_company_statement, ChangeStatement {
    override string toString() { result = "ChangeCompanyStatement" }
  }

  private Element getImmediateChildOfChangeCompanyStatement(ChangeCompanyStatement e, int index) {
    exists(int n, int nExpression, int nStatement |
      n = 0 and
      nExpression = n + 1 and
      nStatement = nExpression + 1 and
      (
        none()
        or
        index = n and result = e.getExpression()
        or
        index = nExpression and result = e.getStatement()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ClassOrInterface extends @class_or_interface, ModelElement {
    /**
     * Gets the attributes of this class or interface, if it exists.
     */
    AttributeList getAttributes() { class_or_interface_attributes(this, result) }

    /**
     * Gets the element type name of this class or interface, if it exists.
     */
    string getElementTypeName() { class_or_interface_element_type_names(this, result) }

    /**
     * Gets the enclosing type of this class or interface, if it exists.
     */
    ModelElement getEnclosingType() { class_or_interface_enclosing_types(this, result) }

    /**
     * Gets the extends of this class or interface, if it exists.
     */
    string getExtends() { class_or_interface_extends(this, result) }

    /**
     * Holds if this class or interface is abstract.
     */
    predicate isAbstract() { class_or_interface_is_abstract(this) }

    /**
     * Holds if this class or interface is composite data entity view.
     */
    predicate isCompositeDataEntityView() { class_or_interface_is_composite_data_entity_view(this) }

    /**
     * Holds if this class or interface is final.
     */
    predicate isFinal() { class_or_interface_is_final(this) }

    /**
     * Holds if this class or interface is nested.
     */
    predicate isNested() { class_or_interface_is_nested(this) }

    /**
     * Holds if this class or interface is static.
     */
    predicate isStatic() { class_or_interface_is_static(this) }

    /**
     * Gets the qualifier of this class or interface, if it exists.
     */
    string getQualifier() { class_or_interface_qualifiers(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ClrEnumerationLiteralExpression extends @clr_enumeration_literal_expression,
    LiteralExpression
  {
    override string toString() { result = "ClrEnumerationLiteralExpression" }

    /**
     * Gets the enumeration literal of this clr enumeration literal expression, if it exists.
     */
    string getEnumerationLiteral() {
      clr_enumeration_literal_expression_enumeration_literals(this, result)
    }

    /**
     * Gets the enumeration type of this clr enumeration literal expression, if it exists.
     */
    string getEnumerationType() {
      clr_enumeration_literal_expression_enumeration_types(this, result)
    }
  }

  private Element getImmediateChildOfClrEnumerationLiteralExpression(
    ClrEnumerationLiteralExpression e, int index
  ) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ClrType extends @clr_type, GenericXppType {
    override string toString() { result = "ClrType" }

    /**
     * Gets the full name of this clr type, if it exists.
     */
    string getFullName() { clr_type_full_names(this, result) }

    /**
     * Gets the `index`th rectangular dimension of this clr type (0-based).
     */
    int getRectangularDimension(int index) { clr_type_rectangular_dimensions(this, index, result) }

    /**
     * Gets the number of rectangular dimensions of this clr type.
     */
    int getNumberOfRectangularDimensions() {
      result = count(int i | clr_type_rectangular_dimensions(this, i, _))
    }
  }

  private Element getImmediateChildOfClrType(ClrType e, int index) {
    exists(int n, int nTypeArgumentList |
      n = 0 and
      nTypeArgumentList = n + e.getNumberOfTypeArgumentLists() and
      (
        none()
        or
        result = e.getTypeArgumentList(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ContainerLiteralExpression extends @container_literal_expression, LiteralExpression {
    override string toString() { result = "ContainerLiteralExpression" }

    /**
     * Gets the `index`th value of this container literal expression (0-based).
     */
    Expression getValue(int index) { container_literal_expression_values(this, index, result) }

    /**
     * Gets the number of values of this container literal expression.
     */
    int getNumberOfValues() {
      result = count(int i | container_literal_expression_values(this, i, _))
    }
  }

  private Element getImmediateChildOfContainerLiteralExpression(
    ContainerLiteralExpression e, int index
  ) {
    exists(int n, int nTransformation, int nValue |
      n = 0 and
      nTransformation = n + 1 and
      nValue = nTransformation + e.getNumberOfValues() and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getValue(index - nTransformation)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class CountAggregateSelection extends @count_aggregate_selection, AggregateSelection {
    override string toString() { result = "CountAggregateSelection" }
  }

  private Element getImmediateChildOfCountAggregateSelection(CountAggregateSelection e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class DateAttributeLiteral extends @date_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "DateAttributeLiteral" }
  }

  private Element getImmediateChildOfDateAttributeLiteral(DateAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class DateTimeAttributeLiteral extends @date_time_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "DateTimeAttributeLiteral" }
  }

  private Element getImmediateChildOfDateTimeAttributeLiteral(DateTimeAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class DblAttributeLiteral extends @dbl_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "DblAttributeLiteral" }
  }

  private Element getImmediateChildOfDblAttributeLiteral(DblAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class DefaultTypeLiteralExpression extends @default_type_literal_expression, LiteralExpression {
    /**
     * Gets the scanned literal value of this default type literal expression, if it exists.
     */
    string getScannedLiteralValue() {
      default_type_literal_expression_scanned_literal_values(this, result)
    }
  }

  /**
   * INTERNAL: Do not use.
   */
  class Delegate extends @delegate, MethodOrDelegate {
    override string toString() { result = "Delegate" }

    /**
     * Holds if this delegate is static.
     */
    predicate isStatic() { delegate_is_static(this) }
  }

  private Element getImmediateChildOfDelegate(Delegate e, int index) {
    exists(
      int n, int nComments, int nRegion, int nAttributes, int nModifierList, int nParameter,
      int nType
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nAttributes = nRegion + 1 and
      nModifierList = nAttributes + e.getNumberOfModifierLists() and
      nParameter = nModifierList + e.getNumberOfParameters() and
      nType = nParameter + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        index = nRegion and result = e.getAttributes()
        or
        result = e.getModifierList(index - nAttributes)
        or
        result = e.getParameter(index - nModifierList)
        or
        index = nParameter and result = e.getType()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class DivideExpression extends @divide_expression, BinaryExpression {
    override string toString() { result = "DivideExpression" }
  }

  private Element getImmediateChildOfDivideExpression(DivideExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class EnumerationLiteralExpression extends @enumeration_literal_expression, LiteralExpression {
    override string toString() { result = "EnumerationLiteralExpression" }

    /**
     * Gets the enumeration literal of this enumeration literal expression, if it exists.
     */
    string getEnumerationLiteral() {
      enumeration_literal_expression_enumeration_literals(this, result)
    }

    /**
     * Gets the enumeration type of this enumeration literal expression, if it exists.
     */
    string getEnumerationType() { enumeration_literal_expression_enumeration_types(this, result) }
  }

  private Element getImmediateChildOfEnumerationLiteralExpression(
    EnumerationLiteralExpression e, int index
  ) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FieldDeclaration extends @field_declaration, Declaration {
    /**
     * Gets the attributes of this field declaration, if it exists.
     */
    AttributeList getAttributes() { field_declaration_attributes(this, result) }

    /**
     * Gets the element type name of this field declaration, if it exists.
     */
    string getElementTypeName() { field_declaration_element_type_names(this, result) }

    /**
     * Gets the extension name of this field declaration, if it exists.
     */
    string getExtensionName() { field_declaration_extension_names(this, result) }

    /**
     * Gets the initial value of this field declaration, if it exists.
     */
    Expression getInitialValue() { field_declaration_initial_values(this, result) }

    /**
     * Holds if this field declaration is const.
     */
    predicate isConst() { field_declaration_is_const(this) }

    /**
     * Holds if this field declaration is extension.
     */
    predicate isExtension() { field_declaration_is_extension(this) }

    /**
     * Holds if this field declaration is internal.
     */
    predicate isInternal() { field_declaration_is_internal(this) }

    /**
     * Holds if this field declaration is obsolete.
     */
    predicate isObsolete() { field_declaration_is_obsolete(this) }

    /**
     * Holds if this field declaration is private.
     */
    predicate isPrivate() { field_declaration_is_private(this) }

    /**
     * Holds if this field declaration is protected.
     */
    predicate isProtected() { field_declaration_is_protected(this) }

    /**
     * Holds if this field declaration is public.
     */
    predicate isPublic() { field_declaration_is_public(this) }

    /**
     * Holds if this field declaration is read only.
     */
    predicate isReadOnly() { field_declaration_is_read_only(this) }

    /**
     * Holds if this field declaration is static.
     */
    predicate isStatic() { field_declaration_is_static(this) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForFieldAssign extends @for_field_assign, ForExpressionAssign {
    override string toString() { result = "ForFieldAssign" }
  }

  private Element getImmediateChildOfForFieldAssign(ForFieldAssign e, int index) {
    exists(int n, int nFieldSpecification, int nExpression |
      n = 0 and
      nFieldSpecification = n + 1 and
      nExpression = nFieldSpecification + 1 and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
        or
        index = nFieldSpecification and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForFieldDecrementAssign extends @for_field_decrement_assign, ForExpressionAssign {
    override string toString() { result = "ForFieldDecrementAssign" }
  }

  private Element getImmediateChildOfForFieldDecrementAssign(ForFieldDecrementAssign e, int index) {
    exists(int n, int nFieldSpecification, int nExpression |
      n = 0 and
      nFieldSpecification = n + 1 and
      nExpression = nFieldSpecification + 1 and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
        or
        index = nFieldSpecification and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ForFieldIncrementAssign extends @for_field_increment_assign, ForExpressionAssign {
    override string toString() { result = "ForFieldIncrementAssign" }
  }

  private Element getImmediateChildOfForFieldIncrementAssign(ForFieldIncrementAssign e, int index) {
    exists(int n, int nFieldSpecification, int nExpression |
      n = 0 and
      nFieldSpecification = n + 1 and
      nExpression = nFieldSpecification + 1 and
      (
        none()
        or
        index = n and result = e.getFieldSpecification()
        or
        index = nFieldSpecification and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FormModelElement extends @form_model_element, ModelElement {
    override string toString() { result = "FormModelElement" }

    /**
     * Gets the behavior of this form model element, if it exists.
     */
    Class getBehavior() { form_model_element_behaviors(this, result) }

    /**
     * Gets the `index`th control of this form model element (0-based).
     */
    FormControl getControl(int index) { form_model_element_controls(this, index, result) }

    /**
     * Gets the number of controls of this form model element.
     */
    int getNumberOfControls() { result = count(int i | form_model_element_controls(this, i, _)) }

    /**
     * Gets the `index`th data source of this form model element (0-based).
     */
    FormDataSource getDataSource(int index) { form_model_element_data_sources(this, index, result) }

    /**
     * Gets the number of data sources of this form model element.
     */
    int getNumberOfDataSources() {
      result = count(int i | form_model_element_data_sources(this, i, _))
    }

    /**
     * Gets the element type name of this form model element, if it exists.
     */
    string getElementTypeName() { form_model_element_element_type_names(this, result) }

    /**
     * Gets the full type name of this form model element, if it exists.
     */
    string getFullTypeName() { form_model_element_full_type_names(this, result) }
  }

  private Element getImmediateChildOfFormModelElement(FormModelElement e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nBehavior, int nControl, int nDataSource
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nBehavior = nUsing + 1 and
      nControl = nBehavior + e.getNumberOfControls() and
      nDataSource = nControl + e.getNumberOfDataSources() and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getBehavior()
        or
        result = e.getControl(index - nBehavior)
        or
        result = e.getDataSource(index - nControl)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FormNestedElement extends @form_nested_element, ModelElement {
    /**
     * Gets the form of this form nested element, if it exists.
     */
    FormModelElement getForm() { form_nested_element_forms(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class GenericEvaluation extends @generic_evaluation, Evaluation {
    /**
     * Gets the `index`th type argument list of this generic evaluation (0-based).
     */
    XppType getTypeArgumentList(int index) {
      generic_evaluation_type_argument_lists(this, index, result)
    }

    /**
     * Gets the number of type argument lists of this generic evaluation.
     */
    int getNumberOfTypeArgumentLists() {
      result = count(int i | generic_evaluation_type_argument_lists(this, i, _))
    }
  }

  /**
   * INTERNAL: Do not use.
   */
  class GuidAttributeLiteral extends @guid_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "GuidAttributeLiteral" }
  }

  private Element getImmediateChildOfGuidAttributeLiteral(GuidAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class InExpression extends @in_expression, BinaryExpression {
    override string toString() { result = "InExpression" }
  }

  private Element getImmediateChildOfInExpression(InExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Int64AttributeLiteral extends @int64_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "Int64AttributeLiteral" }
  }

  private Element getImmediateChildOfInt64AttributeLiteral(Int64AttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class IntAttributeLiteral extends @int_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "IntAttributeLiteral" }
  }

  private Element getImmediateChildOfIntAttributeLiteral(IntAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class IntegerDivideExpression extends @integer_divide_expression, BinaryExpression {
    override string toString() { result = "IntegerDivideExpression" }
  }

  private Element getImmediateChildOfIntegerDivideExpression(IntegerDivideExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class IsClrExpression extends @is_clr_expression, IsAsExpression {
    override string toString() { result = "IsClrExpression" }
  }

  private Element getImmediateChildOfIsClrExpression(IsClrExpression e, int index) {
    exists(int n, int nTransformation, int nExpression |
      n = 0 and
      nTransformation = n + 1 and
      nExpression = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class IsExpression extends @is_expression, IsAsExpression {
    override string toString() { result = "IsExpression" }
  }

  private Element getImmediateChildOfIsExpression(IsExpression e, int index) {
    exists(int n, int nTransformation, int nExpression |
      n = 0 and
      nTransformation = n + 1 and
      nExpression = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class LocalDeclaration extends @local_declaration, Declaration { }

  /**
   * INTERNAL: Do not use.
   */
  class MaxAggregateSelection extends @max_aggregate_selection, AggregateSelection {
    override string toString() { result = "MaxAggregateSelection" }
  }

  private Element getImmediateChildOfMaxAggregateSelection(MaxAggregateSelection e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class Method extends @method, MethodOrDelegate {
    override string toString() { result = "Method" }

    /**
     * Gets the `index`th declarations and statement of this method (0-based).
     */
    Statement getDeclarationsAndStatement(int index) {
      method_declarations_and_statements(this, index, result)
    }

    /**
     * Gets the number of declarations and statements of this method.
     */
    int getNumberOfDeclarationsAndStatements() {
      result = count(int i | method_declarations_and_statements(this, i, _))
    }

    /**
     * Holds if this method has local functions.
     */
    predicate hasLocalFunctions() { method_has_local_functions(this) }

    /**
     * Holds if this method is abstract.
     */
    predicate isAbstract() { method_is_abstract(this) }

    /**
     * Holds if this method is client.
     */
    predicate isClient() { method_is_client(this) }

    /**
     * Holds if this method is constructor.
     */
    predicate isConstructor() { method_is_constructor(this) }

    /**
     * Holds if this method is display.
     */
    predicate isDisplay() { method_is_display(this) }

    /**
     * Holds if this method is edit.
     */
    predicate isEdit() { method_is_edit(this) }

    /**
     * Holds if this method is explicit non hookable.
     */
    predicate isExplicitNonHookable() { method_is_explicit_non_hookable(this) }

    /**
     * Holds if this method is explicit non wrappable.
     */
    predicate isExplicitNonWrappable() { method_is_explicit_non_wrappable(this) }

    /**
     * Holds if this method is extended method.
     */
    predicate isExtendedMethod() { method_is_extended_method(this) }

    /**
     * Holds if this method is final.
     */
    predicate isFinal() { method_is_final(this) }

    /**
     * Holds if this method is hookable.
     */
    predicate isHookable() { method_is_hookable(this) }

    /**
     * Holds if this method is hookable on chain of command.
     */
    predicate isHookableOnChainOfCommand() { method_is_hookable_on_chain_of_command(this) }

    /**
     * Holds if this method is internal.
     */
    predicate isInternal() { method_is_internal(this) }

    /**
     * Holds if this method is private.
     */
    predicate isPrivate() { method_is_private(this) }

    /**
     * Holds if this method is protected.
     */
    predicate isProtected() { method_is_protected(this) }

    /**
     * Holds if this method is public.
     */
    predicate isPublic() { method_is_public(this) }

    /**
     * Holds if this method is replaceable.
     */
    predicate isReplaceable() { method_is_replaceable(this) }

    /**
     * Holds if this method is server.
     */
    predicate isServer() { method_is_server(this) }

    /**
     * Holds if this method is static.
     */
    predicate isStatic() { method_is_static(this) }

    /**
     * Holds if this method is type initializer.
     */
    predicate isTypeInitializer() { method_is_type_initializer(this) }

    /**
     * Holds if this method is wrappable.
     */
    predicate isWrappable() { method_is_wrappable(this) }

    /**
     * Gets the `index`th local of this method (0-based).
     */
    LocalDeclaration getLocal(int index) { method_locals(this, index, result) }

    /**
     * Gets the number of locals of this method.
     */
    int getNumberOfLocals() { result = count(int i | method_locals(this, i, _)) }

    /**
     * Gets the modifiers of this method, if it exists.
     */
    string getModifiers() { method_modifiers(this, result) }

    /**
     * Gets the `index`th statement of this method (0-based).
     */
    Statement getStatement(int index) { method_statements(this, index, result) }

    /**
     * Gets the number of statements of this method.
     */
    int getNumberOfStatements() { result = count(int i | method_statements(this, i, _)) }
  }

  private Element getImmediateChildOfMethod(Method e, int index) {
    exists(
      int n, int nComments, int nRegion, int nAttributes, int nModifierList, int nParameter,
      int nType, int nDeclarationsAndStatement, int nLocal, int nStatement
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nAttributes = nRegion + 1 and
      nModifierList = nAttributes + e.getNumberOfModifierLists() and
      nParameter = nModifierList + e.getNumberOfParameters() and
      nType = nParameter + 1 and
      nDeclarationsAndStatement = nType + e.getNumberOfDeclarationsAndStatements() and
      nLocal = nDeclarationsAndStatement + e.getNumberOfLocals() and
      nStatement = nLocal + e.getNumberOfStatements() and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        index = nRegion and result = e.getAttributes()
        or
        result = e.getModifierList(index - nAttributes)
        or
        result = e.getParameter(index - nModifierList)
        or
        index = nParameter and result = e.getType()
        or
        result = e.getDeclarationsAndStatement(index - nType)
        or
        result = e.getLocal(index - nDeclarationsAndStatement)
        or
        result = e.getStatement(index - nLocal)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class MinAggregateSelection extends @min_aggregate_selection, AggregateSelection {
    override string toString() { result = "MinAggregateSelection" }
  }

  private Element getImmediateChildOfMinAggregateSelection(MinAggregateSelection e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class ModExpression extends @mod_expression, BinaryExpression {
    override string toString() { result = "ModExpression" }
  }

  private Element getImmediateChildOfModExpression(ModExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class MultiplyExpression extends @multiply_expression, BinaryExpression {
    override string toString() { result = "MultiplyExpression" }
  }

  private Element getImmediateChildOfMultiplyExpression(MultiplyExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NamedType extends @named_type, GenericXppType {
    /**
     * Gets the name of this named type, if it exists.
     */
    string getName() { named_type_names(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class NewCall extends @new_call, Evaluation {
    override string toString() { result = "NewCall" }

    /**
     * Gets the type of this new call, if it exists.
     */
    XppType getType() { new_call_types(this, result) }
  }

  private Element getImmediateChildOfNewCall(NewCall e, int index) {
    exists(int n, int nTransformation, int nActualParameter, int nType |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      nType = nActualParameter + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
        or
        index = nActualParameter and result = e.getType()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NextExpression extends @next_expression, Evaluation {
    override string toString() { result = "NextExpression" }

    /**
     * Gets the name of this next expression, if it exists.
     */
    string getName() { next_expression_names(this, result) }
  }

  private Element getImmediateChildOfNextExpression(NextExpression e, int index) {
    exists(int n, int nTransformation, int nActualParameter |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NotExpression extends @not_expression, UnaryExpression {
    override string toString() { result = "NotExpression" }
  }

  private Element getImmediateChildOfNotExpression(NotExpression e, int index) {
    exists(int n, int nTransformation, int nExpression |
      n = 0 and
      nTransformation = n + 1 and
      nExpression = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NullLiteralExpression extends @null_literal_expression, LiteralExpression {
    override string toString() { result = "NullLiteralExpression" }
  }

  private Element getImmediateChildOfNullLiteralExpression(NullLiteralExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class OrExpression extends @or_expression, BinaryExpression {
    override string toString() { result = "OrExpression" }
  }

  private Element getImmediateChildOfOrExpression(OrExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class PhysicalAndExpression extends @physical_and_expression, BinaryExpression {
    override string toString() { result = "PhysicalAndExpression" }
  }

  private Element getImmediateChildOfPhysicalAndExpression(PhysicalAndExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class PhysicalNotExpression extends @physical_not_expression, UnaryExpression {
    override string toString() { result = "PhysicalNotExpression" }
  }

  private Element getImmediateChildOfPhysicalNotExpression(PhysicalNotExpression e, int index) {
    exists(int n, int nTransformation, int nExpression |
      n = 0 and
      nTransformation = n + 1 and
      nExpression = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class PhysicalOrExpression extends @physical_or_expression, BinaryExpression {
    override string toString() { result = "PhysicalOrExpression" }
  }

  private Element getImmediateChildOfPhysicalOrExpression(PhysicalOrExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class PhysicalXorExpression extends @physical_xor_expression, BinaryExpression {
    override string toString() { result = "PhysicalXorExpression" }
  }

  private Element getImmediateChildOfPhysicalXorExpression(PhysicalXorExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ProvidedTypeStaticCall extends @provided_type_static_call, Evaluation {
    override string toString() { result = "ProvidedTypeStaticCall" }

    /**
     * Gets the method name of this provided type static call, if it exists.
     */
    string getMethodName() { provided_type_static_call_method_names(this, result) }

    /**
     * Gets the provided type of this provided type static call, if it exists.
     */
    ProvidedType getProvidedType() { provided_type_static_call_provided_types(this, result) }
  }

  private Element getImmediateChildOfProvidedTypeStaticCall(ProvidedTypeStaticCall e, int index) {
    exists(int n, int nTransformation, int nActualParameter, int nProvidedType |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      nProvidedType = nActualParameter + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
        or
        index = nActualParameter and result = e.getProvidedType()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QualifiedStaticFieldExpression extends @qualified_static_field_expression, FieldExpression {
    override string toString() { result = "QualifiedStaticFieldExpression" }

    /**
     * Gets the class name of this qualified static field expression, if it exists.
     */
    string getClassName() { qualified_static_field_expression_class_names(this, result) }

    /**
     * Holds if this qualified static field expression is static.
     */
    predicate isStatic() { qualified_static_field_expression_is_static(this) }

    /**
     * Gets the name of this qualified static field expression, if it exists.
     */
    string getName() { qualified_static_field_expression_names(this, result) }
  }

  private Element getImmediateChildOfQualifiedStaticFieldExpression(
    QualifiedStaticFieldExpression e, int index
  ) {
    exists(int n, int nTransformation, int nField |
      n = 0 and
      nTransformation = n + 1 and
      nField = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getField()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QueryModelElement extends @query_model_element, ModelElement {
    override string toString() { result = "QueryModelElement" }

    /**
     * Holds if this query model element allow cross company.
     */
    predicate allowCrossCompany() { query_model_element_allow_cross_company(this) }

    /**
     * Gets the behavior of this query model element, if it exists.
     */
    Class getBehavior() { query_model_element_behaviors(this, result) }

    /**
     * Gets the `index`th data source list of this query model element (0-based).
     */
    QueryDataSource getDataSourceList(int index) {
      query_model_element_data_source_lists(this, index, result)
    }

    /**
     * Gets the number of data source lists of this query model element.
     */
    int getNumberOfDataSourceLists() {
      result = count(int i | query_model_element_data_source_lists(this, i, _))
    }

    /**
     * Gets the `index`th data source of this query model element (0-based).
     */
    QueryDataSource getDataSource(int index) {
      query_model_element_data_sources(this, index, result)
    }

    /**
     * Gets the number of data sources of this query model element.
     */
    int getNumberOfDataSources() {
      result = count(int i | query_model_element_data_sources(this, i, _))
    }

    /**
     * Gets the element type name of this query model element, if it exists.
     */
    string getElementTypeName() { query_model_element_element_type_names(this, result) }

    /**
     * Holds if this query model element user update.
     */
    predicate userUpdate() { query_model_element_user_update(this) }
  }

  private Element getImmediateChildOfQueryModelElement(QueryModelElement e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nBehavior, int nDataSourceList,
      int nDataSource
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nBehavior = nUsing + 1 and
      nDataSourceList = nBehavior + e.getNumberOfDataSourceLists() and
      nDataSource = nDataSourceList + e.getNumberOfDataSources() and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getBehavior()
        or
        result = e.getDataSourceList(index - nBehavior)
        or
        result = e.getDataSource(index - nDataSourceList)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class RelationalExpression extends @relational_expression, BinaryExpression {
    /**
     * Gets the operator of this relational expression, if it exists.
     */
    string getOperator() { relational_expression_operators(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ShiftLeftExpression extends @shift_left_expression, BinaryExpression {
    override string toString() { result = "ShiftLeftExpression" }
  }

  private Element getImmediateChildOfShiftLeftExpression(ShiftLeftExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class ShiftRightExpression extends @shift_right_expression, BinaryExpression {
    override string toString() { result = "ShiftRightExpression" }
  }

  private Element getImmediateChildOfShiftRightExpression(ShiftRightExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class StaticQualifier extends @static_qualifier, SimpleQualifier {
    override string toString() { result = "StaticQualifier" }

    /**
     * Gets the `index`th class type argument list of this static qualifier (0-based).
     */
    XppType getClassTypeArgumentList(int index) {
      static_qualifier_class_type_argument_lists(this, index, result)
    }

    /**
     * Gets the number of class type argument lists of this static qualifier.
     */
    int getNumberOfClassTypeArgumentLists() {
      result = count(int i | static_qualifier_class_type_argument_lists(this, i, _))
    }
  }

  private Element getImmediateChildOfStaticQualifier(StaticQualifier e, int index) {
    exists(int n, int nClassTypeArgumentList |
      n = 0 and
      nClassTypeArgumentList = n + e.getNumberOfClassTypeArgumentLists() and
      (
        none()
        or
        result = e.getClassTypeArgumentList(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class StringAttributeLiteral extends @string_attribute_literal, DefaultTypeAttributeLiteral {
    override string toString() { result = "StringAttributeLiteral" }
  }

  private Element getImmediateChildOfStringAttributeLiteral(StringAttributeLiteral e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class StringLengthType extends @string_length_type, StringType {
    override string toString() { result = "StringLengthType" }

    /**
     * Gets the edt name of this string length type, if it exists.
     */
    string getEdtName() { string_length_type_edt_names(this, result) }

    /**
     * Holds if this string length type is edt.
     */
    predicate isEdt() { string_length_type_is_edt(this) }

    /**
     * Gets the length of this string length type, if it exists.
     */
    int getLength() { string_length_type_lengths(this, result) }
  }

  private Element getImmediateChildOfStringLengthType(StringLengthType e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class SubtractExpression extends @subtract_expression, BinaryExpression {
    override string toString() { result = "SubtractExpression" }
  }

  private Element getImmediateChildOfSubtractExpression(SubtractExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class SumAggregateSelection extends @sum_aggregate_selection, AggregateSelection {
    override string toString() { result = "SumAggregateSelection" }
  }

  private Element getImmediateChildOfSumAggregateSelection(SumAggregateSelection e, int index) {
    none()
  }

  /**
   * INTERNAL: Do not use.
   */
  class SuperCall extends @super_call, Evaluation {
    override string toString() { result = "SuperCall" }
  }

  private Element getImmediateChildOfSuperCall(SuperCall e, int index) {
    exists(int n, int nTransformation, int nActualParameter |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Table extends @table, ModelElement {
    override string toString() { result = "Table" }

    /**
     * Gets the attributes of this table, if it exists.
     */
    AttributeList getAttributes() { table_attributes(this, result) }

    /**
     * Gets the element type name of this table, if it exists.
     */
    string getElementTypeName() { table_element_type_names(this, result) }

    /**
     * Gets the extends of this table, if it exists.
     */
    string getExtends() { table_extends(this, result) }

    /**
     * Gets the `index`th field of this table (0-based).
     */
    FieldDeclaration getField(int index) { table_fields(this, index, result) }

    /**
     * Gets the number of fields of this table.
     */
    int getNumberOfFields() { result = count(int i | table_fields(this, i, _)) }

    /**
     * Gets the `index`th index of this table (0-based).
     */
    string getIndex(int index) { table_indexes(this, index, result) }

    /**
     * Gets the number of indexes of this table.
     */
    int getNumberOfIndexes() { result = count(int i | table_indexes(this, i, _)) }

    /**
     * Holds if this table is aggregate data entity.
     */
    predicate isAggregateDataEntity() { table_is_aggregate_data_entity(this) }

    /**
     * Holds if this table is data entity view.
     */
    predicate isDataEntityView() { table_is_data_entity_view(this) }

    /**
     * Holds if this table is map.
     */
    predicate isMap() { table_is_map(this) }

    /**
     * Holds if this table is updatable.
     */
    predicate isUpdatable() { table_is_updatable(this) }

    /**
     * Holds if this table is view.
     */
    predicate isView() { table_is_view(this) }

    /**
     * Holds if this table support inheritance.
     */
    predicate supportInheritance() { table_support_inheritance(this) }
  }

  private Element getImmediateChildOfTable(Table e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nAttributes, int nField
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nAttributes = nUsing + 1 and
      nField = nAttributes + e.getNumberOfFields() and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getAttributes()
        or
        result = e.getField(index - nAttributes)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class TtsAbortStatement extends @tts_abort_statement, TtsStatement {
    override string toString() { result = "TtsAbortStatement" }
  }

  private Element getImmediateChildOfTtsAbortStatement(TtsAbortStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class TtsBeginStatement extends @tts_begin_statement, TtsStatement {
    override string toString() { result = "TtsBeginStatement" }
  }

  private Element getImmediateChildOfTtsBeginStatement(TtsBeginStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class TtsEndStatement extends @tts_end_statement, TtsStatement {
    override string toString() { result = "TtsEndStatement" }
  }

  private Element getImmediateChildOfTtsEndStatement(TtsEndStatement e, int index) { none() }

  /**
   * INTERNAL: Do not use.
   */
  class UnaryMinusExpression extends @unary_minus_expression, UnaryExpression {
    override string toString() { result = "UnaryMinusExpression" }
  }

  private Element getImmediateChildOfUnaryMinusExpression(UnaryMinusExpression e, int index) {
    exists(int n, int nTransformation, int nExpression |
      n = 0 and
      nTransformation = n + 1 and
      nExpression = nTransformation + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignPostDecrementStatement extends @assign_post_decrement_statement, AssignmentSingleField
  {
    override string toString() { result = "AssignPostDecrementStatement" }
  }

  private Element getImmediateChildOfAssignPostDecrementStatement(
    AssignPostDecrementStatement e, int index
  ) {
    exists(int n, int nField |
      n = 0 and
      nField = n + 1 and
      (
        none()
        or
        index = n and result = e.getField()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignPostIncrementStatement extends @assign_post_increment_statement, AssignmentSingleField
  {
    override string toString() { result = "AssignPostIncrementStatement" }
  }

  private Element getImmediateChildOfAssignPostIncrementStatement(
    AssignPostIncrementStatement e, int index
  ) {
    exists(int n, int nField |
      n = 0 and
      nField = n + 1 and
      (
        none()
        or
        index = n and result = e.getField()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignPreDecrementStatement extends @assign_pre_decrement_statement, AssignmentSingleField {
    override string toString() { result = "AssignPreDecrementStatement" }
  }

  private Element getImmediateChildOfAssignPreDecrementStatement(
    AssignPreDecrementStatement e, int index
  ) {
    exists(int n, int nField |
      n = 0 and
      nField = n + 1 and
      (
        none()
        or
        index = n and result = e.getField()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignPreIncrementStatement extends @assign_pre_increment_statement, AssignmentSingleField {
    override string toString() { result = "AssignPreIncrementStatement" }
  }

  private Element getImmediateChildOfAssignPreIncrementStatement(
    AssignPreIncrementStatement e, int index
  ) {
    exists(int n, int nField |
      n = 0 and
      nField = n + 1 and
      (
        none()
        or
        index = n and result = e.getField()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignmentBinary extends @assignment_binary, AssignmentSingleField {
    /**
     * Gets the expression of this assignment binary, if it exists.
     */
    Expression getExpression() { assignment_binary_expressions(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignmentEventHandlerBase extends @assignment_event_handler_base, AssignmentSingleField {
    /**
     * Holds if this assignment event handler base addition.
     */
    predicate addition() { assignment_event_handler_base_addition(this) }

    /**
     * Gets the name of this assignment event handler base, if it exists.
     */
    string getName() { assignment_event_handler_base_names(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class BooleanLiteralExpression extends @boolean_literal_expression, DefaultTypeLiteralExpression {
    override string toString() { result = "BooleanLiteralExpression" }
  }

  private Element getImmediateChildOfBooleanLiteralExpression(BooleanLiteralExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Class extends @class, ClassOrInterface {
    override string toString() { result = "Class" }

    /**
     * Gets the `index`th field of this class (0-based).
     */
    FieldDeclaration getField(int index) { class_fields(this, index, result) }

    /**
     * Gets the number of fields of this class.
     */
    int getNumberOfFields() { result = count(int i | class_fields(this, i, _)) }

    /**
     * Holds if this class has cyclic inheritance.
     */
    predicate hasCyclicInheritance() { class_has_cyclic_inheritance(this) }

    /**
     * Gets the `index`th implement of this class (0-based).
     */
    string getImplement(int index) { class_implements(this, index, result) }

    /**
     * Gets the number of implements of this class.
     */
    int getNumberOfImplements() { result = count(int i | class_implements(this, i, _)) }
  }

  private Element getImmediateChildOfClass(Class e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nAttributes, int nEnclosingType,
      int nField
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nAttributes = nUsing + 1 and
      nEnclosingType = nAttributes + 1 and
      nField = nEnclosingType + e.getNumberOfFields() and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getAttributes()
        or
        index = nAttributes and result = e.getEnclosingType()
        or
        result = e.getField(index - nEnclosingType)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class DateLiteralExpression extends @date_literal_expression, DefaultTypeLiteralExpression {
    override string toString() { result = "DateLiteralExpression" }
  }

  private Element getImmediateChildOfDateLiteralExpression(DateLiteralExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class DateTimeLiteralExpression extends @date_time_literal_expression,
    DefaultTypeLiteralExpression
  {
    override string toString() { result = "DateTimeLiteralExpression" }
  }

  private Element getImmediateChildOfDateTimeLiteralExpression(
    DateTimeLiteralExpression e, int index
  ) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class EqualExpression extends @equal_expression, RelationalExpression {
    override string toString() { result = "EqualExpression" }
  }

  private Element getImmediateChildOfEqualExpression(EqualExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FormControl extends @form_control, FormNestedElement {
    override string toString() { result = "FormControl" }

    /**
     * Holds if this form control auto declaration.
     */
    predicate autoDeclaration() { form_control_auto_declaration(this) }

    /**
     * Gets the `index`th child control of this form control (0-based).
     */
    FormControl getChildControl(int index) { form_control_child_controls(this, index, result) }

    /**
     * Gets the number of child controls of this form control.
     */
    int getNumberOfChildControls() {
      result = count(int i | form_control_child_controls(this, i, _))
    }

    /**
     * Gets the control class of this form control, if it exists.
     */
    string getControlClass() { form_control_control_classes(this, result) }

    /**
     * Gets the control type of this form control, if it exists.
     */
    string getControlType() { form_control_control_types(this, result) }

    /**
     * Gets the custom control class of this form control, if it exists.
     */
    string getCustomControlClass() { form_control_custom_control_classes(this, result) }

    /**
     * Gets the element type name of this form control, if it exists.
     */
    string getElementTypeName() { form_control_element_type_names(this, result) }

    /**
     * Gets the internal control name of this form control, if it exists.
     */
    string getInternalControlName() { form_control_internal_control_names(this, result) }

    /**
     * Holds if this form control is form control extension.
     */
    predicate isFormControlExtension() { form_control_is_form_control_extension(this) }

    /**
     * Gets the parent control of this form control, if it exists.
     */
    FormControl getParentControl() { form_control_parent_controls(this, result) }
  }

  private Element getImmediateChildOfFormControl(FormControl e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nForm, int nChildControl,
      int nParentControl
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nForm = nUsing + 1 and
      nChildControl = nForm + e.getNumberOfChildControls() and
      nParentControl = nChildControl + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getForm()
        or
        result = e.getChildControl(index - nForm)
        or
        index = nChildControl and result = e.getParentControl()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FormDataField extends @form_data_field, FormNestedElement {
    override string toString() { result = "FormDataField" }

    /**
     * Gets the element type name of this form data field, if it exists.
     */
    string getElementTypeName() { form_data_field_element_type_names(this, result) }

    /**
     * Gets the form data source of this form data field, if it exists.
     */
    FormDataSource getFormDataSource() { form_data_field_form_data_sources(this, result) }
  }

  private Element getImmediateChildOfFormDataField(FormDataField e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nForm, int nFormDataSource
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nForm = nUsing + 1 and
      nFormDataSource = nForm + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getForm()
        or
        index = nForm and result = e.getFormDataSource()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FormDataSource extends @form_data_source, FormNestedElement {
    override string toString() { result = "FormDataSource" }

    /**
     * Gets the `index`th data field of this form data source (0-based).
     */
    FormDataField getDataField(int index) { form_data_source_data_fields(this, index, result) }

    /**
     * Gets the number of data fields of this form data source.
     */
    int getNumberOfDataFields() { result = count(int i | form_data_source_data_fields(this, i, _)) }

    /**
     * Gets the element type name of this form data source, if it exists.
     */
    string getElementTypeName() { form_data_source_element_type_names(this, result) }

    /**
     * Gets the join source of this form data source, if it exists.
     */
    string getJoinSource() { form_data_source_join_sources(this, result) }

    /**
     * Gets the link type of this form data source, if it exists.
     */
    string getLinkType() { form_data_source_link_types(this, result) }

    /**
     * Holds if this form data source nested data source.
     */
    predicate nestedDataSource() { form_data_source_nested_data_source(this) }

    /**
     * Gets the query of this form data source, if it exists.
     */
    QueryModelElement getQuery() { form_data_source_queries(this, result) }

    /**
     * Gets the query name of this form data source, if it exists.
     */
    string getQueryName() { form_data_source_query_names(this, result) }

    /**
     * Gets the table of this form data source, if it exists.
     */
    string getTable() { form_data_source_tables(this, result) }
  }

  private Element getImmediateChildOfFormDataSource(FormDataSource e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nForm, int nDataField, int nQuery
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nForm = nUsing + 1 and
      nDataField = nForm + e.getNumberOfDataFields() and
      nQuery = nDataField + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getForm()
        or
        result = e.getDataField(index - nForm)
        or
        index = nDataField and result = e.getQuery()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FormElementType extends @form_element_type, NamedType {
    override string toString() { result = "FormElementType" }

    /**
     * Gets the form name of this form element type, if it exists.
     */
    string getFormName() { form_element_type_form_names(this, result) }
  }

  private Element getImmediateChildOfFormElementType(FormElementType e, int index) {
    exists(int n, int nTypeArgumentList |
      n = 0 and
      nTypeArgumentList = n + e.getNumberOfTypeArgumentLists() and
      (
        none()
        or
        result = e.getTypeArgumentList(index - n)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FunctionCall extends @function_call, GenericEvaluation {
    override string toString() { result = "FunctionCall" }

    /**
     * Gets the function name of this function call, if it exists.
     */
    string getFunctionName() { function_call_function_names(this, result) }
  }

  private Element getImmediateChildOfFunctionCall(FunctionCall e, int index) {
    exists(int n, int nTransformation, int nActualParameter, int nTypeArgumentList |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      nTypeArgumentList = nActualParameter + e.getNumberOfTypeArgumentLists() and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
        or
        result = e.getTypeArgumentList(index - nActualParameter)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class FunctionDeclaration extends @function_declaration, LocalDeclaration {
    override string toString() { result = "FunctionDeclaration" }

    /**
     * Gets the `index`th declarations and statement of this function declaration (0-based).
     */
    Statement getDeclarationsAndStatement(int index) {
      function_declaration_declarations_and_statements(this, index, result)
    }

    /**
     * Gets the number of declarations and statements of this function declaration.
     */
    int getNumberOfDeclarationsAndStatements() {
      result = count(int i | function_declaration_declarations_and_statements(this, i, _))
    }

    /**
     * Gets the element type name of this function declaration, if it exists.
     */
    string getElementTypeName() { function_declaration_element_type_names(this, result) }

    /**
     * Gets the `index`th local of this function declaration (0-based).
     */
    LocalDeclaration getLocal(int index) { function_declaration_locals(this, index, result) }

    /**
     * Gets the number of locals of this function declaration.
     */
    int getNumberOfLocals() { result = count(int i | function_declaration_locals(this, i, _)) }

    /**
     * Gets the `index`th parameter of this function declaration (0-based).
     */
    ParameterDeclaration getParameter(int index) {
      function_declaration_parameters(this, index, result)
    }

    /**
     * Gets the number of parameters of this function declaration.
     */
    int getNumberOfParameters() {
      result = count(int i | function_declaration_parameters(this, i, _))
    }

    /**
     * Gets the `index`th statement of this function declaration (0-based).
     */
    Statement getStatement(int index) { function_declaration_statements(this, index, result) }

    /**
     * Gets the number of statements of this function declaration.
     */
    int getNumberOfStatements() {
      result = count(int i | function_declaration_statements(this, i, _))
    }
  }

  private Element getImmediateChildOfFunctionDeclaration(FunctionDeclaration e, int index) {
    exists(
      int n, int nComments, int nRegion, int nArraySpecification, int nModifierList, int nType,
      int nDeclarationsAndStatement, int nLocal, int nParameter, int nStatement
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nArraySpecification = nRegion + 1 and
      nModifierList = nArraySpecification + e.getNumberOfModifierLists() and
      nType = nModifierList + 1 and
      nDeclarationsAndStatement = nType + e.getNumberOfDeclarationsAndStatements() and
      nLocal = nDeclarationsAndStatement + e.getNumberOfLocals() and
      nParameter = nLocal + e.getNumberOfParameters() and
      nStatement = nParameter + e.getNumberOfStatements() and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        index = nRegion and result = e.getArraySpecification()
        or
        result = e.getModifierList(index - nArraySpecification)
        or
        index = nModifierList and result = e.getType()
        or
        result = e.getDeclarationsAndStatement(index - nType)
        or
        result = e.getLocal(index - nDeclarationsAndStatement)
        or
        result = e.getParameter(index - nLocal)
        or
        result = e.getStatement(index - nParameter)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class GreaterThanExpression extends @greater_than_expression, RelationalExpression {
    override string toString() { result = "GreaterThanExpression" }
  }

  private Element getImmediateChildOfGreaterThanExpression(GreaterThanExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class GreaterThanOrEqualExpression extends @greater_than_or_equal_expression, RelationalExpression
  {
    override string toString() { result = "GreaterThanOrEqualExpression" }
  }

  private Element getImmediateChildOfGreaterThanOrEqualExpression(
    GreaterThanOrEqualExpression e, int index
  ) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Int64LiteralExpression extends @int64_literal_expression, DefaultTypeLiteralExpression {
    override string toString() { result = "Int64LiteralExpression" }
  }

  private Element getImmediateChildOfInt64LiteralExpression(Int64LiteralExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class IntLiteralExpression extends @int_literal_expression, DefaultTypeLiteralExpression {
    override string toString() { result = "IntLiteralExpression" }
  }

  private Element getImmediateChildOfIntLiteralExpression(IntLiteralExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class Interface extends @interface, ClassOrInterface {
    override string toString() { result = "Interface" }
  }

  private Element getImmediateChildOfInterface(Interface e, int index) {
    exists(
      int n, int nComments, int nRegion, int nBaseMethod, int nExtendGenericParameter, int nMethod,
      int nModifierList, int nNestedClass, int nUsing, int nAttributes, int nEnclosingType
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nBaseMethod = nRegion + e.getNumberOfBaseMethods() and
      nExtendGenericParameter = nBaseMethod + e.getNumberOfExtendGenericParameters() and
      nMethod = nExtendGenericParameter + e.getNumberOfMethods() and
      nModifierList = nMethod + e.getNumberOfModifierLists() and
      nNestedClass = nModifierList + e.getNumberOfNestedClasses() and
      nUsing = nNestedClass + e.getNumberOfUsings() and
      nAttributes = nUsing + 1 and
      nEnclosingType = nAttributes + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        result = e.getBaseMethod(index - nRegion)
        or
        result = e.getExtendGenericParameter(index - nBaseMethod)
        or
        result = e.getMethod(index - nExtendGenericParameter)
        or
        result = e.getModifierList(index - nMethod)
        or
        result = e.getNestedClass(index - nModifierList)
        or
        result = e.getUsing(index - nNestedClass)
        or
        index = nUsing and result = e.getAttributes()
        or
        index = nAttributes and result = e.getEnclosingType()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class LessThanExpression extends @less_than_expression, RelationalExpression {
    override string toString() { result = "LessThanExpression" }
  }

  private Element getImmediateChildOfLessThanExpression(LessThanExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class LessThanOrEqualExpression extends @less_than_or_equal_expression, RelationalExpression {
    override string toString() { result = "LessThanOrEqualExpression" }
  }

  private Element getImmediateChildOfLessThanOrEqualExpression(
    LessThanOrEqualExpression e, int index
  ) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class LikeExpression extends @like_expression, RelationalExpression {
    override string toString() { result = "LikeExpression" }
  }

  private Element getImmediateChildOfLikeExpression(LikeExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NewClrCall extends @new_clr_call, GenericEvaluation {
    override string toString() { result = "NewClrCall" }

    /**
     * Gets the clr class name of this new clr call, if it exists.
     */
    string getClrClassName() { new_clr_call_clr_class_names(this, result) }
  }

  private Element getImmediateChildOfNewClrCall(NewClrCall e, int index) {
    exists(int n, int nTransformation, int nActualParameter, int nTypeArgumentList |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      nTypeArgumentList = nActualParameter + e.getNumberOfTypeArgumentLists() and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
        or
        result = e.getTypeArgumentList(index - nActualParameter)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class NotEqualExpression extends @not_equal_expression, RelationalExpression {
    override string toString() { result = "NotEqualExpression" }
  }

  private Element getImmediateChildOfNotEqualExpression(NotEqualExpression e, int index) {
    exists(int n, int nTransformation, int nLeft, int nRight |
      n = 0 and
      nTransformation = n + 1 and
      nLeft = nTransformation + 1 and
      nRight = nLeft + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        index = nTransformation and result = e.getLeft()
        or
        index = nLeft and result = e.getRight()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QualifiedCall extends @qualified_call, GenericEvaluation {
    override string toString() { result = "QualifiedCall" }

    /**
     * Gets the method name of this qualified call, if it exists.
     */
    string getMethodName() { qualified_call_method_names(this, result) }

    /**
     * Gets the qualifier of this qualified call, if it exists.
     */
    Qualifier getQualifier() { qualified_call_qualifiers(this, result) }
  }

  private Element getImmediateChildOfQualifiedCall(QualifiedCall e, int index) {
    exists(int n, int nTransformation, int nActualParameter, int nTypeArgumentList, int nQualifier |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      nTypeArgumentList = nActualParameter + e.getNumberOfTypeArgumentLists() and
      nQualifier = nTypeArgumentList + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
        or
        result = e.getTypeArgumentList(index - nActualParameter)
        or
        index = nTypeArgumentList and result = e.getQualifier()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class QualifiedStaticCall extends @qualified_static_call, GenericEvaluation {
    override string toString() { result = "QualifiedStaticCall" }

    /**
     * Gets the class name of this qualified static call, if it exists.
     */
    string getClassName() { qualified_static_call_class_names(this, result) }

    /**
     * Gets the `index`th class type argument list of this qualified static call (0-based).
     */
    XppType getClassTypeArgumentList(int index) {
      qualified_static_call_class_type_argument_lists(this, index, result)
    }

    /**
     * Gets the number of class type argument lists of this qualified static call.
     */
    int getNumberOfClassTypeArgumentLists() {
      result = count(int i | qualified_static_call_class_type_argument_lists(this, i, _))
    }

    /**
     * Holds if this qualified static call is table map call.
     */
    predicate isTableMapCall() { qualified_static_call_is_table_map_call(this) }

    /**
     * Gets the method name of this qualified static call, if it exists.
     */
    string getMethodName() { qualified_static_call_method_names(this, result) }

    /**
     * Gets the qualifier of this qualified static call, if it exists.
     */
    Qualifier getQualifier() { qualified_static_call_qualifiers(this, result) }
  }

  private Element getImmediateChildOfQualifiedStaticCall(QualifiedStaticCall e, int index) {
    exists(
      int n, int nTransformation, int nActualParameter, int nTypeArgumentList,
      int nClassTypeArgumentList, int nQualifier
    |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      nTypeArgumentList = nActualParameter + e.getNumberOfTypeArgumentLists() and
      nClassTypeArgumentList = nTypeArgumentList + e.getNumberOfClassTypeArgumentLists() and
      nQualifier = nClassTypeArgumentList + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
        or
        result = e.getTypeArgumentList(index - nActualParameter)
        or
        result = e.getClassTypeArgumentList(index - nTypeArgumentList)
        or
        index = nClassTypeArgumentList and result = e.getQualifier()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class RealLiteralExpression extends @real_literal_expression, DefaultTypeLiteralExpression {
    override string toString() { result = "RealLiteralExpression" }
  }

  private Element getImmediateChildOfRealLiteralExpression(RealLiteralExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class StaticMethodCall extends @static_method_call, GenericEvaluation {
    override string toString() { result = "StaticMethodCall" }

    /**
     * Gets the class name of this static method call, if it exists.
     */
    string getClassName() { static_method_call_class_names(this, result) }

    /**
     * Gets the `index`th class type argument list of this static method call (0-based).
     */
    XppType getClassTypeArgumentList(int index) {
      static_method_call_class_type_argument_lists(this, index, result)
    }

    /**
     * Gets the number of class type argument lists of this static method call.
     */
    int getNumberOfClassTypeArgumentLists() {
      result = count(int i | static_method_call_class_type_argument_lists(this, i, _))
    }

    /**
     * Gets the method name of this static method call, if it exists.
     */
    string getMethodName() { static_method_call_method_names(this, result) }
  }

  private Element getImmediateChildOfStaticMethodCall(StaticMethodCall e, int index) {
    exists(
      int n, int nTransformation, int nActualParameter, int nTypeArgumentList,
      int nClassTypeArgumentList
    |
      n = 0 and
      nTransformation = n + 1 and
      nActualParameter = nTransformation + e.getNumberOfActualParameters() and
      nTypeArgumentList = nActualParameter + e.getNumberOfTypeArgumentLists() and
      nClassTypeArgumentList = nTypeArgumentList + e.getNumberOfClassTypeArgumentLists() and
      (
        none()
        or
        index = n and result = e.getTransformation()
        or
        result = e.getActualParameter(index - nTransformation)
        or
        result = e.getTypeArgumentList(index - nActualParameter)
        or
        result = e.getClassTypeArgumentList(index - nTypeArgumentList)
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class StringLiteralExpression extends @string_literal_expression, DefaultTypeLiteralExpression {
    override string toString() { result = "StringLiteralExpression" }

    /**
     * Holds if this string literal expression is label.
     */
    predicate isLabel() { string_literal_expression_is_label(this) }

    /**
     * Gets the label file of this string literal expression, if it exists.
     */
    string getLabelFileId() { string_literal_expression_label_file_ids(this, result) }

    /**
     * Gets the label of this string literal expression, if it exists.
     */
    string getLabelId() { string_literal_expression_label_ids(this, result) }
  }

  private Element getImmediateChildOfStringLiteralExpression(StringLiteralExpression e, int index) {
    exists(int n, int nTransformation |
      n = 0 and
      nTransformation = n + 1 and
      (
        none()
        or
        index = n and result = e.getTransformation()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class TableFieldDeclaration extends @table_field_declaration, FieldDeclaration {
    override string toString() { result = "TableFieldDeclaration" }
  }

  private Element getImmediateChildOfTableFieldDeclaration(TableFieldDeclaration e, int index) {
    exists(
      int n, int nComments, int nRegion, int nArraySpecification, int nModifierList, int nType,
      int nAttributes, int nInitialValue
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nArraySpecification = nRegion + 1 and
      nModifierList = nArraySpecification + e.getNumberOfModifierLists() and
      nType = nModifierList + 1 and
      nAttributes = nType + 1 and
      nInitialValue = nAttributes + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        index = nRegion and result = e.getArraySpecification()
        or
        result = e.getModifierList(index - nArraySpecification)
        or
        index = nModifierList and result = e.getType()
        or
        index = nType and result = e.getAttributes()
        or
        index = nAttributes and result = e.getInitialValue()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class VariableDeclaration extends @variable_declaration, LocalDeclaration {
    /**
     * Gets the element type name of this variable declaration, if it exists.
     */
    string getElementTypeName() { variable_declaration_element_type_names(this, result) }

    /**
     * Gets the initial value of this variable declaration, if it exists.
     */
    Expression getInitialValue() { variable_declaration_initial_values(this, result) }

    /**
     * Holds if this variable declaration is const.
     */
    predicate isConst() { variable_declaration_is_const(this) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignDecrementStatement extends @assign_decrement_statement, AssignmentBinary {
    override string toString() { result = "AssignDecrementStatement" }
  }

  private Element getImmediateChildOfAssignDecrementStatement(AssignDecrementStatement e, int index) {
    exists(int n, int nField, int nExpression |
      n = 0 and
      nField = n + 1 and
      nExpression = nField + 1 and
      (
        none()
        or
        index = n and result = e.getField()
        or
        index = nField and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignDivideStatement extends @assign_divide_statement, AssignmentBinary {
    override string toString() { result = "AssignDivideStatement" }
  }

  private Element getImmediateChildOfAssignDivideStatement(AssignDivideStatement e, int index) {
    exists(int n, int nField, int nExpression |
      n = 0 and
      nField = n + 1 and
      nExpression = nField + 1 and
      (
        none()
        or
        index = n and result = e.getField()
        or
        index = nField and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignEqualStatement extends @assign_equal_statement, AssignmentBinary {
    override string toString() { result = "AssignEqualStatement" }
  }

  private Element getImmediateChildOfAssignEqualStatement(AssignEqualStatement e, int index) {
    exists(int n, int nField, int nExpression |
      n = 0 and
      nField = n + 1 and
      nExpression = nField + 1 and
      (
        none()
        or
        index = n and result = e.getField()
        or
        index = nField and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignIncrementStatement extends @assign_increment_statement, AssignmentBinary {
    override string toString() { result = "AssignIncrementStatement" }
  }

  private Element getImmediateChildOfAssignIncrementStatement(AssignIncrementStatement e, int index) {
    exists(int n, int nField, int nExpression |
      n = 0 and
      nField = n + 1 and
      nExpression = nField + 1 and
      (
        none()
        or
        index = n and result = e.getField()
        or
        index = nField and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignMultiplyStatement extends @assign_multiply_statement, AssignmentBinary {
    override string toString() { result = "AssignMultiplyStatement" }
  }

  private Element getImmediateChildOfAssignMultiplyStatement(AssignMultiplyStatement e, int index) {
    exists(int n, int nField, int nExpression |
      n = 0 and
      nField = n + 1 and
      nExpression = nField + 1 and
      (
        none()
        or
        index = n and result = e.getField()
        or
        index = nField and result = e.getExpression()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignmentEventHandlerInstance extends @assignment_event_handler_instance,
    AssignmentEventHandlerBase
  {
    override string toString() { result = "AssignmentEventHandlerInstance" }

    /**
     * Gets the qualifier part of this assignment event handler instance, if it exists.
     */
    Qualifier getQualifierPart() { assignment_event_handler_instance_qualifier_parts(this, result) }
  }

  private Element getImmediateChildOfAssignmentEventHandlerInstance(
    AssignmentEventHandlerInstance e, int index
  ) {
    exists(int n, int nField, int nQualifierPart |
      n = 0 and
      nField = n + 1 and
      nQualifierPart = nField + 1 and
      (
        none()
        or
        index = n and result = e.getField()
        or
        index = nField and result = e.getQualifierPart()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignmentEventHandlerStatic extends @assignment_event_handler_static,
    AssignmentEventHandlerBase
  {
    /**
     * Gets the type name of this assignment event handler static, if it exists.
     */
    string getTypeName() { assignment_event_handler_static_type_names(this, result) }
  }

  /**
   * INTERNAL: Do not use.
   */
  class ParameterDeclaration extends @parameter_declaration, VariableDeclaration {
    override string toString() { result = "ParameterDeclaration" }

    /**
     * Holds if this parameter declaration is by reference.
     */
    predicate isByRef() { parameter_declaration_is_by_ref(this) }

    /**
     * Holds if this parameter declaration is optional.
     */
    predicate isOptional() { parameter_declaration_is_optional(this) }
  }

  private Element getImmediateChildOfParameterDeclaration(ParameterDeclaration e, int index) {
    exists(
      int n, int nComments, int nRegion, int nArraySpecification, int nModifierList, int nType,
      int nInitialValue
    |
      n = 0 and
      nComments = n + 1 and
      nRegion = nComments + e.getNumberOfRegions() and
      nArraySpecification = nRegion + 1 and
      nModifierList = nArraySpecification + e.getNumberOfModifierLists() and
      nType = nModifierList + 1 and
      nInitialValue = nType + 1 and
      (
        none()
        or
        index = n and result = e.getComments()
        or
        result = e.getRegion(index - nComments)
        or
        index = nRegion and result = e.getArraySpecification()
        or
        result = e.getModifierList(index - nArraySpecification)
        or
        index = nModifierList and result = e.getType()
        or
        index = nType and result = e.getInitialValue()
      )
    )
  }

  /**
   * INTERNAL: Do not use.
   */
  class AssignmentEventHandlerClr extends @assignment_event_handler_clr,
    AssignmentEventHandlerStatic
  {
    override string toString() { result = "AssignmentEventHandlerClr" }
  }

  private Element getImmediateChildOfAssignmentEventHandlerClr(
    AssignmentEventHandlerClr e, int index
  ) {
    exists(int n, int nField |
      n = 0 and
      nField = n + 1 and
      (
        none()
        or
        index = n and result = e.getField()
      )
    )
  }

  /**
   * Gets the immediate child indexed at `index`. Indexes are not guaranteed to be contiguous, but are guaranteed to be distinct.
   */
  pragma[nomagic]
  Element getImmediateChild(Element e, int index) {
    // why does this look more complicated than it should?
    // * none() simplifies generation, as we can append `or ...` without a special case for the first item
    none()
    or
    result = getImmediateChildOfFile(e, index)
    or
    result = getImmediateChildOfLocation(e, index)
    or
    result = getImmediateChildOfComment(e, index)
    or
    result = getImmediateChildOfArraySpecification(e, index)
    or
    result = getImmediateChildOfAttribute(e, index)
    or
    result = getImmediateChildOfAttributeExpression(e, index)
    or
    result = getImmediateChildOfAttributeList(e, index)
    or
    result = getImmediateChildOfAttributeNamedParameterEntry(e, index)
    or
    result = getImmediateChildOfClassAccessModifier(e, index)
    or
    result = getImmediateChildOfCompilationUnitRegionEntry(e, index)
    or
    result = getImmediateChildOfEvaluationActualParameterEntry(e, index)
    or
    result = getImmediateChildOfFieldAssignment(e, index)
    or
    result = getImmediateChildOfInsertFieldSpecification(e, index)
    or
    result = getImmediateChildOfJoinSpecification(e, index)
    or
    result = getImmediateChildOfModelElementUsingEntry(e, index)
    or
    result = getImmediateChildOfModifier(e, index)
    or
    result = getImmediateChildOfQuery(e, index)
    or
    result = getImmediateChildOfQueryDataSource(e, index)
    or
    result = getImmediateChildOfQueryDataSourceHaving(e, index)
    or
    result = getImmediateChildOfQueryDataSourceRange(e, index)
    or
    result = getImmediateChildOfQueryDataSourceRelation(e, index)
    or
    result = getImmediateChildOfSwitchCase(e, index)
    or
    result = getImmediateChildOfSwitchStatementCaseEntry(e, index)
    or
    result = getImmediateChildOfTryStatementCatchEntry(e, index)
    or
    result = getImmediateChildOfUnspecifiedElement(e, index)
    or
    result = getImmediateChildOfAllFieldsSelection(e, index)
    or
    result = getImmediateChildOfAnyType(e, index)
    or
    result = getImmediateChildOfBooleanType(e, index)
    or
    result = getImmediateChildOfBreakStatement(e, index)
    or
    result = getImmediateChildOfBreakpointStatement(e, index)
    or
    result = getImmediateChildOfCaseDefault(e, index)
    or
    result = getImmediateChildOfCaseValues(e, index)
    or
    result = getImmediateChildOfCatchAllValues(e, index)
    or
    result = getImmediateChildOfCatchExpression(e, index)
    or
    result = getImmediateChildOfCatchUpdateConflict(e, index)
    or
    result = getImmediateChildOfCompoundStatement(e, index)
    or
    result = getImmediateChildOfConditionalExpression(e, index)
    or
    result = getImmediateChildOfContainerAttributeLiteral(e, index)
    or
    result = getImmediateChildOfContainerType(e, index)
    or
    result = getImmediateChildOfContinueStatement(e, index)
    or
    result = getImmediateChildOfCrossCompanyAll(e, index)
    or
    result = getImmediateChildOfCrossCompanyContainer(e, index)
    or
    result = getImmediateChildOfDateTimeType(e, index)
    or
    result = getImmediateChildOfDateType(e, index)
    or
    result = getImmediateChildOfDblType(e, index)
    or
    result = getImmediateChildOfDeleteStatement(e, index)
    or
    result = getImmediateChildOfDoWhileStatement(e, index)
    or
    result = getImmediateChildOfEmptyExpression(e, index)
    or
    result = getImmediateChildOfEmptyStatement(e, index)
    or
    result = getImmediateChildOfEnumAttributeLiteral(e, index)
    or
    result = getImmediateChildOfEnumerationType(e, index)
    or
    result = getImmediateChildOfExplicitSelection(e, index)
    or
    result = getImmediateChildOfExpressionCompilationUnit(e, index)
    or
    result = getImmediateChildOfExpressionQualifier(e, index)
    or
    result = getImmediateChildOfExpressionStatement(e, index)
    or
    result = getImmediateChildOfFieldSelection(e, index)
    or
    result = getImmediateChildOfFindStatement(e, index)
    or
    result = getImmediateChildOfFlushStatement(e, index)
    or
    result = getImmediateChildOfForDeclarationAssign(e, index)
    or
    result = getImmediateChildOfForFieldPostDecrement(e, index)
    or
    result = getImmediateChildOfForFieldPostIncrement(e, index)
    or
    result = getImmediateChildOfForFieldPreDecrement(e, index)
    or
    result = getImmediateChildOfForFieldPreIncrement(e, index)
    or
    result = getImmediateChildOfForStatement(e, index)
    or
    result = getImmediateChildOfGlobalOrderElement(e, index)
    or
    result = getImmediateChildOfGuidType(e, index)
    or
    result = getImmediateChildOfIfStatement(e, index)
    or
    result = getImmediateChildOfIfThenElseStatement(e, index)
    or
    result = getImmediateChildOfImplicitSelection(e, index)
    or
    result = getImmediateChildOfInsertStatement(e, index)
    or
    result = getImmediateChildOfInt64Type(e, index)
    or
    result = getImmediateChildOfIntType(e, index)
    or
    result = getImmediateChildOfIntrinsic(e, index)
    or
    result = getImmediateChildOfIntrinsicAttributeLiteral(e, index)
    or
    result = getImmediateChildOfLocalDeclarationsStatement(e, index)
    or
    result = getImmediateChildOfMoveCursorStatement(e, index)
    or
    result = getImmediateChildOfNamedFieldReference(e, index)
    or
    result = getImmediateChildOfNewClrArrayExpression(e, index)
    or
    result = getImmediateChildOfNumberedFieldReference(e, index)
    or
    result = getImmediateChildOfPlaceholder(e, index)
    or
    result = getImmediateChildOfPrintStatement(e, index)
    or
    result = getImmediateChildOfProvidedType(e, index)
    or
    result = getImmediateChildOfQualifiedField(e, index)
    or
    result = getImmediateChildOfQualifiedInstanceName(e, index)
    or
    result = getImmediateChildOfQualifiedNumberedField(e, index)
    or
    result = getImmediateChildOfQualifiedStaticField(e, index)
    or
    result = getImmediateChildOfRetryStatement(e, index)
    or
    result = getImmediateChildOfReturnStatement(e, index)
    or
    result = getImmediateChildOfSearchStatement(e, index)
    or
    result = getImmediateChildOfSimpleField(e, index)
    or
    result = getImmediateChildOfSimpleInstanceName(e, index)
    or
    result = getImmediateChildOfSimpleOrderElement(e, index)
    or
    result = getImmediateChildOfStaticField(e, index)
    or
    result = getImmediateChildOfSwitchStatement(e, index)
    or
    result = getImmediateChildOfTableLookupExpression(e, index)
    or
    result = getImmediateChildOfThrowStatement(e, index)
    or
    result = getImmediateChildOfTryStatement(e, index)
    or
    result = getImmediateChildOfUncheckedStatement(e, index)
    or
    result = getImmediateChildOfUpdateStatement(e, index)
    or
    result = getImmediateChildOfUsingStatement(e, index)
    or
    result = getImmediateChildOfValidTimeStateDate(e, index)
    or
    result = getImmediateChildOfValidTimeStateRange(e, index)
    or
    result = getImmediateChildOfVarType(e, index)
    or
    result = getImmediateChildOfVoidType(e, index)
    or
    result = getImmediateChildOfWhileStatement(e, index)
    or
    result = getImmediateChildOfXppTypeCompilationUnit(e, index)
    or
    result = getImmediateChildOfAddExpression(e, index)
    or
    result = getImmediateChildOfAndExpression(e, index)
    or
    result = getImmediateChildOfAsClrExpression(e, index)
    or
    result = getImmediateChildOfAsExpression(e, index)
    or
    result = getImmediateChildOfAssignMultipleFieldStatement(e, index)
    or
    result = getImmediateChildOfAvgAggregateSelection(e, index)
    or
    result = getImmediateChildOfBooleanAttributeLiteral(e, index)
    or
    result = getImmediateChildOfChangeCompanyStatement(e, index)
    or
    result = getImmediateChildOfClrEnumerationLiteralExpression(e, index)
    or
    result = getImmediateChildOfClrType(e, index)
    or
    result = getImmediateChildOfContainerLiteralExpression(e, index)
    or
    result = getImmediateChildOfCountAggregateSelection(e, index)
    or
    result = getImmediateChildOfDateAttributeLiteral(e, index)
    or
    result = getImmediateChildOfDateTimeAttributeLiteral(e, index)
    or
    result = getImmediateChildOfDblAttributeLiteral(e, index)
    or
    result = getImmediateChildOfDelegate(e, index)
    or
    result = getImmediateChildOfDivideExpression(e, index)
    or
    result = getImmediateChildOfEnumerationLiteralExpression(e, index)
    or
    result = getImmediateChildOfForFieldAssign(e, index)
    or
    result = getImmediateChildOfForFieldDecrementAssign(e, index)
    or
    result = getImmediateChildOfForFieldIncrementAssign(e, index)
    or
    result = getImmediateChildOfFormModelElement(e, index)
    or
    result = getImmediateChildOfGuidAttributeLiteral(e, index)
    or
    result = getImmediateChildOfInExpression(e, index)
    or
    result = getImmediateChildOfInt64AttributeLiteral(e, index)
    or
    result = getImmediateChildOfIntAttributeLiteral(e, index)
    or
    result = getImmediateChildOfIntegerDivideExpression(e, index)
    or
    result = getImmediateChildOfIsClrExpression(e, index)
    or
    result = getImmediateChildOfIsExpression(e, index)
    or
    result = getImmediateChildOfMaxAggregateSelection(e, index)
    or
    result = getImmediateChildOfMethod(e, index)
    or
    result = getImmediateChildOfMinAggregateSelection(e, index)
    or
    result = getImmediateChildOfModExpression(e, index)
    or
    result = getImmediateChildOfMultiplyExpression(e, index)
    or
    result = getImmediateChildOfNewCall(e, index)
    or
    result = getImmediateChildOfNextExpression(e, index)
    or
    result = getImmediateChildOfNotExpression(e, index)
    or
    result = getImmediateChildOfNullLiteralExpression(e, index)
    or
    result = getImmediateChildOfOrExpression(e, index)
    or
    result = getImmediateChildOfPhysicalAndExpression(e, index)
    or
    result = getImmediateChildOfPhysicalNotExpression(e, index)
    or
    result = getImmediateChildOfPhysicalOrExpression(e, index)
    or
    result = getImmediateChildOfPhysicalXorExpression(e, index)
    or
    result = getImmediateChildOfProvidedTypeStaticCall(e, index)
    or
    result = getImmediateChildOfQualifiedStaticFieldExpression(e, index)
    or
    result = getImmediateChildOfQueryModelElement(e, index)
    or
    result = getImmediateChildOfShiftLeftExpression(e, index)
    or
    result = getImmediateChildOfShiftRightExpression(e, index)
    or
    result = getImmediateChildOfStaticQualifier(e, index)
    or
    result = getImmediateChildOfStringAttributeLiteral(e, index)
    or
    result = getImmediateChildOfStringLengthType(e, index)
    or
    result = getImmediateChildOfSubtractExpression(e, index)
    or
    result = getImmediateChildOfSumAggregateSelection(e, index)
    or
    result = getImmediateChildOfSuperCall(e, index)
    or
    result = getImmediateChildOfTable(e, index)
    or
    result = getImmediateChildOfTtsAbortStatement(e, index)
    or
    result = getImmediateChildOfTtsBeginStatement(e, index)
    or
    result = getImmediateChildOfTtsEndStatement(e, index)
    or
    result = getImmediateChildOfUnaryMinusExpression(e, index)
    or
    result = getImmediateChildOfAssignPostDecrementStatement(e, index)
    or
    result = getImmediateChildOfAssignPostIncrementStatement(e, index)
    or
    result = getImmediateChildOfAssignPreDecrementStatement(e, index)
    or
    result = getImmediateChildOfAssignPreIncrementStatement(e, index)
    or
    result = getImmediateChildOfBooleanLiteralExpression(e, index)
    or
    result = getImmediateChildOfClass(e, index)
    or
    result = getImmediateChildOfDateLiteralExpression(e, index)
    or
    result = getImmediateChildOfDateTimeLiteralExpression(e, index)
    or
    result = getImmediateChildOfEqualExpression(e, index)
    or
    result = getImmediateChildOfFormControl(e, index)
    or
    result = getImmediateChildOfFormDataField(e, index)
    or
    result = getImmediateChildOfFormDataSource(e, index)
    or
    result = getImmediateChildOfFormElementType(e, index)
    or
    result = getImmediateChildOfFunctionCall(e, index)
    or
    result = getImmediateChildOfFunctionDeclaration(e, index)
    or
    result = getImmediateChildOfGreaterThanExpression(e, index)
    or
    result = getImmediateChildOfGreaterThanOrEqualExpression(e, index)
    or
    result = getImmediateChildOfInt64LiteralExpression(e, index)
    or
    result = getImmediateChildOfIntLiteralExpression(e, index)
    or
    result = getImmediateChildOfInterface(e, index)
    or
    result = getImmediateChildOfLessThanExpression(e, index)
    or
    result = getImmediateChildOfLessThanOrEqualExpression(e, index)
    or
    result = getImmediateChildOfLikeExpression(e, index)
    or
    result = getImmediateChildOfNewClrCall(e, index)
    or
    result = getImmediateChildOfNotEqualExpression(e, index)
    or
    result = getImmediateChildOfQualifiedCall(e, index)
    or
    result = getImmediateChildOfQualifiedStaticCall(e, index)
    or
    result = getImmediateChildOfRealLiteralExpression(e, index)
    or
    result = getImmediateChildOfStaticMethodCall(e, index)
    or
    result = getImmediateChildOfStringLiteralExpression(e, index)
    or
    result = getImmediateChildOfTableFieldDeclaration(e, index)
    or
    result = getImmediateChildOfAssignDecrementStatement(e, index)
    or
    result = getImmediateChildOfAssignDivideStatement(e, index)
    or
    result = getImmediateChildOfAssignEqualStatement(e, index)
    or
    result = getImmediateChildOfAssignIncrementStatement(e, index)
    or
    result = getImmediateChildOfAssignMultiplyStatement(e, index)
    or
    result = getImmediateChildOfAssignmentEventHandlerInstance(e, index)
    or
    result = getImmediateChildOfParameterDeclaration(e, index)
    or
    result = getImmediateChildOfAssignmentEventHandlerClr(e, index)
  }
}
