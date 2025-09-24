// This file contains auto-generated code.
// Generated from `Azure.Storage.Blobs, Version=12.19.1.0, Culture=neutral, PublicKeyToken=92742159e12e44c8`.
using Azure.Core.Extensions;
using Azure.Storage;
using Azure.Storage.Blobs;

namespace Azure
{
    namespace Storage
    {
        namespace Blobs
        {
            public class BlobClient : Azure.Storage.Blobs.Specialized.BlobBaseClient
            {
                protected BlobClient() => throw null;
                public BlobClient(string connectionString, string blobContainerName, string blobName) => throw null;
                public BlobClient(string connectionString, string blobContainerName, string blobName, Azure.Storage.Blobs.BlobClientOptions options) => throw null;
                public BlobClient(System.Uri blobUri, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobClient(System.Uri blobUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobClient(System.Uri blobUri, Azure.AzureSasCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobClient(System.Uri blobUri, Azure.Core.TokenCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public virtual System.IO.Stream OpenWrite(bool overwrite, Azure.Storage.Blobs.Models.BlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.BlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenWriteAsync(bool overwrite, Azure.Storage.Blobs.Models.BlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.BlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.IO.Stream content) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.BinaryData content) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(string path) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.IO.Stream content, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.BinaryData content, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(string path, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.IO.Stream content, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.BinaryData content, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(string path, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.BinaryData content, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(string path, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(string path, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.IO.Stream content) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.BinaryData content) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(string path) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.IO.Stream content, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.BinaryData content, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(string path, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.IO.Stream content, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.BinaryData content, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(string path, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.BinaryData content, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(string path, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(string path, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                protected virtual Azure.Storage.Blobs.BlobClient WithClientSideEncryptionOptionsCore(Azure.Storage.ClientSideEncryptionOptions clientSideEncryptionOptions) => throw null;
                public Azure.Storage.Blobs.BlobClient WithCustomerProvidedKey(Azure.Storage.Blobs.Models.CustomerProvidedKey? customerProvidedKey) => throw null;
                public Azure.Storage.Blobs.BlobClient WithEncryptionScope(string encryptionScope) => throw null;
                public Azure.Storage.Blobs.BlobClient WithSnapshot(string snapshot) => throw null;
                public Azure.Storage.Blobs.BlobClient WithVersion(string versionId) => throw null;
            }
            public class BlobClientOptions : Azure.Core.ClientOptions
            {
                public Azure.Storage.Blobs.Models.BlobAudience? Audience { get => throw null; set { } }
                public BlobClientOptions(Azure.Storage.Blobs.BlobClientOptions.ServiceVersion version = default(Azure.Storage.Blobs.BlobClientOptions.ServiceVersion)) => throw null;
                public Azure.Storage.Blobs.Models.CustomerProvidedKey? CustomerProvidedKey { get => throw null; set { } }
                public bool EnableTenantDiscovery { get => throw null; set { } }
                public string EncryptionScope { get => throw null; set { } }
                public System.Uri GeoRedundantSecondaryUri { get => throw null; set { } }
                public enum ServiceVersion
                {
                    V2019_02_02 = 1,
                    V2019_07_07 = 2,
                    V2019_12_12 = 3,
                    V2020_02_10 = 4,
                    V2020_04_08 = 5,
                    V2020_06_12 = 6,
                    V2020_08_04 = 7,
                    V2020_10_02 = 8,
                    V2020_12_06 = 9,
                    V2021_02_12 = 10,
                    V2021_04_10 = 11,
                    V2021_06_08 = 12,
                    V2021_08_06 = 13,
                    V2021_10_04 = 14,
                    V2021_12_02 = 15,
                    V2022_11_02 = 16,
                    V2023_01_03 = 17,
                    V2023_05_03 = 18,
                    V2023_08_03 = 19,
                    V2023_11_03 = 20,
                }
                public Azure.Storage.TransferValidationOptions TransferValidation { get => throw null; }
                public bool TrimBlobNameSlashes { get => throw null; set { } }
                public Azure.Storage.Blobs.BlobClientOptions.ServiceVersion Version { get => throw null; }
            }
            public class BlobContainerClient
            {
                public virtual string AccountName { get => throw null; }
                public virtual bool CanGenerateSasUri { get => throw null; }
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo> Create(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions encryptionScopeOptions = default(Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo> Create(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo>> CreateAsync(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions encryptionScopeOptions = default(Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo>> CreateAsync(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                protected static Azure.Storage.Blobs.BlobContainerClient CreateClient(System.Uri containerUri, Azure.Storage.Blobs.BlobClientOptions options, Azure.Core.Pipeline.HttpPipeline pipeline) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo> CreateIfNotExists(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions encryptionScopeOptions = default(Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo> CreateIfNotExists(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo>> CreateIfNotExistsAsync(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions encryptionScopeOptions = default(Azure.Storage.Blobs.Models.BlobContainerEncryptionScopeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo>> CreateIfNotExistsAsync(Azure.Storage.Blobs.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                protected BlobContainerClient() => throw null;
                public BlobContainerClient(string connectionString, string blobContainerName) => throw null;
                public BlobContainerClient(string connectionString, string blobContainerName, Azure.Storage.Blobs.BlobClientOptions options) => throw null;
                public BlobContainerClient(System.Uri blobContainerUri, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobContainerClient(System.Uri blobContainerUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobContainerClient(System.Uri blobContainerUri, Azure.AzureSasCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobContainerClient(System.Uri blobContainerUri, Azure.Core.TokenCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public virtual Azure.Response Delete(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response DeleteBlob(string blobName, Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response> DeleteBlobAsync(string blobName, Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<bool> DeleteBlobIfExists(string blobName, Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteBlobIfExistsAsync(string blobName, Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<bool> DeleteIfExists(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<bool> Exists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<bool>> ExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Pageable<Azure.Storage.Blobs.Models.TaggedBlobItem> FindBlobsByTags(string tagFilterSqlExpression, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.TaggedBlobItem> FindBlobsByTagsAsync(string tagFilterSqlExpression, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.BlobContainerSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.BlobSasBuilder builder) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerAccessPolicy> GetAccessPolicy(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerAccessPolicy>> GetAccessPolicyAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                protected virtual Azure.Storage.Blobs.Specialized.AppendBlobClient GetAppendBlobClientCore(string blobName) => throw null;
                protected virtual Azure.Storage.Blobs.Specialized.BlobBaseClient GetBlobBaseClientCore(string blobName) => throw null;
                public virtual Azure.Storage.Blobs.BlobClient GetBlobClient(string blobName) => throw null;
                protected virtual Azure.Storage.Blobs.Specialized.BlobLeaseClient GetBlobLeaseClientCore(string leaseId) => throw null;
                public virtual Azure.Pageable<Azure.Storage.Blobs.Models.BlobItem> GetBlobs(Azure.Storage.Blobs.Models.BlobTraits traits = default(Azure.Storage.Blobs.Models.BlobTraits), Azure.Storage.Blobs.Models.BlobStates states = default(Azure.Storage.Blobs.Models.BlobStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.BlobItem> GetBlobsAsync(Azure.Storage.Blobs.Models.BlobTraits traits = default(Azure.Storage.Blobs.Models.BlobTraits), Azure.Storage.Blobs.Models.BlobStates states = default(Azure.Storage.Blobs.Models.BlobStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Pageable<Azure.Storage.Blobs.Models.BlobHierarchyItem> GetBlobsByHierarchy(Azure.Storage.Blobs.Models.BlobTraits traits = default(Azure.Storage.Blobs.Models.BlobTraits), Azure.Storage.Blobs.Models.BlobStates states = default(Azure.Storage.Blobs.Models.BlobStates), string delimiter = default(string), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.BlobHierarchyItem> GetBlobsByHierarchyAsync(Azure.Storage.Blobs.Models.BlobTraits traits = default(Azure.Storage.Blobs.Models.BlobTraits), Azure.Storage.Blobs.Models.BlobStates states = default(Azure.Storage.Blobs.Models.BlobStates), string delimiter = default(string), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                protected virtual Azure.Storage.Blobs.Specialized.BlockBlobClient GetBlockBlobClientCore(string blobName) => throw null;
                protected virtual Azure.Storage.Blobs.Specialized.PageBlobClient GetPageBlobClientCore(string blobName) => throw null;
                protected virtual Azure.Storage.Blobs.BlobServiceClient GetParentBlobServiceClientCore() => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerProperties> GetProperties(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerProperties>> GetPropertiesAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public static readonly string LogsBlobContainerName;
                public virtual string Name { get => throw null; }
                public static readonly string RootBlobContainerName;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo> SetAccessPolicy(Azure.Storage.Blobs.Models.PublicAccessType accessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobSignedIdentifier> permissions = default(System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobSignedIdentifier>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo>> SetAccessPolicyAsync(Azure.Storage.Blobs.Models.PublicAccessType accessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobSignedIdentifier> permissions = default(System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobSignedIdentifier>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContainerInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> UploadBlob(string blobName, System.IO.Stream content, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> UploadBlob(string blobName, System.BinaryData content, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadBlobAsync(string blobName, System.IO.Stream content, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadBlobAsync(string blobName, System.BinaryData content, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Uri Uri { get => throw null; }
                public static readonly string WebBlobContainerName;
            }
            public class BlobServiceClient
            {
                public string AccountName { get => throw null; }
                public virtual bool CanGenerateAccountSasUri { get => throw null; }
                public virtual Azure.Response<Azure.Storage.Blobs.BlobContainerClient> CreateBlobContainer(string blobContainerName, Azure.Storage.Blobs.Models.PublicAccessType publicAccessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.BlobContainerClient>> CreateBlobContainerAsync(string blobContainerName, Azure.Storage.Blobs.Models.PublicAccessType publicAccessType = default(Azure.Storage.Blobs.Models.PublicAccessType), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                protected static Azure.Storage.Blobs.BlobServiceClient CreateClient(System.Uri serviceUri, Azure.Storage.Blobs.BlobClientOptions options, Azure.Core.Pipeline.HttpPipelinePolicy authentication, Azure.Core.Pipeline.HttpPipeline pipeline, Azure.Storage.StorageSharedKeyCredential sharedKeyCredential, Azure.AzureSasCredential sasCredential, Azure.Core.TokenCredential tokenCredential) => throw null;
                protected static Azure.Storage.Blobs.BlobServiceClient CreateClient(System.Uri serviceUri, Azure.Storage.Blobs.BlobClientOptions options, Azure.Core.Pipeline.HttpPipelinePolicy authentication, Azure.Core.Pipeline.HttpPipeline pipeline) => throw null;
                protected BlobServiceClient() => throw null;
                public BlobServiceClient(string connectionString) => throw null;
                public BlobServiceClient(string connectionString, Azure.Storage.Blobs.BlobClientOptions options) => throw null;
                public BlobServiceClient(System.Uri serviceUri, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobServiceClient(System.Uri serviceUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobServiceClient(System.Uri serviceUri, Azure.AzureSasCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public BlobServiceClient(System.Uri serviceUri, Azure.Core.TokenCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                public virtual Azure.Response DeleteBlobContainer(string blobContainerName, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response> DeleteBlobContainerAsync(string blobContainerName, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Pageable<Azure.Storage.Blobs.Models.TaggedBlobItem> FindBlobsByTags(string tagFilterSqlExpression, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.TaggedBlobItem> FindBlobsByTagsAsync(string tagFilterSqlExpression, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Sas.AccountSasResourceTypes resourceTypes) => throw null;
                public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasBuilder builder) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.AccountInfo> GetAccountInfo(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.AccountInfo>> GetAccountInfoAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                protected static Azure.Core.Pipeline.HttpPipelinePolicy GetAuthenticationPolicy(Azure.Storage.Blobs.BlobServiceClient client) => throw null;
                public virtual Azure.Storage.Blobs.BlobContainerClient GetBlobContainerClient(string blobContainerName) => throw null;
                public virtual Azure.Pageable<Azure.Storage.Blobs.Models.BlobContainerItem> GetBlobContainers(Azure.Storage.Blobs.Models.BlobContainerTraits traits = default(Azure.Storage.Blobs.Models.BlobContainerTraits), Azure.Storage.Blobs.Models.BlobContainerStates states = default(Azure.Storage.Blobs.Models.BlobContainerStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Pageable<Azure.Storage.Blobs.Models.BlobContainerItem> GetBlobContainers(Azure.Storage.Blobs.Models.BlobContainerTraits traits, string prefix, System.Threading.CancellationToken cancellationToken) => throw null;
                public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.BlobContainerItem> GetBlobContainersAsync(Azure.Storage.Blobs.Models.BlobContainerTraits traits = default(Azure.Storage.Blobs.Models.BlobContainerTraits), Azure.Storage.Blobs.Models.BlobContainerStates states = default(Azure.Storage.Blobs.Models.BlobContainerStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.BlobContainerItem> GetBlobContainersAsync(Azure.Storage.Blobs.Models.BlobContainerTraits traits, string prefix, System.Threading.CancellationToken cancellationToken) => throw null;
                protected static Azure.Storage.Blobs.BlobClientOptions GetClientOptions(Azure.Storage.Blobs.BlobServiceClient client) => throw null;
                protected static Azure.Core.Pipeline.HttpPipeline GetHttpPipeline(Azure.Storage.Blobs.BlobServiceClient client) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobServiceProperties> GetProperties(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobServiceProperties>> GetPropertiesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobServiceStatistics> GetStatistics(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobServiceStatistics>> GetStatisticsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.Models.UserDelegationKey> GetUserDelegationKey(System.DateTimeOffset? startsOn, System.DateTimeOffset expiresOn, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.UserDelegationKey>> GetUserDelegationKeyAsync(System.DateTimeOffset? startsOn, System.DateTimeOffset expiresOn, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response SetProperties(Azure.Storage.Blobs.Models.BlobServiceProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response> SetPropertiesAsync(Azure.Storage.Blobs.Models.BlobServiceProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.BlobContainerClient> UndeleteBlobContainer(string deletedContainerName, string deletedContainerVersion, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual Azure.Response<Azure.Storage.Blobs.BlobContainerClient> UndeleteBlobContainer(string deletedContainerName, string deletedContainerVersion, string destinationContainerName, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.BlobContainerClient>> UndeleteBlobContainerAsync(string deletedContainerName, string deletedContainerVersion, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.BlobContainerClient>> UndeleteBlobContainerAsync(string deletedContainerName, string deletedContainerVersion, string destinationContainerName, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                public virtual System.Uri Uri { get => throw null; }
            }
            public class BlobUriBuilder
            {
                public string AccountName { get => throw null; set { } }
                public string BlobContainerName { get => throw null; set { } }
                public string BlobName { get => throw null; set { } }
                public BlobUriBuilder(System.Uri uri) => throw null;
                public BlobUriBuilder(System.Uri uri, bool trimBlobNameSlashes) => throw null;
                public string Host { get => throw null; set { } }
                public int Port { get => throw null; set { } }
                public string Query { get => throw null; set { } }
                public Azure.Storage.Sas.BlobSasQueryParameters Sas { get => throw null; set { } }
                public string Scheme { get => throw null; set { } }
                public string Snapshot { get => throw null; set { } }
                public override string ToString() => throw null;
                public System.Uri ToUri() => throw null;
                public bool TrimBlobNameSlashes { get => throw null; }
                public string VersionId { get => throw null; set { } }
            }
            namespace Models
            {
                public struct AccessTier : System.IEquatable<Azure.Storage.Blobs.Models.AccessTier>
                {
                    public static Azure.Storage.Blobs.Models.AccessTier Archive { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier Cold { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier Cool { get => throw null; }
                    public AccessTier(string value) => throw null;
                    public override bool Equals(object obj) => throw null;
                    public bool Equals(Azure.Storage.Blobs.Models.AccessTier other) => throw null;
                    public override int GetHashCode() => throw null;
                    public static Azure.Storage.Blobs.Models.AccessTier Hot { get => throw null; }
                    public static bool operator ==(Azure.Storage.Blobs.Models.AccessTier left, Azure.Storage.Blobs.Models.AccessTier right) => throw null;
                    public static implicit operator Azure.Storage.Blobs.Models.AccessTier(string value) => throw null;
                    public static bool operator !=(Azure.Storage.Blobs.Models.AccessTier left, Azure.Storage.Blobs.Models.AccessTier right) => throw null;
                    public static Azure.Storage.Blobs.Models.AccessTier P10 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P15 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P20 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P30 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P4 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P40 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P50 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P6 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P60 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P70 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier P80 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.AccessTier Premium { get => throw null; }
                    public override string ToString() => throw null;
                }
                public class AccountInfo
                {
                    public Azure.Storage.Blobs.Models.AccountKind AccountKind { get => throw null; }
                    public bool IsHierarchicalNamespaceEnabled { get => throw null; }
                    public Azure.Storage.Blobs.Models.SkuName SkuName { get => throw null; }
                }
                public enum AccountKind
                {
                    Storage = 0,
                    BlobStorage = 1,
                    StorageV2 = 2,
                    FileStorage = 3,
                    BlockBlobStorage = 4,
                }
                public class AppendBlobAppendBlockFromUriOptions
                {
                    public AppendBlobAppendBlockFromUriOptions() => throw null;
                    public Azure.Storage.Blobs.Models.AppendBlobRequestConditions DestinationConditions { get => throw null; set { } }
                    public Azure.HttpAuthorization SourceAuthentication { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.AppendBlobRequestConditions SourceConditions { get => throw null; set { } }
                    public byte[] SourceContentHash { get => throw null; set { } }
                    public Azure.HttpRange SourceRange { get => throw null; set { } }
                }
                public class AppendBlobAppendBlockOptions
                {
                    public Azure.Storage.Blobs.Models.AppendBlobRequestConditions Conditions { get => throw null; set { } }
                    public AppendBlobAppendBlockOptions() => throw null;
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class AppendBlobCreateOptions
                {
                    public Azure.Storage.Blobs.Models.AppendBlobRequestConditions Conditions { get => throw null; set { } }
                    public AppendBlobCreateOptions() => throw null;
                    public bool? HasLegalHold { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobHttpHeaders HttpHeaders { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy ImmutabilityPolicy { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                }
                public class AppendBlobOpenWriteOptions
                {
                    public long? BufferSize { get => throw null; set { } }
                    public AppendBlobOpenWriteOptions() => throw null;
                    public Azure.Storage.Blobs.Models.AppendBlobRequestConditions OpenConditions { get => throw null; set { } }
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class AppendBlobRequestConditions : Azure.Storage.Blobs.Models.BlobRequestConditions
                {
                    public AppendBlobRequestConditions() => throw null;
                    public long? IfAppendPositionEqual { get => throw null; set { } }
                    public long? IfMaxSizeLessThanOrEqual { get => throw null; set { } }
                }
                public enum ArchiveStatus
                {
                    RehydratePendingToHot = 0,
                    RehydratePendingToCool = 1,
                    RehydratePendingToCold = 2,
                }
                public class BlobAccessPolicy
                {
                    public BlobAccessPolicy() => throw null;
                    public System.DateTimeOffset ExpiresOn { get => throw null; set { } }
                    public string Permissions { get => throw null; set { } }
                    public System.DateTimeOffset? PolicyExpiresOn { get => throw null; set { } }
                    public System.DateTimeOffset? PolicyStartsOn { get => throw null; set { } }
                    public System.DateTimeOffset StartsOn { get => throw null; set { } }
                }
                public class BlobAnalyticsLogging
                {
                    public BlobAnalyticsLogging() => throw null;
                    public bool Delete { get => throw null; set { } }
                    public bool Read { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRetentionPolicy RetentionPolicy { get => throw null; set { } }
                    public string Version { get => throw null; set { } }
                    public bool Write { get => throw null; set { } }
                }
                public class BlobAppendInfo
                {
                    public string BlobAppendOffset { get => throw null; }
                    public int BlobCommittedBlockCount { get => throw null; }
                    public byte[] ContentCrc64 { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public string EncryptionKeySha256 { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public bool IsServerEncrypted { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                }
                public struct BlobAudience : System.IEquatable<Azure.Storage.Blobs.Models.BlobAudience>
                {
                    public static Azure.Storage.Blobs.Models.BlobAudience CreateBlobServiceAccountAudience(string storageAccountName) => throw null;
                    public BlobAudience(string value) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobAudience DefaultAudience { get => throw null; }
                    public override bool Equals(object obj) => throw null;
                    public bool Equals(Azure.Storage.Blobs.Models.BlobAudience other) => throw null;
                    public override int GetHashCode() => throw null;
                    public static bool operator ==(Azure.Storage.Blobs.Models.BlobAudience left, Azure.Storage.Blobs.Models.BlobAudience right) => throw null;
                    public static implicit operator Azure.Storage.Blobs.Models.BlobAudience(string value) => throw null;
                    public static bool operator !=(Azure.Storage.Blobs.Models.BlobAudience left, Azure.Storage.Blobs.Models.BlobAudience right) => throw null;
                    public override string ToString() => throw null;
                }
                public struct BlobBlock : System.IEquatable<Azure.Storage.Blobs.Models.BlobBlock>
                {
                    public bool Equals(Azure.Storage.Blobs.Models.BlobBlock other) => throw null;
                    public override bool Equals(object obj) => throw null;
                    public override int GetHashCode() => throw null;
                    public string Name { get => throw null; }
                    public int Size { get => throw null; }
                    public long SizeLong { get => throw null; }
                }
                public class BlobContainerAccessPolicy
                {
                    public Azure.Storage.Blobs.Models.PublicAccessType BlobPublicAccess { get => throw null; }
                    public BlobContainerAccessPolicy() => throw null;
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobSignedIdentifier> SignedIdentifiers { get => throw null; }
                }
                public class BlobContainerEncryptionScopeOptions
                {
                    public BlobContainerEncryptionScopeOptions() => throw null;
                    public string DefaultEncryptionScope { get => throw null; set { } }
                    public bool PreventEncryptionScopeOverride { get => throw null; set { } }
                }
                public class BlobContainerInfo
                {
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                }
                public class BlobContainerItem
                {
                    public bool? IsDeleted { get => throw null; }
                    public string Name { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobContainerProperties Properties { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                public class BlobContainerProperties
                {
                    public string DefaultEncryptionScope { get => throw null; }
                    public System.DateTimeOffset? DeletedOn { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public bool? HasImmutabilityPolicy { get => throw null; }
                    public bool HasImmutableStorageWithVersioning { get => throw null; }
                    public bool? HasLegalHold { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseDurationType? LeaseDuration { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseState? LeaseState { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseStatus? LeaseStatus { get => throw null; }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                    public bool? PreventEncryptionScopeOverride { get => throw null; }
                    public Azure.Storage.Blobs.Models.PublicAccessType? PublicAccess { get => throw null; }
                    public int? RemainingRetentionDays { get => throw null; }
                }
                [System.Flags]
                public enum BlobContainerStates
                {
                    None = 0,
                    Deleted = 1,
                    System = 2,
                }
                [System.Flags]
                public enum BlobContainerTraits
                {
                    None = 0,
                    Metadata = 1,
                }
                public class BlobContentInfo
                {
                    public long BlobSequenceNumber { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public string EncryptionKeySha256 { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                public class BlobCopyFromUriOptions
                {
                    public Azure.Storage.Blobs.Models.AccessTier? AccessTier { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobCopySourceTagsMode? CopySourceTagsMode { get => throw null; set { } }
                    public BlobCopyFromUriOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobRequestConditions DestinationConditions { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy DestinationImmutabilityPolicy { get => throw null; set { } }
                    public bool? LegalHold { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.RehydratePriority? RehydratePriority { get => throw null; set { } }
                    public bool? ShouldSealDestination { get => throw null; set { } }
                    public Azure.HttpAuthorization SourceAuthentication { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRequestConditions SourceConditions { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                }
                public class BlobCopyInfo
                {
                    public string CopyId { get => throw null; }
                    public Azure.Storage.Blobs.Models.CopyStatus CopyStatus { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                public enum BlobCopySourceTagsMode
                {
                    Replace = 0,
                    Copy = 1,
                }
                public class BlobCorsRule
                {
                    public string AllowedHeaders { get => throw null; set { } }
                    public string AllowedMethods { get => throw null; set { } }
                    public string AllowedOrigins { get => throw null; set { } }
                    public BlobCorsRule() => throw null;
                    public string ExposedHeaders { get => throw null; set { } }
                    public int MaxAgeInSeconds { get => throw null; set { } }
                }
                public class BlobDownloadDetails
                {
                    public string AcceptRanges { get => throw null; }
                    public int BlobCommittedBlockCount { get => throw null; }
                    public byte[] BlobContentHash { get => throw null; }
                    public long BlobSequenceNumber { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobType BlobType { get => throw null; }
                    public string CacheControl { get => throw null; }
                    public string ContentDisposition { get => throw null; }
                    public string ContentEncoding { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public string ContentLanguage { get => throw null; }
                    public long ContentLength { get => throw null; }
                    public string ContentRange { get => throw null; }
                    public string ContentType { get => throw null; }
                    public System.DateTimeOffset CopyCompletedOn { get => throw null; }
                    public string CopyId { get => throw null; }
                    public string CopyProgress { get => throw null; }
                    public System.Uri CopySource { get => throw null; }
                    public Azure.Storage.Blobs.Models.CopyStatus CopyStatus { get => throw null; }
                    public string CopyStatusDescription { get => throw null; }
                    public System.DateTimeOffset CreatedOn { get => throw null; }
                    public BlobDownloadDetails() => throw null;
                    public string EncryptionKeySha256 { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public bool HasLegalHold { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy ImmutabilityPolicy { get => throw null; }
                    public bool IsSealed { get => throw null; }
                    public bool IsServerEncrypted { get => throw null; }
                    public System.DateTimeOffset LastAccessed { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseDurationType LeaseDuration { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseState LeaseState { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseStatus LeaseStatus { get => throw null; }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                    public string ObjectReplicationDestinationPolicyId { get => throw null; }
                    public System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> ObjectReplicationSourceProperties { get => throw null; }
                    public long TagCount { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                public class BlobDownloadInfo : System.IDisposable
                {
                    public Azure.Storage.Blobs.Models.BlobType BlobType { get => throw null; }
                    public System.IO.Stream Content { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public long ContentLength { get => throw null; }
                    public string ContentType { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobDownloadDetails Details { get => throw null; }
                    public void Dispose() => throw null;
                }
                public class BlobDownloadOptions
                {
                    public Azure.Storage.Blobs.Models.BlobRequestConditions Conditions { get => throw null; set { } }
                    public BlobDownloadOptions() => throw null;
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public Azure.HttpRange Range { get => throw null; set { } }
                    public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class BlobDownloadResult
                {
                    public System.BinaryData Content { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobDownloadDetails Details { get => throw null; }
                }
                public class BlobDownloadStreamingResult : System.IDisposable
                {
                    public System.IO.Stream Content { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobDownloadDetails Details { get => throw null; }
                    public void Dispose() => throw null;
                }
                public class BlobDownloadToOptions
                {
                    public Azure.Storage.Blobs.Models.BlobRequestConditions Conditions { get => throw null; set { } }
                    public BlobDownloadToOptions() => throw null;
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public Azure.Storage.StorageTransferOptions TransferOptions { get => throw null; set { } }
                    public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public struct BlobErrorCode : System.IEquatable<Azure.Storage.Blobs.Models.BlobErrorCode>
                {
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AccountAlreadyExists { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AccountBeingCreated { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AccountIsDisabled { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AppendPositionConditionNotMet { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AuthenticationFailed { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AuthorizationFailure { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AuthorizationPermissionMismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AuthorizationProtocolMismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AuthorizationResourceTypeMismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AuthorizationServiceMismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode AuthorizationSourceIPMismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobAlreadyExists { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobArchived { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobBeingRehydrated { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobImmutableDueToPolicy { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobNotArchived { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobNotFound { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobOverwritten { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobTierInadequateForContentLength { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlobUsesCustomerSpecifiedEncryption { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlockCountExceedsLimit { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode BlockListTooLong { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode CannotChangeToLowerTier { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode CannotVerifyCopySource { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ConditionHeadersNotSupported { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ConditionNotMet { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ContainerAlreadyExists { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ContainerBeingDeleted { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ContainerDisabled { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ContainerNotFound { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ContentLengthLargerThanTierLimit { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode CopyAcrossAccountsNotSupported { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode CopyIdMismatch { get => throw null; }
                    public BlobErrorCode(string value) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobErrorCode EmptyMetadataKey { get => throw null; }
                    public override bool Equals(object obj) => throw null;
                    public bool Equals(Azure.Storage.Blobs.Models.BlobErrorCode other) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobErrorCode FeatureVersionMismatch { get => throw null; }
                    public override int GetHashCode() => throw null;
                    public static Azure.Storage.Blobs.Models.BlobErrorCode IncrementalCopyBlobMismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode IncrementalCopyOfEarlierVersionSnapshotNotAllowed { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode IncrementalCopyOfEralierVersionSnapshotNotAllowed { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode IncrementalCopySourceMustBeSnapshot { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InfiniteLeaseDurationRequired { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InsufficientAccountPermissions { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InternalError { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidAuthenticationInfo { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidBlobOrBlock { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidBlobTier { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidBlobType { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidBlockId { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidBlockList { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidHeaderValue { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidHttpVerb { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidInput { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidMd5 { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidMetadata { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidPageRange { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidQueryParameterValue { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidRange { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidResourceName { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidSourceBlobType { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidSourceBlobUrl { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidUri { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidVersionForPageBlobOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidXmlDocument { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode InvalidXmlNodeValue { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseAlreadyBroken { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseAlreadyPresent { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseIdMismatchWithBlobOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseIdMismatchWithContainerOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseIdMismatchWithLeaseOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseIdMissing { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseIsBreakingAndCannotBeAcquired { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseIsBreakingAndCannotBeChanged { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseIsBrokenAndCannotBeRenewed { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseLost { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseNotPresentWithBlobOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseNotPresentWithContainerOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode LeaseNotPresentWithLeaseOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode MaxBlobSizeConditionNotMet { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode Md5Mismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode MetadataTooLarge { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode MissingContentLengthHeader { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode MissingRequiredHeader { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode MissingRequiredQueryParameter { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode MissingRequiredXmlNode { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode MultipleConditionHeadersNotSupported { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode NoAuthenticationInformation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode NoPendingCopyOperation { get => throw null; }
                    public static bool operator ==(Azure.Storage.Blobs.Models.BlobErrorCode left, Azure.Storage.Blobs.Models.BlobErrorCode right) => throw null;
                    public static implicit operator Azure.Storage.Blobs.Models.BlobErrorCode(string value) => throw null;
                    public static bool operator !=(Azure.Storage.Blobs.Models.BlobErrorCode left, Azure.Storage.Blobs.Models.BlobErrorCode right) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobErrorCode OperationNotAllowedOnIncrementalCopyBlob { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode OperationTimedOut { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode OutOfRangeInput { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode OutOfRangeQueryParameterValue { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode PendingCopyOperation { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode PreviousSnapshotCannotBeNewer { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode PreviousSnapshotNotFound { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode PreviousSnapshotOperationNotSupported { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode RequestBodyTooLarge { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode RequestUrlFailedToParse { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ResourceAlreadyExists { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ResourceNotFound { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ResourceTypeMismatch { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SequenceNumberConditionNotMet { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SequenceNumberIncrementTooLarge { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode ServerBusy { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SnaphotOperationRateExceeded { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SnapshotCountExceeded { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SnapshotOperationRateExceeded { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SnapshotsPresent { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SourceConditionNotMet { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode SystemInUse { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode TargetConditionNotMet { get => throw null; }
                    public override string ToString() => throw null;
                    public static Azure.Storage.Blobs.Models.BlobErrorCode UnauthorizedBlobOverwrite { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode UnsupportedHeader { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode UnsupportedHttpVerb { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode UnsupportedQueryParameter { get => throw null; }
                    public static Azure.Storage.Blobs.Models.BlobErrorCode UnsupportedXmlNode { get => throw null; }
                }
                public class BlobGeoReplication
                {
                    public System.DateTimeOffset? LastSyncedOn { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobGeoReplicationStatus Status { get => throw null; }
                }
                public enum BlobGeoReplicationStatus
                {
                    Live = 0,
                    Bootstrap = 1,
                    Unavailable = 2,
                }
                public class BlobHierarchyItem
                {
                    public Azure.Storage.Blobs.Models.BlobItem Blob { get => throw null; }
                    public bool IsBlob { get => throw null; }
                    public bool IsPrefix { get => throw null; }
                    public string Prefix { get => throw null; }
                }
                public class BlobHttpHeaders
                {
                    public string CacheControl { get => throw null; set { } }
                    public string ContentDisposition { get => throw null; set { } }
                    public string ContentEncoding { get => throw null; set { } }
                    public byte[] ContentHash { get => throw null; set { } }
                    public string ContentLanguage { get => throw null; set { } }
                    public string ContentType { get => throw null; set { } }
                    public BlobHttpHeaders() => throw null;
                    public override bool Equals(object obj) => throw null;
                    public override int GetHashCode() => throw null;
                    public override string ToString() => throw null;
                }
                public class BlobImmutabilityPolicy
                {
                    public BlobImmutabilityPolicy() => throw null;
                    public System.DateTimeOffset? ExpiresOn { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicyMode? PolicyMode { get => throw null; set { } }
                }
                public enum BlobImmutabilityPolicyMode
                {
                    Mutable = 0,
                    Unlocked = 1,
                    Locked = 2,
                }
                public class BlobInfo
                {
                    public long BlobSequenceNumber { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                public class BlobItem
                {
                    public bool Deleted { get => throw null; }
                    public bool? HasVersionsOnly { get => throw null; }
                    public bool? IsLatestVersion { get => throw null; }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                    public string Name { get => throw null; }
                    public System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> ObjectReplicationSourceProperties { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobItemProperties Properties { get => throw null; }
                    public string Snapshot { get => throw null; }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                public class BlobItemProperties
                {
                    public Azure.Storage.Blobs.Models.AccessTier? AccessTier { get => throw null; }
                    public System.DateTimeOffset? AccessTierChangedOn { get => throw null; }
                    public bool AccessTierInferred { get => throw null; }
                    public Azure.Storage.Blobs.Models.ArchiveStatus? ArchiveStatus { get => throw null; }
                    public long? BlobSequenceNumber { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobType? BlobType { get => throw null; }
                    public string CacheControl { get => throw null; }
                    public string ContentDisposition { get => throw null; }
                    public string ContentEncoding { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public string ContentLanguage { get => throw null; }
                    public long? ContentLength { get => throw null; }
                    public string ContentType { get => throw null; }
                    public System.DateTimeOffset? CopyCompletedOn { get => throw null; }
                    public string CopyId { get => throw null; }
                    public string CopyProgress { get => throw null; }
                    public System.Uri CopySource { get => throw null; }
                    public Azure.Storage.Blobs.Models.CopyStatus? CopyStatus { get => throw null; }
                    public string CopyStatusDescription { get => throw null; }
                    public System.DateTimeOffset? CreatedOn { get => throw null; }
                    public string CustomerProvidedKeySha256 { get => throw null; }
                    public System.DateTimeOffset? DeletedOn { get => throw null; }
                    public string DestinationSnapshot { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                    public Azure.ETag? ETag { get => throw null; }
                    public System.DateTimeOffset? ExpiresOn { get => throw null; }
                    public bool HasLegalHold { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy ImmutabilityPolicy { get => throw null; }
                    public bool? IncrementalCopy { get => throw null; }
                    public bool? IsSealed { get => throw null; }
                    public System.DateTimeOffset? LastAccessedOn { get => throw null; }
                    public System.DateTimeOffset? LastModified { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseDurationType? LeaseDuration { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseState? LeaseState { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseStatus? LeaseStatus { get => throw null; }
                    public Azure.Storage.Blobs.Models.RehydratePriority? RehydratePriority { get => throw null; }
                    public int? RemainingRetentionDays { get => throw null; }
                    public bool? ServerEncrypted { get => throw null; }
                    public long? TagCount { get => throw null; }
                }
                public class BlobLease
                {
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public string LeaseId { get => throw null; }
                    public int? LeaseTime { get => throw null; }
                }
                public class BlobLeaseRequestConditions : Azure.RequestConditions
                {
                    public BlobLeaseRequestConditions() => throw null;
                    public string TagConditions { get => throw null; set { } }
                }
                public class BlobLegalHoldResult
                {
                    public BlobLegalHoldResult() => throw null;
                    public bool HasLegalHold { get => throw null; }
                }
                public class BlobMetrics
                {
                    public BlobMetrics() => throw null;
                    public bool Enabled { get => throw null; set { } }
                    public bool? IncludeApis { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRetentionPolicy RetentionPolicy { get => throw null; set { } }
                    public string Version { get => throw null; set { } }
                }
                public class BlobOpenReadOptions
                {
                    public int? BufferSize { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRequestConditions Conditions { get => throw null; set { } }
                    public BlobOpenReadOptions(bool allowModifications) => throw null;
                    public long Position { get => throw null; set { } }
                    public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class BlobOpenWriteOptions
                {
                    public long? BufferSize { get => throw null; set { } }
                    public BlobOpenWriteOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobHttpHeaders HttpHeaders { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRequestConditions OpenConditions { get => throw null; set { } }
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class BlobProperties
                {
                    public string AcceptRanges { get => throw null; }
                    public string AccessTier { get => throw null; }
                    public System.DateTimeOffset AccessTierChangedOn { get => throw null; }
                    public bool AccessTierInferred { get => throw null; }
                    public string ArchiveStatus { get => throw null; }
                    public int BlobCommittedBlockCount { get => throw null; }
                    public Azure.Storage.Blobs.Models.CopyStatus? BlobCopyStatus { get => throw null; }
                    public long BlobSequenceNumber { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobType BlobType { get => throw null; }
                    public string CacheControl { get => throw null; }
                    public string ContentDisposition { get => throw null; }
                    public string ContentEncoding { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public string ContentLanguage { get => throw null; }
                    public long ContentLength { get => throw null; }
                    public string ContentType { get => throw null; }
                    public System.DateTimeOffset CopyCompletedOn { get => throw null; }
                    public string CopyId { get => throw null; }
                    public string CopyProgress { get => throw null; }
                    public System.Uri CopySource { get => throw null; }
                    public Azure.Storage.Blobs.Models.CopyStatus CopyStatus { get => throw null; }
                    public string CopyStatusDescription { get => throw null; }
                    public System.DateTimeOffset CreatedOn { get => throw null; }
                    public BlobProperties() => throw null;
                    public string DestinationSnapshot { get => throw null; }
                    public string EncryptionKeySha256 { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset ExpiresOn { get => throw null; }
                    public bool HasLegalHold { get => throw null; }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy ImmutabilityPolicy { get => throw null; }
                    public bool IsIncrementalCopy { get => throw null; }
                    public bool IsLatestVersion { get => throw null; }
                    public bool IsSealed { get => throw null; }
                    public bool IsServerEncrypted { get => throw null; }
                    public System.DateTimeOffset LastAccessed { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseDurationType LeaseDuration { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseState LeaseState { get => throw null; }
                    public Azure.Storage.Blobs.Models.LeaseStatus LeaseStatus { get => throw null; }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                    public string ObjectReplicationDestinationPolicyId { get => throw null; }
                    public System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> ObjectReplicationSourceProperties { get => throw null; }
                    public string RehydratePriority { get => throw null; }
                    public long TagCount { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                public class BlobQueryArrowField
                {
                    public BlobQueryArrowField() => throw null;
                    public string Name { get => throw null; set { } }
                    public int Precision { get => throw null; set { } }
                    public int Scale { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobQueryArrowFieldType Type { get => throw null; set { } }
                }
                public enum BlobQueryArrowFieldType
                {
                    Int64 = 0,
                    Bool = 1,
                    Timestamp = 2,
                    String = 3,
                    Double = 4,
                    Decimal = 5,
                }
                public class BlobQueryArrowOptions : Azure.Storage.Blobs.Models.BlobQueryTextOptions
                {
                    public BlobQueryArrowOptions() => throw null;
                    public System.Collections.Generic.IList<Azure.Storage.Blobs.Models.BlobQueryArrowField> Schema { get => throw null; set { } }
                }
                public class BlobQueryCsvTextOptions : Azure.Storage.Blobs.Models.BlobQueryTextOptions
                {
                    public string ColumnSeparator { get => throw null; set { } }
                    public BlobQueryCsvTextOptions() => throw null;
                    public char? EscapeCharacter { get => throw null; set { } }
                    public bool HasHeaders { get => throw null; set { } }
                    public char? QuotationCharacter { get => throw null; set { } }
                    public string RecordSeparator { get => throw null; set { } }
                }
                public class BlobQueryError
                {
                    public string Description { get => throw null; }
                    public bool IsFatal { get => throw null; }
                    public string Name { get => throw null; }
                    public long Position { get => throw null; }
                }
                public class BlobQueryJsonTextOptions : Azure.Storage.Blobs.Models.BlobQueryTextOptions
                {
                    public BlobQueryJsonTextOptions() => throw null;
                    public string RecordSeparator { get => throw null; set { } }
                }
                public class BlobQueryOptions
                {
                    public Azure.Storage.Blobs.Models.BlobRequestConditions Conditions { get => throw null; set { } }
                    public BlobQueryOptions() => throw null;
                    public event System.Action<Azure.Storage.Blobs.Models.BlobQueryError> ErrorHandler;
                    public Azure.Storage.Blobs.Models.BlobQueryTextOptions InputTextConfiguration { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobQueryTextOptions OutputTextConfiguration { get => throw null; set { } }
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                }
                public class BlobQueryParquetTextOptions : Azure.Storage.Blobs.Models.BlobQueryTextOptions
                {
                    public BlobQueryParquetTextOptions() => throw null;
                }
                public abstract class BlobQueryTextOptions
                {
                    protected BlobQueryTextOptions() => throw null;
                }
                public class BlobRequestConditions : Azure.Storage.Blobs.Models.BlobLeaseRequestConditions
                {
                    public BlobRequestConditions() => throw null;
                    public string LeaseId { get => throw null; set { } }
                    public override string ToString() => throw null;
                }
                public class BlobRetentionPolicy
                {
                    public BlobRetentionPolicy() => throw null;
                    public int? Days { get => throw null; set { } }
                    public bool Enabled { get => throw null; set { } }
                }
                public class BlobServiceProperties
                {
                    public System.Collections.Generic.IList<Azure.Storage.Blobs.Models.BlobCorsRule> Cors { get => throw null; set { } }
                    public BlobServiceProperties() => throw null;
                    public string DefaultServiceVersion { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRetentionPolicy DeleteRetentionPolicy { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobMetrics HourMetrics { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobAnalyticsLogging Logging { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobMetrics MinuteMetrics { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobStaticWebsite StaticWebsite { get => throw null; set { } }
                }
                public class BlobServiceStatistics
                {
                    public Azure.Storage.Blobs.Models.BlobGeoReplication GeoReplication { get => throw null; }
                }
                public class BlobSignedIdentifier
                {
                    public Azure.Storage.Blobs.Models.BlobAccessPolicy AccessPolicy { get => throw null; set { } }
                    public BlobSignedIdentifier() => throw null;
                    public string Id { get => throw null; set { } }
                }
                public static class BlobsModelFactory
                {
                    public static Azure.Storage.Blobs.Models.AccountInfo AccountInfo(Azure.Storage.Blobs.Models.SkuName skuName, Azure.Storage.Blobs.Models.AccountKind accountKind, bool isHierarchicalNamespaceEnabled) => throw null;
                    public static Azure.Storage.Blobs.Models.AccountInfo AccountInfo(Azure.Storage.Blobs.Models.SkuName skuName, Azure.Storage.Blobs.Models.AccountKind accountKind) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobAppendInfo BlobAppendInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, byte[] contentCrc64, string blobAppendOffset, int blobCommittedBlockCount, bool isServerEncrypted, string encryptionKeySha256, string encryptionScope) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobAppendInfo BlobAppendInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, byte[] contentCrc64, string blobAppendOffset, int blobCommittedBlockCount, bool isServerEncrypted, string encryptionKeySha256) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobBlock BlobBlock(string name, int size) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobBlock BlobBlock(string name, long size) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerAccessPolicy BlobContainerAccessPolicy(Azure.Storage.Blobs.Models.PublicAccessType blobPublicAccess, Azure.ETag eTag, System.DateTimeOffset lastModified, System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobSignedIdentifier> signedIdentifiers) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerInfo BlobContainerInfo(Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerItem BlobContainerItem(string name, Azure.Storage.Blobs.Models.BlobContainerProperties properties, bool? isDeleted = default(bool?), string versionId = default(string)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerItem BlobContainerItem(string name, Azure.Storage.Blobs.Models.BlobContainerProperties properties) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerProperties BlobContainerProperties(System.DateTimeOffset lastModified, Azure.ETag eTag, Azure.Storage.Blobs.Models.LeaseState? leaseState = default(Azure.Storage.Blobs.Models.LeaseState?), Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration = default(Azure.Storage.Blobs.Models.LeaseDurationType?), Azure.Storage.Blobs.Models.PublicAccessType? publicAccess = default(Azure.Storage.Blobs.Models.PublicAccessType?), bool? hasImmutabilityPolicy = default(bool?), Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus = default(Azure.Storage.Blobs.Models.LeaseStatus?), string defaultEncryptionScope = default(string), bool? preventEncryptionScopeOverride = default(bool?), System.DateTimeOffset? deletedOn = default(System.DateTimeOffset?), int? remainingRetentionDays = default(int?), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), bool? hasLegalHold = default(bool?)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerProperties BlobContainerProperties(System.DateTimeOffset lastModified, Azure.ETag eTag, Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus, Azure.Storage.Blobs.Models.LeaseState? leaseState, Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration, Azure.Storage.Blobs.Models.PublicAccessType? publicAccess, bool? hasImmutabilityPolicy, bool? hasLegalHold, System.Collections.Generic.IDictionary<string, string> metadata) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerProperties BlobContainerProperties(System.DateTimeOffset lastModified, Azure.ETag eTag, Azure.Storage.Blobs.Models.LeaseState? leaseState, Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration, Azure.Storage.Blobs.Models.PublicAccessType? publicAccess, bool? hasImmutabilityPolicy, Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus, string defaultEncryptionScope, bool? preventEncryptionScopeOverride, System.Collections.Generic.IDictionary<string, string> metadata, bool? hasLegalHold) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContainerProperties BlobContainerProperties(System.DateTimeOffset lastModified, Azure.ETag eTag, Azure.Storage.Blobs.Models.LeaseState? leaseState, Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration, Azure.Storage.Blobs.Models.PublicAccessType? publicAccess, Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus, bool? hasLegalHold, string defaultEncryptionScope, bool? preventEncryptionScopeOverride, System.Collections.Generic.IDictionary<string, string> metadata, bool? hasImmutabilityPolicy) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContentInfo BlobContentInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, string versionId, string encryptionKeySha256, string encryptionScope, long blobSequenceNumber) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContentInfo BlobContentInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, string encryptionKeySha256, string encryptionScope, long blobSequenceNumber) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobContentInfo BlobContentInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, string encryptionKeySha256, long blobSequenceNumber) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobCopyInfo BlobCopyInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, string versionId, string copyId, Azure.Storage.Blobs.Models.CopyStatus copyStatus) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobCopyInfo BlobCopyInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, string copyId, Azure.Storage.Blobs.Models.CopyStatus copyStatus) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadDetails BlobDownloadDetails(Azure.Storage.Blobs.Models.BlobType blobType, long contentLength, string contentType, byte[] contentHash, System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentRange, string contentEncoding, string cacheControl, string contentDisposition, string contentLanguage, long blobSequenceNumber, System.DateTimeOffset copyCompletedOn, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Blobs.Models.CopyStatus copyStatus, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, Azure.Storage.Blobs.Models.LeaseState leaseState, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, string acceptRanges, int blobCommittedBlockCount, bool isServerEncrypted, string encryptionKeySha256, string encryptionScope, byte[] blobContentHash, long tagCount, string versionId, bool isSealed, System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourceProperties, string objectReplicationDestinationPolicy, bool hasLegalHold, System.DateTimeOffset createdOn) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadDetails BlobDownloadDetails(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentRange, string contentEncoding, string cacheControl, string contentDisposition, string contentLanguage, long blobSequenceNumber, System.DateTimeOffset copyCompletedOn, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Blobs.Models.CopyStatus copyStatus, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, Azure.Storage.Blobs.Models.LeaseState leaseState, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, string acceptRanges, int blobCommittedBlockCount, bool isServerEncrypted, string encryptionKeySha256, string encryptionScope, byte[] blobContentHash, long tagCount, string versionId, bool isSealed, System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourceProperties, string objectReplicationDestinationPolicy) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadDetails BlobDownloadDetails(Azure.Storage.Blobs.Models.BlobType blobType, long contentLength, string contentType, byte[] contentHash, System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentRange, string contentEncoding, string cacheControl, string contentDisposition, string contentLanguage, long blobSequenceNumber, System.DateTimeOffset copyCompletedOn, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Blobs.Models.CopyStatus copyStatus, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, Azure.Storage.Blobs.Models.LeaseState leaseState, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, string acceptRanges, int blobCommittedBlockCount, bool isServerEncrypted, string encryptionKeySha256, string encryptionScope, byte[] blobContentHash, long tagCount, string versionId, bool isSealed, System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourceProperties, string objectReplicationDestinationPolicy) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadInfo BlobDownloadInfo(System.DateTimeOffset lastModified = default(System.DateTimeOffset), long blobSequenceNumber = default(long), Azure.Storage.Blobs.Models.BlobType blobType = default(Azure.Storage.Blobs.Models.BlobType), byte[] contentCrc64 = default(byte[]), string contentLanguage = default(string), string copyStatusDescription = default(string), string copyId = default(string), string copyProgress = default(string), System.Uri copySource = default(System.Uri), Azure.Storage.Blobs.Models.CopyStatus copyStatus = default(Azure.Storage.Blobs.Models.CopyStatus), string contentDisposition = default(string), Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration = default(Azure.Storage.Blobs.Models.LeaseDurationType), string cacheControl = default(string), Azure.Storage.Blobs.Models.LeaseState leaseState = default(Azure.Storage.Blobs.Models.LeaseState), string contentEncoding = default(string), Azure.Storage.Blobs.Models.LeaseStatus leaseStatus = default(Azure.Storage.Blobs.Models.LeaseStatus), byte[] contentHash = default(byte[]), string acceptRanges = default(string), Azure.ETag eTag = default(Azure.ETag), int blobCommittedBlockCount = default(int), string contentRange = default(string), bool isServerEncrypted = default(bool), string contentType = default(string), string encryptionKeySha256 = default(string), string encryptionScope = default(string), long contentLength = default(long), byte[] blobContentHash = default(byte[]), string versionId = default(string), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.IO.Stream content = default(System.IO.Stream), System.DateTimeOffset copyCompletionTime = default(System.DateTimeOffset), long tagCount = default(long), System.DateTimeOffset lastAccessed = default(System.DateTimeOffset)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadInfo BlobDownloadInfo(System.DateTimeOffset lastModified, long blobSequenceNumber, Azure.Storage.Blobs.Models.BlobType blobType, byte[] contentCrc64, string contentLanguage, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Blobs.Models.CopyStatus copyStatus, string contentDisposition, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, string cacheControl, Azure.Storage.Blobs.Models.LeaseState leaseState, string contentEncoding, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, byte[] contentHash, string acceptRanges, Azure.ETag eTag, int blobCommittedBlockCount, string contentRange, bool isServerEncrypted, string contentType, string encryptionKeySha256, string encryptionScope, long contentLength, byte[] blobContentHash, string versionId, System.Collections.Generic.IDictionary<string, string> metadata, System.IO.Stream content, System.DateTimeOffset copyCompletionTime, long tagCount) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadInfo BlobDownloadInfo(System.DateTimeOffset lastModified, long blobSequenceNumber, Azure.Storage.Blobs.Models.BlobType blobType, byte[] contentCrc64, string contentLanguage, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Blobs.Models.CopyStatus copyStatus, string contentDisposition, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, string cacheControl, Azure.Storage.Blobs.Models.LeaseState leaseState, string contentEncoding, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, byte[] contentHash, string acceptRanges, Azure.ETag eTag, int blobCommittedBlockCount, string contentRange, bool isServerEncrypted, string contentType, string encryptionKeySha256, string encryptionScope, long contentLength, byte[] blobContentHash, System.Collections.Generic.IDictionary<string, string> metadata, System.IO.Stream content, System.DateTimeOffset copyCompletionTime) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadInfo BlobDownloadInfo(System.DateTimeOffset lastModified, long blobSequenceNumber, Azure.Storage.Blobs.Models.BlobType blobType, byte[] contentCrc64, string contentLanguage, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Blobs.Models.CopyStatus copyStatus, string contentDisposition, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, string cacheControl, Azure.Storage.Blobs.Models.LeaseState leaseState, string contentEncoding, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, byte[] contentHash, string acceptRanges, Azure.ETag eTag, int blobCommittedBlockCount, string contentRange, bool isServerEncrypted, string contentType, string encryptionKeySha256, long contentLength, byte[] blobContentHash, System.Collections.Generic.IDictionary<string, string> metadata, System.IO.Stream content, System.DateTimeOffset copyCompletionTime) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadResult BlobDownloadResult(System.BinaryData content = default(System.BinaryData), Azure.Storage.Blobs.Models.BlobDownloadDetails details = default(Azure.Storage.Blobs.Models.BlobDownloadDetails)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobDownloadStreamingResult BlobDownloadStreamingResult(System.IO.Stream content = default(System.IO.Stream), Azure.Storage.Blobs.Models.BlobDownloadDetails details = default(Azure.Storage.Blobs.Models.BlobDownloadDetails)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobGeoReplication BlobGeoReplication(Azure.Storage.Blobs.Models.BlobGeoReplicationStatus status, System.DateTimeOffset? lastSyncedOn = default(System.DateTimeOffset?)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobHierarchyItem BlobHierarchyItem(string prefix, Azure.Storage.Blobs.Models.BlobItem blob) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobInfo blobInfo(Azure.ETag eTag = default(Azure.ETag), System.DateTimeOffset lastModifed = default(System.DateTimeOffset), long blobSequenceNumber = default(long), string versionId = default(string)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobInfo BlobInfo(Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobItem BlobItem(string name = default(string), bool deleted = default(bool), Azure.Storage.Blobs.Models.BlobItemProperties properties = default(Azure.Storage.Blobs.Models.BlobItemProperties), string snapshot = default(string), string versionId = default(string), bool? isLatestVersion = default(bool?), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Collections.Generic.IDictionary<string, string> tags = default(System.Collections.Generic.IDictionary<string, string>), System.Collections.Generic.List<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourcePolicies = default(System.Collections.Generic.List<Azure.Storage.Blobs.Models.ObjectReplicationPolicy>), bool? hasVersionsOnly = default(bool?)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobItem BlobItem(string name, bool deleted, Azure.Storage.Blobs.Models.BlobItemProperties properties, string snapshot, string versionId, bool? isLatestVersion, System.Collections.Generic.IDictionary<string, string> metadata, System.Collections.Generic.IDictionary<string, string> tags, System.Collections.Generic.List<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourcePolicies) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobItem BlobItem(string name, bool deleted, Azure.Storage.Blobs.Models.BlobItemProperties properties, string snapshot, System.Collections.Generic.IDictionary<string, string> metadata) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobItemProperties BlobItemProperties(bool accessTierInferred, bool? serverEncrypted = default(bool?), string contentType = default(string), string contentEncoding = default(string), string contentLanguage = default(string), byte[] contentHash = default(byte[]), string contentDisposition = default(string), string cacheControl = default(string), long? blobSequenceNumber = default(long?), Azure.Storage.Blobs.Models.BlobType? blobType = default(Azure.Storage.Blobs.Models.BlobType?), Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus = default(Azure.Storage.Blobs.Models.LeaseStatus?), Azure.Storage.Blobs.Models.LeaseState? leaseState = default(Azure.Storage.Blobs.Models.LeaseState?), Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration = default(Azure.Storage.Blobs.Models.LeaseDurationType?), string copyId = default(string), Azure.Storage.Blobs.Models.CopyStatus? copyStatus = default(Azure.Storage.Blobs.Models.CopyStatus?), System.Uri copySource = default(System.Uri), string copyProgress = default(string), string copyStatusDescription = default(string), long? contentLength = default(long?), bool? incrementalCopy = default(bool?), string destinationSnapshot = default(string), int? remainingRetentionDays = default(int?), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), System.DateTimeOffset? lastModified = default(System.DateTimeOffset?), Azure.Storage.Blobs.Models.ArchiveStatus? archiveStatus = default(Azure.Storage.Blobs.Models.ArchiveStatus?), string customerProvidedKeySha256 = default(string), string encryptionScope = default(string), long? tagCount = default(long?), System.DateTimeOffset? expiresOn = default(System.DateTimeOffset?), bool? isSealed = default(bool?), Azure.Storage.Blobs.Models.RehydratePriority? rehydratePriority = default(Azure.Storage.Blobs.Models.RehydratePriority?), System.DateTimeOffset? lastAccessedOn = default(System.DateTimeOffset?), Azure.ETag? eTag = default(Azure.ETag?), System.DateTimeOffset? createdOn = default(System.DateTimeOffset?), System.DateTimeOffset? copyCompletedOn = default(System.DateTimeOffset?), System.DateTimeOffset? deletedOn = default(System.DateTimeOffset?), System.DateTimeOffset? accessTierChangedOn = default(System.DateTimeOffset?)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobItemProperties BlobItemProperties(bool accessTierInferred, bool? serverEncrypted, string contentType, string contentEncoding, string contentLanguage, byte[] contentHash, string contentDisposition, string cacheControl, long? blobSequenceNumber, Azure.Storage.Blobs.Models.BlobType? blobType, Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus, Azure.Storage.Blobs.Models.LeaseState? leaseState, Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration, string copyId, Azure.Storage.Blobs.Models.CopyStatus? copyStatus, System.Uri copySource, string copyProgress, string copyStatusDescription, long? contentLength, bool? incrementalCopy, string destinationSnapshot, int? remainingRetentionDays, Azure.Storage.Blobs.Models.AccessTier? accessTier, System.DateTimeOffset? lastModified, Azure.Storage.Blobs.Models.ArchiveStatus? archiveStatus, string customerProvidedKeySha256, string encryptionScope, long? tagCount, System.DateTimeOffset? expiresOn, bool? isSealed, Azure.Storage.Blobs.Models.RehydratePriority? rehydratePriority, Azure.ETag? eTag, System.DateTimeOffset? createdOn, System.DateTimeOffset? copyCompletedOn, System.DateTimeOffset? deletedOn, System.DateTimeOffset? accessTierChangedOn) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobItemProperties BlobItemProperties(bool accessTierInferred, string copyProgress, string contentType, string contentEncoding, string contentLanguage, byte[] contentHash, string contentDisposition, string cacheControl, long? blobSequenceNumber, Azure.Storage.Blobs.Models.BlobType? blobType, Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus, Azure.Storage.Blobs.Models.LeaseState? leaseState, Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration, string copyId, Azure.Storage.Blobs.Models.CopyStatus? copyStatus, System.Uri copySource, long? contentLength, string copyStatusDescription, bool? serverEncrypted, bool? incrementalCopy, string destinationSnapshot, int? remainingRetentionDays, Azure.Storage.Blobs.Models.AccessTier? accessTier, System.DateTimeOffset? lastModified, Azure.Storage.Blobs.Models.ArchiveStatus? archiveStatus, string customerProvidedKeySha256, string encryptionScope, Azure.ETag? eTag, System.DateTimeOffset? createdOn, System.DateTimeOffset? copyCompletedOn, System.DateTimeOffset? deletedOn, System.DateTimeOffset? accessTierChangedOn) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobItemProperties BlobItemProperties(bool accessTierInferred, System.Uri copySource, string contentType, string contentEncoding, string contentLanguage, byte[] contentHash, string contentDisposition, string cacheControl, long? blobSequenceNumber, Azure.Storage.Blobs.Models.BlobType? blobType, Azure.Storage.Blobs.Models.LeaseStatus? leaseStatus, Azure.Storage.Blobs.Models.LeaseState? leaseState, Azure.Storage.Blobs.Models.LeaseDurationType? leaseDuration, string copyId, Azure.Storage.Blobs.Models.CopyStatus? copyStatus, long? contentLength, string copyProgress, string copyStatusDescription, bool? serverEncrypted, bool? incrementalCopy, string destinationSnapshot, int? remainingRetentionDays, Azure.Storage.Blobs.Models.AccessTier? accessTier, System.DateTimeOffset? lastModified, Azure.Storage.Blobs.Models.ArchiveStatus? archiveStatus, string customerProvidedKeySha256, Azure.ETag? eTag, System.DateTimeOffset? createdOn, System.DateTimeOffset? copyCompletedOn, System.DateTimeOffset? deletedOn, System.DateTimeOffset? accessTierChangedOn) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobLease BlobLease(Azure.ETag eTag, System.DateTimeOffset lastModified, string leaseId) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobProperties BlobProperties(System.DateTimeOffset lastModified = default(System.DateTimeOffset), Azure.Storage.Blobs.Models.LeaseStatus leaseStatus = default(Azure.Storage.Blobs.Models.LeaseStatus), long contentLength = default(long), string contentType = default(string), Azure.ETag eTag = default(Azure.ETag), Azure.Storage.Blobs.Models.LeaseState leaseState = default(Azure.Storage.Blobs.Models.LeaseState), string contentEncoding = default(string), string contentDisposition = default(string), string contentLanguage = default(string), string cacheControl = default(string), long blobSequenceNumber = default(long), Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration = default(Azure.Storage.Blobs.Models.LeaseDurationType), string acceptRanges = default(string), string destinationSnapshot = default(string), int blobCommittedBlockCount = default(int), bool isIncrementalCopy = default(bool), bool isServerEncrypted = default(bool), Azure.Storage.Blobs.Models.CopyStatus? blobCopyStatus = default(Azure.Storage.Blobs.Models.CopyStatus?), string encryptionKeySha256 = default(string), System.Uri copySource = default(System.Uri), string encryptionScope = default(string), string copyProgress = default(string), string accessTier = default(string), string copyId = default(string), bool accessTierInferred = default(bool), string copyStatusDescription = default(string), string archiveStatus = default(string), System.DateTimeOffset copyCompletedOn = default(System.DateTimeOffset), System.DateTimeOffset accessTierChangedOn = default(System.DateTimeOffset), Azure.Storage.Blobs.Models.BlobType blobType = default(Azure.Storage.Blobs.Models.BlobType), string versionId = default(string), System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourceProperties = default(System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy>), bool isLatestVersion = default(bool), string objectReplicationDestinationPolicyId = default(string), long tagCount = default(long), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.DateTimeOffset expiresOn = default(System.DateTimeOffset), System.DateTimeOffset createdOn = default(System.DateTimeOffset), bool isSealed = default(bool), string rehydratePriority = default(string), byte[] contentHash = default(byte[]), System.DateTimeOffset lastAccessed = default(System.DateTimeOffset), Azure.Storage.Blobs.Models.BlobImmutabilityPolicy immutabilityPolicy = default(Azure.Storage.Blobs.Models.BlobImmutabilityPolicy), bool hasLegalHold = default(bool)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobProperties BlobProperties(System.DateTimeOffset lastModified, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, Azure.Storage.Blobs.Models.LeaseState leaseState, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, long blobSequenceNumber, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, string acceptRanges, string destinationSnapshot, int blobCommittedBlockCount, bool isIncrementalCopy, bool isServerEncrypted, Azure.Storage.Blobs.Models.CopyStatus copyStatus, string encryptionKeySha256, System.Uri copySource, string encryptionScope, string copyProgress, string accessTier, string copyId, bool accessTierInferred, string copyStatusDescription, string archiveStatus, System.DateTimeOffset copyCompletedOn, System.DateTimeOffset accessTierChangedOn, Azure.Storage.Blobs.Models.BlobType blobType, string versionId, System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourceProperties, bool isLatestVersion, string objectReplicationDestinationPolicyId, long tagCount, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset expiresOn, System.DateTimeOffset createdOn, bool isSealed, string rehydratePriority, byte[] contentHash, System.DateTimeOffset lastAccessed, Azure.Storage.Blobs.Models.BlobImmutabilityPolicy immutabilityPolicy, bool hasLegalHold) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobProperties BlobProperties(System.DateTimeOffset lastModified, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, Azure.Storage.Blobs.Models.LeaseState leaseState, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, long blobSequenceNumber, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, string acceptRanges, string destinationSnapshot, int blobCommittedBlockCount, bool isIncrementalCopy, bool isServerEncrypted, Azure.Storage.Blobs.Models.CopyStatus copyStatus, string encryptionKeySha256, System.Uri copySource, string encryptionScope, string copyProgress, string accessTier, string copyId, bool accessTierInferred, string copyStatusDescription, string archiveStatus, System.DateTimeOffset copyCompletedOn, System.DateTimeOffset accessTierChangedOn, Azure.Storage.Blobs.Models.BlobType blobType, string versionId, System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourceProperties, bool isLatestVersion, string objectReplicationDestinationPolicyId, long tagCount, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset expiresOn, System.DateTimeOffset createdOn, bool isSealed, string rehydratePriority, byte[] contentHash, System.DateTimeOffset lastAccessed) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobProperties BlobProperties(System.DateTimeOffset lastModified, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, Azure.Storage.Blobs.Models.LeaseState leaseState, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, long blobSequenceNumber, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, string acceptRanges, string destinationSnapshot, int blobCommittedBlockCount, bool isIncrementalCopy, bool isServerEncrypted, Azure.Storage.Blobs.Models.CopyStatus copyStatus, string encryptionKeySha256, System.Uri copySource, string encryptionScope, string copyProgress, string accessTier, string copyId, bool accessTierInferred, string copyStatusDescription, string archiveStatus, System.DateTimeOffset copyCompletedOn, System.DateTimeOffset accessTierChangedOn, Azure.Storage.Blobs.Models.BlobType blobType, string versionId, System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationPolicy> objectReplicationSourceProperties, bool isLatestVersion, string objectReplicationDestinationPolicyId, long tagCount, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset expiresOn, System.DateTimeOffset createdOn, bool isSealed, string rehydratePriority, byte[] contentHash) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobProperties BlobProperties(System.DateTimeOffset lastModified, Azure.Storage.Blobs.Models.LeaseState leaseState, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, long contentLength, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, Azure.ETag eTag, byte[] contentHash, string contentEncoding, string contentDisposition, string contentLanguage, string destinationSnapshot, string cacheControl, bool isIncrementalCopy, long blobSequenceNumber, Azure.Storage.Blobs.Models.CopyStatus copyStatus, string acceptRanges, System.Uri copySource, int blobCommittedBlockCount, string copyProgress, bool isServerEncrypted, string copyId, string encryptionKeySha256, string copyStatusDescription, string encryptionScope, System.DateTimeOffset copyCompletedOn, string accessTier, Azure.Storage.Blobs.Models.BlobType blobType, bool accessTierInferred, System.Collections.Generic.IDictionary<string, string> metadata, string archiveStatus, System.DateTimeOffset createdOn, System.DateTimeOffset accessTierChangedOn, string contentType) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobProperties BlobProperties(System.DateTimeOffset lastModified, Azure.Storage.Blobs.Models.LeaseDurationType leaseDuration, Azure.Storage.Blobs.Models.LeaseState leaseState, Azure.Storage.Blobs.Models.LeaseStatus leaseStatus, long contentLength, string destinationSnapshot, Azure.ETag eTag, byte[] contentHash, string contentEncoding, string contentDisposition, string contentLanguage, bool isIncrementalCopy, string cacheControl, Azure.Storage.Blobs.Models.CopyStatus copyStatus, long blobSequenceNumber, System.Uri copySource, string acceptRanges, string copyProgress, int blobCommittedBlockCount, string copyId, bool isServerEncrypted, string copyStatusDescription, string encryptionKeySha256, System.DateTimeOffset copyCompletedOn, string accessTier, Azure.Storage.Blobs.Models.BlobType blobType, bool accessTierInferred, System.Collections.Generic.IDictionary<string, string> metadata, string archiveStatus, System.DateTimeOffset createdOn, System.DateTimeOffset accessTierChangedOn, string contentType) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobQueryError BlobQueryError(string name = default(string), string description = default(string), bool isFatal = default(bool), long position = default(long)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobServiceStatistics BlobServiceStatistics(Azure.Storage.Blobs.Models.BlobGeoReplication geoReplication = default(Azure.Storage.Blobs.Models.BlobGeoReplication)) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobSnapshotInfo BlobSnapshotInfo(string snapshot, Azure.ETag eTag, System.DateTimeOffset lastModified, string versionId, bool isServerEncrypted) => throw null;
                    public static Azure.Storage.Blobs.Models.BlobSnapshotInfo BlobSnapshotInfo(string snapshot, Azure.ETag eTag, System.DateTimeOffset lastModified, bool isServerEncrypted) => throw null;
                    public static Azure.Storage.Blobs.Models.BlockInfo BlockInfo(byte[] contentHash, byte[] contentCrc64, string encryptionKeySha256, string encryptionScope) => throw null;
                    public static Azure.Storage.Blobs.Models.BlockInfo BlockInfo(byte[] contentHash, byte[] contentCrc64, string encryptionKeySha256) => throw null;
                    public static Azure.Storage.Blobs.Models.BlockList BlockList(System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobBlock> committedBlocks = default(System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobBlock>), System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobBlock> uncommittedBlocks = default(System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobBlock>)) => throw null;
                    public static Azure.Storage.Blobs.Models.GetBlobTagResult GetBlobTagResult(System.Collections.Generic.IDictionary<string, string> tags) => throw null;
                    public static Azure.Storage.Blobs.Models.ObjectReplicationPolicy ObjectReplicationPolicy(string policyId, System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationRule> rules) => throw null;
                    public static Azure.Storage.Blobs.Models.ObjectReplicationRule ObjectReplicationRule(string ruleId, Azure.Storage.Blobs.Models.ObjectReplicationStatus replicationStatus) => throw null;
                    public static Azure.Storage.Blobs.Models.PageBlobInfo PageBlobInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, long blobSequenceNumber) => throw null;
                    public static Azure.Storage.Blobs.Models.PageInfo PageInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, byte[] contentCrc64, long blobSequenceNumber, string encryptionKeySha256, string encryptionScope) => throw null;
                    public static Azure.Storage.Blobs.Models.PageInfo PageInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, byte[] contentCrc64, long blobSequenceNumber, string encryptionKeySha256) => throw null;
                    public static Azure.Storage.Blobs.Models.PageRangesInfo PageRangesInfo(System.DateTimeOffset lastModified, Azure.ETag eTag, long blobContentLength, System.Collections.Generic.IEnumerable<Azure.HttpRange> pageRanges, System.Collections.Generic.IEnumerable<Azure.HttpRange> clearRanges) => throw null;
                    public static Azure.Storage.Blobs.Models.TaggedBlobItem TaggedBlobItem(string blobName = default(string), string blobContainerName = default(string), System.Collections.Generic.IDictionary<string, string> tags = default(System.Collections.Generic.IDictionary<string, string>)) => throw null;
                    public static Azure.Storage.Blobs.Models.TaggedBlobItem TaggedBlobItem(string blobName = default(string), string blobContainerName = default(string)) => throw null;
                    public static Azure.Storage.Blobs.Models.UserDelegationKey UserDelegationKey(string signedObjectId = default(string), string signedTenantId = default(string), System.DateTimeOffset signedStartsOn = default(System.DateTimeOffset), System.DateTimeOffset signedExpiresOn = default(System.DateTimeOffset), string signedService = default(string), string signedVersion = default(string), string value = default(string)) => throw null;
                    public static Azure.Storage.Blobs.Models.UserDelegationKey UserDelegationKey(string signedObjectId, string signedTenantId, string signedService, string signedVersion, string value, System.DateTimeOffset signedExpiresOn, System.DateTimeOffset signedStartsOn) => throw null;
                }
                public class BlobSnapshotInfo
                {
                    public Azure.ETag ETag { get => throw null; }
                    public bool IsServerEncrypted { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public string Snapshot { get => throw null; }
                    public string VersionId { get => throw null; }
                }
                [System.Flags]
                public enum BlobStates
                {
                    None = 0,
                    Snapshots = 1,
                    Uncommitted = 2,
                    Deleted = 4,
                    Version = 8,
                    DeletedWithVersions = 16,
                    All = -1,
                }
                public class BlobStaticWebsite
                {
                    public BlobStaticWebsite() => throw null;
                    public string DefaultIndexDocumentPath { get => throw null; set { } }
                    public bool Enabled { get => throw null; set { } }
                    public string ErrorDocument404Path { get => throw null; set { } }
                    public string IndexDocument { get => throw null; set { } }
                }
                public class BlobSyncUploadFromUriOptions
                {
                    public Azure.Storage.Blobs.Models.AccessTier? AccessTier { get => throw null; set { } }
                    public byte[] ContentHash { get => throw null; set { } }
                    public bool? CopySourceBlobProperties { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobCopySourceTagsMode? CopySourceTagsMode { get => throw null; set { } }
                    public BlobSyncUploadFromUriOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobRequestConditions DestinationConditions { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobHttpHeaders HttpHeaders { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public Azure.HttpAuthorization SourceAuthentication { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRequestConditions SourceConditions { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                }
                [System.Flags]
                public enum BlobTraits
                {
                    None = 0,
                    CopyStatus = 1,
                    Metadata = 2,
                    Tags = 4,
                    ImmutabilityPolicy = 8,
                    LegalHold = 16,
                    All = -1,
                }
                public enum BlobType
                {
                    Block = 0,
                    Page = 1,
                    Append = 2,
                }
                public class BlobUploadOptions
                {
                    public Azure.Storage.Blobs.Models.AccessTier? AccessTier { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRequestConditions Conditions { get => throw null; set { } }
                    public BlobUploadOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobHttpHeaders HttpHeaders { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy ImmutabilityPolicy { get => throw null; set { } }
                    public bool? LegalHold { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                    public Azure.Storage.StorageTransferOptions TransferOptions { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class BlockBlobOpenWriteOptions
                {
                    public long? BufferSize { get => throw null; set { } }
                    public BlockBlobOpenWriteOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobHttpHeaders HttpHeaders { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRequestConditions OpenConditions { get => throw null; set { } }
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class BlockBlobStageBlockOptions
                {
                    public Azure.Storage.Blobs.Models.BlobRequestConditions Conditions { get => throw null; set { } }
                    public BlockBlobStageBlockOptions() => throw null;
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class BlockInfo
                {
                    public byte[] ContentCrc64 { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public string EncryptionKeySha256 { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                }
                public class BlockList
                {
                    public long BlobContentLength { get => throw null; }
                    public System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobBlock> CommittedBlocks { get => throw null; }
                    public string ContentType { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public System.Collections.Generic.IEnumerable<Azure.Storage.Blobs.Models.BlobBlock> UncommittedBlocks { get => throw null; }
                }
                [System.Flags]
                public enum BlockListTypes
                {
                    All = 3,
                    Committed = 1,
                    Uncommitted = 2,
                }
                public class CommitBlockListOptions
                {
                    public Azure.Storage.Blobs.Models.AccessTier? AccessTier { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobRequestConditions Conditions { get => throw null; set { } }
                    public CommitBlockListOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobHttpHeaders HttpHeaders { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy ImmutabilityPolicy { get => throw null; set { } }
                    public bool? LegalHold { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                }
                public class CopyFromUriOperation : Azure.Operation<long>
                {
                    protected CopyFromUriOperation() => throw null;
                    public CopyFromUriOperation(string id, Azure.Storage.Blobs.Specialized.BlobBaseClient client) => throw null;
                    public override Azure.Response GetRawResponse() => throw null;
                    public override bool HasCompleted { get => throw null; }
                    public override bool HasValue { get => throw null; }
                    public override string Id { get => throw null; }
                    public override Azure.Response UpdateStatus(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.ValueTask<Azure.Response> UpdateStatusAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override long Value { get => throw null; }
                    public override System.Threading.Tasks.ValueTask<Azure.Response<long>> WaitForCompletionAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.ValueTask<Azure.Response<long>> WaitForCompletionAsync(System.TimeSpan pollingInterval, System.Threading.CancellationToken cancellationToken) => throw null;
                }
                public enum CopyStatus
                {
                    Pending = 0,
                    Success = 1,
                    Aborted = 2,
                    Failed = 3,
                }
                public struct CustomerProvidedKey : System.IEquatable<Azure.Storage.Blobs.Models.CustomerProvidedKey>
                {
                    public CustomerProvidedKey(string key) => throw null;
                    public CustomerProvidedKey(byte[] key) => throw null;
                    public Azure.Storage.Blobs.Models.EncryptionAlgorithmType EncryptionAlgorithm { get => throw null; }
                    public string EncryptionKey { get => throw null; }
                    public string EncryptionKeyHash { get => throw null; }
                    public override bool Equals(object obj) => throw null;
                    public bool Equals(Azure.Storage.Blobs.Models.CustomerProvidedKey other) => throw null;
                    public override int GetHashCode() => throw null;
                    public static bool operator ==(Azure.Storage.Blobs.Models.CustomerProvidedKey left, Azure.Storage.Blobs.Models.CustomerProvidedKey right) => throw null;
                    public static bool operator !=(Azure.Storage.Blobs.Models.CustomerProvidedKey left, Azure.Storage.Blobs.Models.CustomerProvidedKey right) => throw null;
                    public override string ToString() => throw null;
                }
                public enum DeleteSnapshotsOption
                {
                    None = 0,
                    IncludeSnapshots = 1,
                    OnlySnapshots = 2,
                }
                public enum EncryptionAlgorithmType
                {
                    Aes256 = 0,
                }
                public class GetBlobTagResult
                {
                    public GetBlobTagResult() => throw null;
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; }
                }
                public class GetPageRangesDiffOptions
                {
                    public Azure.Storage.Blobs.Models.PageBlobRequestConditions Conditions { get => throw null; set { } }
                    public GetPageRangesDiffOptions() => throw null;
                    public string PreviousSnapshot { get => throw null; set { } }
                    public Azure.HttpRange? Range { get => throw null; set { } }
                    public string Snapshot { get => throw null; set { } }
                }
                public class GetPageRangesOptions
                {
                    public Azure.Storage.Blobs.Models.PageBlobRequestConditions Conditions { get => throw null; set { } }
                    public GetPageRangesOptions() => throw null;
                    public Azure.HttpRange? Range { get => throw null; set { } }
                    public string Snapshot { get => throw null; set { } }
                }
                public enum LeaseDurationType
                {
                    Infinite = 0,
                    Fixed = 1,
                }
                public enum LeaseState
                {
                    Available = 0,
                    Leased = 1,
                    Expired = 2,
                    Breaking = 3,
                    Broken = 4,
                }
                public enum LeaseStatus
                {
                    Locked = 0,
                    Unlocked = 1,
                }
                public class ObjectReplicationPolicy
                {
                    public string PolicyId { get => throw null; }
                    public System.Collections.Generic.IList<Azure.Storage.Blobs.Models.ObjectReplicationRule> Rules { get => throw null; }
                }
                public class ObjectReplicationRule
                {
                    public Azure.Storage.Blobs.Models.ObjectReplicationStatus ReplicationStatus { get => throw null; }
                    public string RuleId { get => throw null; }
                }
                [System.Flags]
                public enum ObjectReplicationStatus
                {
                    Complete = 0,
                    Failed = 1,
                }
                public class PageBlobCreateOptions
                {
                    public Azure.Storage.Blobs.Models.PageBlobRequestConditions Conditions { get => throw null; set { } }
                    public PageBlobCreateOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobHttpHeaders HttpHeaders { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.BlobImmutabilityPolicy ImmutabilityPolicy { get => throw null; set { } }
                    public bool? LegalHold { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                    public long? SequenceNumber { get => throw null; set { } }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; set { } }
                }
                public class PageBlobInfo
                {
                    public long BlobSequenceNumber { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                }
                public class PageBlobOpenWriteOptions
                {
                    public long? BufferSize { get => throw null; set { } }
                    public PageBlobOpenWriteOptions() => throw null;
                    public Azure.Storage.Blobs.Models.PageBlobRequestConditions OpenConditions { get => throw null; set { } }
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public long? Size { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class PageBlobRequestConditions : Azure.Storage.Blobs.Models.BlobRequestConditions
                {
                    public PageBlobRequestConditions() => throw null;
                    public long? IfSequenceNumberEqual { get => throw null; set { } }
                    public long? IfSequenceNumberLessThan { get => throw null; set { } }
                    public long? IfSequenceNumberLessThanOrEqual { get => throw null; set { } }
                }
                public class PageBlobUploadPagesFromUriOptions
                {
                    public PageBlobUploadPagesFromUriOptions() => throw null;
                    public Azure.Storage.Blobs.Models.PageBlobRequestConditions DestinationConditions { get => throw null; set { } }
                    public Azure.HttpAuthorization SourceAuthentication { get => throw null; set { } }
                    public Azure.Storage.Blobs.Models.PageBlobRequestConditions SourceConditions { get => throw null; set { } }
                    public byte[] SourceContentHash { get => throw null; set { } }
                }
                public class PageBlobUploadPagesOptions
                {
                    public Azure.Storage.Blobs.Models.PageBlobRequestConditions Conditions { get => throw null; set { } }
                    public PageBlobUploadPagesOptions() => throw null;
                    public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                }
                public class PageInfo
                {
                    public long BlobSequenceNumber { get => throw null; }
                    public byte[] ContentCrc64 { get => throw null; }
                    public byte[] ContentHash { get => throw null; }
                    public string EncryptionKeySha256 { get => throw null; }
                    public string EncryptionScope { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                }
                public class PageRangeItem
                {
                    public PageRangeItem() => throw null;
                    public bool IsClear { get => throw null; }
                    public Azure.HttpRange Range { get => throw null; }
                }
                public class PageRangesInfo
                {
                    public long BlobContentLength { get => throw null; }
                    public System.Collections.Generic.IEnumerable<Azure.HttpRange> ClearRanges { get => throw null; }
                    public Azure.ETag ETag { get => throw null; }
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public System.Collections.Generic.IEnumerable<Azure.HttpRange> PageRanges { get => throw null; }
                }
                public enum PathRenameMode
                {
                    Legacy = 0,
                    Posix = 1,
                }
                public enum PublicAccessType
                {
                    None = 0,
                    BlobContainer = 1,
                    Blob = 2,
                }
                public enum RehydratePriority
                {
                    High = 0,
                    Standard = 1,
                }
                public class ReleasedObjectInfo
                {
                    public ReleasedObjectInfo(Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                    public override bool Equals(object obj) => throw null;
                    public Azure.ETag ETag { get => throw null; }
                    public override int GetHashCode() => throw null;
                    public System.DateTimeOffset LastModified { get => throw null; }
                    public override string ToString() => throw null;
                }
                public enum SequenceNumberAction
                {
                    Max = 0,
                    Update = 1,
                    Increment = 2,
                }
                public enum SkuName
                {
                    StandardLrs = 0,
                    StandardGrs = 1,
                    StandardRagrs = 2,
                    StandardZrs = 3,
                    PremiumLrs = 4,
                }
                public class StageBlockFromUriOptions
                {
                    public StageBlockFromUriOptions() => throw null;
                    public Azure.Storage.Blobs.Models.BlobRequestConditions DestinationConditions { get => throw null; set { } }
                    public Azure.HttpAuthorization SourceAuthentication { get => throw null; set { } }
                    public Azure.RequestConditions SourceConditions { get => throw null; set { } }
                    public byte[] SourceContentHash { get => throw null; set { } }
                    public Azure.HttpRange SourceRange { get => throw null; set { } }
                }
                public class TaggedBlobItem
                {
                    public string BlobContainerName { get => throw null; }
                    public string BlobName { get => throw null; }
                    public System.Collections.Generic.IDictionary<string, string> Tags { get => throw null; }
                }
                public class UserDelegationKey
                {
                    public System.DateTimeOffset SignedExpiresOn { get => throw null; }
                    public string SignedObjectId { get => throw null; }
                    public string SignedService { get => throw null; }
                    public System.DateTimeOffset SignedStartsOn { get => throw null; }
                    public string SignedTenantId { get => throw null; }
                    public string SignedVersion { get => throw null; }
                    public string Value { get => throw null; }
                }
            }
            namespace Specialized
            {
                public class AppendBlobClient : Azure.Storage.Blobs.Specialized.BlobBaseClient
                {
                    public virtual int AppendBlobMaxAppendBlockBytes { get => throw null; }
                    public virtual int AppendBlobMaxBlocks { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo> AppendBlock(System.IO.Stream content, byte[] transactionalContentHash, Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo> AppendBlock(System.IO.Stream content, Azure.Storage.Blobs.Models.AppendBlobAppendBlockOptions options = default(Azure.Storage.Blobs.Models.AppendBlobAppendBlockOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo>> AppendBlockAsync(System.IO.Stream content, byte[] transactionalContentHash, Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo>> AppendBlockAsync(System.IO.Stream content, Azure.Storage.Blobs.Models.AppendBlobAppendBlockOptions options = default(Azure.Storage.Blobs.Models.AppendBlobAppendBlockOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo> AppendBlockFromUri(System.Uri sourceUri, Azure.Storage.Blobs.Models.AppendBlobAppendBlockFromUriOptions options = default(Azure.Storage.Blobs.Models.AppendBlobAppendBlockFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo> AppendBlockFromUri(System.Uri sourceUri, Azure.HttpRange sourceRange, byte[] sourceContentHash, Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions, Azure.Storage.Blobs.Models.AppendBlobRequestConditions sourceConditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo>> AppendBlockFromUriAsync(System.Uri sourceUri, Azure.Storage.Blobs.Models.AppendBlobAppendBlockFromUriOptions options = default(Azure.Storage.Blobs.Models.AppendBlobAppendBlockFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobAppendInfo>> AppendBlockFromUriAsync(System.Uri sourceUri, Azure.HttpRange sourceRange, byte[] sourceContentHash, Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions, Azure.Storage.Blobs.Models.AppendBlobRequestConditions sourceConditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Create(Azure.Storage.Blobs.Models.AppendBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Create(Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.AppendBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateAsync(Azure.Storage.Blobs.Models.AppendBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateAsync(Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.AppendBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> CreateIfNotExists(Azure.Storage.Blobs.Models.AppendBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> CreateIfNotExists(Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateIfNotExistsAsync(Azure.Storage.Blobs.Models.AppendBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateIfNotExistsAsync(Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected AppendBlobClient() => throw null;
                    public AppendBlobClient(string connectionString, string blobContainerName, string blobName) => throw null;
                    public AppendBlobClient(string connectionString, string blobContainerName, string blobName, Azure.Storage.Blobs.BlobClientOptions options) => throw null;
                    public AppendBlobClient(System.Uri blobUri, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public AppendBlobClient(System.Uri blobUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public AppendBlobClient(System.Uri blobUri, Azure.AzureSasCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public AppendBlobClient(System.Uri blobUri, Azure.Core.TokenCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public virtual System.IO.Stream OpenWrite(bool overwrite, Azure.Storage.Blobs.Models.AppendBlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.AppendBlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenWriteAsync(bool overwrite, Azure.Storage.Blobs.Models.AppendBlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.AppendBlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobInfo> Seal(Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.AppendBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobInfo>> SealAsync(Azure.Storage.Blobs.Models.AppendBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.AppendBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public Azure.Storage.Blobs.Specialized.AppendBlobClient WithCustomerProvidedKey(Azure.Storage.Blobs.Models.CustomerProvidedKey? customerProvidedKey) => throw null;
                    public Azure.Storage.Blobs.Specialized.AppendBlobClient WithEncryptionScope(string encryptionScope) => throw null;
                    public Azure.Storage.Blobs.Specialized.AppendBlobClient WithSnapshot(string snapshot) => throw null;
                    public Azure.Storage.Blobs.Specialized.AppendBlobClient WithVersion(string versionId) => throw null;
                }
                public class BlobBaseClient
                {
                    public virtual Azure.Response AbortCopyFromUri(string copyId, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> AbortCopyFromUriAsync(string copyId, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string AccountName { get => throw null; }
                    public virtual string BlobContainerName { get => throw null; }
                    public virtual bool CanGenerateSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobSnapshotInfo> CreateSnapshot(System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobSnapshotInfo>> CreateSnapshotAsync(System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected BlobBaseClient() => throw null;
                    public BlobBaseClient(string connectionString, string blobContainerName, string blobName) => throw null;
                    public BlobBaseClient(string connectionString, string blobContainerName, string blobName, Azure.Storage.Blobs.BlobClientOptions options) => throw null;
                    public BlobBaseClient(System.Uri blobUri, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public BlobBaseClient(System.Uri blobUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public BlobBaseClient(System.Uri blobUri, Azure.AzureSasCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public BlobBaseClient(System.Uri blobUri, Azure.Core.TokenCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public virtual Azure.Response Delete(Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(Azure.Storage.Blobs.Models.DeleteSnapshotsOption snapshotsOption = default(Azure.Storage.Blobs.Models.DeleteSnapshotsOption), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteImmutabilityPolicy(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteImmutabilityPolicyAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo> Download() => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo> Download(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo> Download(Azure.HttpRange range = default(Azure.HttpRange), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), bool rangeGetContentHash = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo>> DownloadAsync() => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo>> DownloadAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo>> DownloadAsync(Azure.HttpRange range = default(Azure.HttpRange), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), bool rangeGetContentHash = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult> DownloadContent() => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult> DownloadContent(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult> DownloadContent(Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult> DownloadContent(Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.IProgress<long> progressHandler, Azure.HttpRange range, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult> DownloadContent(Azure.Storage.Blobs.Models.BlobDownloadOptions options = default(Azure.Storage.Blobs.Models.BlobDownloadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult>> DownloadContentAsync() => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult>> DownloadContentAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult>> DownloadContentAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult>> DownloadContentAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.IProgress<long> progressHandler, Azure.HttpRange range, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadResult>> DownloadContentAsync(Azure.Storage.Blobs.Models.BlobDownloadOptions options = default(Azure.Storage.Blobs.Models.BlobDownloadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadStreamingResult> DownloadStreaming(Azure.HttpRange range, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, bool rangeGetContentHash, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadStreamingResult> DownloadStreaming(Azure.HttpRange range, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, bool rangeGetContentHash, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadStreamingResult> DownloadStreaming(Azure.Storage.Blobs.Models.BlobDownloadOptions options = default(Azure.Storage.Blobs.Models.BlobDownloadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadStreamingResult>> DownloadStreamingAsync(Azure.HttpRange range, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, bool rangeGetContentHash, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadStreamingResult>> DownloadStreamingAsync(Azure.HttpRange range, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, bool rangeGetContentHash, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadStreamingResult>> DownloadStreamingAsync(Azure.Storage.Blobs.Models.BlobDownloadOptions options = default(Azure.Storage.Blobs.Models.BlobDownloadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DownloadTo(System.IO.Stream destination) => throw null;
                    public virtual Azure.Response DownloadTo(string path) => throw null;
                    public virtual Azure.Response DownloadTo(System.IO.Stream destination, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response DownloadTo(string path, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response DownloadTo(System.IO.Stream destination, Azure.Storage.Blobs.Models.BlobDownloadToOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DownloadTo(string path, Azure.Storage.Blobs.Models.BlobDownloadToOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DownloadTo(System.IO.Stream destination, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DownloadTo(string path, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(System.IO.Stream destination) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(string path) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(System.IO.Stream destination, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(string path, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(System.IO.Stream destination, Azure.Storage.Blobs.Models.BlobDownloadToOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(string path, Azure.Storage.Blobs.Models.BlobDownloadToOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(System.IO.Stream destination, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DownloadToAsync(string path, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> Exists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> ExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.BlobSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.BlobSasBuilder builder) => throw null;
                    protected virtual Azure.Storage.Blobs.Specialized.BlobLeaseClient GetBlobLeaseClientCore(string leaseId) => throw null;
                    protected static System.Threading.Tasks.Task<Azure.HttpAuthorization> GetCopyAuthorizationHeaderAsync(Azure.Storage.Blobs.Specialized.BlobBaseClient client, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected virtual Azure.Storage.Blobs.BlobContainerClient GetParentBlobContainerClientCore() => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobProperties> GetProperties(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobProperties>> GetPropertiesAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.GetBlobTagResult> GetTags(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.GetBlobTagResult>> GetTagsAsync(Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string Name { get => throw null; }
                    public virtual System.IO.Stream OpenRead(Azure.Storage.Blobs.Models.BlobOpenReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenRead(long position = default(long), int? bufferSize = default(int?), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenRead(bool allowBlobModifications, long position = default(long), int? bufferSize = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(Azure.Storage.Blobs.Models.BlobOpenReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(long position = default(long), int? bufferSize = default(int?), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(bool allowBlobModifications, long position = default(long), int? bufferSize = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response SetAccessTier(Azure.Storage.Blobs.Models.AccessTier accessTier, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.RehydratePriority? rehydratePriority = default(Azure.Storage.Blobs.Models.RehydratePriority?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> SetAccessTierAsync(Azure.Storage.Blobs.Models.AccessTier accessTier, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.RehydratePriority? rehydratePriority = default(Azure.Storage.Blobs.Models.RehydratePriority?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobInfo> SetHttpHeaders(Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobInfo>> SetHttpHeadersAsync(Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobImmutabilityPolicy> SetImmutabilityPolicy(Azure.Storage.Blobs.Models.BlobImmutabilityPolicy immutabilityPolicy, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobImmutabilityPolicy>> SetImmutabilityPolicyAsync(Azure.Storage.Blobs.Models.BlobImmutabilityPolicy immutabilityPolicy, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobLegalHoldResult> SetLegalHold(bool hasLegalHold, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobLegalHoldResult>> SetLegalHoldAsync(bool hasLegalHold, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response SetTags(System.Collections.Generic.IDictionary<string, string> tags, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> SetTagsAsync(System.Collections.Generic.IDictionary<string, string> tags, Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Blobs.Models.CopyFromUriOperation StartCopyFromUri(System.Uri source, Azure.Storage.Blobs.Models.BlobCopyFromUriOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Blobs.Models.CopyFromUriOperation StartCopyFromUri(System.Uri source, System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), Azure.Storage.Blobs.Models.BlobRequestConditions sourceConditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.BlobRequestConditions destinationConditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.RehydratePriority? rehydratePriority = default(Azure.Storage.Blobs.Models.RehydratePriority?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Storage.Blobs.Models.CopyFromUriOperation> StartCopyFromUriAsync(System.Uri source, Azure.Storage.Blobs.Models.BlobCopyFromUriOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Storage.Blobs.Models.CopyFromUriOperation> StartCopyFromUriAsync(System.Uri source, System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), Azure.Storage.Blobs.Models.BlobRequestConditions sourceConditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.BlobRequestConditions destinationConditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.RehydratePriority? rehydratePriority = default(Azure.Storage.Blobs.Models.RehydratePriority?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobCopyInfo> SyncCopyFromUri(System.Uri source, Azure.Storage.Blobs.Models.BlobCopyFromUriOptions options = default(Azure.Storage.Blobs.Models.BlobCopyFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobCopyInfo>> SyncCopyFromUriAsync(System.Uri source, Azure.Storage.Blobs.Models.BlobCopyFromUriOptions options = default(Azure.Storage.Blobs.Models.BlobCopyFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response Undelete(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> UndeleteAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri Uri { get => throw null; }
                    public virtual Azure.Storage.Blobs.Specialized.BlobBaseClient WithCustomerProvidedKey(Azure.Storage.Blobs.Models.CustomerProvidedKey? customerProvidedKey) => throw null;
                    public virtual Azure.Storage.Blobs.Specialized.BlobBaseClient WithEncryptionScope(string encryptionScope) => throw null;
                    public virtual Azure.Storage.Blobs.Specialized.BlobBaseClient WithSnapshot(string snapshot) => throw null;
                    protected virtual Azure.Storage.Blobs.Specialized.BlobBaseClient WithSnapshotCore(string snapshot) => throw null;
                    public virtual Azure.Storage.Blobs.Specialized.BlobBaseClient WithVersion(string versionId) => throw null;
                }
                public class BlobLeaseClient
                {
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobLease> Acquire(System.TimeSpan duration, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response Acquire(System.TimeSpan duration, Azure.RequestConditions conditions, Azure.RequestContext context) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobLease>> AcquireAsync(System.TimeSpan duration, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> AcquireAsync(System.TimeSpan duration, Azure.RequestConditions conditions, Azure.RequestContext context) => throw null;
                    protected virtual Azure.Storage.Blobs.Specialized.BlobBaseClient BlobClient { get => throw null; }
                    protected virtual Azure.Storage.Blobs.BlobContainerClient BlobContainerClient { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobLease> Break(System.TimeSpan? breakPeriod = default(System.TimeSpan?), Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobLease>> BreakAsync(System.TimeSpan? breakPeriod = default(System.TimeSpan?), Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobLease> Change(string proposedId, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobLease>> ChangeAsync(string proposedId, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected BlobLeaseClient() => throw null;
                    public BlobLeaseClient(Azure.Storage.Blobs.Specialized.BlobBaseClient client, string leaseId = default(string)) => throw null;
                    public BlobLeaseClient(Azure.Storage.Blobs.BlobContainerClient client, string leaseId = default(string)) => throw null;
                    public static readonly System.TimeSpan InfiniteLeaseDuration;
                    public virtual string LeaseId { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.ReleasedObjectInfo> Release(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.ReleasedObjectInfo>> ReleaseAsync(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.ReleasedObjectInfo>> ReleaseInternal(Azure.RequestConditions conditions, bool async, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobLease> Renew(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobLease>> RenewAsync(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public System.Uri Uri { get => throw null; }
                }
                public class BlockBlobClient : Azure.Storage.Blobs.Specialized.BlobBaseClient
                {
                    public virtual int BlockBlobMaxBlocks { get => throw null; }
                    public virtual int BlockBlobMaxStageBlockBytes { get => throw null; }
                    public virtual long BlockBlobMaxStageBlockLongBytes { get => throw null; }
                    public virtual int BlockBlobMaxUploadBlobBytes { get => throw null; }
                    public virtual long BlockBlobMaxUploadBlobLongBytes { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> CommitBlockList(System.Collections.Generic.IEnumerable<string> base64BlockIds, Azure.Storage.Blobs.Models.CommitBlockListOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> CommitBlockList(System.Collections.Generic.IEnumerable<string> base64BlockIds, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CommitBlockListAsync(System.Collections.Generic.IEnumerable<string> base64BlockIds, Azure.Storage.Blobs.Models.CommitBlockListOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CommitBlockListAsync(System.Collections.Generic.IEnumerable<string> base64BlockIds, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected static Azure.Storage.Blobs.Specialized.BlockBlobClient CreateClient(System.Uri blobUri, Azure.Storage.Blobs.BlobClientOptions options, Azure.Core.Pipeline.HttpPipeline pipeline) => throw null;
                    protected BlockBlobClient() => throw null;
                    public BlockBlobClient(string connectionString, string containerName, string blobName) => throw null;
                    public BlockBlobClient(string connectionString, string blobContainerName, string blobName, Azure.Storage.Blobs.BlobClientOptions options) => throw null;
                    public BlockBlobClient(System.Uri blobUri, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public BlockBlobClient(System.Uri blobUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public BlockBlobClient(System.Uri blobUri, Azure.AzureSasCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public BlockBlobClient(System.Uri blobUri, Azure.Core.TokenCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlockList> GetBlockList(Azure.Storage.Blobs.Models.BlockListTypes blockListTypes = default(Azure.Storage.Blobs.Models.BlockListTypes), string snapshot = default(string), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlockList>> GetBlockListAsync(Azure.Storage.Blobs.Models.BlockListTypes blockListTypes = default(Azure.Storage.Blobs.Models.BlockListTypes), string snapshot = default(string), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenWrite(bool overwrite, Azure.Storage.Blobs.Models.BlockBlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.BlockBlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenWriteAsync(bool overwrite, Azure.Storage.Blobs.Models.BlockBlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.BlockBlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo> Query(string querySqlExpression, Azure.Storage.Blobs.Models.BlobQueryOptions options = default(Azure.Storage.Blobs.Models.BlobQueryOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobDownloadInfo>> QueryAsync(string querySqlExpression, Azure.Storage.Blobs.Models.BlobQueryOptions options = default(Azure.Storage.Blobs.Models.BlobQueryOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlockInfo> StageBlock(string base64BlockId, System.IO.Stream content, byte[] transactionalContentHash, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlockInfo> StageBlock(string base64BlockId, System.IO.Stream content, Azure.Storage.Blobs.Models.BlockBlobStageBlockOptions options = default(Azure.Storage.Blobs.Models.BlockBlobStageBlockOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlockInfo>> StageBlockAsync(string base64BlockId, System.IO.Stream content, byte[] transactionalContentHash, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlockInfo>> StageBlockAsync(string base64BlockId, System.IO.Stream content, Azure.Storage.Blobs.Models.BlockBlobStageBlockOptions options = default(Azure.Storage.Blobs.Models.BlockBlobStageBlockOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlockInfo> StageBlockFromUri(System.Uri sourceUri, string base64BlockId, Azure.Storage.Blobs.Models.StageBlockFromUriOptions options = default(Azure.Storage.Blobs.Models.StageBlockFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlockInfo> StageBlockFromUri(System.Uri sourceUri, string base64BlockId, Azure.HttpRange sourceRange, byte[] sourceContentHash, Azure.RequestConditions sourceConditions, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlockInfo>> StageBlockFromUriAsync(System.Uri sourceUri, string base64BlockId, Azure.Storage.Blobs.Models.StageBlockFromUriOptions options = default(Azure.Storage.Blobs.Models.StageBlockFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlockInfo>> StageBlockFromUriAsync(System.Uri sourceUri, string base64BlockId, Azure.HttpRange sourceRange, byte[] sourceContentHash, Azure.RequestConditions sourceConditions, Azure.Storage.Blobs.Models.BlobRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> SyncUploadFromUri(System.Uri copySource, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> SyncUploadFromUri(System.Uri copySource, Azure.Storage.Blobs.Models.BlobSyncUploadFromUriOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> SyncUploadFromUriAsync(System.Uri copySource, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> SyncUploadFromUriAsync(System.Uri copySource, Azure.Storage.Blobs.Models.BlobSyncUploadFromUriOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Upload(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), System.IProgress<long> progressHandler = default(System.IProgress<long>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> UploadAsync(System.IO.Stream content, Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), Azure.Storage.Blobs.Models.AccessTier? accessTier = default(Azure.Storage.Blobs.Models.AccessTier?), System.IProgress<long> progressHandler = default(System.IProgress<long>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public Azure.Storage.Blobs.Specialized.BlockBlobClient WithCustomerProvidedKey(Azure.Storage.Blobs.Models.CustomerProvidedKey? customerProvidedKey) => throw null;
                    public Azure.Storage.Blobs.Specialized.BlockBlobClient WithEncryptionScope(string encryptionScope) => throw null;
                    public Azure.Storage.Blobs.Specialized.BlockBlobClient WithSnapshot(string snapshot) => throw null;
                    protected override sealed Azure.Storage.Blobs.Specialized.BlobBaseClient WithSnapshotCore(string snapshot) => throw null;
                    public Azure.Storage.Blobs.Specialized.BlockBlobClient WithVersion(string versionId) => throw null;
                }
                public class PageBlobClient : Azure.Storage.Blobs.Specialized.BlobBaseClient
                {
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageInfo> ClearPages(Azure.HttpRange range, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageInfo>> ClearPagesAsync(Azure.HttpRange range, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Create(long size, Azure.Storage.Blobs.Models.PageBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> Create(long size, long? sequenceNumber = default(long?), Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateAsync(long size, Azure.Storage.Blobs.Models.PageBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateAsync(long size, long? sequenceNumber = default(long?), Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> CreateIfNotExists(long size, Azure.Storage.Blobs.Models.PageBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo> CreateIfNotExists(long size, long? sequenceNumber = default(long?), Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateIfNotExistsAsync(long size, Azure.Storage.Blobs.Models.PageBlobCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.BlobContentInfo>> CreateIfNotExistsAsync(long size, long? sequenceNumber = default(long?), Azure.Storage.Blobs.Models.BlobHttpHeaders httpHeaders = default(Azure.Storage.Blobs.Models.BlobHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected PageBlobClient() => throw null;
                    public PageBlobClient(string connectionString, string blobContainerName, string blobName) => throw null;
                    public PageBlobClient(string connectionString, string blobContainerName, string blobName, Azure.Storage.Blobs.BlobClientOptions options) => throw null;
                    public PageBlobClient(System.Uri blobUri, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public PageBlobClient(System.Uri blobUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public PageBlobClient(System.Uri blobUri, Azure.AzureSasCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public PageBlobClient(System.Uri blobUri, Azure.Core.TokenCredential credential, Azure.Storage.Blobs.BlobClientOptions options = default(Azure.Storage.Blobs.BlobClientOptions)) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Blobs.Models.PageRangeItem> GetAllPageRanges(Azure.Storage.Blobs.Models.GetPageRangesOptions options = default(Azure.Storage.Blobs.Models.GetPageRangesOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.PageRangeItem> GetAllPageRangesAsync(Azure.Storage.Blobs.Models.GetPageRangesOptions options = default(Azure.Storage.Blobs.Models.GetPageRangesOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Blobs.Models.PageRangeItem> GetAllPageRangesDiff(Azure.Storage.Blobs.Models.GetPageRangesDiffOptions options = default(Azure.Storage.Blobs.Models.GetPageRangesDiffOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Blobs.Models.PageRangeItem> GetAllPageRangesDiffAsync(Azure.Storage.Blobs.Models.GetPageRangesDiffOptions options = default(Azure.Storage.Blobs.Models.GetPageRangesDiffOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageRangesInfo> GetManagedDiskPageRangesDiff(Azure.HttpRange? range = default(Azure.HttpRange?), string snapshot = default(string), System.Uri previousSnapshotUri = default(System.Uri), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageRangesInfo>> GetManagedDiskPageRangesDiffAsync(Azure.HttpRange? range = default(Azure.HttpRange?), string snapshot = default(string), System.Uri previousSnapshotUri = default(System.Uri), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageRangesInfo> GetPageRanges(Azure.HttpRange? range = default(Azure.HttpRange?), string snapshot = default(string), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageRangesInfo>> GetPageRangesAsync(Azure.HttpRange? range = default(Azure.HttpRange?), string snapshot = default(string), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageRangesInfo> GetPageRangesDiff(Azure.HttpRange? range = default(Azure.HttpRange?), string snapshot = default(string), string previousSnapshot = default(string), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageRangesInfo>> GetPageRangesDiffAsync(Azure.HttpRange? range = default(Azure.HttpRange?), string snapshot = default(string), string previousSnapshot = default(string), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenWrite(bool overwrite, long position, Azure.Storage.Blobs.Models.PageBlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.PageBlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenWriteAsync(bool overwrite, long position, Azure.Storage.Blobs.Models.PageBlobOpenWriteOptions options = default(Azure.Storage.Blobs.Models.PageBlobOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual int PageBlobMaxUploadPagesBytes { get => throw null; }
                    public virtual int PageBlobPageBytes { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageBlobInfo> Resize(long size, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageBlobInfo>> ResizeAsync(long size, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Blobs.Models.CopyFromUriOperation StartCopyIncremental(System.Uri sourceUri, string snapshot, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Storage.Blobs.Models.CopyFromUriOperation> StartCopyIncrementalAsync(System.Uri sourceUri, string snapshot, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageBlobInfo> UpdateSequenceNumber(Azure.Storage.Blobs.Models.SequenceNumberAction action, long? sequenceNumber = default(long?), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageBlobInfo>> UpdateSequenceNumberAsync(Azure.Storage.Blobs.Models.SequenceNumberAction action, long? sequenceNumber = default(long?), Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.PageBlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageInfo> UploadPages(System.IO.Stream content, long offset, byte[] transactionalContentHash, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageInfo> UploadPages(System.IO.Stream content, long offset, Azure.Storage.Blobs.Models.PageBlobUploadPagesOptions options = default(Azure.Storage.Blobs.Models.PageBlobUploadPagesOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageInfo>> UploadPagesAsync(System.IO.Stream content, long offset, byte[] transactionalContentHash, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageInfo>> UploadPagesAsync(System.IO.Stream content, long offset, Azure.Storage.Blobs.Models.PageBlobUploadPagesOptions options = default(Azure.Storage.Blobs.Models.PageBlobUploadPagesOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageInfo> UploadPagesFromUri(System.Uri sourceUri, Azure.HttpRange sourceRange, Azure.HttpRange range, Azure.Storage.Blobs.Models.PageBlobUploadPagesFromUriOptions options = default(Azure.Storage.Blobs.Models.PageBlobUploadPagesFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Blobs.Models.PageInfo> UploadPagesFromUri(System.Uri sourceUri, Azure.HttpRange sourceRange, Azure.HttpRange range, byte[] sourceContentHash, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions, Azure.Storage.Blobs.Models.PageBlobRequestConditions sourceConditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageInfo>> UploadPagesFromUriAsync(System.Uri sourceUri, Azure.HttpRange sourceRange, Azure.HttpRange range, Azure.Storage.Blobs.Models.PageBlobUploadPagesFromUriOptions options = default(Azure.Storage.Blobs.Models.PageBlobUploadPagesFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Blobs.Models.PageInfo>> UploadPagesFromUriAsync(System.Uri sourceUri, Azure.HttpRange sourceRange, Azure.HttpRange range, byte[] sourceContentHash, Azure.Storage.Blobs.Models.PageBlobRequestConditions conditions, Azure.Storage.Blobs.Models.PageBlobRequestConditions sourceConditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public Azure.Storage.Blobs.Specialized.PageBlobClient WithCustomerProvidedKey(Azure.Storage.Blobs.Models.CustomerProvidedKey? customerProvidedKey) => throw null;
                    public Azure.Storage.Blobs.Specialized.PageBlobClient WithEncryptionScope(string encryptionScope) => throw null;
                    public Azure.Storage.Blobs.Specialized.PageBlobClient WithSnapshot(string snapshot) => throw null;
                    protected override sealed Azure.Storage.Blobs.Specialized.BlobBaseClient WithSnapshotCore(string snapshot) => throw null;
                    public Azure.Storage.Blobs.Specialized.PageBlobClient WithVersion(string versionId) => throw null;
                }
                public class SpecializedBlobClientOptions : Azure.Storage.Blobs.BlobClientOptions
                {
                    public Azure.Storage.ClientSideEncryptionOptions ClientSideEncryption { get => throw null; set { } }
                    public SpecializedBlobClientOptions(Azure.Storage.Blobs.BlobClientOptions.ServiceVersion version = default(Azure.Storage.Blobs.BlobClientOptions.ServiceVersion)) : base(default(Azure.Storage.Blobs.BlobClientOptions.ServiceVersion)) => throw null;
                }
                public static partial class SpecializedBlobExtensions
                {
                    public static Azure.Storage.Blobs.Specialized.AppendBlobClient GetAppendBlobClient(this Azure.Storage.Blobs.BlobContainerClient client, string blobName) => throw null;
                    public static Azure.Storage.Blobs.Specialized.BlobBaseClient GetBlobBaseClient(this Azure.Storage.Blobs.BlobContainerClient client, string blobName) => throw null;
                    public static Azure.Storage.Blobs.Specialized.BlobLeaseClient GetBlobLeaseClient(this Azure.Storage.Blobs.Specialized.BlobBaseClient client, string leaseId = default(string)) => throw null;
                    public static Azure.Storage.Blobs.Specialized.BlobLeaseClient GetBlobLeaseClient(this Azure.Storage.Blobs.BlobContainerClient client, string leaseId = default(string)) => throw null;
                    public static Azure.Storage.Blobs.Specialized.BlockBlobClient GetBlockBlobClient(this Azure.Storage.Blobs.BlobContainerClient client, string blobName) => throw null;
                    public static Azure.Storage.Blobs.Specialized.PageBlobClient GetPageBlobClient(this Azure.Storage.Blobs.BlobContainerClient client, string blobName) => throw null;
                    public static Azure.Storage.Blobs.BlobContainerClient GetParentBlobContainerClient(this Azure.Storage.Blobs.Specialized.BlobBaseClient client) => throw null;
                    public static Azure.Storage.Blobs.BlobServiceClient GetParentBlobServiceClient(this Azure.Storage.Blobs.BlobContainerClient client) => throw null;
                    public static void UpdateClientSideKeyEncryptionKey(this Azure.Storage.Blobs.BlobClient client, Azure.Storage.ClientSideEncryptionOptions encryptionOptionsOverride = default(Azure.Storage.ClientSideEncryptionOptions), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public static System.Threading.Tasks.Task UpdateClientSideKeyEncryptionKeyAsync(this Azure.Storage.Blobs.BlobClient client, Azure.Storage.ClientSideEncryptionOptions encryptionOptionsOverride = default(Azure.Storage.ClientSideEncryptionOptions), Azure.Storage.Blobs.Models.BlobRequestConditions conditions = default(Azure.Storage.Blobs.Models.BlobRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public static Azure.Storage.Blobs.BlobClient WithClientSideEncryptionOptions(this Azure.Storage.Blobs.BlobClient client, Azure.Storage.ClientSideEncryptionOptions clientSideEncryptionOptions) => throw null;
                }
            }
        }
        namespace Sas
        {
            [System.Flags]
            public enum BlobAccountSasPermissions
            {
                Read = 1,
                Add = 2,
                Create = 4,
                Write = 8,
                Delete = 16,
                List = 32,
                All = -1,
            }
            [System.Flags]
            public enum BlobContainerSasPermissions
            {
                Read = 1,
                Add = 2,
                Create = 4,
                Write = 8,
                Delete = 16,
                List = 32,
                Tag = 64,
                DeleteBlobVersion = 128,
                Move = 256,
                Execute = 512,
                SetImmutabilityPolicy = 1024,
                Filter = 2048,
                All = -1,
            }
            public class BlobSasBuilder
            {
                public string BlobContainerName { get => throw null; set { } }
                public string BlobName { get => throw null; set { } }
                public string BlobVersionId { get => throw null; set { } }
                public string CacheControl { get => throw null; set { } }
                public string ContentDisposition { get => throw null; set { } }
                public string ContentEncoding { get => throw null; set { } }
                public string ContentLanguage { get => throw null; set { } }
                public string ContentType { get => throw null; set { } }
                public string CorrelationId { get => throw null; set { } }
                public BlobSasBuilder() => throw null;
                public BlobSasBuilder(Azure.Storage.Sas.BlobSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                public BlobSasBuilder(Azure.Storage.Sas.BlobContainerSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                public string EncryptionScope { get => throw null; set { } }
                public override bool Equals(object obj) => throw null;
                public System.DateTimeOffset ExpiresOn { get => throw null; set { } }
                public override int GetHashCode() => throw null;
                public string Identifier { get => throw null; set { } }
                public Azure.Storage.Sas.SasIPRange IPRange { get => throw null; set { } }
                public string Permissions { get => throw null; }
                public string PreauthorizedAgentObjectId { get => throw null; set { } }
                public Azure.Storage.Sas.SasProtocol Protocol { get => throw null; set { } }
                public string Resource { get => throw null; set { } }
                public void SetPermissions(Azure.Storage.Sas.BlobSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.BlobAccountSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.BlobContainerSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.SnapshotSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.BlobVersionSasPermissions permissions) => throw null;
                public void SetPermissions(string rawPermissions, bool normalize = default(bool)) => throw null;
                public void SetPermissions(string rawPermissions) => throw null;
                public string Snapshot { get => throw null; set { } }
                public System.DateTimeOffset StartsOn { get => throw null; set { } }
                public Azure.Storage.Sas.BlobSasQueryParameters ToSasQueryParameters(Azure.Storage.StorageSharedKeyCredential sharedKeyCredential) => throw null;
                public Azure.Storage.Sas.BlobSasQueryParameters ToSasQueryParameters(Azure.Storage.Blobs.Models.UserDelegationKey userDelegationKey, string accountName) => throw null;
                public override string ToString() => throw null;
                public string Version { get => throw null; set { } }
            }
            [System.Flags]
            public enum BlobSasPermissions
            {
                Read = 1,
                Add = 2,
                Create = 4,
                Write = 8,
                Delete = 16,
                Tag = 32,
                DeleteBlobVersion = 64,
                List = 128,
                Move = 256,
                Execute = 512,
                SetImmutabilityPolicy = 1024,
                PermanentDelete = 2048,
                All = -1,
            }
            public sealed class BlobSasQueryParameters : Azure.Storage.Sas.SasQueryParameters
            {
                public static Azure.Storage.Sas.BlobSasQueryParameters Empty { get => throw null; }
                public System.DateTimeOffset KeyExpiresOn { get => throw null; }
                public string KeyObjectId { get => throw null; }
                public string KeyService { get => throw null; }
                public System.DateTimeOffset KeyStartsOn { get => throw null; }
                public string KeyTenantId { get => throw null; }
                public string KeyVersion { get => throw null; }
                public override string ToString() => throw null;
            }
            [System.Flags]
            public enum BlobVersionSasPermissions
            {
                Delete = 1,
                SetImmutabilityPolicy = 2,
                PermanentDelete = 4,
                All = -1,
            }
            [System.Flags]
            public enum SnapshotSasPermissions
            {
                Read = 1,
                Write = 2,
                Delete = 4,
                SetImmutabilityPolicy = 8,
                PermanentDelete = 16,
                All = -1,
            }
        }
    }
}
namespace Microsoft
{
    namespace Extensions
    {
        namespace Azure
        {
            public static partial class BlobClientBuilderExtensions
            {
                public static IAzureClientBuilder<BlobServiceClient, BlobClientOptions> AddBlobServiceClient<TBuilder>(this TBuilder builder, string connectionString) where TBuilder : IAzureClientFactoryBuilder => throw null;
                public static IAzureClientBuilder<BlobServiceClient, BlobClientOptions> AddBlobServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri) where TBuilder : IAzureClientFactoryBuilderWithCredential => throw null;
                public static IAzureClientBuilder<BlobServiceClient, BlobClientOptions> AddBlobServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri, StorageSharedKeyCredential sharedKeyCredential) where TBuilder : IAzureClientFactoryBuilder => throw null;
                public static IAzureClientBuilder<BlobServiceClient, BlobClientOptions> AddBlobServiceClient<TBuilder, TConfiguration>(this TBuilder builder, TConfiguration configuration) where TBuilder : IAzureClientFactoryBuilderWithConfiguration<TConfiguration> => throw null;
            }
        }
    }
}
