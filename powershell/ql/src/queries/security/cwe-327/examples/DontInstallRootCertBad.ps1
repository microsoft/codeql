# BAD: Importing a certificate into the root store weakens security for all
# applications on the machine.
Import-Certificate -FilePath "C:\certs\my-cert.cer" -CertStoreLocation Cert:\LocalMachine\Root
