/**
 * @name Use of deprecated mcrypt extension
 * @description The mcrypt extension has been deprecated since PHP 7.1 and removed in
 *              PHP 7.2. Its algorithms (DES, 3DES, Blowfish in ECB) are considered
 *              insecure. Use OpenSSL with AES instead.
 * @kind problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id php/deprecated-mcrypt
 * @tags security
 *       external/cwe/cwe-327
 */

import codeql.php.ast.internal.TreeSitter

/** A call to any mcrypt_* function. */
class McryptCall extends Php::FunctionCallExpression {
  string funcName;

  McryptCall() {
    funcName = this.getFunction().(Php::Name).getValue() and
    funcName.matches("mcrypt_%")
  }

  /** Gets the function name. */
  string getFunctionName() { result = funcName }
}

from McryptCall call
select call,
  "Call to deprecated function " + call.getFunctionName() +
    "(). The mcrypt extension is removed since PHP 7.2. Use openssl_encrypt() with AES instead."
