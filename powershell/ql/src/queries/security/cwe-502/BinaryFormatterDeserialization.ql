/**
 * @name Use of BinaryFormatter deserialization API
 * @description BinaryFormatter deserialization is unsafe even when the input is trusted.
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.5
 * @precision high
 * @id powershell/microsoft/public/binary-formatter-deserialization
 * @tags correctness
 *       security
 *       external/cwe/cwe-502
 */

import powershell
import semmle.code.powershell.security.UnsafeDeserializationCustomizations::UnsafeDeserialization

from BinaryFormatterDeserializeCall call
select call,
  "This call uses BinaryFormatter deserialization. BinaryFormatter is unsafe; if this data can be attacker-controlled, the unsafe-deserialization query reports the data flow."
