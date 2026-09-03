// This file contains auto-generated code.
// Generated from `Azure.Security.KeyVault.Secrets, Version=4.5.0.0, Culture=neutral, PublicKeyToken=92742159e12e44c8`.

namespace Azure
{
    namespace Security
    {
        namespace KeyVault
        {
            namespace Secrets
            {
                public class DeletedSecret : Azure.Security.KeyVault.Secrets.KeyVaultSecret
                {
                    public System.DateTimeOffset? DeletedOn { get => throw null; }
                    public System.Uri RecoveryId { get => throw null; }
                    public System.DateTimeOffset? ScheduledPurgeDate { get => throw null; }
                    internal DeletedSecret() : base(default(string), default(string)) { }
                }
                public class DeleteSecretOperation : Azure.Operation<Azure.Security.KeyVault.Secrets.DeletedSecret>
                {
                    protected DeleteSecretOperation() => throw null;
                    public override Azure.Response GetRawResponse() => throw null;
                    public override bool HasCompleted { get => throw null; }
                    public override bool HasValue { get => throw null; }
                    public override string Id { get => throw null; }
                    public override Azure.Response UpdateStatus(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.ValueTask<Azure.Response> UpdateStatusAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Security.KeyVault.Secrets.DeletedSecret Value { get => throw null; }
                    public override System.Threading.Tasks.ValueTask<Azure.Response<Azure.Security.KeyVault.Secrets.DeletedSecret>> WaitForCompletionAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.ValueTask<Azure.Response<Azure.Security.KeyVault.Secrets.DeletedSecret>> WaitForCompletionAsync(System.TimeSpan pollingInterval, System.Threading.CancellationToken cancellationToken) => throw null;
                }
                public class KeyVaultSecret
                {
                    public KeyVaultSecret(string name, string value) => throw null;
                    public System.Uri Id { get => throw null; }
                    public string Name { get => throw null; }
                    public Azure.Security.KeyVault.Secrets.SecretProperties Properties { get => throw null; }
                    public string Value { get => throw null; }
                }
                public struct KeyVaultSecretIdentifier : System.IEquatable<Azure.Security.KeyVault.Secrets.KeyVaultSecretIdentifier>
                {
                    public KeyVaultSecretIdentifier(System.Uri id) => throw null;
                    public override bool Equals(object obj) => throw null;
                    public bool Equals(Azure.Security.KeyVault.Secrets.KeyVaultSecretIdentifier other) => throw null;
                    public override int GetHashCode() => throw null;
                    public string Name { get => throw null; }
                    public System.Uri SourceId { get => throw null; }
                    public override string ToString() => throw null;
                    public static bool TryCreate(System.Uri id, out Azure.Security.KeyVault.Secrets.KeyVaultSecretIdentifier identifier) => throw null;
                    public System.Uri VaultUri { get => throw null; }
                    public string Version { get => throw null; }
                }
                public class RecoverDeletedSecretOperation : Azure.Operation<Azure.Security.KeyVault.Secrets.SecretProperties>
                {
                    protected RecoverDeletedSecretOperation() => throw null;
                    public override Azure.Response GetRawResponse() => throw null;
                    public override bool HasCompleted { get => throw null; }
                    public override bool HasValue { get => throw null; }
                    public override string Id { get => throw null; }
                    public override Azure.Response UpdateStatus(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.ValueTask<Azure.Response> UpdateStatusAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Security.KeyVault.Secrets.SecretProperties Value { get => throw null; }
                    public override System.Threading.Tasks.ValueTask<Azure.Response<Azure.Security.KeyVault.Secrets.SecretProperties>> WaitForCompletionAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.ValueTask<Azure.Response<Azure.Security.KeyVault.Secrets.SecretProperties>> WaitForCompletionAsync(System.TimeSpan pollingInterval, System.Threading.CancellationToken cancellationToken) => throw null;
                }
                public class SecretClient
                {
                    public virtual Azure.Response<byte[]> BackupSecret(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<byte[]>> BackupSecretAsync(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected SecretClient() => throw null;
                    public SecretClient(System.Uri vaultUri, Azure.Core.TokenCredential credential) => throw null;
                    public SecretClient(System.Uri vaultUri, Azure.Core.TokenCredential credential, Azure.Security.KeyVault.Secrets.SecretClientOptions options) => throw null;
                    public virtual Azure.Response<Azure.Security.KeyVault.Secrets.DeletedSecret> GetDeletedSecret(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Security.KeyVault.Secrets.DeletedSecret>> GetDeletedSecretAsync(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Security.KeyVault.Secrets.DeletedSecret> GetDeletedSecrets(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Security.KeyVault.Secrets.DeletedSecret> GetDeletedSecretsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Security.KeyVault.Secrets.SecretProperties> GetPropertiesOfSecrets(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Security.KeyVault.Secrets.SecretProperties> GetPropertiesOfSecretsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Security.KeyVault.Secrets.SecretProperties> GetPropertiesOfSecretVersions(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Security.KeyVault.Secrets.SecretProperties> GetPropertiesOfSecretVersionsAsync(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Security.KeyVault.Secrets.KeyVaultSecret> GetSecret(string name, string version = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Security.KeyVault.Secrets.KeyVaultSecret>> GetSecretAsync(string name, string version = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response PurgeDeletedSecret(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> PurgeDeletedSecretAsync(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Security.KeyVault.Secrets.SecretProperties> RestoreSecretBackup(byte[] backup, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Security.KeyVault.Secrets.SecretProperties>> RestoreSecretBackupAsync(byte[] backup, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Security.KeyVault.Secrets.KeyVaultSecret> SetSecret(Azure.Security.KeyVault.Secrets.KeyVaultSecret secret, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Security.KeyVault.Secrets.KeyVaultSecret> SetSecret(string name, string value, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Security.KeyVault.Secrets.KeyVaultSecret>> SetSecretAsync(Azure.Security.KeyVault.Secrets.KeyVaultSecret secret, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Security.KeyVault.Secrets.KeyVaultSecret>> SetSecretAsync(string name, string value, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Security.KeyVault.Secrets.DeleteSecretOperation StartDeleteSecret(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Security.KeyVault.Secrets.DeleteSecretOperation> StartDeleteSecretAsync(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Security.KeyVault.Secrets.RecoverDeletedSecretOperation StartRecoverDeletedSecret(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Security.KeyVault.Secrets.RecoverDeletedSecretOperation> StartRecoverDeletedSecretAsync(string name, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Security.KeyVault.Secrets.SecretProperties> UpdateSecretProperties(Azure.Security.KeyVault.Secrets.SecretProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Security.KeyVault.Secrets.SecretProperties>> UpdateSecretPropertiesAsync(Azure.Security.KeyVault.Secrets.SecretProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri VaultUri { get => throw null; }
                }
                public class SecretClientOptions : Azure.Core.ClientOptions
                {
                    public SecretClientOptions(Azure.Security.KeyVault.Secrets.SecretClientOptions.ServiceVersion version = default(Azure.Security.KeyVault.Secrets.SecretClientOptions.ServiceVersion)) => throw null;
                    public bool DisableChallengeResourceVerification { get => throw null; set { } }
                    public enum ServiceVersion
                    {
                        V7_0 = 0,
                        V7_1 = 1,
                        V7_2 = 2,
                        V7_3 = 3,
                        V7_4 = 4,
                    }
                    public Azure.Security.KeyVault.Secrets.SecretClientOptions.ServiceVersion Version { get => throw null; }
                }
                public static class SecretModelFactory
                {
                    public static Azure.Security.KeyVault.Secrets.DeletedSecret DeletedSecret(Azure.Security.KeyVault.Secrets.SecretProperties properties, string value = default(string), System.Uri recoveryId = default(System.Uri), System.DateTimeOffset? deletedOn = default(System.DateTimeOffset?), System.DateTimeOffset? scheduledPurgeDate = default(System.DateTimeOffset?)) => throw null;
                    public static Azure.Security.KeyVault.Secrets.KeyVaultSecret KeyVaultSecret(Azure.Security.KeyVault.Secrets.SecretProperties properties, string value = default(string)) => throw null;
                    public static Azure.Security.KeyVault.Secrets.SecretProperties SecretProperties(System.Uri id, System.Uri vaultUri, string name, string version, bool managed, System.Uri keyId, System.DateTimeOffset? createdOn, System.DateTimeOffset? updatedOn, string recoveryLevel) => throw null;
                    public static Azure.Security.KeyVault.Secrets.SecretProperties SecretProperties(System.Uri id = default(System.Uri), System.Uri vaultUri = default(System.Uri), string name = default(string), string version = default(string), bool managed = default(bool), System.Uri keyId = default(System.Uri), System.DateTimeOffset? createdOn = default(System.DateTimeOffset?), System.DateTimeOffset? updatedOn = default(System.DateTimeOffset?), string recoveryLevel = default(string), int? recoverableDays = default(int?)) => throw null;
                }
                public class SecretProperties
                {
                    public string ContentType { get => throw null; set { } }
                    public System.DateTimeOffset? CreatedOn { get => throw null; }
                    public SecretProperties(string name) => throw null;
                    public SecretProperties(System.Uri id) => throw null;
                    public bool? Enabled { get => throw null; set { } }
                    public System.DateTimeOffset? ExpiresOn { get => throw null; set { } }
                    public System.Uri Id { get => throw null; }
                    public System.Uri KeyId { get => throw null; }
                    public bool Managed { get => throw null; }
                    public string Name { get => throw null; }
                    public System.DateTimeOffset? NotBefore { get => throw null; set { } }
                    public int? RecoverableDays { get => throw null; }
                    public string RecoveryLevel { get => throw null; }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; }
                    public System.DateTimeOffset? UpdatedOn { get => throw null; }
                    public System.Uri VaultUri { get => throw null; }
                    public string Version { get => throw null; }
                }
            }
        }
    }
}
