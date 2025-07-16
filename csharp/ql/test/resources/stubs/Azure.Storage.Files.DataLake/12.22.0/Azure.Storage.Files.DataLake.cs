// This file contains auto-generated code.
// Generated from `Azure.Storage.Files.DataLake, Version=12.22.0.0, Culture=neutral, PublicKeyToken=92742159e12e44c8`.
namespace Azure
{
    namespace Storage
    {
        namespace Files
        {
            namespace DataLake
            {
                public class DataLakeClientOptions : Azure.Core.ClientOptions
                {
                    public Azure.Storage.Files.DataLake.Models.DataLakeAudience? Audience { get => throw null; set { } }
                    public DataLakeClientOptions(Azure.Storage.Files.DataLake.DataLakeClientOptions.ServiceVersion version = default(Azure.Storage.Files.DataLake.DataLakeClientOptions.ServiceVersion)) => throw null;
                    public Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey? CustomerProvidedKey { get => throw null; set { } }
                    public bool EnableTenantDiscovery { get => throw null; set { } }
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
                        V2024_02_04 = 21,
                        V2024_05_04 = 22,
                        V2024_08_04 = 23,
                        V2024_11_04 = 24,
                        V2025_01_05 = 25,
                        V2025_05_05 = 26,
                    }
                    public Azure.Storage.TransferValidationOptions TransferValidation { get => throw null; }
                    public Azure.Storage.Files.DataLake.DataLakeClientOptions.ServiceVersion Version { get => throw null; }
                }
                public class DataLakeDirectoryClient : Azure.Storage.Files.DataLake.DataLakePathClient
                {
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Create(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Create(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient> CreateFile(string fileName, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient> CreateFile(string fileName, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient>> CreateFileAsync(string fileName, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient>> CreateFileAsync(string fileName, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient> CreateSubDirectory(string path, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient> CreateSubDirectory(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient>> CreateSubDirectoryAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient>> CreateSubDirectoryAsync(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    protected DataLakeDirectoryClient() => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri) => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeDirectoryClient(string connectionString, string fileSystemName, string directoryPath) => throw null;
                    public DataLakeDirectoryClient(string connectionString, string fileSystemName, string directoryPath, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri, Azure.Storage.StorageSharedKeyCredential credential) => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri, Azure.AzureSasCredential credential) => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri, Azure.AzureSasCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri, Azure.Core.TokenCredential credential) => throw null;
                    public DataLakeDirectoryClient(System.Uri directoryUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public virtual Azure.Response Delete(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteFile(string fileName, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteFileAsync(string fileName, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteSubDirectory(string path, string continuation = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteSubDirectoryAsync(string path, string continuation = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                    public override System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn, out string stringToSign) => throw null;
                    public override System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder) => throw null;
                    public override System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, out string stringToSign) => throw null;
                    public override System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey) => throw null;
                    public override System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, out string stringToSign) => throw null;
                    public override System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey) => throw null;
                    public override System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, out string stringToSign) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathAccessControl> GetAccessControl(bool? userPrincipalName = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathAccessControl>> GetAccessControlAsync(bool? userPrincipalName = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Files.DataLake.DataLakeFileClient GetFileClient(string fileName) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.DataLake.Models.PathItem> GetPaths(bool recursive = default(bool), bool userPrincipalName = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.DataLake.Models.PathItem> GetPathsAsync(bool recursive = default(bool), bool userPrincipalName = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathProperties> GetProperties(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathProperties>> GetPropertiesAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Files.DataLake.DataLakeDirectoryClient GetSubDirectoryClient(string subdirectoryName) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient> Rename(string destinationPath, string destinationFileSystem = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions sourceConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions destinationConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient>> RenameAsync(string destinationPath, string destinationFileSystem = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions sourceConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions destinationConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetAccessControlList(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetAccessControlListAsync(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetHttpHeaders(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetHttpHeadersAsync(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetPermissions(Azure.Storage.Files.DataLake.Models.PathPermissions permissions = default(Azure.Storage.Files.DataLake.Models.PathPermissions), string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetPermissionsAsync(Azure.Storage.Files.DataLake.Models.PathPermissions permissions = default(Azure.Storage.Files.DataLake.Models.PathPermissions), string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public Azure.Storage.Files.DataLake.DataLakeDirectoryClient WithCustomerProvidedKey(Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey? customerProvidedKey) => throw null;
                }
                public class DataLakeFileClient : Azure.Storage.Files.DataLake.DataLakePathClient
                {
                    public virtual Azure.Response Append(System.IO.Stream content, long offset, Azure.Storage.Files.DataLake.Models.DataLakeFileAppendOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileAppendOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response Append(System.IO.Stream content, long offset, byte[] contentHash, string leaseId, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> AppendAsync(System.IO.Stream content, long offset, Azure.Storage.Files.DataLake.Models.DataLakeFileAppendOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileAppendOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> AppendAsync(System.IO.Stream content, long offset, byte[] contentHash, string leaseId, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Create(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Create(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, System.Threading.CancellationToken cancellationToken) => throw null;
                    protected DataLakeFileClient() => throw null;
                    public DataLakeFileClient(System.Uri fileUri) => throw null;
                    public DataLakeFileClient(System.Uri fileUri, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileClient(string connectionString, string fileSystemName, string filePath) => throw null;
                    public DataLakeFileClient(string connectionString, string fileSystemName, string filePath, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileClient(System.Uri fileUri, Azure.Storage.StorageSharedKeyCredential credential) => throw null;
                    public DataLakeFileClient(System.Uri fileUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileClient(System.Uri fileUri, Azure.AzureSasCredential credential) => throw null;
                    public DataLakeFileClient(System.Uri fileUri, Azure.AzureSasCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileClient(System.Uri fileUri, Azure.Core.TokenCredential credential) => throw null;
                    public DataLakeFileClient(System.Uri fileUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public virtual Azure.Response Delete(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Flush(long position, Azure.Storage.Files.DataLake.Models.DataLakeFileFlushOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileFlushOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Flush(long position, bool? retainUncommittedData, bool? close, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> FlushAsync(long position, Azure.Storage.Files.DataLake.Models.DataLakeFileFlushOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileFlushOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> FlushAsync(long position, bool? retainUncommittedData, bool? close, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathAccessControl> GetAccessControl(bool? userPrincipalName = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathAccessControl>> GetAccessControlAsync(bool? userPrincipalName = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathProperties> GetProperties(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathProperties>> GetPropertiesAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual int MaxUploadBytes { get => throw null; }
                    public virtual long MaxUploadLongBytes { get => throw null; }
                    public virtual System.IO.Stream OpenRead(Azure.Storage.Files.DataLake.Models.DataLakeOpenReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenRead(long position = default(long), int? bufferSize = default(int?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenRead(bool allowfileModifications, long position = default(long), int? bufferSize = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(Azure.Storage.Files.DataLake.Models.DataLakeOpenReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(long position = default(long), int? bufferSize = default(int?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(bool allowfileModifications, long position = default(long), int? bufferSize = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenWrite(bool overwrite, Azure.Storage.Files.DataLake.Models.DataLakeFileOpenWriteOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenWriteAsync(bool overwrite, Azure.Storage.Files.DataLake.Models.DataLakeFileOpenWriteOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo> Query(string querySqlExpression, Azure.Storage.Files.DataLake.Models.DataLakeQueryOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeQueryOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo>> QueryAsync(string querySqlExpression, Azure.Storage.Files.DataLake.Models.DataLakeQueryOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeQueryOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo> Read() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo> Read(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo> Read(Azure.HttpRange range, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, bool rangeGetContentHash, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo> Read(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo>> ReadAsync() => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo>> ReadAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo>> ReadAsync(Azure.HttpRange range, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, bool rangeGetContentHash, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileDownloadInfo>> ReadAsync(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadResult> ReadContent() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadResult> ReadContent(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadResult> ReadContent(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadResult>> ReadContentAsync() => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadResult>> ReadContentAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadResult>> ReadContentAsync(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadStreamingResult> ReadStreaming() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadStreamingResult> ReadStreaming(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadStreamingResult> ReadStreaming(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadStreamingResult>> ReadStreamingAsync() => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadStreamingResult>> ReadStreamingAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeFileReadStreamingResult>> ReadStreamingAsync(Azure.Storage.Files.DataLake.Models.DataLakeFileReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response ReadTo(System.IO.Stream destination, Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response ReadTo(string path, Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response ReadTo(System.IO.Stream destination, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, Azure.Storage.StorageTransferOptions transferOptions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response ReadTo(string path, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, Azure.Storage.StorageTransferOptions transferOptions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> ReadToAsync(System.IO.Stream destination, Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> ReadToAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileReadToOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> ReadToAsync(System.IO.Stream destination, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, Azure.Storage.StorageTransferOptions transferOptions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> ReadToAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, Azure.Storage.StorageTransferOptions transferOptions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient> Rename(string destinationPath, string destinationFileSystem = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions sourceConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions destinationConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient>> RenameAsync(string destinationPath, string destinationFileSystem = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions sourceConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions destinationConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> ScheduleDeletion(Azure.Storage.Files.DataLake.Models.DataLakeFileScheduleDeletionOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> ScheduleDeletionAsync(Azure.Storage.Files.DataLake.Models.DataLakeFileScheduleDeletionOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetAccessControlList(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetAccessControlListAsync(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetHttpHeaders(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetHttpHeadersAsync(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetPermissions(Azure.Storage.Files.DataLake.Models.PathPermissions permissions, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public override System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetPermissionsAsync(Azure.Storage.Files.DataLake.Models.PathPermissions permissions, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(System.IO.Stream content, Azure.Storage.Files.DataLake.Models.DataLakeFileUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(System.IO.Stream content, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(System.IO.Stream content) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(System.IO.Stream content, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(string path, Azure.Storage.Files.DataLake.Models.DataLakeFileUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(string path) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Upload(string path, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(System.IO.Stream content, Azure.Storage.Files.DataLake.Models.DataLakeFileUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(System.IO.Stream content, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(System.IO.Stream content) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(System.IO.Stream content, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakeFileUploadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.IProgress<long> progressHandler = default(System.IProgress<long>), Azure.Storage.StorageTransferOptions transferOptions = default(Azure.Storage.StorageTransferOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(string path) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> UploadAsync(string path, bool overwrite = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public Azure.Storage.Files.DataLake.DataLakeFileClient WithCustomerProvidedKey(Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey? customerProvidedKey) => throw null;
                }
                public class DataLakeFileSystemClient
                {
                    public virtual string AccountName { get => throw null; }
                    public virtual bool CanGenerateSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo> Create(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo> Create(Azure.Storage.Files.DataLake.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient> CreateDirectory(string path, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient> CreateDirectory(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient>> CreateDirectoryAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeDirectoryClient>> CreateDirectoryAsync(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient> CreateFile(string path, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient> CreateFile(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient>> CreateFileAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileClient>> CreateFileAsync(string path, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    protected DataLakeFileSystemClient() => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri) => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileSystemClient(string connectionString, string fileSystemName) => throw null;
                    public DataLakeFileSystemClient(string connectionString, string fileSystemName, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri, Azure.Storage.StorageSharedKeyCredential credential) => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri, Azure.AzureSasCredential credential) => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri, Azure.AzureSasCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri, Azure.Core.TokenCredential credential) => throw null;
                    public DataLakeFileSystemClient(System.Uri fileSystemUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public virtual Azure.Response Delete(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteDirectory(string path, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteDirectoryAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteFile(string path, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteFileAsync(string path, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> Exists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> ExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeFileSystemSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeFileSystemSasPermissions permissions, System.DateTimeOffset expiresOn, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeFileSystemSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeFileSystemSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, out string stringToSign) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemAccessPolicy> GetAccessPolicy(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemAccessPolicy>> GetAccessPolicyAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.DataLake.Models.PathDeletedItem> GetDeletedPaths(string pathPrefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.DataLake.Models.PathDeletedItem> GetDeletedPathsAsync(string pathPrefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Files.DataLake.DataLakeDirectoryClient GetDirectoryClient(string directoryName) => throw null;
                    public virtual Azure.Storage.Files.DataLake.DataLakeFileClient GetFileClient(string fileName) => throw null;
                    protected virtual Azure.Storage.Files.DataLake.DataLakeServiceClient GetParentServiceClientCore() => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.DataLake.Models.PathItem> GetPaths(string path = default(string), bool recursive = default(bool), bool userPrincipalName = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.DataLake.Models.PathItem> GetPathsAsync(string path = default(string), bool recursive = default(bool), bool userPrincipalName = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemProperties> GetProperties(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemProperties>> GetPropertiesAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string Name { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo> SetAccessPolicy(Azure.Storage.Files.DataLake.Models.PublicAccessType accessType = default(Azure.Storage.Files.DataLake.Models.PublicAccessType), System.Collections.Generic.IEnumerable<Azure.Storage.Files.DataLake.Models.DataLakeSignedIdentifier> permissions = default(System.Collections.Generic.IEnumerable<Azure.Storage.Files.DataLake.Models.DataLakeSignedIdentifier>), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo>> SetAccessPolicyAsync(Azure.Storage.Files.DataLake.Models.PublicAccessType accessType = default(Azure.Storage.Files.DataLake.Models.PublicAccessType), System.Collections.Generic.IEnumerable<Azure.Storage.Files.DataLake.Models.DataLakeSignedIdentifier> permissions = default(System.Collections.Generic.IEnumerable<Azure.Storage.Files.DataLake.Models.DataLakeSignedIdentifier>), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.FileSystemInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakePathClient> UndeletePath(string deletedPath, string deletionId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakePathClient>> UndeletePathAsync(string deletedPath, string deletionId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri Uri { get => throw null; }
                }
                public class DataLakeLeaseClient
                {
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease> Acquire(System.TimeSpan duration, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease>> AcquireAsync(System.TimeSpan duration, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease> Break(System.TimeSpan? breakPeriod = default(System.TimeSpan?), Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease>> BreakAsync(System.TimeSpan? breakPeriod = default(System.TimeSpan?), Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease> Change(string proposedId, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease>> ChangeAsync(string proposedId, Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected DataLakeLeaseClient() => throw null;
                    public DataLakeLeaseClient(Azure.Storage.Files.DataLake.DataLakePathClient client, string leaseId = default(string)) => throw null;
                    public DataLakeLeaseClient(Azure.Storage.Files.DataLake.DataLakeFileSystemClient client, string leaseId = default(string)) => throw null;
                    public static readonly System.TimeSpan InfiniteLeaseDuration;
                    public virtual string LeaseId { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo> Release(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo>> ReleaseAsync(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease> Renew(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeLease>> RenewAsync(Azure.RequestConditions conditions = default(Azure.RequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public System.Uri Uri { get => throw null; }
                }
                public static partial class DataLakeLeaseClientExtensions
                {
                    public static Azure.Storage.Files.DataLake.DataLakeLeaseClient GetDataLakeLeaseClient(this Azure.Storage.Files.DataLake.DataLakePathClient client, string leaseId = default(string)) => throw null;
                    public static Azure.Storage.Files.DataLake.DataLakeLeaseClient GetDataLakeLeaseClient(this Azure.Storage.Files.DataLake.DataLakeFileSystemClient client, string leaseId = default(string)) => throw null;
                }
                public class DataLakePathClient
                {
                    public virtual string AccountName { get => throw null; }
                    public virtual bool CanGenerateSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Create(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> Create(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateAsync(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> CreateIfNotExists(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakePathCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.DataLake.Models.PathResourceType resourceType, Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, string permissions, string umask, System.Threading.CancellationToken cancellationToken) => throw null;
                    protected DataLakePathClient() => throw null;
                    public DataLakePathClient(System.Uri pathUri) => throw null;
                    public DataLakePathClient(System.Uri pathUri, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakePathClient(string connectionString, string fileSystemName, string path) => throw null;
                    public DataLakePathClient(string connectionString, string fileSystemName, string path, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakePathClient(System.Uri pathUri, Azure.Storage.StorageSharedKeyCredential credential) => throw null;
                    public DataLakePathClient(System.Uri pathUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakePathClient(System.Uri pathUri, Azure.AzureSasCredential credential) => throw null;
                    public DataLakePathClient(System.Uri pathUri, Azure.AzureSasCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakePathClient(System.Uri pathUri, Azure.Core.TokenCredential credential) => throw null;
                    public DataLakePathClient(System.Uri pathUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakePathClient(Azure.Storage.Files.DataLake.DataLakeFileSystemClient fileSystemClient, string path) => throw null;
                    public virtual Azure.Response Delete(bool? recursive = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(bool? recursive = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(bool? recursive = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(bool? recursive = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> Exists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> ExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string FileSystemName { get => throw null; }
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey) => throw null;
                    public virtual System.Uri GenerateUserDelegationSasUri(Azure.Storage.Sas.DataLakeSasBuilder builder, Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, out string stringToSign) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathAccessControl> GetAccessControl(bool? userPrincipalName = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathAccessControl>> GetAccessControlAsync(bool? userPrincipalName = default(bool?), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected virtual Azure.Storage.Files.DataLake.DataLakeDirectoryClient GetParentDirectoryClientCore() => throw null;
                    protected virtual Azure.Storage.Files.DataLake.DataLakeFileSystemClient GetParentFileSystemClientCore() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathProperties> GetProperties(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathProperties>> GetPropertiesAsync(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string Name { get => throw null; }
                    public virtual string Path { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.AccessControlChangeResult> RemoveAccessControlRecursive(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.RemovePathAccessControlItem> accessControlList, string continuationToken = default(string), Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions options = default(Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.AccessControlChangeResult>> RemoveAccessControlRecursiveAsync(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.RemovePathAccessControlItem> accessControlList, string continuationToken = default(string), Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions options = default(Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakePathClient> Rename(string destinationPath, string destinationFileSystem = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions sourceConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions destinationConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakePathClient>> RenameAsync(string destinationPath, string destinationFileSystem = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions sourceConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions destinationConditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetAccessControlList(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetAccessControlListAsync(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.AccessControlChangeResult> SetAccessControlRecursive(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string continuationToken = default(string), Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions options = default(Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.AccessControlChangeResult>> SetAccessControlRecursiveAsync(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string continuationToken = default(string), Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions options = default(Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetHttpHeaders(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetHttpHeadersAsync(Azure.Storage.Files.DataLake.Models.PathHttpHeaders httpHeaders = default(Azure.Storage.Files.DataLake.Models.PathHttpHeaders), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo> SetPermissions(Azure.Storage.Files.DataLake.Models.PathPermissions permissions, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.PathInfo>> SetPermissionsAsync(Azure.Storage.Files.DataLake.Models.PathPermissions permissions, string owner = default(string), string group = default(string), Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.AccessControlChangeResult> UpdateAccessControlRecursive(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string continuationToken = default(string), Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions options = default(Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.AccessControlChangeResult>> UpdateAccessControlRecursiveAsync(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList, string continuationToken = default(string), Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions options = default(Azure.Storage.Files.DataLake.Models.AccessControlChangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri Uri { get => throw null; }
                    public Azure.Storage.Files.DataLake.DataLakePathClient WithCustomerProvidedKey(Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey? customerProvidedKey) => throw null;
                }
                public class DataLakeServiceClient
                {
                    public virtual string AccountName { get => throw null; }
                    public virtual bool CanGenerateAccountSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileSystemClient> CreateFileSystem(string fileSystemName, Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileSystemClient> CreateFileSystem(string fileSystemName, Azure.Storage.Files.DataLake.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileSystemClient>> CreateFileSystemAsync(string fileSystemName, Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions options = default(Azure.Storage.Files.DataLake.Models.DataLakeFileSystemCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileSystemClient>> CreateFileSystemAsync(string fileSystemName, Azure.Storage.Files.DataLake.Models.PublicAccessType publicAccessType, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    protected DataLakeServiceClient() => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri) => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeServiceClient(string connectionString) => throw null;
                    public DataLakeServiceClient(string connectionString, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri, Azure.Storage.StorageSharedKeyCredential credential) => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri, Azure.AzureSasCredential credential) => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri, Azure.AzureSasCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri, Azure.Core.TokenCredential credential) => throw null;
                    public DataLakeServiceClient(System.Uri serviceUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.DataLake.DataLakeClientOptions options) => throw null;
                    public virtual Azure.Response DeleteFileSystem(string fileSystemName, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteFileSystemAsync(string fileSystemName, Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions conditions = default(Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Sas.AccountSasResourceTypes resourceTypes) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Sas.AccountSasResourceTypes resourceTypes, out string stringToSign) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasBuilder builder) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasBuilder builder, out string stringToSign) => throw null;
                    public virtual Azure.Storage.Files.DataLake.DataLakeFileSystemClient GetFileSystemClient(string fileSystemName) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.DataLake.Models.FileSystemItem> GetFileSystems(Azure.Storage.Files.DataLake.Models.FileSystemTraits traits = default(Azure.Storage.Files.DataLake.Models.FileSystemTraits), Azure.Storage.Files.DataLake.Models.FileSystemStates states = default(Azure.Storage.Files.DataLake.Models.FileSystemStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.DataLake.Models.FileSystemItem> GetFileSystems(Azure.Storage.Files.DataLake.Models.FileSystemTraits traits, string prefix, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.DataLake.Models.FileSystemItem> GetFileSystemsAsync(Azure.Storage.Files.DataLake.Models.FileSystemTraits traits = default(Azure.Storage.Files.DataLake.Models.FileSystemTraits), Azure.Storage.Files.DataLake.Models.FileSystemStates states = default(Azure.Storage.Files.DataLake.Models.FileSystemStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.DataLake.Models.FileSystemItem> GetFileSystemsAsync(Azure.Storage.Files.DataLake.Models.FileSystemTraits traits, string prefix, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeServiceProperties> GetProperties(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.DataLakeServiceProperties>> GetPropertiesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.Models.UserDelegationKey> GetUserDelegationKey(System.DateTimeOffset? startsOn, System.DateTimeOffset expiresOn, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.Models.UserDelegationKey>> GetUserDelegationKeyAsync(System.DateTimeOffset? startsOn, System.DateTimeOffset expiresOn, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response SetProperties(Azure.Storage.Files.DataLake.Models.DataLakeServiceProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> SetPropertiesAsync(Azure.Storage.Files.DataLake.Models.DataLakeServiceProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileSystemClient> UndeleteFileSystem(string deletedFileSystemName, string deleteFileSystemVersion, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.DataLake.DataLakeFileSystemClient>> UndeleteFileSystemAsync(string deletedFileSystemName, string deleteFileSystemVersion, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri Uri { get => throw null; }
                }
                public class DataLakeUriBuilder
                {
                    public string AccountName { get => throw null; set { } }
                    public DataLakeUriBuilder(System.Uri uri) => throw null;
                    public string DirectoryOrFilePath { get => throw null; set { } }
                    public string FileSystemName { get => throw null; set { } }
                    public string Host { get => throw null; set { } }
                    public int Port { get => throw null; set { } }
                    public string Query { get => throw null; set { } }
                    public Azure.Storage.Sas.DataLakeSasQueryParameters Sas { get => throw null; set { } }
                    public string Scheme { get => throw null; set { } }
                    public string Snapshot { get => throw null; set { } }
                    public override string ToString() => throw null;
                    public System.Uri ToUri() => throw null;
                }
                namespace Models
                {
                    public struct AccessControlChangeCounters
                    {
                        public long ChangedDirectoriesCount { get => throw null; }
                        public long ChangedFilesCount { get => throw null; }
                        public long FailedChangesCount { get => throw null; }
                    }
                    public struct AccessControlChangeFailure
                    {
                        public string ErrorMessage { get => throw null; }
                        public bool IsDirectory { get => throw null; }
                        public string Name { get => throw null; }
                    }
                    public class AccessControlChangeOptions
                    {
                        public int? BatchSize { get => throw null; set { } }
                        public bool? ContinueOnFailure { get => throw null; set { } }
                        public AccessControlChangeOptions() => throw null;
                        public int? MaxBatches { get => throw null; set { } }
                        public System.IProgress<Azure.Response<Azure.Storage.Files.DataLake.Models.AccessControlChanges>> ProgressHandler { get => throw null; set { } }
                    }
                    public struct AccessControlChangeResult
                    {
                        public Azure.Storage.Files.DataLake.Models.AccessControlChangeFailure[] BatchFailures { get => throw null; }
                        public string ContinuationToken { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.AccessControlChangeCounters Counters { get => throw null; }
                    }
                    public struct AccessControlChanges
                    {
                        public Azure.Storage.Files.DataLake.Models.AccessControlChangeCounters AggregateCounters { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.AccessControlChangeCounters BatchCounters { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.AccessControlChangeFailure[] BatchFailures { get => throw null; }
                        public string ContinuationToken { get => throw null; }
                    }
                    public enum AccessControlType
                    {
                        Other = 0,
                        User = 1,
                        Group = 2,
                        Mask = 4,
                    }
                    public enum CopyStatus
                    {
                        Pending = 0,
                        Success = 1,
                        Aborted = 2,
                        Failed = 3,
                    }
                    public class DataLakeAccessOptions
                    {
                        public System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> AccessControlList { get => throw null; set { } }
                        public DataLakeAccessOptions() => throw null;
                        public string Group { get => throw null; set { } }
                        public string Owner { get => throw null; set { } }
                        public string Permissions { get => throw null; set { } }
                        public string Umask { get => throw null; set { } }
                    }
                    public class DataLakeAccessPolicy
                    {
                        public DataLakeAccessPolicy() => throw null;
                        public System.DateTimeOffset ExpiresOn { get => throw null; set { } }
                        public string Permissions { get => throw null; set { } }
                        public System.DateTimeOffset? PolicyExpiresOn { get => throw null; set { } }
                        public System.DateTimeOffset? PolicyStartsOn { get => throw null; set { } }
                        public System.DateTimeOffset StartsOn { get => throw null; set { } }
                    }
                    public class DataLakeAclChangeFailedException : System.Exception, System.Runtime.Serialization.ISerializable
                    {
                        public string ContinuationToken { get => throw null; }
                        public DataLakeAclChangeFailedException(string message, System.Exception exception, string continuationToken) => throw null;
                        public DataLakeAclChangeFailedException(string message, Azure.RequestFailedException exception, string continuationToken) => throw null;
                        protected DataLakeAclChangeFailedException(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContext context) => throw null;
                        public override void GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContext context) => throw null;
                    }
                    public class DataLakeAnalyticsLogging
                    {
                        public DataLakeAnalyticsLogging() => throw null;
                        public bool Delete { get => throw null; set { } }
                        public bool Read { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeRetentionPolicy RetentionPolicy { get => throw null; set { } }
                        public string Version { get => throw null; set { } }
                        public bool Write { get => throw null; set { } }
                    }
                    public struct DataLakeAudience : System.IEquatable<Azure.Storage.Files.DataLake.Models.DataLakeAudience>
                    {
                        public static Azure.Storage.Files.DataLake.Models.DataLakeAudience CreateDataLakeServiceAccountAudience(string storageAccountName) => throw null;
                        public DataLakeAudience(string value) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.DataLakeAudience DefaultAudience { get => throw null; }
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.DataLake.Models.DataLakeAudience other) => throw null;
                        public override int GetHashCode() => throw null;
                        public static bool operator ==(Azure.Storage.Files.DataLake.Models.DataLakeAudience left, Azure.Storage.Files.DataLake.Models.DataLakeAudience right) => throw null;
                        public static implicit operator Azure.Storage.Files.DataLake.Models.DataLakeAudience(string value) => throw null;
                        public static bool operator !=(Azure.Storage.Files.DataLake.Models.DataLakeAudience left, Azure.Storage.Files.DataLake.Models.DataLakeAudience right) => throw null;
                        public override string ToString() => throw null;
                    }
                    public class DataLakeCorsRule
                    {
                        public string AllowedHeaders { get => throw null; set { } }
                        public string AllowedMethods { get => throw null; set { } }
                        public string AllowedOrigins { get => throw null; set { } }
                        public DataLakeCorsRule() => throw null;
                        public string ExposedHeaders { get => throw null; set { } }
                        public int MaxAgeInSeconds { get => throw null; set { } }
                    }
                    public struct DataLakeCustomerProvidedKey : System.IEquatable<Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey>
                    {
                        public DataLakeCustomerProvidedKey(string key) => throw null;
                        public DataLakeCustomerProvidedKey(byte[] key) => throw null;
                        public Azure.Storage.Files.DataLake.Models.DataLakeEncryptionAlgorithmType EncryptionAlgorithm { get => throw null; }
                        public string EncryptionKey { get => throw null; }
                        public string EncryptionKeyHash { get => throw null; }
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey other) => throw null;
                        public override int GetHashCode() => throw null;
                        public static bool operator ==(Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey left, Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey right) => throw null;
                        public static bool operator !=(Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey left, Azure.Storage.Files.DataLake.Models.DataLakeCustomerProvidedKey right) => throw null;
                        public override string ToString() => throw null;
                    }
                    public enum DataLakeEncryptionAlgorithmType
                    {
                        Aes256 = 0,
                    }
                    public class DataLakeFileAppendOptions
                    {
                        public byte[] ContentHash { get => throw null; set { } }
                        public DataLakeFileAppendOptions() => throw null;
                        public bool? Flush { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseAction? LeaseAction { get => throw null; set { } }
                        public System.TimeSpan? LeaseDuration { get => throw null; set { } }
                        public string LeaseId { get => throw null; set { } }
                        public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                        public string ProposedLeaseId { get => throw null; set { } }
                        public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public enum DataLakeFileExpirationOrigin
                    {
                        CreationTime = 0,
                        Now = 1,
                    }
                    public class DataLakeFileFlushOptions
                    {
                        public bool? Close { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions Conditions { get => throw null; set { } }
                        public DataLakeFileFlushOptions() => throw null;
                        public Azure.Storage.Files.DataLake.Models.PathHttpHeaders HttpHeaders { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseAction? LeaseAction { get => throw null; set { } }
                        public System.TimeSpan? LeaseDuration { get => throw null; set { } }
                        public string ProposedLeaseId { get => throw null; set { } }
                        public bool? RetainUncommittedData { get => throw null; set { } }
                    }
                    public class DataLakeFileOpenWriteOptions
                    {
                        public long? BufferSize { get => throw null; set { } }
                        public bool? Close { get => throw null; set { } }
                        public DataLakeFileOpenWriteOptions() => throw null;
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions OpenConditions { get => throw null; set { } }
                        public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                        public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class DataLakeFileReadOptions
                    {
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions Conditions { get => throw null; set { } }
                        public DataLakeFileReadOptions() => throw null;
                        public Azure.HttpRange Range { get => throw null; set { } }
                        public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class DataLakeFileReadResult
                    {
                        public System.BinaryData Content { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.FileDownloadDetails Details { get => throw null; }
                    }
                    public class DataLakeFileReadStreamingResult : System.IDisposable
                    {
                        public System.IO.Stream Content { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.FileDownloadDetails Details { get => throw null; }
                        public void Dispose() => throw null;
                    }
                    public class DataLakeFileReadToOptions
                    {
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions Conditions { get => throw null; set { } }
                        public DataLakeFileReadToOptions() => throw null;
                        public Azure.Storage.StorageTransferOptions TransferOptions { get => throw null; set { } }
                        public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class DataLakeFileScheduleDeletionOptions
                    {
                        public DataLakeFileScheduleDeletionOptions(System.DateTimeOffset? expiresOn) => throw null;
                        public DataLakeFileScheduleDeletionOptions(System.TimeSpan timeToExpire, Azure.Storage.Files.DataLake.Models.DataLakeFileExpirationOrigin setRelativeTo) => throw null;
                        public DataLakeFileScheduleDeletionOptions() => throw null;
                        public System.DateTimeOffset? ExpiresOn { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeFileExpirationOrigin? SetExpiryRelativeTo { get => throw null; }
                        public System.TimeSpan? TimeToExpire { get => throw null; }
                    }
                    public class DataLakeFileSystemCreateOptions
                    {
                        public DataLakeFileSystemCreateOptions() => throw null;
                        public Azure.Storage.Files.DataLake.Models.DataLakeFileSystemEncryptionScopeOptions EncryptionScopeOptions { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.PublicAccessType PublicAccessType { get => throw null; set { } }
                    }
                    public class DataLakeFileSystemEncryptionScopeOptions
                    {
                        public DataLakeFileSystemEncryptionScopeOptions() => throw null;
                        public string DefaultEncryptionScope { get => throw null; set { } }
                        public bool PreventEncryptionScopeOverride { get => throw null; set { } }
                    }
                    public class DataLakeFileUploadOptions
                    {
                        public bool? Close { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions Conditions { get => throw null; set { } }
                        public DataLakeFileUploadOptions() => throw null;
                        public string EncryptionContext { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.PathHttpHeaders HttpHeaders { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public string Permissions { get => throw null; set { } }
                        public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                        public Azure.Storage.StorageTransferOptions TransferOptions { get => throw null; set { } }
                        public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                        public string Umask { get => throw null; set { } }
                    }
                    public class DataLakeLease
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public string LeaseId { get => throw null; }
                        public int? LeaseTime { get => throw null; }
                    }
                    public enum DataLakeLeaseAction
                    {
                        Acquire = 0,
                        AutoRenew = 1,
                        Release = 2,
                        AcquireRelease = 3,
                    }
                    public enum DataLakeLeaseDuration
                    {
                        Infinite = 0,
                        Fixed = 1,
                    }
                    public enum DataLakeLeaseState
                    {
                        Available = 0,
                        Leased = 1,
                        Expired = 2,
                        Breaking = 3,
                        Broken = 4,
                    }
                    public enum DataLakeLeaseStatus
                    {
                        Locked = 0,
                        Unlocked = 1,
                    }
                    public class DataLakeMetrics
                    {
                        public DataLakeMetrics() => throw null;
                        public bool Enabled { get => throw null; set { } }
                        public bool? IncludeApis { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeRetentionPolicy RetentionPolicy { get => throw null; set { } }
                        public string Version { get => throw null; set { } }
                    }
                    public static class DataLakeModelFactory
                    {
                        public static Azure.Storage.Files.DataLake.Models.DataLakeFileReadResult DataLakeFileReadResult(System.BinaryData content, Azure.Storage.Files.DataLake.Models.FileDownloadDetails details) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.DataLakeFileReadStreamingResult DataLakeFileReadStreamingResult(System.IO.Stream content, Azure.Storage.Files.DataLake.Models.FileDownloadDetails details) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.DataLakeQueryError DataLakeQueryError(string name = default(string), string description = default(string), bool isFatal = default(bool), long position = default(long)) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileDownloadDetails FileDownloadDetails(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentRange, Azure.ETag eTag, string contentEncoding, string cacheControl, string contentDisposition, string contentLanguage, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, byte[] contentHash, System.DateTimeOffset createdOn, string encryptionContext, System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileDownloadDetails FileDownloadDetails(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentRange, Azure.ETag eTag, string contentEncoding, string cacheControl, string contentDisposition, string contentLanguage, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, byte[] contentHash, System.DateTimeOffset createdOn, string encryptionContext) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileDownloadDetails FileDownloadDetails(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentRange, Azure.ETag eTag, string contentEncoding, string cacheControl, string contentDisposition, string contentLanguage, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, byte[] contentHash, System.DateTimeOffset createdOn) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileDownloadDetails FileDownloadDetails(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentRange, Azure.ETag eTag, string contentEncoding, string cacheControl, string contentDisposition, string contentLanguage, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, byte[] contentHash) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileDownloadInfo FileDownloadInfo(long contentLength, System.IO.Stream content, byte[] contentHash, Azure.Storage.Files.DataLake.Models.FileDownloadDetails properties) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileSystemInfo FileSystemInfo(Azure.ETag etag, System.DateTimeOffset lastModified) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileSystemItem FileSystemItem(string name = default(string), bool? isDeleted = default(bool?), string versionId = default(string), Azure.Storage.Files.DataLake.Models.FileSystemProperties properties = default(Azure.Storage.Files.DataLake.Models.FileSystemProperties)) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileSystemItem FileSystemItem(string name, Azure.Storage.Files.DataLake.Models.FileSystemProperties properties) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileSystemProperties FileSystemProperties(System.DateTimeOffset lastModified = default(System.DateTimeOffset), Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus? leaseStatus = default(Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus?), Azure.Storage.Files.DataLake.Models.DataLakeLeaseState? leaseState = default(Azure.Storage.Files.DataLake.Models.DataLakeLeaseState?), Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration? leaseDuration = default(Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration?), Azure.Storage.Files.DataLake.Models.PublicAccessType? publicAccess = default(Azure.Storage.Files.DataLake.Models.PublicAccessType?), bool? hasImmutabilityPolicy = default(bool?), bool? hasLegalHold = default(bool?), Azure.ETag eTag = default(Azure.ETag), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.DateTimeOffset? deletedOn = default(System.DateTimeOffset?), int? remainingRetentionDays = default(int?)) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.FileSystemProperties FileSystemProperties(System.DateTimeOffset lastModified, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus? leaseStatus, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState? leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration? leaseDuration, Azure.Storage.Files.DataLake.Models.PublicAccessType? publicAccess, bool? hasImmutabilityPolicy, bool? hasLegalHold, Azure.ETag eTag) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.DataLakeLease Lease(Azure.ETag eTag, System.DateTimeOffset lastModified, string leaseId, int? leaseTime) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathAccessControl PathAccessControl(string owner, string group, Azure.Storage.Files.DataLake.Models.PathPermissions permissions, System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> acl) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathContentInfo PathContentInfo(string contentHash, Azure.ETag eTag, System.DateTimeOffset lastModified, string acceptRanges, string cacheControl, string contentDisposition, string contentEncoding, string contentLanguage, long contentLength, string contentRange, string contentType, System.Collections.Generic.IDictionary<string, string> metadata) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathCreateInfo PathCreateInfo(Azure.Storage.Files.DataLake.Models.PathInfo pathInfo, string continuation) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathInfo PathInfo(Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathItem PathItem(string name, bool? isDirectory, System.DateTimeOffset lastModified, Azure.ETag eTag, long? contentLength, string owner, string group, string permissions, System.DateTimeOffset? createdOn, System.DateTimeOffset? expiresOn, string encryptionContext) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathItem PathItem(string name, bool? isDirectory, System.DateTimeOffset lastModified, Azure.ETag eTag, long? contentLength, string owner, string group, string permissions, System.DateTimeOffset? createdOn, System.DateTimeOffset? expiresOn) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathItem PathItem(string name, bool? isDirectory, System.DateTimeOffset lastModified, Azure.ETag eTag, long? contentLength, string owner, string group, string permissions) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathProperties PathProperties(System.DateTimeOffset lastModified, System.DateTimeOffset creationTime, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, bool isIncrementalCopy, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, byte[] contentHash, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, string accessTier, string archiveStatus, System.DateTimeOffset accessTierChangeTime, bool isDirectory, string encryptionContext, string owner, string group, string permissions, System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathProperties PathProperties(System.DateTimeOffset lastModified, System.DateTimeOffset creationTime, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, bool isIncrementalCopy, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, byte[] contentHash, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, string accessTier, string archiveStatus, System.DateTimeOffset accessTierChangeTime, bool isDirectory, string encryptionContext, string owner, string group, string permissions) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathProperties PathProperties(System.DateTimeOffset lastModified, System.DateTimeOffset creationTime, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, bool isIncrementalCopy, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, byte[] contentHash, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, string accessTier, string archiveStatus, System.DateTimeOffset accessTierChangeTime, bool isDirectory, string encryptionContext) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathProperties PathProperties(System.DateTimeOffset lastModified, System.DateTimeOffset creationTime, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, bool isIncrementalCopy, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, byte[] contentHash, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, string accessTier, string archiveStatus, System.DateTimeOffset accessTierChangeTime, bool isDirectory) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathProperties PathProperties(System.DateTimeOffset lastModified, System.DateTimeOffset creationTime, System.Collections.Generic.IDictionary<string, string> metadata, System.DateTimeOffset copyCompletionTime, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.DataLake.Models.CopyStatus copyStatus, bool isIncrementalCopy, Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration leaseDuration, Azure.Storage.Files.DataLake.Models.DataLakeLeaseState leaseState, Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus leaseStatus, long contentLength, string contentType, Azure.ETag eTag, byte[] contentHash, string contentEncoding, string contentDisposition, string contentLanguage, string cacheControl, string acceptRanges, bool isServerEncrypted, string encryptionKeySha256, string accessTier, string archiveStatus, System.DateTimeOffset accessTierChangeTime) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.UserDelegationKey UserDelegationKey(string signedObjectId, string signedTenantId, System.DateTimeOffset signedStart, System.DateTimeOffset signedExpiry, string signedService, string signedVersion, string value) => throw null;
                    }
                    public class DataLakeOpenReadOptions
                    {
                        public int? BufferSize { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions Conditions { get => throw null; set { } }
                        public DataLakeOpenReadOptions(bool allowModifications) => throw null;
                        public long Position { get => throw null; set { } }
                        public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class DataLakePathCreateOptions
                    {
                        public Azure.Storage.Files.DataLake.Models.DataLakeAccessOptions AccessOptions { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions Conditions { get => throw null; set { } }
                        public DataLakePathCreateOptions() => throw null;
                        public string EncryptionContext { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.PathHttpHeaders HttpHeaders { get => throw null; set { } }
                        public System.TimeSpan? LeaseDuration { get => throw null; set { } }
                        public string LeaseId { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakePathScheduleDeletionOptions ScheduleDeletionOptions { get => throw null; set { } }
                    }
                    public class DataLakePathScheduleDeletionOptions
                    {
                        public DataLakePathScheduleDeletionOptions(System.DateTimeOffset? expiresOn) => throw null;
                        public DataLakePathScheduleDeletionOptions(System.TimeSpan? timeToExpire) => throw null;
                        public System.DateTimeOffset? ExpiresOn { get => throw null; }
                        public System.TimeSpan? TimeToExpire { get => throw null; }
                    }
                    public class DataLakeQueryArrowField
                    {
                        public DataLakeQueryArrowField() => throw null;
                        public string Name { get => throw null; set { } }
                        public int Precision { get => throw null; set { } }
                        public int Scale { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeQueryArrowFieldType Type { get => throw null; set { } }
                    }
                    public enum DataLakeQueryArrowFieldType
                    {
                        Int64 = 0,
                        Bool = 1,
                        Timestamp = 2,
                        String = 3,
                        Double = 4,
                        Decimal = 5,
                    }
                    public class DataLakeQueryArrowOptions : Azure.Storage.Files.DataLake.Models.DataLakeQueryTextOptions
                    {
                        public DataLakeQueryArrowOptions() => throw null;
                        public System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.DataLakeQueryArrowField> Schema { get => throw null; set { } }
                    }
                    public class DataLakeQueryCsvTextOptions : Azure.Storage.Files.DataLake.Models.DataLakeQueryTextOptions
                    {
                        public string ColumnSeparator { get => throw null; set { } }
                        public DataLakeQueryCsvTextOptions() => throw null;
                        public char? EscapeCharacter { get => throw null; set { } }
                        public bool HasHeaders { get => throw null; set { } }
                        public char? QuotationCharacter { get => throw null; set { } }
                        public string RecordSeparator { get => throw null; set { } }
                    }
                    public class DataLakeQueryError
                    {
                        public string Description { get => throw null; }
                        public bool IsFatal { get => throw null; }
                        public string Name { get => throw null; }
                        public long Position { get => throw null; }
                    }
                    public class DataLakeQueryJsonTextOptions : Azure.Storage.Files.DataLake.Models.DataLakeQueryTextOptions
                    {
                        public DataLakeQueryJsonTextOptions() => throw null;
                        public string RecordSeparator { get => throw null; set { } }
                    }
                    public class DataLakeQueryOptions
                    {
                        public Azure.Storage.Files.DataLake.Models.DataLakeRequestConditions Conditions { get => throw null; set { } }
                        public DataLakeQueryOptions() => throw null;
                        public event System.Action<Azure.Storage.Files.DataLake.Models.DataLakeQueryError> ErrorHandler;
                        public Azure.Storage.Files.DataLake.Models.DataLakeQueryTextOptions InputTextConfiguration { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeQueryTextOptions OutputTextConfiguration { get => throw null; set { } }
                        public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                    }
                    public class DataLakeQueryParquetTextOptions : Azure.Storage.Files.DataLake.Models.DataLakeQueryTextOptions
                    {
                        public DataLakeQueryParquetTextOptions() => throw null;
                    }
                    public abstract class DataLakeQueryTextOptions
                    {
                        protected DataLakeQueryTextOptions() => throw null;
                    }
                    public class DataLakeRequestConditions : Azure.RequestConditions
                    {
                        public DataLakeRequestConditions() => throw null;
                        public string LeaseId { get => throw null; set { } }
                        public override string ToString() => throw null;
                    }
                    public class DataLakeRetentionPolicy
                    {
                        public DataLakeRetentionPolicy() => throw null;
                        public int? Days { get => throw null; set { } }
                        public bool Enabled { get => throw null; set { } }
                    }
                    public class DataLakeServiceProperties
                    {
                        public System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.DataLakeCorsRule> Cors { get => throw null; set { } }
                        public DataLakeServiceProperties() => throw null;
                        public string DefaultServiceVersion { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeRetentionPolicy DeleteRetentionPolicy { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeMetrics HourMetrics { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeAnalyticsLogging Logging { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeMetrics MinuteMetrics { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.DataLakeStaticWebsite StaticWebsite { get => throw null; set { } }
                    }
                    public class DataLakeSignedIdentifier
                    {
                        public Azure.Storage.Files.DataLake.Models.DataLakeAccessPolicy AccessPolicy { get => throw null; set { } }
                        public DataLakeSignedIdentifier() => throw null;
                        public string Id { get => throw null; set { } }
                    }
                    public class DataLakeStaticWebsite
                    {
                        public DataLakeStaticWebsite() => throw null;
                        public string DefaultIndexDocumentPath { get => throw null; set { } }
                        public bool Enabled { get => throw null; set { } }
                        public string ErrorDocument404Path { get => throw null; set { } }
                        public string IndexDocument { get => throw null; set { } }
                    }
                    public class FileDownloadDetails
                    {
                        public string AcceptRanges { get => throw null; }
                        public System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> AccessControlList { get => throw null; }
                        public string CacheControl { get => throw null; }
                        public string ContentDisposition { get => throw null; }
                        public string ContentEncoding { get => throw null; }
                        public byte[] ContentHash { get => throw null; }
                        public string ContentLanguage { get => throw null; }
                        public string ContentRange { get => throw null; }
                        public System.DateTimeOffset CopyCompletedOn { get => throw null; }
                        public string CopyId { get => throw null; }
                        public string CopyProgress { get => throw null; }
                        public System.Uri CopySource { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.CopyStatus CopyStatus { get => throw null; }
                        public string CopyStatusDescription { get => throw null; }
                        public System.DateTimeOffset CreatedOn { get => throw null; }
                        public string EncryptionContext { get => throw null; }
                        public string EncryptionKeySha256 { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public bool IsServerEncrypted { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration LeaseDuration { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseState LeaseState { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus LeaseStatus { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                    }
                    public class FileDownloadInfo
                    {
                        public System.IO.Stream Content { get => throw null; }
                        public byte[] ContentHash { get => throw null; }
                        public long ContentLength { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.FileDownloadDetails Properties { get => throw null; }
                    }
                    public class FileSystemAccessPolicy
                    {
                        public FileSystemAccessPolicy() => throw null;
                        public Azure.Storage.Files.DataLake.Models.PublicAccessType DataLakePublicAccess { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public System.Collections.Generic.IEnumerable<Azure.Storage.Files.DataLake.Models.DataLakeSignedIdentifier> SignedIdentifiers { get => throw null; }
                    }
                    public class FileSystemInfo
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                    }
                    public class FileSystemItem
                    {
                        public bool? IsDeleted { get => throw null; }
                        public string Name { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.FileSystemProperties Properties { get => throw null; }
                        public string VersionId { get => throw null; }
                    }
                    public class FileSystemProperties
                    {
                        public string DefaultEncryptionScope { get => throw null; }
                        public System.DateTimeOffset? DeletedOn { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public bool? HasImmutabilityPolicy { get => throw null; }
                        public bool? HasLegalHold { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration? LeaseDuration { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseState? LeaseState { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus? LeaseStatus { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                        public bool? PreventEncryptionScopeOverride { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.PublicAccessType? PublicAccess { get => throw null; }
                        public int? RemainingRetentionDays { get => throw null; }
                    }
                    [System.Flags]
                    public enum FileSystemStates
                    {
                        None = 0,
                        Deleted = 1,
                        System = 2,
                    }
                    [System.Flags]
                    public enum FileSystemTraits
                    {
                        None = 0,
                        Metadata = 1,
                    }
                    public class PathAccessControl
                    {
                        public System.Collections.Generic.IEnumerable<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> AccessControlList { get => throw null; }
                        public string Group { get => throw null; }
                        public string Owner { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.PathPermissions Permissions { get => throw null; }
                    }
                    public static partial class PathAccessControlExtensions
                    {
                        public static System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> ParseAccessControlList(string s) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.RolePermissions ParseOctalRolePermissions(char c) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.RolePermissions ParseSymbolicRolePermissions(string s, bool allowStickyBit = default(bool)) => throw null;
                        public static string ToAccessControlListString(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> accessControlList) => throw null;
                        public static string ToOctalRolePermissions(this Azure.Storage.Files.DataLake.Models.RolePermissions rolePermissions) => throw null;
                        public static string ToSymbolicRolePermissions(this Azure.Storage.Files.DataLake.Models.RolePermissions rolePermissions) => throw null;
                        public static string ToSymbolicRolePermissions(this Azure.Storage.Files.DataLake.Models.RolePermissions rolePermissions, bool stickyBit) => throw null;
                    }
                    public class PathAccessControlItem
                    {
                        public Azure.Storage.Files.DataLake.Models.AccessControlType AccessControlType { get => throw null; set { } }
                        public PathAccessControlItem() => throw null;
                        public PathAccessControlItem(Azure.Storage.Files.DataLake.Models.AccessControlType accessControlType, Azure.Storage.Files.DataLake.Models.RolePermissions permissions, bool defaultScope = default(bool), string entityId = default(string)) => throw null;
                        public bool DefaultScope { get => throw null; set { } }
                        public string EntityId { get => throw null; set { } }
                        public static Azure.Storage.Files.DataLake.Models.PathAccessControlItem Parse(string s) => throw null;
                        public Azure.Storage.Files.DataLake.Models.RolePermissions Permissions { get => throw null; set { } }
                        public override string ToString() => throw null;
                    }
                    public class PathContentInfo
                    {
                        public string AcceptRanges { get => throw null; }
                        public string CacheControl { get => throw null; }
                        public string ContentDisposition { get => throw null; }
                        public string ContentEncoding { get => throw null; }
                        public string ContentHash { get => throw null; }
                        public string ContentLanguage { get => throw null; }
                        public long ContentLength { get => throw null; }
                        public string ContentRange { get => throw null; }
                        public string ContentType { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                    }
                    public class PathCreateInfo
                    {
                        public string Continuation { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.PathInfo PathInfo { get => throw null; }
                    }
                    public class PathDeletedItem
                    {
                        public System.DateTimeOffset? DeletedOn { get => throw null; }
                        public string DeletionId { get => throw null; }
                        public string Path { get => throw null; }
                        public int? RemainingRetentionDays { get => throw null; }
                    }
                    public enum PathGetPropertiesAction
                    {
                        GetAccessControl = 0,
                        GetStatus = 1,
                    }
                    public class PathHttpHeaders
                    {
                        public string CacheControl { get => throw null; set { } }
                        public string ContentDisposition { get => throw null; set { } }
                        public string ContentEncoding { get => throw null; set { } }
                        public byte[] ContentHash { get => throw null; set { } }
                        public string ContentLanguage { get => throw null; set { } }
                        public string ContentType { get => throw null; set { } }
                        public PathHttpHeaders() => throw null;
                        public override bool Equals(object obj) => throw null;
                        public override int GetHashCode() => throw null;
                        public override string ToString() => throw null;
                    }
                    public class PathInfo
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                    }
                    public class PathItem
                    {
                        public long? ContentLength { get => throw null; }
                        public System.DateTimeOffset? CreatedOn { get => throw null; }
                        public string EncryptionContext { get => throw null; }
                        public string EncryptionScope { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset? ExpiresOn { get => throw null; }
                        public string Group { get => throw null; }
                        public bool? IsDirectory { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public string Name { get => throw null; }
                        public string Owner { get => throw null; }
                        public string Permissions { get => throw null; }
                    }
                    public enum PathLeaseAction
                    {
                        Acquire = 0,
                        Break = 1,
                        Change = 2,
                        Renew = 3,
                        Release = 4,
                    }
                    public class PathPermissions
                    {
                        public PathPermissions() => throw null;
                        public PathPermissions(Azure.Storage.Files.DataLake.Models.RolePermissions owner, Azure.Storage.Files.DataLake.Models.RolePermissions group, Azure.Storage.Files.DataLake.Models.RolePermissions other, bool stickyBit = default(bool), bool extendedInfoInAcl = default(bool)) => throw null;
                        public bool ExtendedAcls { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.RolePermissions Group { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.RolePermissions Other { get => throw null; set { } }
                        public Azure.Storage.Files.DataLake.Models.RolePermissions Owner { get => throw null; set { } }
                        public static Azure.Storage.Files.DataLake.Models.PathPermissions ParseOctalPermissions(string s) => throw null;
                        public static Azure.Storage.Files.DataLake.Models.PathPermissions ParseSymbolicPermissions(string s) => throw null;
                        public bool StickyBit { get => throw null; set { } }
                        public string ToOctalPermissions() => throw null;
                        public string ToSymbolicPermissions() => throw null;
                    }
                    public class PathProperties
                    {
                        public string AcceptRanges { get => throw null; }
                        public System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.PathAccessControlItem> AccessControlList { get => throw null; set { } }
                        public string AccessTier { get => throw null; }
                        public System.DateTimeOffset AccessTierChangedOn { get => throw null; }
                        public string ArchiveStatus { get => throw null; }
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
                        public Azure.Storage.Files.DataLake.Models.CopyStatus CopyStatus { get => throw null; }
                        public string CopyStatusDescription { get => throw null; }
                        public System.DateTimeOffset CreatedOn { get => throw null; }
                        public string EncryptionContext { get => throw null; }
                        public string EncryptionKeySha256 { get => throw null; }
                        public string EncryptionScope { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset ExpiresOn { get => throw null; }
                        public string Group { get => throw null; }
                        public bool IsDirectory { get => throw null; }
                        public bool IsIncrementalCopy { get => throw null; }
                        public bool IsServerEncrypted { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseDuration LeaseDuration { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseState LeaseState { get => throw null; }
                        public Azure.Storage.Files.DataLake.Models.DataLakeLeaseStatus LeaseStatus { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                        public string Owner { get => throw null; }
                        public string Permissions { get => throw null; }
                    }
                    public enum PathRenameMode
                    {
                        Legacy = 0,
                        Posix = 1,
                    }
                    public enum PathResourceType
                    {
                        Directory = 0,
                        File = 1,
                    }
                    public enum PathUpdateAction
                    {
                        Append = 0,
                        Flush = 1,
                        SetProperties = 2,
                        SetAccessControl = 3,
                        SetAccessControlRecursive = 4,
                    }
                    public enum PublicAccessType
                    {
                        None = 0,
                        FileSystem = 1,
                        Path = 2,
                    }
                    public struct ReleasedObjectInfo : System.IEquatable<Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo>
                    {
                        public ReleasedObjectInfo(Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo other) => throw null;
                        public Azure.ETag ETag { get => throw null; }
                        public override int GetHashCode() => throw null;
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public static bool operator ==(Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo left, Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo right) => throw null;
                        public static bool operator !=(Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo left, Azure.Storage.Files.DataLake.Models.ReleasedObjectInfo right) => throw null;
                        public override string ToString() => throw null;
                    }
                    public class RemovePathAccessControlItem
                    {
                        public Azure.Storage.Files.DataLake.Models.AccessControlType AccessControlType { get => throw null; }
                        public RemovePathAccessControlItem(Azure.Storage.Files.DataLake.Models.AccessControlType accessControlType, bool defaultScope = default(bool), string entityId = default(string)) => throw null;
                        public bool DefaultScope { get => throw null; }
                        public string EntityId { get => throw null; }
                        public static Azure.Storage.Files.DataLake.Models.RemovePathAccessControlItem Parse(string serializedAccessControl) => throw null;
                        public static System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.RemovePathAccessControlItem> ParseAccessControlList(string s) => throw null;
                        public static string ToAccessControlListString(System.Collections.Generic.IList<Azure.Storage.Files.DataLake.Models.RemovePathAccessControlItem> accessControlList) => throw null;
                        public override string ToString() => throw null;
                    }
                    [System.Flags]
                    public enum RolePermissions
                    {
                        None = 0,
                        Execute = 1,
                        Write = 2,
                        Read = 4,
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
                    public static partial class SpecializedDataLakeExtensions
                    {
                        public static Azure.Storage.Files.DataLake.DataLakeDirectoryClient GetParentDirectoryClient(this Azure.Storage.Files.DataLake.DataLakePathClient client) => throw null;
                        public static Azure.Storage.Files.DataLake.DataLakeFileSystemClient GetParentFileSystemClient(this Azure.Storage.Files.DataLake.DataLakePathClient client) => throw null;
                        public static Azure.Storage.Files.DataLake.DataLakeServiceClient GetParentServiceClient(this Azure.Storage.Files.DataLake.DataLakeFileSystemClient client) => throw null;
                    }
                }
            }
        }
        namespace Sas
        {
            [System.Flags]
            public enum DataLakeAccountSasPermissions
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
            public enum DataLakeFileSystemSasPermissions
            {
                Read = 1,
                Add = 2,
                Create = 4,
                Write = 8,
                Delete = 16,
                List = 32,
                Move = 64,
                Execute = 128,
                ManageOwnership = 256,
                ManageAccessControl = 512,
                All = -1,
            }
            public class DataLakeSasBuilder
            {
                public string AgentObjectId { get => throw null; set { } }
                public string CacheControl { get => throw null; set { } }
                public string ContentDisposition { get => throw null; set { } }
                public string ContentEncoding { get => throw null; set { } }
                public string ContentLanguage { get => throw null; set { } }
                public string ContentType { get => throw null; set { } }
                public string CorrelationId { get => throw null; set { } }
                public DataLakeSasBuilder() => throw null;
                public DataLakeSasBuilder(Azure.Storage.Sas.DataLakeSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                public DataLakeSasBuilder(Azure.Storage.Sas.DataLakeFileSystemSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                public string EncryptionScope { get => throw null; set { } }
                public override bool Equals(object obj) => throw null;
                public System.DateTimeOffset ExpiresOn { get => throw null; set { } }
                public string FileSystemName { get => throw null; set { } }
                public override int GetHashCode() => throw null;
                public string Identifier { get => throw null; set { } }
                public Azure.Storage.Sas.SasIPRange IPRange { get => throw null; set { } }
                public bool? IsDirectory { get => throw null; set { } }
                public string Path { get => throw null; set { } }
                public string Permissions { get => throw null; }
                public string PreauthorizedAgentObjectId { get => throw null; set { } }
                public Azure.Storage.Sas.SasProtocol Protocol { get => throw null; set { } }
                public string Resource { get => throw null; set { } }
                public void SetPermissions(Azure.Storage.Sas.DataLakeSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.DataLakeAccountSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.DataLakeFileSystemSasPermissions permissions) => throw null;
                public void SetPermissions(string rawPermissions, bool normalize = default(bool)) => throw null;
                public void SetPermissions(string rawPermissions) => throw null;
                public System.DateTimeOffset StartsOn { get => throw null; set { } }
                public Azure.Storage.Sas.DataLakeSasQueryParameters ToSasQueryParameters(Azure.Storage.StorageSharedKeyCredential sharedKeyCredential) => throw null;
                public Azure.Storage.Sas.DataLakeSasQueryParameters ToSasQueryParameters(Azure.Storage.StorageSharedKeyCredential sharedKeyCredential, out string stringToSign) => throw null;
                public Azure.Storage.Sas.DataLakeSasQueryParameters ToSasQueryParameters(Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, string accountName) => throw null;
                public Azure.Storage.Sas.DataLakeSasQueryParameters ToSasQueryParameters(Azure.Storage.Files.DataLake.Models.UserDelegationKey userDelegationKey, string accountName, out string stringToSign) => throw null;
                public override string ToString() => throw null;
                public string Version { get => throw null; set { } }
            }
            [System.Flags]
            public enum DataLakeSasPermissions
            {
                Read = 1,
                Add = 2,
                Create = 4,
                Write = 8,
                Delete = 16,
                List = 32,
                Move = 64,
                Execute = 128,
                ManageOwnership = 256,
                ManageAccessControl = 512,
                All = -1,
            }
            public sealed class DataLakeSasQueryParameters : Azure.Storage.Sas.SasQueryParameters
            {
                public static Azure.Storage.Sas.DataLakeSasQueryParameters Empty { get => throw null; }
                public System.DateTimeOffset KeyExpiresOn { get => throw null; }
                public string KeyObjectId { get => throw null; }
                public string KeyService { get => throw null; }
                public System.DateTimeOffset KeyStartsOn { get => throw null; }
                public string KeyTenantId { get => throw null; }
                public string KeyVersion { get => throw null; }
                public override string ToString() => throw null;
            }
        }
    }
}
// namespace Microsoft
// {
//     namespace Extensions
//     {
//         namespace Azure
//         {
//             public static partial class DataLakeClientBuilderExtensions
//             {
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.DataLake.DataLakeServiceClient, Azure.Storage.Files.DataLake.DataLakeClientOptions> AddDataLakeServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilderWithCredential => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.DataLake.DataLakeServiceClient, Azure.Storage.Files.DataLake.DataLakeClientOptions> AddDataLakeServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri, Azure.Storage.StorageSharedKeyCredential sharedKeyCredential) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilder => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.DataLake.DataLakeServiceClient, Azure.Storage.Files.DataLake.DataLakeClientOptions> AddDataLakeServiceClient<TBuilder, TConfiguration>(this TBuilder builder, TConfiguration configuration) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilderWithConfiguration<TConfiguration> => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.DataLake.DataLakeServiceClient, Azure.Storage.Files.DataLake.DataLakeClientOptions> AddDataLakeServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri, Azure.Core.TokenCredential tokenCredential) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilderWithCredential => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.DataLake.DataLakeServiceClient, Azure.Storage.Files.DataLake.DataLakeClientOptions> AddDataLakeServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri, Azure.AzureSasCredential sasCredential) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilder => throw null;
//             }
//         }
//     }
// }
