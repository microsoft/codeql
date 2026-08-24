/**
 * @name Do not add certificates to the system root store
 * @description Adding certificates to the system root certificate store weakens security for all
 *              applications running on the same machine by trusting potentially untrusted
 *              certificate authorities.
 * @kind problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id powershell/adding-cert-to-root-store
 * @tags security
 *       external/cwe/cwe-327
 */

import powershell

/**
 * A call to `Import-Certificate` or `Import-PfxCertificate` that targets the root certificate store.
 */
class ImportCertToRootStore extends CmdCall {
  ImportCertToRootStore() {
    this.getAName() = ["Import-Certificate", "Import-PfxCertificate"] and
    exists(Expr loc |
      loc = this.getNamedArgument("certstorelocation") and
      loc.getValue().asString().toLowerCase().matches("%root%")
    )
  }
}

from ImportCertToRootStore call
select call,
  "This call adds a certificate to the root certificate store, which weakens security for all applications on the machine."
