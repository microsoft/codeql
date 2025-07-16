// This file contains auto-generated code.
// Generated from `Azure.Storage.Files.Shares, Version=12.22.0.0, Culture=neutral, PublicKeyToken=92742159e12e44c8`.
namespace Azure
{
    namespace Storage
    {
        namespace Files
        {
            namespace Shares
            {
                namespace Models
                {
                    public class CloseHandlesResult
                    {
                        public int ClosedHandlesCount { get => throw null; }
                        public int FailedHandlesCount { get => throw null; }
                    }
                    [System.Flags]
                    public enum CopyableFileSmbProperties
                    {
                        None = 0,
                        FileAttributes = 1,
                        CreatedOn = 2,
                        LastWrittenOn = 4,
                        ChangedOn = 8,
                        All = -1,
                    }
                    public enum CopyStatus
                    {
                        Pending = 0,
                        Success = 1,
                        Aborted = 2,
                        Failed = 3,
                    }
                    public enum FileLastWrittenMode
                    {
                        Now = 0,
                        Preserve = 1,
                    }
                    public class FileLeaseReleaseInfo
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                    }
                    public static class FileModelFactory
                    {
                        public static Azure.Storage.Files.Shares.Models.CloseHandlesResult ClosedHandlesInfo(int closedHandlesCount) => throw null;
                        public static Azure.Storage.Files.Shares.Models.CloseHandlesResult ClosedHandlesInfo(int closedHandlesCount, int failedHandlesCount) => throw null;
                    }
                    public enum FilePermissionFormat
                    {
                        Sddl = 0,
                        Binary = 1,
                    }
                    public class FilePosixProperties
                    {
                        public FilePosixProperties() => throw null;
                        public Azure.Storage.Files.Shares.Models.NfsFileMode FileMode { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.NfsFileType? FileType { get => throw null; }
                        public string Group { get => throw null; set { } }
                        public long? LinkCount { get => throw null; }
                        public string Owner { get => throw null; set { } }
                    }
                    public class FileSmbProperties
                    {
                        public FileSmbProperties() => throw null;
                        public override bool Equals(object other) => throw null;
                        public Azure.Storage.Files.Shares.Models.NtfsFileAttributes? FileAttributes { get => throw null; set { } }
                        public System.DateTimeOffset? FileChangedOn { get => throw null; set { } }
                        public System.DateTimeOffset? FileCreatedOn { get => throw null; set { } }
                        public string FileId { get => throw null; }
                        public System.DateTimeOffset? FileLastWrittenOn { get => throw null; set { } }
                        public string FilePermissionKey { get => throw null; set { } }
                        public override int GetHashCode() => throw null;
                        public string ParentId { get => throw null; }
                    }
                    public static class FilesModelFactory
                    {
                        public static Azure.Storage.Files.Shares.Models.FilePosixProperties FilePosixProperties(Azure.Storage.Files.Shares.Models.NfsFileMode fileMode, string owner, string group, Azure.Storage.Files.Shares.Models.NfsFileType fileType, long? linkCount) => throw null;
                        public static Azure.Storage.Files.Shares.Models.FileSmbProperties FileSmbProperties(System.DateTimeOffset? fileChangedOn, string fileId, string parentId) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileItem ShareFileItem(bool isDirectory = default(bool), string name = default(string), long? fileSize = default(long?), string id = default(string), Azure.Storage.Files.Shares.Models.ShareFileItemProperties properties = default(Azure.Storage.Files.Shares.Models.ShareFileItemProperties), Azure.Storage.Files.Shares.Models.NtfsFileAttributes? fileAttributes = default(Azure.Storage.Files.Shares.Models.NtfsFileAttributes?), string permissionKey = default(string)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareDirectoryInfo StorageDirectoryInfo(Azure.ETag eTag = default(Azure.ETag), System.DateTimeOffset lastModified = default(System.DateTimeOffset), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), Azure.Storage.Files.Shares.Models.FilePosixProperties posixProperties = default(Azure.Storage.Files.Shares.Models.FilePosixProperties)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareDirectoryProperties StorageDirectoryProperties(System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.ETag eTag = default(Azure.ETag), System.DateTimeOffset lastModified = default(System.DateTimeOffset), bool isServerEncrypted = default(bool), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), Azure.Storage.Files.Shares.Models.FilePosixProperties posixProperties = default(Azure.Storage.Files.Shares.Models.FilePosixProperties)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareDirectoryProperties StorageDirectoryProperties(System.Collections.Generic.IDictionary<string, string> metadata, Azure.ETag eTag, System.DateTimeOffset lastModified, bool isServerEncrypted, string fileAttributes, System.DateTimeOffset fileCreationTime, System.DateTimeOffset fileLastWriteTime, System.DateTimeOffset fileChangeTime, string filePermissionKey, string fileId, string fileParentId) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileDownloadInfo StorageFileDownloadInfo(System.DateTimeOffset lastModified = default(System.DateTimeOffset), System.Collections.Generic.IEnumerable<string> contentLanguage = default(System.Collections.Generic.IEnumerable<string>), string acceptRanges = default(string), System.DateTimeOffset copyCompletionTime = default(System.DateTimeOffset), string copyStatusDescription = default(string), string contentDisposition = default(string), string copyProgress = default(string), System.Uri copySource = default(System.Uri), Azure.Storage.Files.Shares.Models.CopyStatus copyStatus = default(Azure.Storage.Files.Shares.Models.CopyStatus), byte[] fileContentHash = default(byte[]), bool isServerEncrypted = default(bool), string cacheControl = default(string), string fileAttributes = default(string), System.Collections.Generic.IEnumerable<string> contentEncoding = default(System.Collections.Generic.IEnumerable<string>), System.DateTimeOffset fileCreationTime = default(System.DateTimeOffset), byte[] contentHash = default(byte[]), System.DateTimeOffset fileLastWriteTime = default(System.DateTimeOffset), Azure.ETag eTag = default(Azure.ETag), System.DateTimeOffset fileChangeTime = default(System.DateTimeOffset), string contentRange = default(string), string filePermissionKey = default(string), string contentType = default(string), string fileId = default(string), long contentLength = default(long), string fileParentId = default(string), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.IO.Stream content = default(System.IO.Stream), string copyId = default(string)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileDownloadDetails StorageFileDownloadProperties(System.DateTimeOffset lastModified = default(System.DateTimeOffset), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), string contentRange = default(string), Azure.ETag eTag = default(Azure.ETag), System.Collections.Generic.IEnumerable<string> contentEncoding = default(System.Collections.Generic.IEnumerable<string>), string cacheControl = default(string), string contentDisposition = default(string), System.Collections.Generic.IEnumerable<string> contentLanguage = default(System.Collections.Generic.IEnumerable<string>), string acceptRanges = default(string), System.DateTimeOffset copyCompletedOn = default(System.DateTimeOffset), string copyStatusDescription = default(string), string copyId = default(string), string copyProgress = default(string), System.Uri copySource = default(System.Uri), Azure.Storage.Files.Shares.Models.CopyStatus copyStatus = default(Azure.Storage.Files.Shares.Models.CopyStatus), byte[] fileContentHash = default(byte[]), bool isServiceEncrypted = default(bool), Azure.Storage.Files.Shares.Models.ShareLeaseDuration leaseDuration = default(Azure.Storage.Files.Shares.Models.ShareLeaseDuration), Azure.Storage.Files.Shares.Models.ShareLeaseState leaseState = default(Azure.Storage.Files.Shares.Models.ShareLeaseState), Azure.Storage.Files.Shares.Models.ShareLeaseStatus leaseStatus = default(Azure.Storage.Files.Shares.Models.ShareLeaseStatus), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), Azure.Storage.Files.Shares.Models.FilePosixProperties posixProperties = default(Azure.Storage.Files.Shares.Models.FilePosixProperties)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileDownloadDetails StorageFileDownloadProperties(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, string contentType, string contentRange, Azure.ETag eTag, System.Collections.Generic.IEnumerable<string> contentEncoding, string cacheControl, string contentDisposition, System.Collections.Generic.IEnumerable<string> contentLanguage, string acceptRanges, System.DateTimeOffset copyCompletedOn, string copyStatusDescription, string copyId, string copyProgress, System.Uri copySource, Azure.Storage.Files.Shares.Models.CopyStatus copyStatus, byte[] fileContentHash, bool isServiceEncrypted) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileInfo StorageFileInfo(Azure.ETag eTag = default(Azure.ETag), System.DateTimeOffset lastModified = default(System.DateTimeOffset), bool isServerEncrypted = default(bool), string filePermissionKey = default(string), string fileAttributes = default(string), System.DateTimeOffset fileCreationTime = default(System.DateTimeOffset), System.DateTimeOffset fileLastWriteTime = default(System.DateTimeOffset), System.DateTimeOffset fileChangeTime = default(System.DateTimeOffset), string fileId = default(string), string fileParentId = default(string), Azure.Storage.Files.Shares.Models.NfsFileMode nfsFileMode = default(Azure.Storage.Files.Shares.Models.NfsFileMode), string owner = default(string), string group = default(string), Azure.Storage.Files.Shares.Models.NfsFileType nfsFileType = default(Azure.Storage.Files.Shares.Models.NfsFileType)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileInfo StorageFileInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, bool isServerEncrypted, string filePermissionKey, string fileAttributes, System.DateTimeOffset fileCreationTime, System.DateTimeOffset fileLastWriteTime, System.DateTimeOffset fileChangeTime, string fileId, string fileParentId) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileItem StorageFileItem(bool isDirectory, string name, long? fileSize) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileProperties StorageFileProperties(System.DateTimeOffset lastModified = default(System.DateTimeOffset), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), long contentLength = default(long), string contentType = default(string), Azure.ETag eTag = default(Azure.ETag), byte[] contentHash = default(byte[]), System.Collections.Generic.IEnumerable<string> contentEncoding = default(System.Collections.Generic.IEnumerable<string>), string cacheControl = default(string), string contentDisposition = default(string), System.Collections.Generic.IEnumerable<string> contentLanguage = default(System.Collections.Generic.IEnumerable<string>), System.DateTimeOffset copyCompletedOn = default(System.DateTimeOffset), string copyStatusDescription = default(string), string copyId = default(string), string copyProgress = default(string), string copySource = default(string), Azure.Storage.Files.Shares.Models.CopyStatus copyStatus = default(Azure.Storage.Files.Shares.Models.CopyStatus), bool isServerEncrypted = default(bool), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), Azure.Storage.Files.Shares.Models.FilePosixProperties posixProperties = default(Azure.Storage.Files.Shares.Models.FilePosixProperties)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileProperties StorageFileProperties(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, long contentLength, string contentType, Azure.ETag eTag, byte[] contentHash, System.Collections.Generic.IEnumerable<string> contentEncoding, string cacheControl, string contentDisposition, System.Collections.Generic.IEnumerable<string> contentLanguage, System.DateTimeOffset copyCompletedOn, string copyStatusDescription, string copyId, string copyProgress, string copySource, Azure.Storage.Files.Shares.Models.CopyStatus copyStatus, bool isServerEncrypted, string fileAttributes, System.DateTimeOffset fileCreationTime, System.DateTimeOffset fileLastWriteTime, System.DateTimeOffset fileChangeTime, string filePermissionKey, string fileId, string fileParentId) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileProperties StorageFileProperties(System.DateTimeOffset lastModified, System.Collections.Generic.IDictionary<string, string> metadata, long contentLength, string contentType, Azure.ETag eTag, byte[] contentHash, System.Collections.Generic.IEnumerable<string> contentEncoding, string cacheControl, string contentDisposition, System.Collections.Generic.IEnumerable<string> contentLanguage, System.DateTimeOffset copyCompletedOn, string copyStatusDescription, string copyId, string copyProgress, string copySource, Azure.Storage.Files.Shares.Models.CopyStatus copyStatus, bool isServerEncrypted, Azure.Storage.Files.Shares.Models.NtfsFileAttributes fileAttributes, System.DateTimeOffset fileCreationTime, System.DateTimeOffset fileLastWriteTime, System.DateTimeOffset fileChangeTime, string filePermissionKey, string fileId, string fileParentId) => throw null;
                    }
                    public enum ModeCopyMode
                    {
                        Source = 0,
                        Override = 1,
                    }
                    public class NfsFileMode
                    {
                        public NfsFileMode() => throw null;
                        public bool EffectiveGroupIdentity { get => throw null; set { } }
                        public bool EffectiveUserIdentity { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.PosixRolePermissions Group { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.PosixRolePermissions Other { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.PosixRolePermissions Owner { get => throw null; set { } }
                        public static Azure.Storage.Files.Shares.Models.NfsFileMode ParseOctalFileMode(string modeString) => throw null;
                        public static Azure.Storage.Files.Shares.Models.NfsFileMode ParseSymbolicFileMode(string modeString) => throw null;
                        public bool StickyBit { get => throw null; set { } }
                        public string ToOctalFileMode() => throw null;
                        public override string ToString() => throw null;
                        public string ToSymbolicFileMode() => throw null;
                    }
                    public struct NfsFileType : System.IEquatable<Azure.Storage.Files.Shares.Models.NfsFileType>
                    {
                        public NfsFileType(string value) => throw null;
                        public static Azure.Storage.Files.Shares.Models.NfsFileType Directory { get => throw null; }
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.Shares.Models.NfsFileType other) => throw null;
                        public override int GetHashCode() => throw null;
                        public static bool operator ==(Azure.Storage.Files.Shares.Models.NfsFileType left, Azure.Storage.Files.Shares.Models.NfsFileType right) => throw null;
                        public static implicit operator Azure.Storage.Files.Shares.Models.NfsFileType(string value) => throw null;
                        public static bool operator !=(Azure.Storage.Files.Shares.Models.NfsFileType left, Azure.Storage.Files.Shares.Models.NfsFileType right) => throw null;
                        public static Azure.Storage.Files.Shares.Models.NfsFileType Regular { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.NfsFileType SymLink { get => throw null; }
                        public override string ToString() => throw null;
                    }
                    [System.Flags]
                    public enum NtfsFileAttributes
                    {
                        ReadOnly = 1,
                        Hidden = 2,
                        System = 4,
                        None = 8,
                        Directory = 16,
                        Archive = 32,
                        Temporary = 64,
                        Offline = 128,
                        NotContentIndexed = 256,
                        NoScrubData = 512,
                    }
                    public enum OwnerCopyMode
                    {
                        Source = 0,
                        Override = 1,
                    }
                    public enum PermissionCopyMode
                    {
                        Source = 0,
                        Override = 1,
                    }
                    public class PermissionInfo
                    {
                        public string FilePermissionKey { get => throw null; }
                    }
                    [System.Flags]
                    public enum PosixRolePermissions
                    {
                        None = 0,
                        Execute = 1,
                        Write = 2,
                        Read = 4,
                    }
                    public class ShareAccessPolicy
                    {
                        public ShareAccessPolicy() => throw null;
                        public System.DateTimeOffset ExpiresOn { get => throw null; set { } }
                        public string Permissions { get => throw null; set { } }
                        public System.DateTimeOffset? PolicyExpiresOn { get => throw null; set { } }
                        public System.DateTimeOffset? PolicyStartsOn { get => throw null; set { } }
                        public System.DateTimeOffset StartsOn { get => throw null; set { } }
                    }
                    public struct ShareAccessTier : System.IEquatable<Azure.Storage.Files.Shares.Models.ShareAccessTier>
                    {
                        public static Azure.Storage.Files.Shares.Models.ShareAccessTier Cool { get => throw null; }
                        public ShareAccessTier(string value) => throw null;
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.Shares.Models.ShareAccessTier other) => throw null;
                        public override int GetHashCode() => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareAccessTier Hot { get => throw null; }
                        public static bool operator ==(Azure.Storage.Files.Shares.Models.ShareAccessTier left, Azure.Storage.Files.Shares.Models.ShareAccessTier right) => throw null;
                        public static implicit operator Azure.Storage.Files.Shares.Models.ShareAccessTier(string value) => throw null;
                        public static bool operator !=(Azure.Storage.Files.Shares.Models.ShareAccessTier left, Azure.Storage.Files.Shares.Models.ShareAccessTier right) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareAccessTier Premium { get => throw null; }
                        public override string ToString() => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareAccessTier TransactionOptimized { get => throw null; }
                    }
                    public struct ShareAudience : System.IEquatable<Azure.Storage.Files.Shares.Models.ShareAudience>
                    {
                        public static Azure.Storage.Files.Shares.Models.ShareAudience CreateShareServiceAccountAudience(string storageAccountName) => throw null;
                        public ShareAudience(string value) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareAudience DefaultAudience { get => throw null; }
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.Shares.Models.ShareAudience other) => throw null;
                        public override int GetHashCode() => throw null;
                        public static bool operator ==(Azure.Storage.Files.Shares.Models.ShareAudience left, Azure.Storage.Files.Shares.Models.ShareAudience right) => throw null;
                        public static implicit operator Azure.Storage.Files.Shares.Models.ShareAudience(string value) => throw null;
                        public static bool operator !=(Azure.Storage.Files.Shares.Models.ShareAudience left, Azure.Storage.Files.Shares.Models.ShareAudience right) => throw null;
                        public override string ToString() => throw null;
                    }
                    public class ShareCorsRule
                    {
                        public string AllowedHeaders { get => throw null; set { } }
                        public string AllowedMethods { get => throw null; set { } }
                        public string AllowedOrigins { get => throw null; set { } }
                        public ShareCorsRule() => throw null;
                        public string ExposedHeaders { get => throw null; set { } }
                        public int MaxAgeInSeconds { get => throw null; set { } }
                    }
                    public class ShareCreateOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareAccessTier? AccessTier { get => throw null; set { } }
                        public ShareCreateOptions() => throw null;
                        public bool? EnablePaidBursting { get => throw null; set { } }
                        public bool? EnableSnapshotVirtualDirectoryAccess { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public long? PaidBurstingMaxBandwidthMibps { get => throw null; set { } }
                        public long? PaidBurstingMaxIops { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareProtocols? Protocols { get => throw null; set { } }
                        public long? ProvisionedMaxBandwidthMibps { get => throw null; set { } }
                        public long? ProvisionedMaxIops { get => throw null; set { } }
                        public int? QuotaInGB { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareRootSquash? RootSquash { get => throw null; set { } }
                    }
                    public class ShareDeleteOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareDeleteOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareSnapshotsDeleteOption? ShareSnapshotsDeleteOption { get => throw null; set { } }
                    }
                    public class ShareDirectoryCreateOptions
                    {
                        public ShareDirectoryCreateOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareFilePermission FilePermission { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public class ShareDirectoryGetFilesAndDirectoriesOptions
                    {
                        public ShareDirectoryGetFilesAndDirectoriesOptions() => throw null;
                        public bool? IncludeExtendedInfo { get => throw null; set { } }
                        public string Prefix { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileTraits Traits { get => throw null; set { } }
                    }
                    public class ShareDirectoryInfo
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public class ShareDirectoryProperties
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public bool IsServerEncrypted { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public class ShareDirectorySetHttpHeadersOptions
                    {
                        public ShareDirectorySetHttpHeadersOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareFilePermission FilePermission { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public struct ShareErrorCode : System.IEquatable<Azure.Storage.Files.Shares.Models.ShareErrorCode>
                    {
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AccountAlreadyExists { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AccountBeingCreated { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AccountIsDisabled { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AuthenticationFailed { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AuthorizationFailure { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AuthorizationPermissionMismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AuthorizationProtocolMismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AuthorizationResourceTypeMismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AuthorizationServiceMismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode AuthorizationSourceIPMismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode CannotDeleteFileOrDirectory { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ClientCacheFlushDelay { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ConditionHeadersNotSupported { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ConditionNotMet { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ContainerQuotaDowngradeNotAllowed { get => throw null; }
                        public ShareErrorCode(string value) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode DeletePending { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode DirectoryNotEmpty { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode EmptyMetadataKey { get => throw null; }
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.Shares.Models.ShareErrorCode other) => throw null;
                        public bool Equals(string value) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode FeatureVersionMismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode FileLockConflict { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode FileShareProvisionedBandwidthDowngradeNotAllowed { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode FileShareProvisionedIopsDowngradeNotAllowed { get => throw null; }
                        public override int GetHashCode() => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InsufficientAccountPermissions { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InternalError { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidAuthenticationInfo { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidFileOrDirectoryPathName { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidHeaderValue { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidHttpVerb { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidInput { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidMd5 { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidMetadata { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidQueryParameterValue { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidRange { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidResourceName { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidUri { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidXmlDocument { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode InvalidXmlNodeValue { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode Md5Mismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode MetadataTooLarge { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode MissingContentLengthHeader { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode MissingRequiredHeader { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode MissingRequiredQueryParameter { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode MissingRequiredXmlNode { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode MultipleConditionHeadersNotSupported { get => throw null; }
                        public static bool operator ==(Azure.Storage.Files.Shares.Models.ShareErrorCode left, Azure.Storage.Files.Shares.Models.ShareErrorCode right) => throw null;
                        public static bool operator ==(Azure.Storage.Files.Shares.Models.ShareErrorCode code, string value) => throw null;
                        public static bool operator ==(string value, Azure.Storage.Files.Shares.Models.ShareErrorCode code) => throw null;
                        public static implicit operator Azure.Storage.Files.Shares.Models.ShareErrorCode(string value) => throw null;
                        public static bool operator !=(Azure.Storage.Files.Shares.Models.ShareErrorCode left, Azure.Storage.Files.Shares.Models.ShareErrorCode right) => throw null;
                        public static bool operator !=(Azure.Storage.Files.Shares.Models.ShareErrorCode code, string value) => throw null;
                        public static bool operator !=(string value, Azure.Storage.Files.Shares.Models.ShareErrorCode code) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode OperationTimedOut { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode OutOfRangeInput { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode OutOfRangeQueryParameterValue { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ParentNotFound { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode PreviousSnapshotNotFound { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ReadOnlyAttribute { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode RequestBodyTooLarge { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode RequestUrlFailedToParse { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ResourceAlreadyExists { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ResourceNotFound { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ResourceTypeMismatch { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ServerBusy { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareAlreadyExists { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareBeingDeleted { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareDisabled { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareHasSnapshots { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareNotFound { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareSnapshotCountExceeded { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareSnapshotInProgress { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode ShareSnapshotOperationNotSupported { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode SharingViolation { get => throw null; }
                        public override string ToString() => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode UnsupportedHeader { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode UnsupportedHttpVerb { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode UnsupportedQueryParameter { get => throw null; }
                        public static Azure.Storage.Files.Shares.Models.ShareErrorCode UnsupportedXmlNode { get => throw null; }
                    }
                    public class ShareFileCopyInfo
                    {
                        public string CopyId { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.CopyStatus CopyStatus { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                    }
                    public class ShareFileCopyOptions
                    {
                        public bool? Archive { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileCopyOptions() => throw null;
                        public string FilePermission { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.PermissionCopyMode? FilePermissionCopyMode { get => throw null; set { } }
                        public bool? IgnoreReadOnly { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ModeCopyMode? ModeCopyMode { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.OwnerCopyMode? OwnerCopyMode { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePermissionFormat? PermissionFormat { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.CopyableFileSmbProperties SmbPropertiesToCopy { get => throw null; set { } }
                    }
                    public class ShareFileCreateOptions
                    {
                        public ShareFileCreateOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareFilePermission FilePermission { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders HttpHeaders { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public class ShareFileDownloadDetails
                    {
                        public string AcceptRanges { get => throw null; }
                        public string CacheControl { get => throw null; }
                        public string ContentDisposition { get => throw null; }
                        public System.Collections.Generic.IEnumerable<string> ContentEncoding { get => throw null; }
                        public System.Collections.Generic.IEnumerable<string> ContentLanguage { get => throw null; }
                        public string ContentRange { get => throw null; }
                        public System.DateTimeOffset CopyCompletedOn { get => throw null; }
                        public string CopyId { get => throw null; }
                        public string CopyProgress { get => throw null; }
                        public System.Uri CopySource { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.CopyStatus CopyStatus { get => throw null; }
                        public string CopyStatusDescription { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public byte[] FileContentHash { get => throw null; }
                        public bool IsServerEncrypted { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseDuration LeaseDuration { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseState LeaseState { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseStatus LeaseStatus { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public class ShareFileDownloadInfo : System.IDisposable
                    {
                        public System.IO.Stream Content { get => throw null; }
                        public byte[] ContentHash { get => throw null; }
                        public long ContentLength { get => throw null; }
                        public string ContentType { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareFileDownloadDetails Details { get => throw null; }
                        public void Dispose() => throw null;
                    }
                    public class ShareFileDownloadOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileDownloadOptions() => throw null;
                        public Azure.HttpRange Range { get => throw null; set { } }
                        public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class ShareFileGetRangeListDiffOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileGetRangeListDiffOptions() => throw null;
                        public bool? IncludeRenames { get => throw null; set { } }
                        public string PreviousSnapshot { get => throw null; set { } }
                        public Azure.HttpRange? Range { get => throw null; set { } }
                        public string Snapshot { get => throw null; set { } }
                    }
                    public class ShareFileGetRangeListOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileGetRangeListOptions() => throw null;
                        public Azure.HttpRange? Range { get => throw null; set { } }
                        public string Snapshot { get => throw null; set { } }
                    }
                    public class ShareFileHandle
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileHandleAccessRights? AccessRights { get => throw null; }
                        public string ClientIp { get => throw null; }
                        public string ClientName { get => throw null; }
                        public string FileId { get => throw null; }
                        public string HandleId { get => throw null; }
                        public System.DateTimeOffset? LastReconnectedOn { get => throw null; }
                        public System.DateTimeOffset? OpenedOn { get => throw null; }
                        public string ParentId { get => throw null; }
                        public string Path { get => throw null; }
                        public string SessionId { get => throw null; }
                    }
                    [System.Flags]
                    public enum ShareFileHandleAccessRights
                    {
                        None = 0,
                        Read = 1,
                        Write = 2,
                        Delete = 4,
                    }
                    public class ShareFileHttpHeaders
                    {
                        public string CacheControl { get => throw null; set { } }
                        public string ContentDisposition { get => throw null; set { } }
                        public string[] ContentEncoding { get => throw null; set { } }
                        public byte[] ContentHash { get => throw null; set { } }
                        public string[] ContentLanguage { get => throw null; set { } }
                        public string ContentType { get => throw null; set { } }
                        public ShareFileHttpHeaders() => throw null;
                        public override bool Equals(object obj) => throw null;
                        public override int GetHashCode() => throw null;
                    }
                    public class ShareFileInfo
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public bool IsServerEncrypted { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public class ShareFileItem
                    {
                        public Azure.Storage.Files.Shares.Models.NtfsFileAttributes? FileAttributes { get => throw null; }
                        public long? FileSize { get => throw null; }
                        public string Id { get => throw null; }
                        public bool IsDirectory { get => throw null; }
                        public string Name { get => throw null; }
                        public string PermissionKey { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareFileItemProperties Properties { get => throw null; }
                    }
                    public class ShareFileItemProperties
                    {
                        public System.DateTimeOffset? ChangedOn { get => throw null; }
                        public System.DateTimeOffset? CreatedOn { get => throw null; }
                        public Azure.ETag? ETag { get => throw null; }
                        public System.DateTimeOffset? LastAccessedOn { get => throw null; }
                        public System.DateTimeOffset? LastModified { get => throw null; }
                        public System.DateTimeOffset? LastWrittenOn { get => throw null; }
                    }
                    public class ShareFileLease
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public string LeaseId { get => throw null; }
                        public int? LeaseTime { get => throw null; }
                    }
                    public class ShareFileModifiedException : System.Exception, System.Runtime.Serialization.ISerializable
                    {
                        public Azure.ETag ActualETag { get => throw null; }
                        public ShareFileModifiedException(string message, System.Uri resourceUri, Azure.ETag expectedETag, Azure.ETag actualETag, Azure.HttpRange range) => throw null;
                        protected ShareFileModifiedException(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContext streamingContext) => throw null;
                        public Azure.ETag ExpectedETag { get => throw null; }
                        public override void GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContext context) => throw null;
                        public Azure.HttpRange Range { get => throw null; }
                        public System.Uri ResourceUri { get => throw null; }
                    }
                    public class ShareFileOpenReadOptions
                    {
                        public int? BufferSize { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileOpenReadOptions(bool allowModifications) => throw null;
                        public long Position { get => throw null; set { } }
                        public Azure.Storage.DownloadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class ShareFileOpenWriteOptions
                    {
                        public long? BufferSize { get => throw null; set { } }
                        public ShareFileOpenWriteOptions() => throw null;
                        public long? MaxSize { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions OpenConditions { get => throw null; set { } }
                        public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                        public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class ShareFilePermission
                    {
                        public ShareFilePermission() => throw null;
                        public string Permission { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePermissionFormat? PermissionFormat { get => throw null; set { } }
                    }
                    public class ShareFileProperties
                    {
                        public string CacheControl { get => throw null; }
                        public string ContentDisposition { get => throw null; }
                        public System.Collections.Generic.IEnumerable<string> ContentEncoding { get => throw null; }
                        public byte[] ContentHash { get => throw null; }
                        public System.Collections.Generic.IEnumerable<string> ContentLanguage { get => throw null; }
                        public long ContentLength { get => throw null; }
                        public string ContentType { get => throw null; }
                        public System.DateTimeOffset CopyCompletedOn { get => throw null; }
                        public string CopyId { get => throw null; }
                        public string CopyProgress { get => throw null; }
                        public string CopySource { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.CopyStatus CopyStatus { get => throw null; }
                        public string CopyStatusDescription { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public bool IsServerEncrypted { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseDuration LeaseDuration { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseState LeaseState { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseStatus LeaseStatus { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    public class ShareFileRangeInfo
                    {
                        public System.Collections.Generic.IEnumerable<Azure.HttpRange> ClearRanges { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public long FileContentLength { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public System.Collections.Generic.IEnumerable<Azure.HttpRange> Ranges { get => throw null; }
                    }
                    public enum ShareFileRangeWriteType
                    {
                        Update = 0,
                        Clear = 1,
                    }
                    public class ShareFileRenameOptions
                    {
                        public string ContentType { get => throw null; set { } }
                        public ShareFileRenameOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions DestinationConditions { get => throw null; set { } }
                        public string FilePermission { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePermissionFormat? FilePermissionFormat { get => throw null; set { } }
                        public bool? IgnoreReadOnly { get => throw null; set { } }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; set { } }
                        public bool? ReplaceIfExists { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions SourceConditions { get => throw null; set { } }
                    }
                    public class ShareFileRequestConditions
                    {
                        public ShareFileRequestConditions() => throw null;
                        public string LeaseId { get => throw null; set { } }
                        public override string ToString() => throw null;
                    }
                    public class ShareFileSetHttpHeadersOptions
                    {
                        public ShareFileSetHttpHeadersOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareFilePermission FilePermission { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders HttpHeaders { get => throw null; set { } }
                        public long? NewSize { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FilePosixProperties PosixProperties { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.FileSmbProperties SmbProperties { get => throw null; set { } }
                    }
                    [System.Flags]
                    public enum ShareFileTraits
                    {
                        None = 0,
                        Timestamps = 1,
                        ETag = 2,
                        Attributes = 4,
                        PermissionKey = 8,
                        All = -1,
                    }
                    public class ShareFileUploadInfo
                    {
                        public byte[] ContentHash { get => throw null; }
                        public Azure.ETag ETag { get => throw null; }
                        public bool IsServerEncrypted { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                    }
                    public class ShareFileUploadOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileUploadOptions() => throw null;
                        public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                        public Azure.Storage.StorageTransferOptions TransferOptions { get => throw null; set { } }
                        public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class ShareFileUploadRangeFromUriOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileUploadRangeFromUriOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.FileLastWrittenMode? FileLastWrittenMode { get => throw null; set { } }
                        public Azure.HttpAuthorization SourceAuthentication { get => throw null; set { } }
                    }
                    public class ShareFileUploadRangeOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareFileUploadRangeOptions() => throw null;
                        public Azure.Storage.Files.Shares.Models.FileLastWrittenMode? FileLastWrittenMode { get => throw null; set { } }
                        public System.IProgress<long> ProgressHandler { get => throw null; set { } }
                        public byte[] TransactionalContentHash { get => throw null; set { } }
                        public Azure.Storage.UploadTransferValidationOptions TransferValidation { get => throw null; set { } }
                    }
                    public class ShareInfo
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                    }
                    public class ShareItem
                    {
                        public bool? IsDeleted { get => throw null; }
                        public string Name { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareProperties Properties { get => throw null; }
                        public string Snapshot { get => throw null; }
                        public string VersionId { get => throw null; }
                    }
                    public enum ShareLeaseDuration
                    {
                        Infinite = 0,
                        Fixed = 1,
                    }
                    public enum ShareLeaseState
                    {
                        Available = 0,
                        Leased = 1,
                        Expired = 2,
                        Breaking = 3,
                        Broken = 4,
                    }
                    public enum ShareLeaseStatus
                    {
                        Locked = 0,
                        Unlocked = 1,
                    }
                    public class ShareMetrics
                    {
                        public ShareMetrics() => throw null;
                        public bool Enabled { get => throw null; set { } }
                        public bool? IncludeApis { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareRetentionPolicy RetentionPolicy { get => throw null; set { } }
                        public string Version { get => throw null; set { } }
                    }
                    public static class ShareModelFactory
                    {
                        public static Azure.Storage.Files.Shares.Models.FileLeaseReleaseInfo FileLeaseReleaseInfo(Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                        public static Azure.Storage.Files.Shares.Models.PermissionInfo PermissionInfo(string filePermissionKey) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileCopyInfo ShareFileCopyInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, string copyId, Azure.Storage.Files.Shares.Models.CopyStatus copyStatus) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileHandle ShareFileHandle(string handleId, string path, string fileId, string sessionId, string clientIp, string clientName, string parentId = default(string), System.DateTimeOffset? openedOn = default(System.DateTimeOffset?), System.DateTimeOffset? lastReconnectedOn = default(System.DateTimeOffset?), Azure.Storage.Files.Shares.Models.ShareFileHandleAccessRights? accessRights = default(Azure.Storage.Files.Shares.Models.ShareFileHandleAccessRights?)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileHandle ShareFileHandle(string handleId, string path, string fileId, string sessionId, string clientIp, string parentId = default(string), System.DateTimeOffset? openedOn = default(System.DateTimeOffset?), System.DateTimeOffset? lastReconnectedOn = default(System.DateTimeOffset?), Azure.Storage.Files.Shares.Models.ShareFileHandleAccessRights? accessRights = default(Azure.Storage.Files.Shares.Models.ShareFileHandleAccessRights?)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileHandle ShareFileHandle(string handleId, string path, string fileId, string sessionId, string clientIp, string parentId = default(string), System.DateTimeOffset? openedOn = default(System.DateTimeOffset?), System.DateTimeOffset? lastReconnectedOn = default(System.DateTimeOffset?)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileItemProperties ShareFileItemProperties(System.DateTimeOffset? createdOn = default(System.DateTimeOffset?), System.DateTimeOffset? lastAccessedOn = default(System.DateTimeOffset?), System.DateTimeOffset? lastWrittenOn = default(System.DateTimeOffset?), System.DateTimeOffset? changedOn = default(System.DateTimeOffset?), System.DateTimeOffset? lastModified = default(System.DateTimeOffset?), Azure.ETag? etag = default(Azure.ETag?)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileLease ShareFileLease(Azure.ETag eTag, System.DateTimeOffset lastModified, string leaseId) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileRangeInfo ShareFileRangeInfo(System.DateTimeOffset lastModified, Azure.ETag eTag, long fileContentLength, System.Collections.Generic.IEnumerable<Azure.HttpRange> ranges) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareFileUploadInfo ShareFileUploadInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, byte[] contentHash, bool isServerEncrypted) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareInfo ShareInfo(Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareItem ShareItem(string name, Azure.Storage.Files.Shares.Models.ShareProperties properties, string snapshot = default(string), bool? isDeleted = default(bool?), string versionId = default(string)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareItem ShareItem(string name, Azure.Storage.Files.Shares.Models.ShareProperties properties, string snapshot) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(string accessTier = default(string), System.DateTimeOffset? lastModified = default(System.DateTimeOffset?), int? provisionedIops = default(int?), int? provisionedIngressMBps = default(int?), int? provisionedEgressMBps = default(int?), System.DateTimeOffset? nextAllowedQuotaDowngradeTime = default(System.DateTimeOffset?), System.DateTimeOffset? deletedOn = default(System.DateTimeOffset?), int? remainingRetentionDays = default(int?), Azure.ETag? eTag = default(Azure.ETag?), System.DateTimeOffset? accessTierChangeTime = default(System.DateTimeOffset?), string accessTierTransitionState = default(string), Azure.Storage.Files.Shares.Models.ShareLeaseStatus? leaseStatus = default(Azure.Storage.Files.Shares.Models.ShareLeaseStatus?), Azure.Storage.Files.Shares.Models.ShareLeaseState? leaseState = default(Azure.Storage.Files.Shares.Models.ShareLeaseState?), Azure.Storage.Files.Shares.Models.ShareLeaseDuration? leaseDuration = default(Azure.Storage.Files.Shares.Models.ShareLeaseDuration?), int? quotaInGB = default(int?), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Files.Shares.Models.ShareProtocols? protocols = default(Azure.Storage.Files.Shares.Models.ShareProtocols?), Azure.Storage.Files.Shares.Models.ShareRootSquash? rootSquash = default(Azure.Storage.Files.Shares.Models.ShareRootSquash?), bool? enableSnapshotVirtualDirectoryAccess = default(bool?), bool? enablePaidBursting = default(bool?), long? paidBurstingMaxIops = default(long?), long? paidBustingMaxBandwidthMibps = default(long?), long? includedBurstIops = default(long?), long? maxBurstCreditsForIops = default(long?), System.DateTimeOffset? nextAllowedProvisionedIopsDowngradeTime = default(System.DateTimeOffset?), System.DateTimeOffset? nextAllowedProvisionedBandwidthDowngradeTime = default(System.DateTimeOffset?)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(string accessTier, System.DateTimeOffset? lastModified, int? provisionedIops, int? provisionedIngressMBps, int? provisionedEgressMBps, System.DateTimeOffset? nextAllowedQuotaDowngradeTime, System.DateTimeOffset? deletedOn, int? remainingRetentionDays, Azure.ETag? eTag, System.DateTimeOffset? accessTierChangeTime, string accessTierTransitionState, Azure.Storage.Files.Shares.Models.ShareLeaseStatus? leaseStatus, Azure.Storage.Files.Shares.Models.ShareLeaseState? leaseState, Azure.Storage.Files.Shares.Models.ShareLeaseDuration? leaseDuration, int? quotaInGB, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.ShareProtocols? protocols, Azure.Storage.Files.Shares.Models.ShareRootSquash? rootSquash, bool? enableSnapshotVirtualDirectoryAccess, bool? enablePaidBursting, long? paidBurstingMaxIops, long? paidBustingMaxBandwidthMibps) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(string accessTier, System.DateTimeOffset? lastModified, int? provisionedIops, int? provisionedIngressMBps, int? provisionedEgressMBps, System.DateTimeOffset? nextAllowedQuotaDowngradeTime, System.DateTimeOffset? deletedOn, int? remainingRetentionDays, Azure.ETag? eTag, System.DateTimeOffset? accessTierChangeTime, string accessTierTransitionState, Azure.Storage.Files.Shares.Models.ShareLeaseStatus? leaseStatus, Azure.Storage.Files.Shares.Models.ShareLeaseState? leaseState, Azure.Storage.Files.Shares.Models.ShareLeaseDuration? leaseDuration, int? quotaInGB, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.ShareProtocols? protocols, Azure.Storage.Files.Shares.Models.ShareRootSquash? rootSquash, bool? enableSnapshotVirtualDirectoryAccess) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(System.DateTimeOffset? lastModified, Azure.ETag? eTag, int? provisionedIops, int? provisionedIngressMBps, int? provisionedEgressMBps, System.DateTimeOffset? nextAllowedQuotaDowngradeTime, System.DateTimeOffset? deletedOn, int? remainingRetentionDays, int? quotaInGB, System.Collections.Generic.IDictionary<string, string> metadata) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(string accessTier = default(string), System.DateTimeOffset? lastModified = default(System.DateTimeOffset?), int? provisionedIops = default(int?), int? provisionedIngressMBps = default(int?), int? provisionedEgressMBps = default(int?), System.DateTimeOffset? nextAllowedQuotaDowngradeTime = default(System.DateTimeOffset?), System.DateTimeOffset? deletedOn = default(System.DateTimeOffset?), int? remainingRetentionDays = default(int?), Azure.ETag? eTag = default(Azure.ETag?), System.DateTimeOffset? accessTierChangeTime = default(System.DateTimeOffset?), string accessTierTransitionState = default(string), Azure.Storage.Files.Shares.Models.ShareLeaseStatus? leaseStatus = default(Azure.Storage.Files.Shares.Models.ShareLeaseStatus?), Azure.Storage.Files.Shares.Models.ShareLeaseState? leaseState = default(Azure.Storage.Files.Shares.Models.ShareLeaseState?), Azure.Storage.Files.Shares.Models.ShareLeaseDuration? leaseDuration = default(Azure.Storage.Files.Shares.Models.ShareLeaseDuration?), int? quotaInGB = default(int?), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Files.Shares.Models.ShareProtocols? protocols = default(Azure.Storage.Files.Shares.Models.ShareProtocols?), Azure.Storage.Files.Shares.Models.ShareRootSquash? rootSquash = default(Azure.Storage.Files.Shares.Models.ShareRootSquash?)) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(string accessTier, System.DateTimeOffset? lastModified, int? provisionedIops, int? provisionedIngressMBps, int? provisionedEgressMBps, System.DateTimeOffset? nextAllowedQuotaDowngradeTime, System.DateTimeOffset? deletedOn, int? remainingRetentionDays, Azure.ETag? eTag, System.DateTimeOffset? accessTierChangeTime, string accessTierTransitionState, Azure.Storage.Files.Shares.Models.ShareLeaseStatus? leaseStatus, Azure.Storage.Files.Shares.Models.ShareLeaseState? leaseState, Azure.Storage.Files.Shares.Models.ShareLeaseDuration? leaseDuration, int? quotaInGB, System.Collections.Generic.IDictionary<string, string> metadata) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(System.DateTimeOffset? lastModified, Azure.ETag? eTag, int? provisionedIops, int? provisionedIngressMBps, int? provisionedEgressMBps, System.DateTimeOffset? nextAllowedQuotaDowngradeTime, int? quotaInGB, System.Collections.Generic.IDictionary<string, string> metadata) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareProperties ShareProperties(System.DateTimeOffset? lastModified, Azure.ETag? eTag, int? quotaInGB, System.Collections.Generic.IDictionary<string, string> metadata) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareSnapshotInfo ShareSnapshotInfo(string snapshot, Azure.ETag eTag, System.DateTimeOffset lastModified) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareStatistics ShareStatistics(long shareUsageInBytes) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareStatistics ShareStatistics(int shareUsageBytes) => throw null;
                        public static Azure.Storage.Files.Shares.Models.StorageClosedHandlesSegment StorageClosedHandlesSegment(string marker, int numberOfHandlesClosed) => throw null;
                        public static Azure.Storage.Files.Shares.Models.StorageClosedHandlesSegment StorageClosedHandlesSegment(string marker, int numberOfHandlesClosed, int numberOfHandlesFailedToClose) => throw null;
                    }
                    public class ShareProperties
                    {
                        public string AccessTier { get => throw null; }
                        public System.DateTimeOffset? AccessTierChangeTime { get => throw null; }
                        public string AccessTierTransitionState { get => throw null; }
                        public System.DateTimeOffset? DeletedOn { get => throw null; }
                        public bool? EnablePaidBursting { get => throw null; }
                        public bool? EnableSnapshotVirtualDirectoryAccess { get => throw null; }
                        public Azure.ETag? ETag { get => throw null; }
                        public long? IncludedBurstIops { get => throw null; }
                        public System.DateTimeOffset? LastModified { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseDuration? LeaseDuration { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseState? LeaseState { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareLeaseStatus? LeaseStatus { get => throw null; }
                        public long? MaxBurstCreditsForIops { get => throw null; }
                        public System.Collections.Generic.IDictionary<string, string> Metadata { get => throw null; }
                        public System.DateTimeOffset? NextAllowedProvisionedBandwidthDowngradeTime { get => throw null; }
                        public System.DateTimeOffset? NextAllowedProvisionedIopsDowngradeTime { get => throw null; }
                        public System.DateTimeOffset? NextAllowedQuotaDowngradeTime { get => throw null; }
                        public long? PaidBurstingMaxBandwidthMibps { get => throw null; }
                        public long? PaidBurstingMaxIops { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareProtocols? Protocols { get => throw null; }
                        public int? ProvisionedBandwidthMiBps { get => throw null; }
                        public int? ProvisionedEgressMBps { get => throw null; }
                        public int? ProvisionedIngressMBps { get => throw null; }
                        public int? ProvisionedIops { get => throw null; }
                        public int? QuotaInGB { get => throw null; }
                        public int? RemainingRetentionDays { get => throw null; }
                        public Azure.Storage.Files.Shares.Models.ShareRootSquash? RootSquash { get => throw null; }
                    }
                    [System.Flags]
                    public enum ShareProtocols
                    {
                        Smb = 1,
                        Nfs = 2,
                    }
                    public class ShareProtocolSettings
                    {
                        public ShareProtocolSettings() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareSmbSettings Smb { get => throw null; set { } }
                    }
                    public class ShareRetentionPolicy
                    {
                        public ShareRetentionPolicy() => throw null;
                        public int? Days { get => throw null; set { } }
                        public bool Enabled { get => throw null; set { } }
                    }
                    public enum ShareRootSquash
                    {
                        NoRootSquash = 0,
                        RootSquash = 1,
                        AllSquash = 2,
                    }
                    public class ShareServiceProperties
                    {
                        public System.Collections.Generic.IList<Azure.Storage.Files.Shares.Models.ShareCorsRule> Cors { get => throw null; set { } }
                        public ShareServiceProperties() => throw null;
                        public Azure.Storage.Files.Shares.Models.ShareMetrics HourMetrics { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareMetrics MinuteMetrics { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareProtocolSettings Protocol { get => throw null; set { } }
                    }
                    public class ShareSetPropertiesOptions
                    {
                        public Azure.Storage.Files.Shares.Models.ShareAccessTier? AccessTier { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareFileRequestConditions Conditions { get => throw null; set { } }
                        public ShareSetPropertiesOptions() => throw null;
                        public bool? EnablePaidBursting { get => throw null; set { } }
                        public bool? EnableSnapshotVirtualDirectoryAccess { get => throw null; set { } }
                        public long? PaidBurstingMaxBandwidthMibps { get => throw null; set { } }
                        public long? PaidBurstingMaxIops { get => throw null; set { } }
                        public long? ProvisionedMaxBandwidthMibps { get => throw null; set { } }
                        public long? ProvisionedMaxIops { get => throw null; set { } }
                        public int? QuotaInGB { get => throw null; set { } }
                        public Azure.Storage.Files.Shares.Models.ShareRootSquash? RootSquash { get => throw null; set { } }
                    }
                    public class ShareSignedIdentifier
                    {
                        public Azure.Storage.Files.Shares.Models.ShareAccessPolicy AccessPolicy { get => throw null; set { } }
                        public ShareSignedIdentifier() => throw null;
                        public string Id { get => throw null; set { } }
                    }
                    public class ShareSmbSettings
                    {
                        public ShareSmbSettings() => throw null;
                        public Azure.Storage.Files.Shares.Models.SmbMultichannel Multichannel { get => throw null; set { } }
                    }
                    public static class SharesModelFactory
                    {
                        public static Azure.Storage.Files.Shares.Models.FileSmbProperties FileSmbProperties(System.DateTimeOffset? fileChangedOn, string fileId, string parentId) => throw null;
                        public static Azure.Storage.Files.Shares.Models.ShareDirectoryInfo StorageDirectoryInfo(Azure.ETag eTag, System.DateTimeOffset lastModified, string filePermissionKey, string fileAttributes, System.DateTimeOffset fileCreationTime, System.DateTimeOffset fileLastWriteTime, System.DateTimeOffset fileChangeTime, string fileId, string fileParentId) => throw null;
                    }
                    public class ShareSnapshotInfo
                    {
                        public Azure.ETag ETag { get => throw null; }
                        public System.DateTimeOffset LastModified { get => throw null; }
                        public string Snapshot { get => throw null; }
                    }
                    public enum ShareSnapshotsDeleteOption
                    {
                        Include = 0,
                        IncludeWithLeased = 1,
                    }
                    [System.Flags]
                    public enum ShareStates
                    {
                        None = 0,
                        Snapshots = 1,
                        Deleted = 2,
                        All = -1,
                    }
                    public class ShareStatistics
                    {
                        public int ShareUsageBytes { get => throw null; }
                        public long ShareUsageInBytes { get => throw null; }
                    }
                    public struct ShareTokenIntent : System.IEquatable<Azure.Storage.Files.Shares.Models.ShareTokenIntent>
                    {
                        public static Azure.Storage.Files.Shares.Models.ShareTokenIntent Backup { get => throw null; }
                        public ShareTokenIntent(string value) => throw null;
                        public override bool Equals(object obj) => throw null;
                        public bool Equals(Azure.Storage.Files.Shares.Models.ShareTokenIntent other) => throw null;
                        public override int GetHashCode() => throw null;
                        public static bool operator ==(Azure.Storage.Files.Shares.Models.ShareTokenIntent left, Azure.Storage.Files.Shares.Models.ShareTokenIntent right) => throw null;
                        public static implicit operator Azure.Storage.Files.Shares.Models.ShareTokenIntent(string value) => throw null;
                        public static bool operator !=(Azure.Storage.Files.Shares.Models.ShareTokenIntent left, Azure.Storage.Files.Shares.Models.ShareTokenIntent right) => throw null;
                        public override string ToString() => throw null;
                    }
                    [System.Flags]
                    public enum ShareTraits
                    {
                        None = 0,
                        Metadata = 1,
                        All = -1,
                    }
                    public class SmbMultichannel
                    {
                        public SmbMultichannel() => throw null;
                        public bool? Enabled { get => throw null; set { } }
                    }
                    public class StorageClosedHandlesSegment
                    {
                        public string Marker { get => throw null; }
                        public int NumberOfHandlesClosed { get => throw null; }
                        public int NumberOfHandlesFailedToClose { get => throw null; }
                    }
                }
                public class ShareClient
                {
                    public virtual string AccountName { get => throw null; }
                    public virtual bool CanGenerateSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> Create(Azure.Storage.Files.Shares.Models.ShareCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> Create(System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), int? quotaInGB = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> CreateAsync(Azure.Storage.Files.Shares.Models.ShareCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> CreateAsync(System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), int? quotaInGB = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient> CreateDirectory(string directoryName, Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient> CreateDirectory(string directoryName, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient>> CreateDirectoryAsync(string directoryName, Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient>> CreateDirectoryAsync(string directoryName, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> CreateIfNotExists(Azure.Storage.Files.Shares.Models.ShareCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> CreateIfNotExists(System.Collections.Generic.IDictionary<string, string> metadata, int? quotaInGB, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.Shares.Models.ShareCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> CreateIfNotExistsAsync(System.Collections.Generic.IDictionary<string, string> metadata, int? quotaInGB, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.PermissionInfo> CreatePermission(Azure.Storage.Files.Shares.Models.ShareFilePermission permission, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.PermissionInfo> CreatePermission(string permission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.PermissionInfo>> CreatePermissionAsync(Azure.Storage.Files.Shares.Models.ShareFilePermission permission, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.PermissionInfo>> CreatePermissionAsync(string permission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareSnapshotInfo> CreateSnapshot(System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareSnapshotInfo>> CreateSnapshotAsync(System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected ShareClient() => throw null;
                    public ShareClient(string connectionString, string shareName) => throw null;
                    public ShareClient(string connectionString, string shareName, Azure.Storage.Files.Shares.ShareClientOptions options) => throw null;
                    public ShareClient(System.Uri shareUri, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareClient(System.Uri shareUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareClient(System.Uri shareUri, Azure.AzureSasCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareClient(System.Uri shareUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public virtual Azure.Response Delete(Azure.Storage.Files.Shares.Models.ShareDeleteOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response Delete(bool includeSnapshots = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(Azure.Storage.Files.Shares.Models.ShareDeleteOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(bool includeSnapshots = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteDirectory(string directoryName, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteDirectoryAsync(string directoryName, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(Azure.Storage.Files.Shares.Models.ShareDeleteOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(bool includeSnapshots = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(Azure.Storage.Files.Shares.Models.ShareDeleteOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(bool includeSnapshots = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> Exists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> ExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasPermissions permissions, System.DateTimeOffset expiresOn, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasBuilder builder) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasBuilder builder, out string stringToSign) => throw null;
                    public virtual Azure.Response<System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier>> GetAccessPolicy(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier>> GetAccessPolicy(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier>>> GetAccessPolicyAsync(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier>>> GetAccessPolicyAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Storage.Files.Shares.ShareDirectoryClient GetDirectoryClient(string directoryName) => throw null;
                    protected virtual Azure.Storage.Files.Shares.ShareServiceClient GetParentServiceClientCore() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFilePermission> GetPermission(string filePermissionKey, Azure.Storage.Files.Shares.Models.FilePermissionFormat? filePermissionFormat = default(Azure.Storage.Files.Shares.Models.FilePermissionFormat?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<string> GetPermission(string filePermissionKey, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFilePermission>> GetPermissionAsync(string filePermissionKey, Azure.Storage.Files.Shares.Models.FilePermissionFormat? filePermissionFormat = default(Azure.Storage.Files.Shares.Models.FilePermissionFormat?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<string>> GetPermissionAsync(string filePermissionKey, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareProperties> GetProperties(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareProperties> GetProperties(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareProperties>> GetPropertiesAsync(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareProperties>> GetPropertiesAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Storage.Files.Shares.ShareDirectoryClient GetRootDirectoryClient() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareStatistics> GetStatistics(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareStatistics> GetStatistics(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareStatistics>> GetStatisticsAsync(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareStatistics>> GetStatisticsAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual string Name { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> SetAccessPolicy(System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier> permissions, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> SetAccessPolicy(System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier> permissions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> SetAccessPolicyAsync(System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier> permissions, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> SetAccessPolicyAsync(System.Collections.Generic.IEnumerable<Azure.Storage.Files.Shares.Models.ShareSignedIdentifier> permissions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> SetProperties(Azure.Storage.Files.Shares.Models.ShareSetPropertiesOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> SetPropertiesAsync(Azure.Storage.Files.Shares.Models.ShareSetPropertiesOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> SetQuota(int quotaInGB = default(int), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo> SetQuota(int quotaInGB, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> SetQuotaAsync(int quotaInGB = default(int), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareInfo>> SetQuotaAsync(int quotaInGB, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Uri Uri { get => throw null; }
                    public virtual Azure.Storage.Files.Shares.ShareClient WithSnapshot(string snapshot) => throw null;
                }
                public class ShareClientOptions : Azure.Core.ClientOptions
                {
                    public bool? AllowSourceTrailingDot { get => throw null; set { } }
                    public bool? AllowTrailingDot { get => throw null; set { } }
                    public Azure.Storage.Files.Shares.Models.ShareAudience? Audience { get => throw null; set { } }
                    public ShareClientOptions(Azure.Storage.Files.Shares.ShareClientOptions.ServiceVersion version = default(Azure.Storage.Files.Shares.ShareClientOptions.ServiceVersion)) => throw null;
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
                    public Azure.Storage.Files.Shares.Models.ShareTokenIntent? ShareTokenIntent { get => throw null; set { } }
                    public Azure.Storage.TransferValidationOptions TransferValidation { get => throw null; }
                    public Azure.Storage.Files.Shares.ShareClientOptions.ServiceVersion Version { get => throw null; }
                }
                public class ShareDirectoryClient
                {
                    public virtual string AccountName { get => throw null; }
                    public virtual bool CanGenerateSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo> Create(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo> Create(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo>> CreateAsync(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo>> CreateAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareFileClient> CreateFile(string fileName, long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders = default(Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), string filePermission = default(string), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareFileClient> CreateFile(string fileName, long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareFileClient>> CreateFileAsync(string fileName, long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders = default(Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders), System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), string filePermission = default(string), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareFileClient>> CreateFileAsync(string fileName, long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo> CreateIfNotExists(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo> CreateIfNotExists(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo>> CreateIfNotExistsAsync(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryCreateOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo>> CreateIfNotExistsAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient> CreateSubdirectory(string subdirectoryName, System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), string filePermission = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient>> CreateSubdirectoryAsync(string subdirectoryName, System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties = default(Azure.Storage.Files.Shares.Models.FileSmbProperties), string filePermission = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected ShareDirectoryClient() => throw null;
                    public ShareDirectoryClient(string connectionString, string shareName, string directoryPath) => throw null;
                    public ShareDirectoryClient(string connectionString, string shareName, string directoryPath, Azure.Storage.Files.Shares.ShareClientOptions options) => throw null;
                    public ShareDirectoryClient(System.Uri directoryUri, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareDirectoryClient(System.Uri directoryUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareDirectoryClient(System.Uri directoryUri, Azure.AzureSasCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareDirectoryClient(System.Uri directoryUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public virtual Azure.Response Delete(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteFile(string fileName, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteFile(string fileName, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteFileAsync(string fileName, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteFileAsync(string fileName, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteSubdirectory(string subdirectoryName, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteSubdirectoryAsync(string subdirectoryName, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<bool> Exists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> ExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Files.Shares.Models.CloseHandlesResult ForceCloseAllHandles(bool? recursive = default(bool?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Storage.Files.Shares.Models.CloseHandlesResult> ForceCloseAllHandlesAsync(bool? recursive = default(bool?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.CloseHandlesResult> ForceCloseHandle(string handleId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.CloseHandlesResult>> ForceCloseHandleAsync(string handleId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareFileSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareFileSasPermissions permissions, System.DateTimeOffset expiresOn, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasBuilder builder) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasBuilder builder, out string stringToSign) => throw null;
                    public virtual Azure.Storage.Files.Shares.ShareFileClient GetFileClient(string fileName) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.Shares.Models.ShareFileItem> GetFilesAndDirectories(Azure.Storage.Files.Shares.Models.ShareDirectoryGetFilesAndDirectoriesOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryGetFilesAndDirectoriesOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.Shares.Models.ShareFileItem> GetFilesAndDirectories(string prefix, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.Shares.Models.ShareFileItem> GetFilesAndDirectoriesAsync(Azure.Storage.Files.Shares.Models.ShareDirectoryGetFilesAndDirectoriesOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectoryGetFilesAndDirectoriesOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.Shares.Models.ShareFileItem> GetFilesAndDirectoriesAsync(string prefix, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.Shares.Models.ShareFileHandle> GetHandles(bool? recursive = default(bool?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.Shares.Models.ShareFileHandle> GetHandlesAsync(bool? recursive = default(bool?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected virtual Azure.Storage.Files.Shares.ShareDirectoryClient GetParentDirectoryClientCore() => throw null;
                    protected virtual Azure.Storage.Files.Shares.ShareClient GetParentShareClientCore() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryProperties> GetProperties(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryProperties>> GetPropertiesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Files.Shares.ShareDirectoryClient GetSubdirectoryClient(string subdirectoryName) => throw null;
                    public virtual string Name { get => throw null; }
                    public virtual string Path { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient> Rename(string destinationPath, Azure.Storage.Files.Shares.Models.ShareFileRenameOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileRenameOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareDirectoryClient>> RenameAsync(string destinationPath, Azure.Storage.Files.Shares.Models.ShareFileRenameOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileRenameOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo> SetHttpHeaders(Azure.Storage.Files.Shares.Models.ShareDirectorySetHttpHeadersOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectorySetHttpHeadersOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo> SetHttpHeaders(Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo>> SetHttpHeadersAsync(Azure.Storage.Files.Shares.Models.ShareDirectorySetHttpHeadersOptions options = default(Azure.Storage.Files.Shares.Models.ShareDirectorySetHttpHeadersOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo>> SetHttpHeadersAsync(Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareDirectoryInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string ShareName { get => throw null; }
                    public virtual System.Uri Uri { get => throw null; }
                    public virtual Azure.Storage.Files.Shares.ShareDirectoryClient WithSnapshot(string snapshot) => throw null;
                }
                public class ShareFileClient
                {
                    public virtual Azure.Response AbortCopy(string copyId, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response AbortCopy(string copyId, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> AbortCopyAsync(string copyId, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> AbortCopyAsync(string copyId, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual string AccountName { get => throw null; }
                    public virtual bool CanGenerateSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> ClearRange(Azure.HttpRange range, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> ClearRangeAsync(Azure.HttpRange range, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> Create(long maxSize, Azure.Storage.Files.Shares.Models.ShareFileCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileCreateOptions), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> Create(long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> Create(long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> CreateAsync(long maxSize, Azure.Storage.Files.Shares.Models.ShareFileCreateOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileCreateOptions), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> CreateAsync(long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> CreateAsync(long maxSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> CreateHardLink(string targetFile, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> CreateHardLinkAsync(string targetFile, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected ShareFileClient() => throw null;
                    public ShareFileClient(string connectionString, string shareName, string filePath) => throw null;
                    public ShareFileClient(string connectionString, string shareName, string filePath, Azure.Storage.Files.Shares.ShareClientOptions options) => throw null;
                    public ShareFileClient(System.Uri fileUri, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareFileClient(System.Uri fileUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareFileClient(System.Uri fileUri, Azure.AzureSasCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareFileClient(System.Uri fileUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public virtual Azure.Response Delete(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response Delete(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<bool> DeleteIfExists(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> DeleteIfExistsAsync(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileDownloadInfo> Download(Azure.Storage.Files.Shares.Models.ShareFileDownloadOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileDownloadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileDownloadInfo> Download(Azure.HttpRange range, bool rangeGetContentHash, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileDownloadInfo> Download(Azure.HttpRange range, bool rangeGetContentHash, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileDownloadInfo>> DownloadAsync(Azure.Storage.Files.Shares.Models.ShareFileDownloadOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileDownloadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileDownloadInfo>> DownloadAsync(Azure.HttpRange range, bool rangeGetContentHash, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileDownloadInfo>> DownloadAsync(Azure.HttpRange range, bool rangeGetContentHash, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<bool> Exists(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<bool>> ExistsAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Files.Shares.Models.CloseHandlesResult ForceCloseAllHandles(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Storage.Files.Shares.Models.CloseHandlesResult> ForceCloseAllHandlesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.CloseHandlesResult> ForceCloseHandle(string handleId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.CloseHandlesResult>> ForceCloseHandleAsync(string handleId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareFileSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareFileSasPermissions permissions, System.DateTimeOffset expiresOn, out string stringToSign) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasBuilder builder) => throw null;
                    public virtual System.Uri GenerateSasUri(Azure.Storage.Sas.ShareSasBuilder builder, out string stringToSign) => throw null;
                    protected static System.Threading.Tasks.Task<Azure.HttpAuthorization> GetCopyAuthorizationHeaderAsync(Azure.Storage.Files.Shares.ShareFileClient client, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.Shares.Models.ShareFileHandle> GetHandles(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.Shares.Models.ShareFileHandle> GetHandlesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected virtual Azure.Storage.Files.Shares.ShareClient GetParentShareClientCore() => throw null;
                    protected virtual Azure.Storage.Files.Shares.ShareDirectoryClient GetParentShareDirectoryClientCore() => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileProperties> GetProperties(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileProperties> GetProperties(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileProperties>> GetPropertiesAsync(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileProperties>> GetPropertiesAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo> GetRangeList(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo> GetRangeList(Azure.HttpRange range, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo> GetRangeList(Azure.HttpRange range, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo>> GetRangeListAsync(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo>> GetRangeListAsync(Azure.HttpRange range, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo>> GetRangeListAsync(Azure.HttpRange range, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo> GetRangeListDiff(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListDiffOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListDiffOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileRangeInfo>> GetRangeListDiffAsync(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListDiffOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileGetRangeListDiffOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string Name { get => throw null; }
                    public virtual System.IO.Stream OpenRead(Azure.Storage.Files.Shares.Models.ShareFileOpenReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenRead(long position = default(long), int? bufferSize = default(int?), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenRead(bool allowfileModifications, long position = default(long), int? bufferSize = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(Azure.Storage.Files.Shares.Models.ShareFileOpenReadOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(long position = default(long), int? bufferSize = default(int?), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenReadAsync(bool allowfileModifications, long position = default(long), int? bufferSize = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.IO.Stream OpenWrite(bool overwrite, long position, Azure.Storage.Files.Shares.Models.ShareFileOpenWriteOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<System.IO.Stream> OpenWriteAsync(bool overwrite, long position, Azure.Storage.Files.Shares.Models.ShareFileOpenWriteOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileOpenWriteOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual string Path { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareFileClient> Rename(string destinationPath, Azure.Storage.Files.Shares.Models.ShareFileRenameOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileRenameOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareFileClient>> RenameAsync(string destinationPath, Azure.Storage.Files.Shares.Models.ShareFileRenameOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileRenameOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> SetHttpHeaders(Azure.Storage.Files.Shares.Models.ShareFileSetHttpHeadersOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileSetHttpHeadersOptions), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> SetHttpHeaders(long? newSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> SetHttpHeaders(long? newSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> SetHttpHeadersAsync(Azure.Storage.Files.Shares.Models.ShareFileSetHttpHeadersOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileSetHttpHeadersOptions), Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> SetHttpHeadersAsync(long? newSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> SetHttpHeadersAsync(long? newSize, Azure.Storage.Files.Shares.Models.ShareFileHttpHeaders httpHeaders, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo> SetMetadata(System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions = default(Azure.Storage.Files.Shares.Models.ShareFileRequestConditions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileInfo>> SetMetadataAsync(System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual string ShareName { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileCopyInfo> StartCopy(System.Uri sourceUri, Azure.Storage.Files.Shares.Models.ShareFileCopyOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileCopyOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileCopyInfo> StartCopy(System.Uri sourceUri, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, Azure.Storage.Files.Shares.Models.PermissionCopyMode? filePermissionCopyMode, bool? ignoreReadOnly, bool? setArchiveAttribute, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileCopyInfo> StartCopy(System.Uri sourceUri, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileCopyInfo>> StartCopyAsync(System.Uri sourceUri, Azure.Storage.Files.Shares.Models.ShareFileCopyOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileCopyOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileCopyInfo>> StartCopyAsync(System.Uri sourceUri, System.Collections.Generic.IDictionary<string, string> metadata, Azure.Storage.Files.Shares.Models.FileSmbProperties smbProperties, string filePermission, Azure.Storage.Files.Shares.Models.PermissionCopyMode? filePermissionCopyMode, bool? ignoreReadOnly, bool? setArchiveAttribute, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileCopyInfo>> StartCopyAsync(System.Uri sourceUri, System.Collections.Generic.IDictionary<string, string> metadata, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> Upload(System.IO.Stream stream, Azure.Storage.Files.Shares.Models.ShareFileUploadOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileUploadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> Upload(System.IO.Stream content, System.IProgress<long> progressHandler, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> Upload(System.IO.Stream content, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadAsync(System.IO.Stream stream, Azure.Storage.Files.Shares.Models.ShareFileUploadOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileUploadOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadAsync(System.IO.Stream content, System.IProgress<long> progressHandler, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadAsync(System.IO.Stream content, System.IProgress<long> progressHandler, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> UploadRange(Azure.HttpRange range, System.IO.Stream content, Azure.Storage.Files.Shares.Models.ShareFileUploadRangeOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileUploadRangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> UploadRange(Azure.HttpRange range, System.IO.Stream content, byte[] transactionalContentHash, System.IProgress<long> progressHandler, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> UploadRange(Azure.Storage.Files.Shares.Models.ShareFileRangeWriteType writeType, Azure.HttpRange range, System.IO.Stream content, byte[] transactionalContentHash = default(byte[]), System.IProgress<long> progressHandler = default(System.IProgress<long>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadRangeAsync(Azure.HttpRange range, System.IO.Stream content, Azure.Storage.Files.Shares.Models.ShareFileUploadRangeOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileUploadRangeOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadRangeAsync(Azure.HttpRange range, System.IO.Stream content, byte[] transactionalContentHash, System.IProgress<long> progressHandler, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadRangeAsync(Azure.Storage.Files.Shares.Models.ShareFileRangeWriteType writeType, Azure.HttpRange range, System.IO.Stream content, byte[] transactionalContentHash = default(byte[]), System.IProgress<long> progressHandler = default(System.IProgress<long>), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> UploadRangeFromUri(System.Uri sourceUri, Azure.HttpRange range, Azure.HttpRange sourceRange, Azure.Storage.Files.Shares.Models.ShareFileUploadRangeFromUriOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileUploadRangeFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> UploadRangeFromUri(System.Uri sourceUri, Azure.HttpRange range, Azure.HttpRange sourceRange, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo> UploadRangeFromUri(System.Uri sourceUri, Azure.HttpRange range, Azure.HttpRange sourceRange, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadRangeFromUriAsync(System.Uri sourceUri, Azure.HttpRange range, Azure.HttpRange sourceRange, Azure.Storage.Files.Shares.Models.ShareFileUploadRangeFromUriOptions options = default(Azure.Storage.Files.Shares.Models.ShareFileUploadRangeFromUriOptions), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadRangeFromUriAsync(System.Uri sourceUri, Azure.HttpRange range, Azure.HttpRange sourceRange, Azure.Storage.Files.Shares.Models.ShareFileRequestConditions conditions, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileUploadInfo>> UploadRangeFromUriAsync(System.Uri sourceUri, Azure.HttpRange range, Azure.HttpRange sourceRange, System.Threading.CancellationToken cancellationToken) => throw null;
                    public virtual System.Uri Uri { get => throw null; }
                    public virtual Azure.Storage.Files.Shares.ShareFileClient WithSnapshot(string shareSnapshot) => throw null;
                }
                public class ShareServiceClient
                {
                    public virtual string AccountName { get => throw null; }
                    public virtual bool CanGenerateAccountSasUri { get => throw null; }
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareClient> CreateShare(string shareName, Azure.Storage.Files.Shares.Models.ShareCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareClient> CreateShare(string shareName, System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), int? quotaInGB = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareClient>> CreateShareAsync(string shareName, Azure.Storage.Files.Shares.Models.ShareCreateOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareClient>> CreateShareAsync(string shareName, System.Collections.Generic.IDictionary<string, string> metadata = default(System.Collections.Generic.IDictionary<string, string>), int? quotaInGB = default(int?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    protected ShareServiceClient() => throw null;
                    public ShareServiceClient(string connectionString) => throw null;
                    public ShareServiceClient(string connectionString, Azure.Storage.Files.Shares.ShareClientOptions options) => throw null;
                    public ShareServiceClient(System.Uri serviceUri, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareServiceClient(System.Uri serviceUri, Azure.Storage.StorageSharedKeyCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareServiceClient(System.Uri serviceUri, Azure.AzureSasCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public ShareServiceClient(System.Uri serviceUri, Azure.Core.TokenCredential credential, Azure.Storage.Files.Shares.ShareClientOptions options = default(Azure.Storage.Files.Shares.ShareClientOptions)) => throw null;
                    public virtual Azure.Response DeleteShare(string shareName, Azure.Storage.Files.Shares.Models.ShareDeleteOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response DeleteShare(string shareName, bool includeSnapshots = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteShareAsync(string shareName, Azure.Storage.Files.Shares.Models.ShareDeleteOptions options, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> DeleteShareAsync(string shareName, bool includeSnapshots = default(bool), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Sas.AccountSasResourceTypes resourceTypes) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasPermissions permissions, System.DateTimeOffset expiresOn, Azure.Storage.Sas.AccountSasResourceTypes resourceTypes, out string stringToSign) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasBuilder builder) => throw null;
                    public System.Uri GenerateAccountSasUri(Azure.Storage.Sas.AccountSasBuilder builder, out string stringToSign) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareServiceProperties> GetProperties(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareServiceProperties>> GetPropertiesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Storage.Files.Shares.ShareClient GetShareClient(string shareName) => throw null;
                    public virtual Azure.Pageable<Azure.Storage.Files.Shares.Models.ShareItem> GetShares(Azure.Storage.Files.Shares.Models.ShareTraits traits = default(Azure.Storage.Files.Shares.Models.ShareTraits), Azure.Storage.Files.Shares.Models.ShareStates states = default(Azure.Storage.Files.Shares.Models.ShareStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.AsyncPageable<Azure.Storage.Files.Shares.Models.ShareItem> GetSharesAsync(Azure.Storage.Files.Shares.Models.ShareTraits traits = default(Azure.Storage.Files.Shares.Models.ShareTraits), Azure.Storage.Files.Shares.Models.ShareStates states = default(Azure.Storage.Files.Shares.Models.ShareStates), string prefix = default(string), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response SetProperties(Azure.Storage.Files.Shares.Models.ShareServiceProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response> SetPropertiesAsync(Azure.Storage.Files.Shares.Models.ShareServiceProperties properties, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual Azure.Response<Azure.Storage.Files.Shares.ShareClient> UndeleteShare(string deletedShareName, string deletedShareVersion, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.ShareClient>> UndeleteShareAsync(string deletedShareName, string deletedShareVersion, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                    public virtual System.Uri Uri { get => throw null; }
                }
                public class ShareUriBuilder
                {
                    public string AccountName { get => throw null; set { } }
                    public ShareUriBuilder(System.Uri uri) => throw null;
                    public string DirectoryOrFilePath { get => throw null; set { } }
                    public string Host { get => throw null; set { } }
                    public int Port { get => throw null; set { } }
                    public string Query { get => throw null; set { } }
                    public Azure.Storage.Sas.SasQueryParameters Sas { get => throw null; set { } }
                    public string Scheme { get => throw null; set { } }
                    public string ShareName { get => throw null; set { } }
                    public string Snapshot { get => throw null; set { } }
                    public override string ToString() => throw null;
                    public System.Uri ToUri() => throw null;
                }
                namespace Specialized
                {
                    public class ShareLeaseClient
                    {
                        public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease> Acquire(System.TimeSpan? duration = default(System.TimeSpan?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease> Acquire(System.Threading.CancellationToken cancellationToken) => throw null;
                        public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease>> AcquireAsync(System.TimeSpan? duration = default(System.TimeSpan?), System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease>> AcquireAsync(System.Threading.CancellationToken cancellationToken) => throw null;
                        public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease> Break(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease>> BreakAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease> Change(string proposedId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease>> ChangeAsync(string proposedId, System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        protected ShareLeaseClient() => throw null;
                        public ShareLeaseClient(Azure.Storage.Files.Shares.ShareFileClient client, string leaseId = default(string)) => throw null;
                        public ShareLeaseClient(Azure.Storage.Files.Shares.ShareClient client, string leaseId = default(string)) => throw null;
                        protected virtual Azure.Storage.Files.Shares.ShareFileClient FileClient { get => throw null; }
                        public static readonly System.TimeSpan InfiniteLeaseDuration;
                        public virtual string LeaseId { get => throw null; }
                        public virtual Azure.Response<Azure.Storage.Files.Shares.Models.FileLeaseReleaseInfo> Release(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.FileLeaseReleaseInfo>> ReleaseAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease> Renew(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        public virtual System.Threading.Tasks.Task<Azure.Response<Azure.Storage.Files.Shares.Models.ShareFileLease>> RenewAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken)) => throw null;
                        protected virtual Azure.Storage.Files.Shares.ShareClient ShareClient { get => throw null; }
                        public System.Uri Uri { get => throw null; }
                    }
                    public static partial class SpecializedFileExtensions
                    {
                        public static Azure.Storage.Files.Shares.Specialized.ShareLeaseClient GetShareLeaseClient(this Azure.Storage.Files.Shares.ShareFileClient client, string leaseId = default(string)) => throw null;
                        public static Azure.Storage.Files.Shares.Specialized.ShareLeaseClient GetShareLeaseClient(this Azure.Storage.Files.Shares.ShareClient client, string leaseId = default(string)) => throw null;
                    }
                    public static partial class SpecializedShareExtensions
                    {
                        public static Azure.Storage.Files.Shares.ShareDirectoryClient GetParentDirectoryClient(this Azure.Storage.Files.Shares.ShareDirectoryClient client) => throw null;
                        public static Azure.Storage.Files.Shares.ShareServiceClient GetParentServiceClient(this Azure.Storage.Files.Shares.ShareClient client) => throw null;
                        public static Azure.Storage.Files.Shares.ShareClient GetParentShareClient(this Azure.Storage.Files.Shares.ShareDirectoryClient client) => throw null;
                        public static Azure.Storage.Files.Shares.ShareClient GetParentShareClient(this Azure.Storage.Files.Shares.ShareFileClient client) => throw null;
                        public static Azure.Storage.Files.Shares.ShareDirectoryClient GetParentShareDirectoryClient(this Azure.Storage.Files.Shares.ShareFileClient client) => throw null;
                    }
                }
            }
        }
        namespace Sas
        {
            [System.Flags]
            public enum ShareAccountSasPermissions
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
            public enum ShareFileSasPermissions
            {
                Read = 1,
                Create = 2,
                Write = 4,
                Delete = 8,
                All = -1,
            }
            public class ShareSasBuilder
            {
                public string CacheControl { get => throw null; set { } }
                public string ContentDisposition { get => throw null; set { } }
                public string ContentEncoding { get => throw null; set { } }
                public string ContentLanguage { get => throw null; set { } }
                public string ContentType { get => throw null; set { } }
                public ShareSasBuilder() => throw null;
                public ShareSasBuilder(Azure.Storage.Sas.ShareFileSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                public ShareSasBuilder(Azure.Storage.Sas.ShareSasPermissions permissions, System.DateTimeOffset expiresOn) => throw null;
                public override bool Equals(object obj) => throw null;
                public System.DateTimeOffset ExpiresOn { get => throw null; set { } }
                public string FilePath { get => throw null; set { } }
                public override int GetHashCode() => throw null;
                public string Identifier { get => throw null; set { } }
                public Azure.Storage.Sas.SasIPRange IPRange { get => throw null; set { } }
                public string Permissions { get => throw null; }
                public Azure.Storage.Sas.SasProtocol Protocol { get => throw null; set { } }
                public string Resource { get => throw null; set { } }
                public void SetPermissions(Azure.Storage.Sas.ShareFileSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.ShareAccountSasPermissions permissions) => throw null;
                public void SetPermissions(Azure.Storage.Sas.ShareSasPermissions permissions) => throw null;
                public void SetPermissions(string rawPermissions, bool normalize = default(bool)) => throw null;
                public void SetPermissions(string rawPermissions) => throw null;
                public string ShareName { get => throw null; set { } }
                public System.DateTimeOffset StartsOn { get => throw null; set { } }
                public Azure.Storage.Sas.SasQueryParameters ToSasQueryParameters(Azure.Storage.StorageSharedKeyCredential sharedKeyCredential) => throw null;
                public Azure.Storage.Sas.SasQueryParameters ToSasQueryParameters(Azure.Storage.StorageSharedKeyCredential sharedKeyCredential, out string stringToSign) => throw null;
                public override string ToString() => throw null;
                public string Version { get => throw null; set { } }
            }
            [System.Flags]
            public enum ShareSasPermissions
            {
                Read = 1,
                Create = 2,
                Write = 4,
                Delete = 8,
                List = 16,
                All = -1,
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
//             public static partial class ShareClientBuilderExtensions
//             {
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.Shares.ShareServiceClient, Azure.Storage.Files.Shares.ShareClientOptions> AddFileServiceClient<TBuilder>(this TBuilder builder, string connectionString) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilder => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.Shares.ShareServiceClient, Azure.Storage.Files.Shares.ShareClientOptions> AddFileServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilder => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.Shares.ShareServiceClient, Azure.Storage.Files.Shares.ShareClientOptions> AddFileServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri, Azure.Storage.StorageSharedKeyCredential sharedKeyCredential) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilder => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.Shares.ShareServiceClient, Azure.Storage.Files.Shares.ShareClientOptions> AddFileServiceClient<TBuilder, TConfiguration>(this TBuilder builder, TConfiguration configuration) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilderWithConfiguration<TConfiguration> => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.Shares.ShareServiceClient, Azure.Storage.Files.Shares.ShareClientOptions> AddFileServiceClientWithCredential<TBuilder>(this TBuilder builder, System.Uri serviceUri) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilderWithCredential => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.Shares.ShareServiceClient, Azure.Storage.Files.Shares.ShareClientOptions> AddShareServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri, Azure.Core.TokenCredential tokenCredential) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilderWithCredential => throw null;
//                 public static Azure.Core.Extensions.IAzureClientBuilder<Azure.Storage.Files.Shares.ShareServiceClient, Azure.Storage.Files.Shares.ShareClientOptions> AddShareServiceClient<TBuilder>(this TBuilder builder, System.Uri serviceUri, Azure.AzureSasCredential sasCredential) where TBuilder : Azure.Core.Extensions.IAzureClientFactoryBuilder => throw null;
//             }
//         }
//     }
// }
