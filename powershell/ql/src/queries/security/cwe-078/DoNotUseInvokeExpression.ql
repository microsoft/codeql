/**
 * @name Use of Invoke-Expression
 * @description Avoid using Invoke-Expression when safer command invocation is possible.
 * @kind problem
 * @problem.severity recommendation
 * @precision medium
 * @id powershell/microsoft/public/do-not-use-invoke-expression
 * @tags quality
 *       maintainability
 *       correctness
 */

import powershell

from CmdCall call
where call.matchesName("Invoke-Expression")
select call,
  "Prefer direct command invocation, splatting, or the call operator over Invoke-Expression."
