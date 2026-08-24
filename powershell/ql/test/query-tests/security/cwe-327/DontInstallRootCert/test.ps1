# BAD: importing into the machine root store.
Import-Certificate -FilePath "C:\certs\my-cert.cer" -CertStoreLocation Cert:\LocalMachine\Root # $ Alert

# BAD: importing a PFX into the current-user root store.
Import-PfxCertificate -FilePath "C:\certs\my-cert.pfx" -CertStoreLocation Cert:\CurrentUser\Root # $ Alert

# BAD: casing should not matter.
Import-Certificate -FilePath "C:\certs\my-cert.cer" -CertStoreLocation cert:\localmachine\root # $ Alert

# GOOD: user-specific personal store.
Import-Certificate -FilePath "C:\certs\my-cert.cer" -CertStoreLocation Cert:\CurrentUser\My

# GOOD: machine personal store.
Import-PfxCertificate -FilePath "C:\certs\my-cert.pfx" -CertStoreLocation Cert:\LocalMachine\My

# GOOD: no store location specified.
Import-Certificate -FilePath "C:\certs\my-cert.cer"
