import python
import semmle.python.ApiGraphs
import semmle.python.Concepts
import semmle.python.dataflow.new.DataFlow
import semmle.python.dataflow.new.RemoteFlowSources
import semmle.python.dataflow.new.TaintTracking
import semmle.python.frameworks.Pydantic

private class PySparkSqlExecution extends SqlExecution::Range, DataFlow::CallCfgNode {
  PySparkSqlExecution() {
    this =
      API::moduleImport("pyspark")
          .getMember("sql")
          .getMember("SparkSession")
          .getAnInstance()
          .getMember("sql")
          .getACall()
  }

  override DataFlow::Node getSql() { result in [this.getArg(0), this.getArgByName("sqlQuery")] }
}

private API::Node pydanticBaseModelSubclass() {
  result = API::moduleImport("pydantic").getMember("BaseModel").getASubclass+()
}

private class PydanticValidationCall extends DataFlow::CallCfgNode,
  Pydantic::BaseModel::InstanceSource
{
  PydanticValidationCall() {
    this =
      pydanticBaseModelSubclass().getMember(["model_validate", "model_validate_json"]).getACall()
  }

  DataFlow::Node getInput() {
    result in [this.getArg(0), this.getArgByName("obj"), this.getArgByName("json_data")]
  }
}

private class PydanticValidationTaintStep extends TaintTracking::AdditionalTaintStep {
  override predicate step(DataFlow::Node nodeFrom, DataFlow::Node nodeTo) {
    exists(PydanticValidationCall call |
      nodeFrom = call.getInput() and
      nodeTo = call
    )
  }
}

private class PydanticModelLoopTarget extends Pydantic::BaseModel::InstanceSource {
  PydanticModelLoopTarget() {
    exists(For loop, DataFlow::AttrRead field |
      field.getObject() = Pydantic::BaseModel::instance() and
      field.asExpr() = loop.getIter() and
      this.asExpr() = loop.getTarget()
    )
  }
}

private class PydanticAnnotatedParameter extends Pydantic::BaseModel::InstanceSource,
  DataFlow::ParameterNode
{
  PydanticAnnotatedParameter() {
    this.getParameter().getAnnotation() =
      Pydantic::BaseModel::subclassRef().getAValueReachableFromSource().asExpr()
  }
}

private class PydanticModelLoopTaintStep extends TaintTracking::AdditionalTaintStep {
  override predicate step(DataFlow::Node nodeFrom, DataFlow::Node nodeTo) {
    exists(For loop, DataFlow::AttrRead field |
      field.getObject() = Pydantic::BaseModel::instance() and
      field.asExpr() = loop.getIter() and
      nodeFrom = field and
      nodeTo.asExpr() = loop.getTarget()
    )
  }
}

private predicate isDefaultDictNode(DataFlow::Node node) {
  exists(API::CallNode call |
    call = API::moduleImport("collections").getMember("defaultdict").getACall() and
    DataFlow::localFlow(call, node)
  )
}

private class DefaultDictCollectionTaintStep extends TaintTracking::AdditionalTaintStep {
  override predicate step(DataFlow::Node nodeFrom, DataFlow::Node nodeTo) {
    exists(DataFlow::MethodCallNode append, DataFlow::Node bucket, DataFlow::Node dictionary |
      append.getMethodName() = "append" and
      bucket = append.getObject() and
      dictionary.asCfgNode() = bucket.asCfgNode().(SubscriptNode).getObject() and
      isDefaultDictNode(dictionary) and
      nodeFrom = append.getArg(0) and
      nodeTo = dictionary
    )
    or
    exists(DataFlow::Node dictionary |
      isDefaultDictNode(dictionary) and
      nodeFrom = dictionary and
      nodeTo.asCfgNode().(SubscriptNode).getObject() = dictionary.asCfgNode()
    )
    or
    exists(For loop, DataFlow::Node dictionary |
      isDefaultDictNode(dictionary) and
      nodeFrom.asCfgNode().(SubscriptNode).getObject() = dictionary.asCfgNode() and
      nodeFrom.asExpr() = loop.getIter() and
      nodeTo.asExpr() = loop.getTarget()
    )
  }
}

private class SqlglotParseCall extends DataFlow::CallCfgNode {
  SqlglotParseCall() {
    this = API::moduleImport("sqlglot").getMember(["parse", "parse_one"]).getACall()
  }

  DataFlow::Node getSql() { result in [this.getArg(0), this.getArgByName("sql")] }
}

private class SqlglotSerializationCall extends DataFlow::CallCfgNode {
  SqlglotSerializationCall() {
    this instanceof DataFlow::MethodCallNode and
    this.(DataFlow::MethodCallNode).getMethodName() = "sql" and
    exists(SqlglotParseCall parse |
      TaintTracking::localTaint(parse, this.(DataFlow::MethodCallNode).getObject())
    )
  }

  DataFlow::Node getExpression() { result = this.(DataFlow::MethodCallNode).getObject() }
}

private class SqlglotTaintStep extends TaintTracking::AdditionalTaintStep {
  override predicate step(DataFlow::Node nodeFrom, DataFlow::Node nodeTo) {
    exists(SqlglotParseCall call |
      nodeFrom = call.getSql() and
      nodeTo = call
    )
    or
    exists(SqlglotSerializationCall call |
      nodeFrom = call.getExpression() and
      nodeTo = call
    )
  }
}

private API::CallNode functionToolCall() {
  result =
    [
      API::moduleImport("autogen_core").getMember("FunctionTool"),
      API::moduleImport("autogen_core").getMember("tools").getMember("FunctionTool")
    ].getACall()
}

private predicate isBoundFunctionToolCallback(Function function) {
  exists(API::CallNode call, DataFlow::AttrRead callback |
    call = functionToolCall() and
    callback = call.getArg(0) and
    callback.getAttributeName() = function.getName()
  )
}

private class AutoGenFunctionToolParameter extends RemoteFlowSource::Range {
  AutoGenFunctionToolParameter() {
    this = functionToolCall().getParameter(0, "func").getParameter(_).asSource()
    or
    exists(Function function, int index |
      isBoundFunctionToolCallback(function) and
      index > 0 and
      this = DataFlow::parameterNode(function.getArg(index))
    )
  }

  override string getSourceType() { result = "AutoGen FunctionTool argument" }
}

private class AutoGenCallbackSqlExecution extends SqlExecution::Range, DataFlow::MethodCallNode {
  AutoGenCallbackSqlExecution() {
    this.getMethodName() = "query_execution" and
    isBoundFunctionToolCallback(this.asExpr().getScope().(Function))
  }

  override DataFlow::Node getSql() { result in [this.getArg(0), this.getArgByName("sql_query")] }
}

private class AutoGenValidationTaintStep extends TaintTracking::AdditionalTaintStep {
  override predicate step(DataFlow::Node nodeFrom, DataFlow::Node nodeTo) {
    exists(DataFlow::MethodCallNode call, Function callback |
      call.getMethodName() = "query_validation" and
      call.asExpr().getScope() = callback and
      isBoundFunctionToolCallback(callback) and
      nodeFrom in [call.getArg(0), call.getArgByName("sql_query")] and
      nodeTo = call
    )
  }
}

private class JobConfigurationEnvironmentSource extends RemoteFlowSource::Range {
  JobConfigurationEnvironmentSource() {
    this = API::moduleImport("os").getMember("environ").getSubscript("JOB_CONFIG").asSource()
    or
    exists(API::CallNode call, StringLiteral key |
      call = API::moduleImport("os").getMember("environ").getMember("get").getACall() and
      key.getText() = "JOB_CONFIG" and
      call.getArg(0) = DataFlow::exprNode(key) and
      this = call
    )
  }

  override string getSourceType() { result = "externally supplied job configuration" }
}
