/**
 * @name Use of a broken or weak cryptographic hash function
 * @description Using broken or weak cryptographic hash functions such as MD5 or SHA-1
 *              can compromise security. Per Microsoft SDL, only SHA-2 and SHA-3 family
 *              algorithms are approved.
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision high
 * @id php/weak-cryptographic-hash
 * @tags security
 *       external/cwe/cwe-327
 *       external/cwe/cwe-328
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

/** A direct call to a weak hash function like `md5()` or `sha1()`. */
class WeakHashFunctionCall extends Php::FunctionCallExpression {
  string funcName;

  WeakHashFunctionCall() {
    funcName = this.getFunction().(Php::Name).getValue() and
    funcName = ["md5", "sha1", "md5_file", "sha1_file", "crc32"]
  }

  /** Gets the function name. */
  string getFunctionName() { result = funcName }
}

/** Holds if `algoName` is a weak hash algorithm per Microsoft SDL. */
bindingset[algoName]
predicate isWeakHashAlgorithm(string algoName) {
  exists(string lower | lower = algoName.toLowerCase() |
    lower = "md5" or
    lower = "md4" or
    lower = "md2" or
    lower = "sha1" or
    lower = "sha-1" or
    lower = "ripemd128" or
    lower = "ripemd160" or
    lower = "crc32" or
    lower = "crc32b" or
    lower = "adler32" or
    lower = "gost" or
    lower = "snefru"
  )
}

/**
 * A call to `hash()` or `hash_init()` with a weak algorithm name as the
 * first string argument.
 */
class HashCallWithWeakAlgo extends Php::FunctionCallExpression {
  string algoName;

  HashCallWithWeakAlgo() {
    this.getFunction().(Php::Name).getValue() =
      ["hash", "hash_init", "hash_hmac", "hash_file", "hash_hmac_file"] and
    exists(Php::Argument arg |
      this.getArguments().getChild(0) = arg and
      algoName = getStringValue(arg.getChild()) and
      isWeakHashAlgorithm(algoName)
    )
  }

  /** Gets the weak algorithm name. */
  string getAlgorithmName() { result = algoName }
}

from Php::FunctionCallExpression call, string msg
where
  exists(WeakHashFunctionCall weak | weak = call |
    msg =
      "Call to " + weak.getFunctionName() +
        "() uses a broken hash algorithm. Use hash() with SHA-256 or stronger."
  )
  or
  exists(HashCallWithWeakAlgo hashCall | hashCall = call |
    msg =
      "Call to " + call.getFunction().(Php::Name).getValue() + "() uses the weak algorithm '" +
        hashCall.getAlgorithmName() + "'. Use SHA-256 or stronger."
  )
select call, msg
