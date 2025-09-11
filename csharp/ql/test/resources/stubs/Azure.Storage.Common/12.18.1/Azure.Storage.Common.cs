// This file contains auto-generated code.
// Generated from `Azure.Storage.Common, Version=12.18.1.0, Culture=neutral, PublicKeyToken=92742159e12e44c8`.
namespace Azure
{
    namespace Storage
    {
        public class ClientSideEncryptionOptions
        {
            public ClientSideEncryptionOptions(Azure.Storage.ClientSideEncryptionVersion version) => throw null;
            public Azure.Storage.ClientSideEncryptionVersion EncryptionVersion { get => throw null; }
            public Azure.Core.Cryptography.IKeyEncryptionKey KeyEncryptionKey { get => throw null; set { } }
            public Azure.Core.Cryptography.IKeyEncryptionKeyResolver KeyResolver { get => throw null; set { } }
            public string KeyWrapAlgorithm { get => throw null; set { } }
        }
        public enum ClientSideEncryptionVersion
        {
            V1_0 = 1,
            V2_0 = 2,
        }
        public class DownloadTransferValidationOptions
        {
            public bool AutoValidateChecksum { get => throw null; set { } }
            public Azure.Storage.StorageChecksumAlgorithm ChecksumAlgorithm { get => throw null; set { } }
            public DownloadTransferValidationOptions() => throw null;
        }
        namespace Sas
        {
            public class AccountSasBuilder
            {
                public AccountSasBuilder() => throw null;
                public AccountSasBuilder(Azure.Storage.Sas.AccountSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Sas.AccountSasServices services, Azure.Storage.Sas.AccountSasResourceTypes resourceTypes) => throw null;
                public string EncryptionScope { get => throw null; set { } }
                public override bool Equals(object obj) => throw null;
                public System.DateTimeOffset ExpiresOn { get => throw null; set { } }
                public override int GetHashCode() => throw null;
                public Azure.Storage.Sas.SasIPRange IPRange { get => throw null; set { } }
                public string Permissions { get => throw null; }
                public Azure.Storage.Sas.SasProtocol Protocol { get => throw null; set { } }
                public Azure.Storage.Sas.AccountSasResourceTypes ResourceTypes { get => throw null; set { } }
                public Azure.Storage.Sas.AccountSasServices Services { get => throw null; set { } }
                public void SetPermissions(Azure.Storage.Sas.AccountSasPermissions permissions) => throw null;
                public void SetPermissions(string rawPermissions) => throw null;
                public System.DateTimeOffset StartsOn { get => throw null; set { } }
                public Azure.Storage.Sas.SasQueryParameters ToSasQueryParameters(Azure.Storage.StorageSharedKeyCredential sharedKeyCredential) => throw null;
                public override string ToString() => throw null;
                public string Version { get => throw null; set { } }
            }
            [System.Flags]
            public enum AccountSasPermissions
            {
                Read = 1,
                Write = 2,
                Delete = 4,
                List = 8,
                Add = 16,
                Create = 32,
                Update = 64,
                Process = 128,
                Tag = 256,
                Filter = 512,
                DeleteVersion = 1024,
                SetImmutabilityPolicy = 2048,
                PermanentDelete = 4096,
                All = -1,
            }
            [System.Flags]
            public enum AccountSasResourceTypes
            {
                Service = 1,
                Container = 2,
                Object = 4,
                All = -1,
            }
            [System.Flags]
            public enum AccountSasServices
            {
                Blobs = 1,
                Queues = 2,
                Files = 4,
                Tables = 8,
                All = -1,
            }
            public struct SasIPRange : System.IEquatable<Azure.Storage.Sas.SasIPRange>
            {
                public SasIPRange(System.Net.IPAddress start, System.Net.IPAddress end = default(System.Net.IPAddress)) => throw null;
                public System.Net.IPAddress End { get => throw null; }
                public override bool Equals(object obj) => throw null;
                public bool Equals(Azure.Storage.Sas.SasIPRange other) => throw null;
                public override int GetHashCode() => throw null;
                public static bool operator ==(Azure.Storage.Sas.SasIPRange left, Azure.Storage.Sas.SasIPRange right) => throw null;
                public static bool operator !=(Azure.Storage.Sas.SasIPRange left, Azure.Storage.Sas.SasIPRange right) => throw null;
                public static Azure.Storage.Sas.SasIPRange Parse(string s) => throw null;
                public System.Net.IPAddress Start { get => throw null; }
                public override string ToString() => throw null;
            }
            public enum SasProtocol
            {
                None = 0,
                HttpsAndHttp = 1,
                Https = 2,
            }
            public class SasQueryParameters
            {
                public string AgentObjectId { get => throw null; }
                protected void AppendProperties(System.Text.StringBuilder stringBuilder) => throw null;
                public string CacheControl { get => throw null; }
                public string ContentDisposition { get => throw null; }
                public string ContentEncoding { get => throw null; }
                public string ContentLanguage { get => throw null; }
                public string ContentType { get => throw null; }
                public string CorrelationId { get => throw null; }
                protected static Azure.Storage.Sas.SasQueryParameters Create(System.Collections.Generic.IDictionary<string, string> values) => throw null;
                protected static Azure.Storage.Sas.SasQueryParameters Create(string version, Azure.Storage.Sas.AccountSasServices? services, Azure.Storage.Sas.AccountSasResourceTypes? resourceTypes, Azure.Storage.Sas.SasProtocol protocol, System.DateTimeOffset startsOn, System.DateTimeOffset expiresOn, Azure.Storage.Sas.SasIPRange ipRange, string identifier, string resource, string permissions, string signature, string cacheControl = default(string), string contentDisposition = default(string), string contentEncoding = default(string), string contentLanguage = default(string), string contentType = default(string), string authorizedAadObjectId = default(string), string unauthorizedAadObjectId = default(string), string correlationId = default(string), int? directoryDepth = default(int?), string encryptionScope = default(string)) => throw null;
                protected static Azure.Storage.Sas.SasQueryParameters Create(string version, Azure.Storage.Sas.AccountSasServices? services, Azure.Storage.Sas.AccountSasResourceTypes? resourceTypes, Azure.Storage.Sas.SasProtocol protocol, System.DateTimeOffset startsOn, System.DateTimeOffset expiresOn, Azure.Storage.Sas.SasIPRange ipRange, string identifier, string resource, string permissions, string signature, string cacheControl = default(string), string contentDisposition = default(string), string contentEncoding = default(string), string contentLanguage = default(string), string contentType = default(string)) => throw null;
                protected static Azure.Storage.Sas.SasQueryParameters Create(string version, Azure.Storage.Sas.AccountSasServices? services, Azure.Storage.Sas.AccountSasResourceTypes? resourceTypes, Azure.Storage.Sas.SasProtocol protocol, System.DateTimeOffset startsOn, System.DateTimeOffset expiresOn, Azure.Storage.Sas.SasIPRange ipRange, string identifier, string resource, string permissions, string signature, string cacheControl = default(string), string contentDisposition = default(string), string contentEncoding = default(string), string contentLanguage = default(string), string contentType = default(string), string authorizedAadObjectId = default(string), string unauthorizedAadObjectId = default(string), string correlationId = default(string), int? directoryDepth = default(int?)) => throw null;
                protected SasQueryParameters() => throw null;
                protected SasQueryParameters(System.Collections.Generic.IDictionary<string, string> values) => throw null;
                protected SasQueryParameters(string version, Azure.Storage.Sas.AccountSasServices? services, Azure.Storage.Sas.AccountSasResourceTypes? resourceTypes, Azure.Storage.Sas.SasProtocol protocol, System.DateTimeOffset startsOn, System.DateTimeOffset expiresOn, Azure.Storage.Sas.SasIPRange ipRange, string identifier, string resource, string permissions, string signature, string cacheControl = default(string), string contentDisposition = default(string), string contentEncoding = default(string), string contentLanguage = default(string), string contentType = default(string), string authorizedAadObjectId = default(string), string unauthorizedAadObjectId = default(string), string correlationId = default(string), int? directoryDepth = default(int?), string encryptionScope = default(string)) => throw null;
                protected SasQueryParameters(string version, Azure.Storage.Sas.AccountSasServices? services, Azure.Storage.Sas.AccountSasResourceTypes? resourceTypes, Azure.Storage.Sas.SasProtocol protocol, System.DateTimeOffset startsOn, System.DateTimeOffset expiresOn, Azure.Storage.Sas.SasIPRange ipRange, string identifier, string resource, string permissions, string signature, string cacheControl = default(string), string contentDisposition = default(string), string contentEncoding = default(string), string contentLanguage = default(string), string contentType = default(string)) => throw null;
                protected SasQueryParameters(string version, Azure.Storage.Sas.AccountSasServices? services, Azure.Storage.Sas.AccountSasResourceTypes? resourceTypes, Azure.Storage.Sas.SasProtocol protocol, System.DateTimeOffset startsOn, System.DateTimeOffset expiresOn, Azure.Storage.Sas.SasIPRange ipRange, string identifier, string resource, string permissions, string signature, string cacheControl = default(string), string contentDisposition = default(string), string contentEncoding = default(string), string contentLanguage = default(string), string contentType = default(string), string authorizedAadObjectId = default(string), string unauthorizedAadObjectId = default(string), string correlationId = default(string), int? directoryDepth = default(int?)) => throw null;
                public const string DefaultSasVersion = default;
                public int? DirectoryDepth { get => throw null; }
                public static Azure.Storage.Sas.SasQueryParameters Empty { get => throw null; }
                public string EncryptionScope { get => throw null; }
                public System.DateTimeOffset ExpiresOn { get => throw null; }
                public string Identifier { get => throw null; }
                public Azure.Storage.Sas.SasIPRange IPRange { get => throw null; }
                public string Permissions { get => throw null; }
                public string PreauthorizedAgentObjectId { get => throw null; }
                public Azure.Storage.Sas.SasProtocol Protocol { get => throw null; }
                public string Resource { get => throw null; }
                public Azure.Storage.Sas.AccountSasResourceTypes? ResourceTypes { get => throw null; }
                public Azure.Storage.Sas.AccountSasServices? Services { get => throw null; }
                public string Signature { get => throw null; }
                public System.DateTimeOffset StartsOn { get => throw null; }
                public override string ToString() => throw null;
                public string Version { get => throw null; }
            }
        }
        public enum StorageChecksumAlgorithm
        {
            Auto = 0,
            None = 1,
            MD5 = 2,
            StorageCrc64 = 3,
        }
        // public class StorageCrc64HashAlgorithm : System.IO.Hashing.NonCryptographicHashAlgorithm
        // {
        //     public override void Append(System.ReadOnlySpan<byte> source) => throw null;
        //     public static Azure.Storage.StorageCrc64HashAlgorithm Create() => throw null;
        //     protected override void GetCurrentHashCore(System.Span<byte> destination) => throw null;
        //     public override void Reset() => throw null;
        //     internal StorageCrc64HashAlgorithm() : base(default(int)) { }
        // }
        public static partial class StorageExtensions
        {
            public static System.IDisposable CreateServiceTimeoutScope(System.TimeSpan? timeout) => throw null;
        }
        public class StorageSharedKeyCredential
        {
            public string AccountName { get => throw null; }
            protected static string ComputeSasSignature(Azure.Storage.StorageSharedKeyCredential credential, string message) => throw null;
            public StorageSharedKeyCredential(string accountName, string accountKey) => throw null;
            public void SetAccountKey(string accountKey) => throw null;
        }
        public struct StorageTransferOptions : System.IEquatable<Azure.Storage.StorageTransferOptions>
        {
            public override bool Equals(object obj) => throw null;
            public bool Equals(Azure.Storage.StorageTransferOptions obj) => throw null;
            public override int GetHashCode() => throw null;
            public int? InitialTransferLength { get => throw null; set { } }
            public long? InitialTransferSize { get => throw null; set { } }
            public int? MaximumConcurrency { get => throw null; set { } }
            public int? MaximumTransferLength { get => throw null; set { } }
            public long? MaximumTransferSize { get => throw null; set { } }
            public static bool operator ==(Azure.Storage.StorageTransferOptions left, Azure.Storage.StorageTransferOptions right) => throw null;
            public static bool operator !=(Azure.Storage.StorageTransferOptions left, Azure.Storage.StorageTransferOptions right) => throw null;
        }
        public class TransferValidationOptions
        {
            public TransferValidationOptions() => throw null;
            public Azure.Storage.DownloadTransferValidationOptions Download { get => throw null; }
            public Azure.Storage.UploadTransferValidationOptions Upload { get => throw null; }
        }
        public class UploadTransferValidationOptions
        {
            public Azure.Storage.StorageChecksumAlgorithm ChecksumAlgorithm { get => throw null; set { } }
            public UploadTransferValidationOptions() => throw null;
            public System.ReadOnlyMemory<byte> PrecalculatedChecksum { get => throw null; set { } }
        }
    }
}
