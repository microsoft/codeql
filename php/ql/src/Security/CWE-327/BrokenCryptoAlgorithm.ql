/**
 * @name Use of a broken or weak cryptographic algorithm
 * @description Using broken or weak cryptographic algorithms can compromise security.
 *              Per Microsoft SDL, only AES is approved; DES, 3DES, RC4, RC2, and
 *              Blowfish are banned.
 * @kind problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id php/weak-cryptographic-algorithm
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

/** A call to `openssl_encrypt` or `openssl_decrypt`. */
class OpenSslCryptoCall extends Php::FunctionCallExpression {
  string funcName;

  OpenSslCryptoCall() {
    funcName = this.getFunction().(Php::Name).getValue() and
    funcName = ["openssl_encrypt", "openssl_decrypt"]
  }

  /** Gets the cipher method argument (second argument, index 1 in the Arguments children). */
  Php::AstNode getCipherArg() {
    exists(Php::Argument arg |
      this.getArguments().getChild(1) = arg and
      result = arg.getChild()
    )
  }

  /** Gets the function name. */
  string getFunctionName() { result = funcName }
}

/** Holds if `cipher` is a weak or banned cipher name per Microsoft SDL. */
bindingset[cipher]
predicate isWeakCipher(string cipher) {
  exists(string lower | lower = cipher.toLowerCase() |
    // DES variants (but not AES)
    lower.matches("des%") or
    lower.matches("%-des%") or
    lower.matches("%des-ede%") or
    // RC4 / RC2
    lower.matches("rc4%") or
    lower.matches("rc2%") or
    // Blowfish
    lower.matches("bf-%") or
    // CAST5
    lower.matches("cast5%") or
    // SEED
    lower.matches("seed%") or
    // IDEA
    lower.matches("idea%") or
    // Camellia is acceptable but ECB modes are banned; handled by InsecureBlockMode
    // Desx
    lower.matches("desx%")
  )
}

from OpenSslCryptoCall call, string cipherName
where
  cipherName = getStringValue(call.getCipherArg()) and
  isWeakCipher(cipherName)
select call,
  "Call to " + call.getFunctionName() + "() uses the weak cipher '" + cipherName +
    "', which is banned by Microsoft SDL. Use AES instead."
