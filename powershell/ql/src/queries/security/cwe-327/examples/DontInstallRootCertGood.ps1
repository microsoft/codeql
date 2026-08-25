# GOOD: Importing a certificate into a user-specific store limits the scope of trust.
Import-Certificate -FilePath "C:\certs\my-cert.cer" -CertStoreLocation Cert:\CurrentUser\My
