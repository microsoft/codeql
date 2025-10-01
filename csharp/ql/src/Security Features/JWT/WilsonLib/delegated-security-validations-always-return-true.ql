/**
 * @name Delegated security sensitive validations for JsonWebTokenHandler always return true, medium precision
 * @description Security sensitive validations for `JsonWebTokenHandler` are being delegated to a function that seems to always return true.
 *   Higher precision version checks for exception throws, so less false positives are expected.
 * @kind problem
 * @tags security
 *       wilson-library
 *       manual-verification-required
 * @id cs/wilson-library/delegated-security-validations-always-return-true
 * @problem.severity warning
 * @precision high
 */

import csharp
import DataFlow
import wilsonlib

from
  TokenValidationParametersPropertyWriteToValidationDelegated tv, Assignment a,
  AbstractCallableAlwaysReturnsTrueHigherPrecision e
where a.getLValue() = tv and a.getRValue().getAChild*() = e
select tv,
  "JsonWebTokenHandler security-sensitive property $@ is being delegated to $@.",
  tv, tv.getTarget().toString(), e, "a callable that always returns \"true\""
