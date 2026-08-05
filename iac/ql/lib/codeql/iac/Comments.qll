/**
 * Provides a unified representation of comments across the infrastructure-as-code
 * (IaC) languages supported by CodeQL, spanning HCL/Terraform comments and comments
 * in YAML files recognized by a public IaC framework API.
 */

import iac

/**
 * Holds if `file` is a YAML file recognized by a public IaC framework API.
 */
private predicate isSupportedYamlFile(File file) {
  exists(CloudFormation::Document document | document.getFile() = file)
  or
  exists(ARM::Document document | document.getFile() = file)
  or
  exists(AzurePipelines::Document document | document.getFile() = file)
  or
  exists(Compose::Document document | document.getFile() = file)
  or
  exists(HelmChart::Document document | document.getFile() = file)
  or
  exists(OpenApi::Document document | document.getFile() = file)
  or
  exists(YamlDocument document |
    document.getFile() = file and
    document instanceof YamlMapping and
    document
        .(YamlMapping)
        .lookup("$schema")
        .(YamlString)
        .getValue()
        .regexpMatch(".*schema\\.management\\.azure\\.com.*")
  )
}

/**
 * Gets the delimiter-stripped `text` and `delimiterStyle` of an HCL comment.
 */
private predicate getHclCommentText(HCLComment comment, string text, string delimiterStyle) {
  exists(string raw | raw = comment.getContents() |
    raw.matches("#%") and
    text = raw.suffix(1).replaceAll("\r", "") and
    delimiterStyle = "hash"
    or
    raw.matches("//%") and
    text = raw.suffix(2).replaceAll("\r", "") and
    delimiterStyle = "slash"
    or
    raw.matches("/*%*/") and
    text = raw.substring(2, raw.length() - 2).replaceAll("\r", "") and
    delimiterStyle = "slash"
  )
}

/**
 * Gets the delimiter-stripped `text` and `delimiterStyle` of a comment exposed by a
 * supported public IaC API located at `location`.
 */
private predicate getIacCommentText(Location location, string text, string delimiterStyle) {
  exists(HCLComment comment |
    location = comment.getLocation() and
    getHclCommentText(comment, text, delimiterStyle)
  )
  or
  exists(YamlComment comment |
    location = comment.getLocation() and
    isSupportedYamlFile(comment.getLocation().getFile()) and
    text = comment.getText() and
    delimiterStyle = "hash"
  )
}

/**
 * A comment exposed by a supported public IaC API.
 *
 * This spans HCL/Terraform comments and comments in YAML files recognized by a public
 * IaC framework API (for example CloudFormation, ARM, Azure Pipelines, Compose, Helm
 * charts and OpenAPI documents).
 */
class Comment extends Location {
  Comment() {
    exists(string text, string delimiterStyle | getIacCommentText(this, text, delimiterStyle))
  }

  /** Gets the comment text without its delimiter. */
  string getText() {
    exists(string delimiterStyle | getIacCommentText(this, result, delimiterStyle))
  }

  /** Holds if this comment uses `#` as its delimiter. */
  predicate hasHashDelimiter() { exists(string text | getIacCommentText(this, text, "hash")) }
}
