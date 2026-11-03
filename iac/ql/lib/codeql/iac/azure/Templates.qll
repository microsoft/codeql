/**
 * Provides structural Azure Pipelines template references and local include edges.
 */

private import iac
private import codeql.files.FileSystem

module AzurePipelineTemplates {
  /** A template include or extends declaration, not an arbitrary template parameter. */
  class Reference extends YamlMapping {
    Reference() {
      exists(this.lookup("template")) and
      (
        this instanceof AzurePipelines::TemplateStep
        or
        this instanceof AzurePipelines::Stage
        or
        this instanceof AzurePipelines::Job
        or
        this = any(AzurePipelines::Document doc).lookup("extends")
        or
        this = any(AzurePipelines::Document doc).lookup("variables").getAChild()
        or
        this = any(AzurePipelines::Stage stage).lookup("variables").getAChild()
        or
        this = any(AzurePipelines::Job job).lookup("variables").getAChild()
      )
    }

    /** Gets the template path and optional repository suffix as source data. */
    string getTarget() { result = this.lookup("template").(YamlString).getValue() }

    /** Gets the explicit repository alias, if any. */
    string getRepositoryAlias() { result = this.getTarget().regexpCapture("[^@]+@([^@]+)", 1) }

    /** Gets the path within the selected repository. */
    string getPath() { result = this.getTarget().regexpCapture("([^@]+)(?:@[^@]+)?", 1) }

    /** Gets the containing pipeline or template document. */
    AzurePipelines::Document getEnclosingDocument() { result = this.getDocument() }
  }

  private predicate localPath(Reference reference, string path) {
    (not exists(reference.getRepositoryAlias()) or reference.getRepositoryAlias() = "self") and
    path = reference.getPath() and
    not path.regexpMatch(".*\\$[({\\[].*")
  }

  private Container walk(Reference reference, int index) {
    exists(string path | localPath(reference, path) |
      index = 0 and
      (
        not path.matches("/%") and result = reference.getFile().getParentContainer()
        or
        path.matches("/%") and
        result = reference.getFile().getParentContainer*() and
        result.getRelativePath() = ""
      )
      or
      exists(Container parent, string part |
        parent = walk(reference, index - 1) and part = path.splitAt("/", index - 1)
      |
        part = ["", "."] and result = parent
        or
        part = ".." and result = parent.getParentContainer()
        or
        result = parent.getAChildContainer() and result.getBaseName() = part
      )
    )
  }

  /** Holds if a literal local include resolves to the extracted document `target`. */
  predicate locallyIncludes(AzurePipelines::Document source, AzurePipelines::Document target) {
    YamlDocumentClassification::isSupportedYamlDocument(source, "ado-pipeline") and
    YamlDocumentClassification::isSupportedYamlDocument(target, "ado-pipeline") and
    exists(Reference reference, string path |
      reference.getEnclosingDocument() = source and
      localPath(reference, path) and
      target.getFile() = walk(reference, count(int i | exists(path.splitAt("/", i))))
    )
  }

  /** Holds if `target` is reachable through zero or more local template includes. */
  predicate reaches(AzurePipelines::Document source, AzurePipelines::Document target) {
    source = target
    or
    exists(AzurePipelines::Document intermediate |
      reaches(source, intermediate) and locallyIncludes(intermediate, target)
    )
  }
}
