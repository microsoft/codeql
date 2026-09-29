/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * insecure-randomness vulnerabilities, as well as extension points for
 * adding your own.
 */

private import semmle.code.powershell.dataflow.DataFlow
import semmle.code.powershell.ApiGraphs

module InsecureRandomness {
  /**
   * A data flow source for insecure-randomness vulnerabilities.
   */
  abstract class Source extends DataFlow::Node { }

  /**
   * A data flow sink for insecure-randomness vulnerabilities.
   */
  abstract class Sink extends DataFlow::Node {
    /** Gets a human-readable description of this sink. */
    abstract string getSinkDescription();
  }

  /**
   * A sanitizer for insecure-randomness vulnerabilities.
   */
  abstract class Sanitizer extends DataFlow::Node { }

  /** A call to the `Get-Random` cmdlet. */
  class GetRandomSource extends Source instanceof DataFlow::CallNode {
    GetRandomSource() { this.matchesName("Get-Random") }
  }

  /** An instantiation of `System.Random` via `New-Object`. */
  class SystemRandomObjectCreation extends Source instanceof DataFlow::ObjectCreationNode {
    SystemRandomObjectCreation() {
      this.asExpr()
          .getExpr()
          .(ObjectCreation)
          .getAnArgument()
          .getValue()
          .stringMatches("System.Random")
    }
  }

  /** A call to `[System.Random]::new()` via the API graph. */
  class SystemRandomNewCall extends Source instanceof DataFlow::CallNode {
    SystemRandomNewCall() {
      this = API::getTopLevelMember("system").getMember("random").getMember("new").asCall()
    }
  }

  /** Assignment to .Key or .IV on an object. */
  class CryptoKeyIvAssignmentSink extends Sink {
    CryptoKeyIvAssignmentSink() {
      exists(AssignStmt a, MemberExprWriteAccess m |
        m = a.getLeftHandSide() and
        m.getLowerCaseMemberName() in ["key", "iv"] and
        this.asExpr().getExpr() = a.getRightHandSide()
      )
    }

    override string getSinkDescription() { result = "a cryptographic key or IV" }
  }

  /** Argument to a cryptographic constructor (HMAC key or KDF salt). */
  class CryptoConstructorSink extends Sink {
    CryptoConstructorSink() {
      exists(DataFlow::ObjectCreationNode oc |
        (
          oc.getLowerCaseConstructedTypeName().matches("%hmac%")
          or
          oc.getLowerCaseConstructedTypeName().matches("%rfc2898derivebytes%")
        ) and
        this = oc.getAnArgument() and
        not this = oc.getConstructedTypeNode()
      )
    }

    override string getSinkDescription() { result = "a cryptographic operation" }
  }

  /** First positional argument to ConvertTo-SecureString. */
  class SecureStringSink extends Sink {
    SecureStringSink() {
      exists(DataFlow::CallNode call |
        call.matchesName("ConvertTo-SecureString") and
        this = call.getPositionalArgument(0)
      )
    }

    override string getSinkDescription() { result = "a secure string conversion" }
  }

  /** Value used in HTTP headers passed to Invoke-RestMethod or Invoke-WebRequest. */
  class HttpHeaderValueSink extends Sink {
    HttpHeaderValueSink() {
      exists(DataFlow::CallNode call, HashTableExpr ht |
        (call.matchesName("Invoke-RestMethod") or call.matchesName("Invoke-WebRequest")) and
        call.getNamedArgument("headers").asExpr().getExpr() = ht and
        this.asExpr().getExpr() = ht.getAValue()
      )
    }

    override string getSinkDescription() { result = "an HTTP header" }
  }
}
