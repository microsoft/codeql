/**
 * @name Use of insecure block cipher mode (ECB)
 * @description ECB (Electronic Codebook) mode is insecure because identical plaintext
 *              blocks produce identical ciphertext blocks, leaking data patterns.
 *              Per Microsoft SDL, ECB mode is banned.
 * @kind problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id php/insecure-block-mode
 * @tags security
 *       external/cwe/cwe-327
 */

import codeql.php.ast.internal.TreeSitter

/**
 * Gets the string content value from a `String` node (a single-quoted or
 * double-quoted string literal).
 */
string getStringValue(Php::AstNode node) {
  result = node.(Php::String).getChild(0).(Php::StringContent).getValue()
  or
  result = node.(Php::EncapsedString).getChild(0).(Php::StringContent).getValue()
}

/** A call to `openssl_encrypt` or `openssl_decrypt` using ECB mode. */
class EcbModeCall extends Php::FunctionCallExpression {
  string funcName;
  string cipherName;

  EcbModeCall() {
    funcName = this.getFunction().(Php::Name).getValue() and
    funcName = ["openssl_encrypt", "openssl_decrypt"] and
    exists(Php::Argument arg |
      this.getArguments().getChild(1) = arg and
      cipherName = getStringValue(arg.getChild()) and
      cipherName.toLowerCase().matches("%-ecb%")
    )
  }

  /** Gets the function name. */
  string getFunctionName() { result = funcName }

  /** Gets the cipher name. */
  string getCipherName() { result = cipherName }
}

from EcbModeCall call
select call,
  "Call to " + call.getFunctionName() + "() uses ECB mode ('" + call.getCipherName() +
    "'). ECB mode is banned by Microsoft SDL because it leaks data patterns. Use CBC or GCM mode."
