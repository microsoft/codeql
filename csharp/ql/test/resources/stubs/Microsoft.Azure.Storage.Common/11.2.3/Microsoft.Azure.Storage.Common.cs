// This file contains auto-generated code.
// Generated from `Microsoft.Azure.Storage.Common, Version=11.2.3.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35`.
namespace Microsoft
{
    namespace Azure
    {
        namespace Storage
        {
            public sealed class AccessCondition
            {
                public Microsoft.Azure.Storage.AccessCondition Clone() => throw null;
                public AccessCondition() => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateEmptyCondition() => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfAppendPositionEqualCondition(long appendPosition) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfExistsCondition() => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfMatchCondition(string etag) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfMaxSizeLessThanOrEqualCondition(long maxSize) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfModifiedSinceCondition(System.DateTimeOffset modifiedTime) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfNoneMatchCondition(string etag) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfNotExistsCondition() => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfNotModifiedSinceCondition(System.DateTimeOffset modifiedTime) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfSequenceNumberEqualCondition(long sequenceNumber) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfSequenceNumberLessThanCondition(long sequenceNumber) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateIfSequenceNumberLessThanOrEqualCondition(long sequenceNumber) => throw null;
                public static Microsoft.Azure.Storage.AccessCondition GenerateLeaseCondition(string leaseId) => throw null;
                public long? IfAppendPositionEqual { get => throw null; set { } }
                public string IfMatchContentCrc { get => throw null; set { } }
                public string IfMatchETag { get => throw null; set { } }
                public long? IfMaxSizeLessThanOrEqual { get => throw null; set { } }
                public System.DateTimeOffset? IfModifiedSinceTime { get => throw null; set { } }
                public string IfNoneMatchContentCrc { get => throw null; set { } }
                public string IfNoneMatchETag { get => throw null; set { } }
                public System.DateTimeOffset? IfNotModifiedSinceTime { get => throw null; set { } }
                public long? IfSequenceNumberEqual { get => throw null; set { } }
                public long? IfSequenceNumberLessThan { get => throw null; set { } }
                public long? IfSequenceNumberLessThanOrEqual { get => throw null; set { } }
                public string LeaseId { get => throw null; set { } }
            }
            namespace Auth
            {
                public struct NewTokenAndFrequency
                {
                    public NewTokenAndFrequency(string newToken, System.TimeSpan? newFrequency = default(System.TimeSpan?)) => throw null;
                    public System.TimeSpan? Frequency { get => throw null; set { } }
                    public string Token { get => throw null; set { } }
                }
                public delegate System.Threading.Tasks.Task<Microsoft.Azure.Storage.Auth.NewTokenAndFrequency> RenewTokenFuncAsync(object state, System.Threading.CancellationToken cancellationToken);
                public sealed class StorageCredentials
                {
                    public string AccountName { get => throw null; }
                    public StorageCredentials() => throw null;
                    public StorageCredentials(string accountName, string keyValue) => throw null;
                    public StorageCredentials(string accountName, byte[] keyValue) => throw null;
                    public StorageCredentials(string accountName, string keyValue, string keyName) => throw null;
                    public StorageCredentials(string accountName, byte[] keyValue, string keyName) => throw null;
                    public StorageCredentials(string sasToken) => throw null;
                    public StorageCredentials(Microsoft.Azure.Storage.Auth.TokenCredential tokenCredential) => throw null;
                    public bool Equals(Microsoft.Azure.Storage.Auth.StorageCredentials other) => throw null;
                    public string ExportBase64EncodedKey() => throw null;
                    public byte[] ExportKey() => throw null;
                    public bool IsAnonymous { get => throw null; }
                    public bool IsSAS { get => throw null; }
                    public bool IsSharedKey { get => throw null; }
                    public bool IsToken { get => throw null; }
                    public string KeyName { get => throw null; }
                    public string SASSignature { get => throw null; }
                    public string SASToken { get => throw null; }
                    public System.Uri TransformUri(System.Uri resourceUri) => throw null;
                    public Microsoft.Azure.Storage.StorageUri TransformUri(Microsoft.Azure.Storage.StorageUri resourceUri) => throw null;
                    public void UpdateKey(string keyValue) => throw null;
                    public void UpdateKey(byte[] keyValue) => throw null;
                    public void UpdateKey(string keyValue, string keyName) => throw null;
                    public void UpdateKey(byte[] keyValue, string keyName) => throw null;
                    public void UpdateSASToken(string sasToken) => throw null;
                }
                public sealed class TokenCredential : System.IDisposable
                {
                    public TokenCredential(string initialToken) => throw null;
                    public TokenCredential(string initialToken, Microsoft.Azure.Storage.Auth.RenewTokenFuncAsync periodicTokenRenewer, object state, System.TimeSpan renewFrequency) => throw null;
                    public void Dispose() => throw null;
                    public string Token { get => throw null; set { } }
                }
            }
            public enum AuthenticationScheme
            {
                SharedKeyLite = 0,
                SharedKey = 1,
                Token = 2,
            }
            public class CloudStorageAccount
            {
                public System.Uri BlobEndpoint { get => throw null; }
                public Microsoft.Azure.Storage.StorageUri BlobStorageUri { get => throw null; }
                public Microsoft.Azure.Storage.Auth.StorageCredentials Credentials { get => throw null; }
                public CloudStorageAccount(Microsoft.Azure.Storage.Auth.StorageCredentials storageCredentials, System.Uri blobEndpoint, System.Uri queueEndpoint, System.Uri tableEndpoint, System.Uri fileEndpoint) => throw null;
                public CloudStorageAccount(Microsoft.Azure.Storage.Auth.StorageCredentials storageCredentials, Microsoft.Azure.Storage.StorageUri blobStorageUri, Microsoft.Azure.Storage.StorageUri queueStorageUri, Microsoft.Azure.Storage.StorageUri tableStorageUri, Microsoft.Azure.Storage.StorageUri fileStorageUri) => throw null;
                public CloudStorageAccount(Microsoft.Azure.Storage.Auth.StorageCredentials storageCredentials, bool useHttps) => throw null;
                public CloudStorageAccount(Microsoft.Azure.Storage.Auth.StorageCredentials storageCredentials, string endpointSuffix, bool useHttps) => throw null;
                public CloudStorageAccount(Microsoft.Azure.Storage.Auth.StorageCredentials storageCredentials, string accountName, string endpointSuffix, bool useHttps) => throw null;
                public static Microsoft.Azure.Storage.CloudStorageAccount DevelopmentStorageAccount { get => throw null; }
                public System.Uri FileEndpoint { get => throw null; }
                public Microsoft.Azure.Storage.StorageUri FileStorageUri { get => throw null; }
                public string GetSharedAccessSignature(Microsoft.Azure.Storage.SharedAccessAccountPolicy policy) => throw null;
                public static Microsoft.Azure.Storage.CloudStorageAccount Parse(string connectionString) => throw null;
                public System.Uri QueueEndpoint { get => throw null; }
                public Microsoft.Azure.Storage.StorageUri QueueStorageUri { get => throw null; }
                public System.Uri TableEndpoint { get => throw null; }
                public Microsoft.Azure.Storage.StorageUri TableStorageUri { get => throw null; }
                public override string ToString() => throw null;
                public string ToString(bool exportSecrets) => throw null;
                public static bool TryParse(string connectionString, out Microsoft.Azure.Storage.CloudStorageAccount account) => throw null;
                public static bool UseV1MD5 { get => throw null; set { } }
            }
            namespace Core
            {
                namespace Auth
                {
                    public interface ICanonicalizer
                    {
                        string AuthorizationScheme { get; }
                        string CanonicalizeHttpRequest(System.Net.Http.HttpRequestMessage request, string accountName);
                    }
                    public sealed class SharedKeyCanonicalizer : Microsoft.Azure.Storage.Core.Auth.ICanonicalizer
                    {
                        public string AuthorizationScheme { get => throw null; }
                        public string CanonicalizeHttpRequest(System.Net.Http.HttpRequestMessage request, string accountName) => throw null;
                        public static Microsoft.Azure.Storage.Core.Auth.SharedKeyCanonicalizer Instance { get => throw null; }
                    }
                    public sealed class SharedKeyLiteCanonicalizer : Microsoft.Azure.Storage.Core.Auth.ICanonicalizer
                    {
                        public string AuthorizationScheme { get => throw null; }
                        public string CanonicalizeHttpRequest(System.Net.Http.HttpRequestMessage request, string accountName) => throw null;
                        public static Microsoft.Azure.Storage.Core.Auth.SharedKeyLiteCanonicalizer Instance { get => throw null; }
                    }
                }
                public class MultiBufferMemoryStream : System.IO.Stream
                {
                    public System.IAsyncResult BeginFastCopyTo(System.IO.Stream destination, System.DateTime? expiryTime, System.AsyncCallback callback, object state) => throw null;
                    public override System.IAsyncResult BeginRead(byte[] buffer, int offset, int count, System.AsyncCallback callback, object state) => throw null;
                    public override System.IAsyncResult BeginWrite(byte[] buffer, int offset, int count, System.AsyncCallback callback, object state) => throw null;
                    public override bool CanRead { get => throw null; }
                    public override bool CanSeek { get => throw null; }
                    public override bool CanWrite { get => throw null; }
                    public string ComputeCRC64Hash() => throw null;
                    public string ComputeMD5Hash() => throw null;
                    public MultiBufferMemoryStream(Microsoft.Azure.Storage.IBufferManager bufferManager, int bufferSize = default(int)) => throw null;
                    protected override void Dispose(bool disposing) => throw null;
                    public void EndFastCopyTo(System.IAsyncResult asyncResult) => throw null;
                    public override int EndRead(System.IAsyncResult asyncResult) => throw null;
                    public override void EndWrite(System.IAsyncResult asyncResult) => throw null;
                    public void FastCopyTo(System.IO.Stream destination, System.DateTime? expiryTime) => throw null;
                    public System.Threading.Tasks.Task FastCopyToAsync(System.IO.Stream destination, System.DateTime? expiryTime, System.Threading.CancellationToken token) => throw null;
                    public override void Flush() => throw null;
                    public override long Length { get => throw null; }
                    public override long Position { get => throw null; set { } }
                    public override int Read(byte[] buffer, int offset, int count) => throw null;
                    public override long Seek(long offset, System.IO.SeekOrigin origin) => throw null;
                    public override void SetLength(long value) => throw null;
                    public override void Write(byte[] buffer, int offset, int count) => throw null;
                }
                public sealed class NullType
                {
                }
                public class SasQueryBuilder : Microsoft.Azure.Storage.Core.UriQueryBuilder
                {
                    public override void Add(string name, string value) => throw null;
                    public override System.Uri AddToUri(System.Uri uri) => throw null;
                    public SasQueryBuilder(string sasToken) => throw null;
                    public bool RequireHttps { get => throw null; }
                }
                public class SyncMemoryStream : System.IO.MemoryStream
                {
                    public override System.IAsyncResult BeginRead(byte[] buffer, int offset, int count, System.AsyncCallback callback, object state) => throw null;
                    public override System.IAsyncResult BeginWrite(byte[] buffer, int offset, int count, System.AsyncCallback callback, object state) => throw null;
                    public SyncMemoryStream() => throw null;
                    public SyncMemoryStream(byte[] buffer) => throw null;
                    public SyncMemoryStream(byte[] buffer, int index) => throw null;
                    public SyncMemoryStream(byte[] buffer, int index, int count) => throw null;
                    public override int EndRead(System.IAsyncResult asyncResult) => throw null;
                    public override void EndWrite(System.IAsyncResult asyncResult) => throw null;
                }
                public class UriQueryBuilder
                {
                    public virtual void Add(string name, string value) => throw null;
                    public void AddRange(System.Collections.Generic.IEnumerable<System.Collections.Generic.KeyValuePair<string, string>> parameters) => throw null;
                    public Microsoft.Azure.Storage.StorageUri AddToUri(Microsoft.Azure.Storage.StorageUri storageUri) => throw null;
                    public virtual System.Uri AddToUri(System.Uri uri) => throw null;
                    protected System.Uri AddToUriCore(System.Uri uri) => throw null;
                    public bool ContainsQueryStringName(string name) => throw null;
                    public UriQueryBuilder() => throw null;
                    public UriQueryBuilder(Microsoft.Azure.Storage.Core.UriQueryBuilder builder) => throw null;
                    protected System.Collections.Generic.IDictionary<string, string> Parameters { get => throw null; }
                    public string this[string name] { get => throw null; }
                    public override string ToString() => throw null;
                }
                namespace Util
                {
                    public class AsyncManualResetEvent
                    {
                        public AsyncManualResetEvent(bool initialStateSignaled) => throw null;
                        public void Reset() => throw null;
                        public System.Threading.Tasks.Task Set() => throw null;
                        public System.Threading.Tasks.Task WaitAsync() => throw null;
                    }
                    public sealed class StorageProgress
                    {
                        public long BytesTransferred { get => throw null; }
                        public StorageProgress(long bytesTransferred) => throw null;
                    }
                }
            }
            [System.AttributeUsage((System.AttributeTargets)64, AllowMultiple = false)]
            public sealed class DoesServiceRequestAttribute : System.Attribute
            {
                public DoesServiceRequestAttribute() => throw null;
            }
            public interface IBufferManager
            {
                int GetDefaultBufferSize();
                void ReturnBuffer(byte[] buffer);
                byte[] TakeBuffer(int bufferSize);
            }
            public interface ICancellableAsyncResult : System.IAsyncResult
            {
                void Cancel();
            }
            public interface IContinuationToken
            {
                Microsoft.Azure.Storage.StorageLocation? TargetLocation { get; set; }
            }
            public class IPAddressOrRange
            {
                public string Address { get => throw null; }
                public IPAddressOrRange(string address) => throw null;
                public IPAddressOrRange(string minimum, string maximum) => throw null;
                public bool IsSingleAddress { get => throw null; }
                public string MaximumAddress { get => throw null; }
                public string MinimumAddress { get => throw null; }
                public override string ToString() => throw null;
            }
            public interface IRequestOptions
            {
                Microsoft.Azure.Storage.RetryPolicies.LocationMode? LocationMode { get; set; }
                System.TimeSpan? MaximumExecutionTime { get; set; }
                System.TimeSpan? NetworkTimeout { get; set; }
                bool? RequireEncryption { get; set; }
                Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy RetryPolicy { get; set; }
                System.TimeSpan? ServerTimeout { get; set; }
            }
            public enum LogLevel
            {
                Off = 0,
                Error = 1,
                Warning = 2,
                Informational = 3,
                Verbose = 4,
            }
            public static class NameValidator
            {
                public static void ValidateBlobName(string blobName) => throw null;
                public static void ValidateContainerName(string containerName) => throw null;
                public static void ValidateDirectoryName(string directoryName) => throw null;
                public static void ValidateFileName(string fileName) => throw null;
                public static void ValidateQueueName(string queueName) => throw null;
                public static void ValidateShareName(string shareName) => throw null;
                public static void ValidateTableName(string tableName) => throw null;
            }
            public sealed class OperationContext
            {
                public string ClientRequestID { get => throw null; set { } }
                public OperationContext() => throw null;
                public string CustomUserAgent { get => throw null; set { } }
                public static Microsoft.Azure.Storage.LogLevel DefaultLogLevel { get => throw null; set { } }
                public System.DateTime EndTime { get => throw null; set { } }
                public static event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> GlobalRequestCompleted;
                public static event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> GlobalResponseReceived;
                public static event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> GlobalRetrying;
                public static event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> GlobalSendingRequest;
                public Microsoft.Azure.Storage.RequestResult LastResult { get => throw null; }
                public Microsoft.Azure.Storage.LogLevel LogLevel { get => throw null; set { } }
                public event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> RequestCompleted;
                public System.Collections.Generic.IList<Microsoft.Azure.Storage.RequestResult> RequestResults { get => throw null; }
                public event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> ResponseReceived;
                public event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> Retrying;
                public event System.EventHandler<Microsoft.Azure.Storage.RequestEventArgs> SendingRequest;
                public System.DateTime StartTime { get => throw null; set { } }
                public System.Collections.Generic.IDictionary<string, string> UserHeaders { get => throw null; set { } }
            }
            public sealed class RequestEventArgs : System.EventArgs
            {
                public RequestEventArgs(Microsoft.Azure.Storage.RequestResult res) => throw null;
                public System.Net.Http.HttpRequestMessage Request { get => throw null; }
                public Microsoft.Azure.Storage.RequestResult RequestInformation { get => throw null; }
                public System.Net.Http.HttpResponseMessage Response { get => throw null; }
            }
            public class RequestResult
            {
                public string ContentCrc64 { get => throw null; }
                public string ContentMd5 { get => throw null; }
                public RequestResult() => throw null;
                public long EgressBytes { get => throw null; set { } }
                public string EncryptionKeySHA256 { get => throw null; }
                public string EncryptionScope { get => throw null; }
                public System.DateTime EndTime { get => throw null; }
                public string ErrorCode { get => throw null; }
                public string Etag { get => throw null; }
                public System.Exception Exception { get => throw null; set { } }
                public Microsoft.Azure.Storage.StorageExtendedErrorInformation ExtendedErrorInformation { get => throw null; }
                public int HttpStatusCode { get => throw null; set { } }
                public string HttpStatusMessage { get => throw null; }
                public long IngressBytes { get => throw null; set { } }
                public bool IsRequestServerEncrypted { get => throw null; }
                public bool IsServiceEncrypted { get => throw null; }
                public System.Threading.Tasks.Task ReadXmlAsync(System.Xml.XmlReader reader) => throw null;
                public string RequestDate { get => throw null; }
                public string ServiceRequestID { get => throw null; }
                public System.DateTime StartTime { get => throw null; }
                public Microsoft.Azure.Storage.StorageLocation TargetLocation { get => throw null; }
                public static Microsoft.Azure.Storage.RequestResult TranslateFromExceptionMessage(string message) => throw null;
                public void WriteXml(System.Xml.XmlWriter writer) => throw null;
            }
            public class ResultSegment<TElement>
            {
                public Microsoft.Azure.Storage.IContinuationToken ContinuationToken { get => throw null; }
                public System.Collections.Generic.List<TElement> Results { get => throw null; }
            }
            namespace RetryPolicies
            {
                public sealed class ExponentialRetry : Microsoft.Azure.Storage.RetryPolicies.IExtendedRetryPolicy, Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy
                {
                    public Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy CreateInstance() => throw null;
                    public ExponentialRetry() => throw null;
                    public ExponentialRetry(System.TimeSpan deltaBackoff, int maxAttempts) => throw null;
                    public Microsoft.Azure.Storage.RetryPolicies.RetryInfo Evaluate(Microsoft.Azure.Storage.RetryPolicies.RetryContext retryContext, Microsoft.Azure.Storage.OperationContext operationContext) => throw null;
                    public bool ShouldRetry(int currentRetryCount, int statusCode, System.Exception lastException, out System.TimeSpan retryInterval, Microsoft.Azure.Storage.OperationContext operationContext) => throw null;
                }
                public interface IExtendedRetryPolicy : Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy
                {
                    Microsoft.Azure.Storage.RetryPolicies.RetryInfo Evaluate(Microsoft.Azure.Storage.RetryPolicies.RetryContext retryContext, Microsoft.Azure.Storage.OperationContext operationContext);
                }
                public interface IRetryPolicy
                {
                    Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy CreateInstance();
                    bool ShouldRetry(int currentRetryCount, int statusCode, System.Exception lastException, out System.TimeSpan retryInterval, Microsoft.Azure.Storage.OperationContext operationContext);
                }
                public sealed class LinearRetry : Microsoft.Azure.Storage.RetryPolicies.IExtendedRetryPolicy, Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy
                {
                    public Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy CreateInstance() => throw null;
                    public LinearRetry() => throw null;
                    public LinearRetry(System.TimeSpan deltaBackoff, int maxAttempts) => throw null;
                    public Microsoft.Azure.Storage.RetryPolicies.RetryInfo Evaluate(Microsoft.Azure.Storage.RetryPolicies.RetryContext retryContext, Microsoft.Azure.Storage.OperationContext operationContext) => throw null;
                    public bool ShouldRetry(int currentRetryCount, int statusCode, System.Exception lastException, out System.TimeSpan retryInterval, Microsoft.Azure.Storage.OperationContext operationContext) => throw null;
                }
                public enum LocationMode
                {
                    PrimaryOnly = 0,
                    PrimaryThenSecondary = 1,
                    SecondaryOnly = 2,
                    SecondaryThenPrimary = 3,
                }
                public sealed class NoRetry : Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy
                {
                    public Microsoft.Azure.Storage.RetryPolicies.IRetryPolicy CreateInstance() => throw null;
                    public NoRetry() => throw null;
                    public bool ShouldRetry(int currentRetryCount, int statusCode, System.Exception lastException, out System.TimeSpan retryInterval, Microsoft.Azure.Storage.OperationContext operationContext) => throw null;
                }
                public sealed class RetryContext
                {
                    public int CurrentRetryCount { get => throw null; }
                    public Microsoft.Azure.Storage.RequestResult LastRequestResult { get => throw null; }
                    public Microsoft.Azure.Storage.RetryPolicies.LocationMode LocationMode { get => throw null; }
                    public Microsoft.Azure.Storage.StorageLocation NextLocation { get => throw null; }
                    public override string ToString() => throw null;
                }
                public sealed class RetryInfo
                {
                    public RetryInfo() => throw null;
                    public RetryInfo(Microsoft.Azure.Storage.RetryPolicies.RetryContext retryContext) => throw null;
                    public System.TimeSpan RetryInterval { get => throw null; set { } }
                    public Microsoft.Azure.Storage.StorageLocation TargetLocation { get => throw null; set { } }
                    public override string ToString() => throw null;
                    public Microsoft.Azure.Storage.RetryPolicies.LocationMode UpdatedLocationMode { get => throw null; set { } }
                }
            }
            namespace Shared
            {
                namespace Protocol
                {
                    public sealed class AccountProperties
                    {
                        public string AccountKind { get => throw null; }
                        public AccountProperties() => throw null;
                        public string SkuName { get => throw null; }
                    }
                    public sealed class Checksum
                    {
                        public string CRC64 { get => throw null; set { } }
                        public Checksum(string md5 = default(string), string crc64 = default(string)) => throw null;
                        public string MD5 { get => throw null; set { } }
                        public static Microsoft.Azure.Storage.Shared.Protocol.Checksum None { get => throw null; }
                        public static implicit operator Microsoft.Azure.Storage.Shared.Protocol.Checksum(string md5) => throw null;
                    }
                    public sealed class ChecksumOptions
                    {
                        public ChecksumOptions() => throw null;
                        public bool? DisableContentCRC64Validation { get => throw null; set { } }
                        public bool? DisableContentMD5Validation { get => throw null; set { } }
                        public bool? StoreContentMD5 { get => throw null; set { } }
                        public bool? UseTransactionalCRC64 { get => throw null; set { } }
                        public bool? UseTransactionalMD5 { get => throw null; set { } }
                    }
                    public static class Constants
                    {
                        public const string AccessPolicy = default;
                        public const string AccessTierChangeTimeElement = default;
                        public const string AccessTierElement = default;
                        public const string AccessTierInferred = default;
                        public const string AES256 = default;
                        public static class AnalyticsConstants
                        {
                            public const string LoggingVersionV1 = default;
                            public const string LogsContainer = default;
                            public const string MetricsCapacityBlob = default;
                            public const string MetricsHourPrimaryTransactionsBlob = default;
                            public const string MetricsHourPrimaryTransactionsFile = default;
                            public const string MetricsHourPrimaryTransactionsQueue = default;
                            public const string MetricsHourPrimaryTransactionsTable = default;
                            public const string MetricsHourSecondaryTransactionsBlob = default;
                            public const string MetricsHourSecondaryTransactionsFile = default;
                            public const string MetricsHourSecondaryTransactionsQueue = default;
                            public const string MetricsHourSecondaryTransactionsTable = default;
                            public const string MetricsMinutePrimaryTransactionsBlob = default;
                            public const string MetricsMinutePrimaryTransactionsFile = default;
                            public const string MetricsMinutePrimaryTransactionsQueue = default;
                            public const string MetricsMinutePrimaryTransactionsTable = default;
                            public const string MetricsMinuteSecondaryTransactionsBlob = default;
                            public const string MetricsMinuteSecondaryTransactionsFile = default;
                            public const string MetricsMinuteSecondaryTransactionsQueue = default;
                            public const string MetricsMinuteSecondaryTransactionsTable = default;
                            public const string MetricsVersionV1 = default;
                        }
                        public const string AppendBlobValue = default;
                        public const string ArchiveStatusElement = default;
                        public const string BlobElement = default;
                        public const string BlobPrefixElement = default;
                        public const string BlobsElement = default;
                        public const string BlobTypeElement = default;
                        public const string BlockBlobValue = default;
                        public const string BlockElement = default;
                        public const string BlockListElement = default;
                        public const string CacheControlElement = default;
                        public const string ClearRangeElement = default;
                        public const string ClientIpElement = default;
                        public const string CommittedBlocksElement = default;
                        public const string CommittedElement = default;
                        public const string ContainerElement = default;
                        public const string ContainerNameElement = default;
                        public const string ContainersElement = default;
                        public const string ContentEncodingElement = default;
                        public const string ContentLanguageElement = default;
                        public const string ContentLengthElement = default;
                        public const string ContentMD5Element = default;
                        public const string ContentTypeElement = default;
                        public static class ContinuationConstants
                        {
                            public const string BlobType = default;
                            public const string ContinuationTopElement = default;
                            public const string CurrentVersion = default;
                            public const string FileType = default;
                            public const string NextMarkerElement = default;
                            public const string NextPartitionKeyElement = default;
                            public const string NextRowKeyElement = default;
                            public const string NextTableNameElement = default;
                            public const string QueueType = default;
                            public const string TableType = default;
                            public const string TargetLocationElement = default;
                            public const string TypeElement = default;
                            public const string VersionElement = default;
                        }
                        public const string CopyAbortedValue = default;
                        public const string CopyCompletionTimeElement = default;
                        public const string CopyDestinationSnapshotElement = default;
                        public const string CopyFailedValue = default;
                        public const string CopyIdElement = default;
                        public const string CopyPendingValue = default;
                        public const string CopyProgressElement = default;
                        public const string CopySourceElement = default;
                        public const string CopyStatusDescriptionElement = default;
                        public const string CopyStatusElement = default;
                        public const string CopySuccessValue = default;
                        public const string CreationTimeElement = default;
                        public static readonly System.TimeSpan DefaultClientSideTimeout;
                        public static readonly System.TimeSpan DefaultNetworkTimeout;
                        public const long DefaultParallelDownloadRangeSizeBytes = 16777216;
                        public const int DefaultSubStreamBufferSize = 4194304;
                        public const int DefaultWriteBlockSizeBytes = 4194304;
                        public const string DeletedElement = default;
                        public const string DeletedTimeElement = default;
                        public const string DelimiterElement = default;
                        public const string DequeueCountElement = default;
                        public const string DirectoryPathElement = default;
                        public static class EncryptionConstants
                        {
                            public const string AgentMetadataKey = default;
                            public const string AgentMetadataValue = default;
                            public const string BlobEncryptionData = default;
                            public const string TableEncryptionKeyDetails = default;
                            public const string TableEncryptionPropertyDetails = default;
                        }
                        public const string EncryptionScopeElement = default;
                        public const string EndElement = default;
                        public const string EntriesElement = default;
                        public const string EnumerationResultsElement = default;
                        public const string ErrorCode = default;
                        public const string ErrorExceptionMessage = default;
                        public const string ErrorExceptionStackTrace = default;
                        public const string ErrorMessage = default;
                        public const string ErrorRootElement = default;
                        public const string EtagElement = default;
                        public const string ExpirationTimeElement = default;
                        public const string Expiry = default;
                        public const string FileDirectoryElement = default;
                        public const string FileElement = default;
                        public const string FileHandleListElement = default;
                        public const string FileIdElement = default;
                        public const string FileRangeElement = default;
                        public const string FileRangeListElement = default;
                        public const long GB = 1073741824;
                        public const string GeoBootstrapValue = default;
                        public const string GeoLiveValue = default;
                        public const string GeoUnavailableValue = default;
                        public const string HandleElement = default;
                        public const string HandleIdElement = default;
                        public const string HasImmutabilityPolicyElement = default;
                        public const string HasLegalHoldElement = default;
                        public static class HeaderConstants
                        {
                            public const string AccessTierChangeTimeHeader = default;
                            public const string AccessTierHeader = default;
                            public const string AccessTierInferredHeader = default;
                            public const string AllFileHandles = default;
                            public const string AppendBlob = default;
                            public const string ApproximateMessagesCount = default;
                            public const string ArchiveStatusHeader = default;
                            public const string BlobAppendOffset = default;
                            public const string BlobCacheControlHeader = default;
                            public const string BlobCommittedBlockCount = default;
                            public const string BlobContentDispositionRequestHeader = default;
                            public const string BlobContentEncodingHeader = default;
                            public const string BlobContentLanguageHeader = default;
                            public const string BlobContentLengthHeader = default;
                            public const string BlobContentMD5Header = default;
                            public const string BlobContentTypeHeader = default;
                            public const string BlobPublicAccess = default;
                            public const string BlobSequenceNumber = default;
                            public const string BlobType = default;
                            public const string BlockBlob = default;
                            public const string ClientProvidedEncryptionSuccess = default;
                            public const string ClientProvidedEncyptionAlgorithm = default;
                            public const string ClientProvidedEncyptionKey = default;
                            public const string ClientProvidedEncyptionKeyAlgorithmSource = default;
                            public const string ClientProvidedEncyptionKeyHash = default;
                            public const string ClientProvidedEncyptionKeyHashSource = default;
                            public const string ClientProvidedEncyptionKeySource = default;
                            public const string ClientRequestIdHeader = default;
                            public const string ContainerPublicAccessType = default;
                            public const string ContentCrc64Header = default;
                            public const string ContentDispositionResponseHeader = default;
                            public const string ContentLanguageHeader = default;
                            public const string ContentLengthHeader = default;
                            public const string CopyActionAbort = default;
                            public const string CopyActionHeader = default;
                            public const string CopyCompletionTimeHeader = default;
                            public const string CopyDescriptionHeader = default;
                            public const string CopyDestinationSnapshotHeader = default;
                            public const string CopyIdHeader = default;
                            public const string CopyProgressHeader = default;
                            public const string CopySourceHeader = default;
                            public const string CopyStatusHeader = default;
                            public const string CopyTypeHeader = default;
                            public const string CreationTimeHeader = default;
                            public const string Date = default;
                            public const string DefaultEncryptionScopeHeader = default;
                            public const string DeleteSnapshotHeader = default;
                            public const string EncryptionScopeHeader = default;
                            public const string EtagHeader = default;
                            public const string FalseHeader = default;
                            public const string File = default;
                            public const string FileAttributes = default;
                            public const string FileAttributesNone = default;
                            public const string FileCacheControlHeader = default;
                            public const string FileChangeTime = default;
                            public const string FileContentCRC64Header = default;
                            public const string FileContentDispositionRequestHeader = default;
                            public const string FileContentEncodingHeader = default;
                            public const string FileContentLanguageHeader = default;
                            public const string FileContentLengthHeader = default;
                            public const string FileContentMD5Header = default;
                            public const string FileContentTypeHeader = default;
                            public const string FileCopyFromSource = default;
                            public const string FileCopyInoreReadOnly = default;
                            public const string FileCopyOverride = default;
                            public const string FileCopySetArchive = default;
                            public const string FileCreationTime = default;
                            public const string FileId = default;
                            public const string FileLastWriteTime = default;
                            public const string FileParentId = default;
                            public const string FilePermission = default;
                            public const string FilePermissionCopyMode = default;
                            public const string FilePermissionInherit = default;
                            public const string FilePermissionKey = default;
                            public const string FileRangeWrite = default;
                            public const string FileTimeNow = default;
                            public const string FileType = default;
                            public const string HandleId = default;
                            public const string HasImmutabilityPolicyHeader = default;
                            public const string HasLegalHoldHeader = default;
                            public const string IfAppendPositionEqualHeader = default;
                            public const string IfMaxSizeLessThanOrEqualHeader = default;
                            public const string IfSequenceNumberEqHeader = default;
                            public const string IfSequenceNumberLEHeader = default;
                            public const string IfSequenceNumberLTHeader = default;
                            public const string IncludeSnapshotsValue = default;
                            public const string IncrementalCopyHeader = default;
                            public const string KeyNameHeader = default;
                            public const string LeaseActionHeader = default;
                            public const string LeaseBreakPeriodHeader = default;
                            public const string LeaseDurationHeader = default;
                            public const string LeaseIdHeader = default;
                            public const string LeaseState = default;
                            public const string LeaseStatus = default;
                            public const string LeaseTimeHeader = default;
                            public const string Marker = default;
                            public const string NextVisibleTime = default;
                            public const string NumHandlesClosed = default;
                            public const string PageBlob = default;
                            public const string PageWrite = default;
                            public const string PeekOnly = default;
                            public const string PopReceipt = default;
                            public const string PrefixForStorageHeader = default;
                            public const string PrefixForStorageMetadata = default;
                            public const string PrefixForStorageProperties = default;
                            public const string Preserve = default;
                            public const string PreventEncryptionScopeOverrideHeader = default;
                            public const string ProposedLeaseIdHeader = default;
                            public const string RangeContentCRC64Header = default;
                            public const string RangeContentMD5Header = default;
                            public const string RangeHeader = default;
                            public const string RangeHeaderFormat = default;
                            public const string Recursive = default;
                            public const string RehydratePriorityHeader = default;
                            public const string RequestIdHeader = default;
                            public const string RequiresSyncHeader = default;
                            public const string SequenceNumberAction = default;
                            public const string ServerEncrypted = default;
                            public const string ServerRequestEncrypted = default;
                            public const string ShareQuota = default;
                            public const string ShareSize = default;
                            public const string SnapshotHeader = default;
                            public const string SnapshotsOnlyValue = default;
                            public const string SourceContentMD5Header = default;
                            public const string SourceIfMatchCrcHeader = default;
                            public const string SourceIfMatchHeader = default;
                            public const string SourceIfModifiedSinceHeader = default;
                            public const string SourceIfNoneMatchCrcHeader = default;
                            public const string SourceIfNoneMatchHeader = default;
                            public const string SourceIfUnmodifiedSinceHeader = default;
                            public const string SourceRangeHeader = default;
                            public const string StorageVersionHeader = default;
                            public const string TargetStorageVersion = default;
                            public const string TrueHeader = default;
                            public static readonly string UserAgent;
                            public static readonly string UserAgentComment;
                            public const string UserAgentProductName = default;
                            public const string UserAgentProductVersion = default;
                        }
                        public const string Id = default;
                        public const string IncrementalCopy = default;
                        public const string InsertionTimeElement = default;
                        public const string InvalidMetadataName = default;
                        public const long KB = 1024;
                        public const string KeyInfo = default;
                        public const string LastModifiedElement = default;
                        public const string LastReconnectTimeElement = default;
                        public const string LatestElement = default;
                        public const string LeaseAvailableValue = default;
                        public const string LeaseBreakingValue = default;
                        public const string LeaseBrokenValue = default;
                        public const string LeaseDurationElement = default;
                        public const string LeasedValue = default;
                        public const string LeaseExpiredValue = default;
                        public const string LeaseFixedValue = default;
                        public const string LeaseInfiniteValue = default;
                        public const string LeaseStateElement = default;
                        public const string LeaseStatusElement = default;
                        public const string LockedValue = default;
                        public const string MarkerElement = default;
                        public const int MaxAppendBlockSize = 4194304;
                        public const long MaxBlobSize = 5242880000000;
                        public const long MaxBlockNumber = 50000;
                        public const int MaxBlockSize = 104857600;
                        public const int MaxIdleTimeMs = 120000;
                        public static readonly System.TimeSpan MaximumAllowedTimeout;
                        public const int MaximumBreakLeasePeriod = 60;
                        public const int MaximumLeaseDuration = 60;
                        public static readonly System.TimeSpan MaximumRetryBackoff;
                        public static readonly System.TimeSpan MaxMaximumExecutionTime;
                        public const int MaxParallelOperationThreadCount = 64;
                        public const int MaxRangeGetContentCRC64Size = 4194304;
                        public const int MaxRangeGetContentMD5Size = 4194304;
                        public const string MaxResults = default;
                        public const string MaxResultsElement = default;
                        public const int MaxRetainedVersionsPerBlob = 10;
                        public const int MaxSharedAccessPolicyIdentifiers = 5;
                        public const long MaxSingleUploadBlobSize = 268435456;
                        public const int MaxSubOperationPerBatch = 256;
                        public const long MB = 1048576;
                        public const string MessageElement = default;
                        public const string MessageIdElement = default;
                        public const string Messages = default;
                        public const string MessagesElement = default;
                        public const string MessageTextElement = default;
                        public const string MetadataElement = default;
                        public const int MinimumBreakLeasePeriod = 0;
                        public const int MinimumLeaseDuration = 15;
                        public const int MinLargeBlockSize = 4194305;
                        public const string NameElement = default;
                        public const string NextMarkerElement = default;
                        public const string OpenTimeElement = default;
                        public const string PageBlobValue = default;
                        public const string PageListElement = default;
                        public const string PageRangeElement = default;
                        public const int PageSize = 512;
                        public const string ParentIdElement = default;
                        public const string PathElement = default;
                        public const string Permission = default;
                        public const string PopReceiptElement = default;
                        public const string PrefixElement = default;
                        public const string PropertiesElement = default;
                        public const string PublicAccessElement = default;
                        public static class QueryConstants
                        {
                            public const string ApiVersion = default;
                            public const string BlobResourceType = default;
                            public const string BlobSnapshotResourceType = default;
                            public const string CacheControl = default;
                            public const string Component = default;
                            public const string ContainerResourceType = default;
                            public const string ContentDisposition = default;
                            public const string ContentEncoding = default;
                            public const string ContentLanguage = default;
                            public const string ContentType = default;
                            public const string CopyId = default;
                            public const string EndPartitionKey = default;
                            public const string EndRowKey = default;
                            public const string Marker = default;
                            public const string MessageTimeToLive = default;
                            public const string NumOfMessages = default;
                            public const string PopReceipt = default;
                            public const string ResourceType = default;
                            public const string SasTableName = default;
                            public const string ShareSnapshot = default;
                            public const string Signature = default;
                            public const string SignedExpiry = default;
                            public const string SignedIdentifier = default;
                            public const string SignedIP = default;
                            public const string SignedKey = default;
                            public const string SignedKeyExpiry = default;
                            public const string SignedKeyOid = default;
                            public const string SignedKeyService = default;
                            public const string SignedKeyStart = default;
                            public const string SignedKeyTid = default;
                            public const string SignedKeyVersion = default;
                            public const string SignedPermissions = default;
                            public const string SignedProtocols = default;
                            public const string SignedResource = default;
                            public const string SignedResourceTypes = default;
                            public const string SignedServices = default;
                            public const string SignedStart = default;
                            public const string SignedVersion = default;
                            public const string Snapshot = default;
                            public const string StartPartitionKey = default;
                            public const string StartRowKey = default;
                            public const string VisibilityTimeout = default;
                        }
                        public const string QueueElement = default;
                        public const string QueueNameElement = default;
                        public const string QueuesElement = default;
                        public const string QuotaElement = default;
                        public const string RehydratePendingToCool = default;
                        public const string RehydratePendingToHot = default;
                        public const string RemainingRetentionDaysElement = default;
                        public const string ServerEncryptionElement = default;
                        public const string ServiceEndpointElement = default;
                        public const string SessionIdElement = default;
                        public const string ShareElement = default;
                        public const string ShareNameElement = default;
                        public const string SharesElement = default;
                        public const string SignedExpiry = default;
                        public const string SignedIdentifier = default;
                        public const string SignedIdentifiers = default;
                        public const string SignedOid = default;
                        public const string SignedService = default;
                        public const string SignedStart = default;
                        public const string SignedTid = default;
                        public const string SignedVersion = default;
                        public const string SizeElement = default;
                        public const string SnapshotElement = default;
                        public const string Start = default;
                        public const string StartElement = default;
                        public const string TimeNextVisibleElement = default;
                        public const string UncommittedBlocksElement = default;
                        public const string UncommittedElement = default;
                        public const string UnlockedValue = default;
                        public const string UrlElement = default;
                        public const string UserDelegationKey = default;
                        public const string Value = default;
                        public static class VersionConstants
                        {
                            public const string August2013 = default;
                            public const string February2012 = default;
                        }
                    }
                    [System.Flags]
                    public enum CorsHttpMethods
                    {
                        None = 0,
                        Get = 1,
                        Head = 2,
                        Post = 4,
                        Put = 8,
                        Delete = 16,
                        Trace = 32,
                        Options = 64,
                        Connect = 128,
                        Merge = 256,
                        Patch = 512,
                    }
                    public sealed class CorsProperties
                    {
                        public System.Collections.Generic.IList<Microsoft.Azure.Storage.Shared.Protocol.CorsRule> CorsRules { get => throw null; }
                        public CorsProperties() => throw null;
                    }
                    public sealed class CorsRule
                    {
                        public System.Collections.Generic.IList<string> AllowedHeaders { get => throw null; set { } }
                        public Microsoft.Azure.Storage.Shared.Protocol.CorsHttpMethods AllowedMethods { get => throw null; set { } }
                        public System.Collections.Generic.IList<string> AllowedOrigins { get => throw null; set { } }
                        public CorsRule() => throw null;
                        public System.Collections.Generic.IList<string> ExposedHeaders { get => throw null; set { } }
                        public int MaxAgeInSeconds { get => throw null; set { } }
                    }
                    public sealed class DeleteRetentionPolicy
                    {
                        public DeleteRetentionPolicy() => throw null;
                        public bool Enabled { get => throw null; set { } }
                        public int? RetentionDays { get => throw null; set { } }
                    }
                    public sealed class GeoReplicationStats
                    {
                        public System.DateTimeOffset? LastSyncTime { get => throw null; }
                        public Microsoft.Azure.Storage.Shared.Protocol.GeoReplicationStatus Status { get => throw null; }
                    }
                    public enum GeoReplicationStatus
                    {
                        Unavailable = 0,
                        Live = 1,
                        Bootstrap = 2,
                    }
                    public class ListingContext
                    {
                        public ListingContext(string prefix, int? maxResults) => throw null;
                        public string Marker { get => throw null; set { } }
                        public int? MaxResults { get => throw null; set { } }
                        public string Prefix { get => throw null; set { } }
                    }
                    [System.Flags]
                    public enum LoggingOperations
                    {
                        None = 0,
                        Read = 1,
                        Write = 2,
                        Delete = 4,
                        All = 7,
                    }
                    public sealed class LoggingProperties
                    {
                        public LoggingProperties() => throw null;
                        public LoggingProperties(string version) => throw null;
                        public Microsoft.Azure.Storage.Shared.Protocol.LoggingOperations LoggingOperations { get => throw null; set { } }
                        public int? RetentionDays { get => throw null; set { } }
                        public string Version { get => throw null; set { } }
                    }
                    public enum MetricsLevel
                    {
                        None = 0,
                        Service = 1,
                        ServiceAndApi = 2,
                    }
                    public sealed class MetricsProperties
                    {
                        public MetricsProperties() => throw null;
                        public MetricsProperties(string version) => throw null;
                        public Microsoft.Azure.Storage.Shared.Protocol.MetricsLevel MetricsLevel { get => throw null; set { } }
                        public int? RetentionDays { get => throw null; set { } }
                        public string Version { get => throw null; set { } }
                    }
                    public abstract class ResponseParsingBase<T> : System.IDisposable
                    {
                        protected bool allObjectsParsed;
                        protected ResponseParsingBase(System.IO.Stream stream) => throw null;
                        public void Dispose() => throw null;
                        protected virtual void Dispose(bool disposing) => throw null;
                        protected System.Collections.Generic.IEnumerable<T> ObjectsToParse { get => throw null; }
                        protected System.Collections.Generic.IList<T> outstandingObjectsToParse;
                        protected abstract System.Collections.Generic.IEnumerable<T> ParseXml();
                        protected System.Xml.XmlReader reader;
                        protected void Variable(ref bool consumable) => throw null;
                    }
                    public sealed class ServiceProperties
                    {
                        public Microsoft.Azure.Storage.Shared.Protocol.CorsProperties Cors { get => throw null; set { } }
                        public ServiceProperties() => throw null;
                        public ServiceProperties(Microsoft.Azure.Storage.Shared.Protocol.LoggingProperties logging = default(Microsoft.Azure.Storage.Shared.Protocol.LoggingProperties), Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties hourMetrics = default(Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties), Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties minuteMetrics = default(Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties), Microsoft.Azure.Storage.Shared.Protocol.CorsProperties cors = default(Microsoft.Azure.Storage.Shared.Protocol.CorsProperties), Microsoft.Azure.Storage.Shared.Protocol.DeleteRetentionPolicy deleteRetentionPolicy = default(Microsoft.Azure.Storage.Shared.Protocol.DeleteRetentionPolicy)) => throw null;
                        public ServiceProperties(Microsoft.Azure.Storage.Shared.Protocol.LoggingProperties logging, Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties hourMetrics, Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties minuteMetrics, Microsoft.Azure.Storage.Shared.Protocol.CorsProperties cors, Microsoft.Azure.Storage.Shared.Protocol.DeleteRetentionPolicy deleteRetentionPolicy, Microsoft.Azure.Storage.Shared.Protocol.StaticWebsiteProperties staticWebsite = default(Microsoft.Azure.Storage.Shared.Protocol.StaticWebsiteProperties)) => throw null;
                        public string DefaultServiceVersion { get => throw null; set { } }
                        public Microsoft.Azure.Storage.Shared.Protocol.DeleteRetentionPolicy DeleteRetentionPolicy { get => throw null; set { } }
                        public Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties HourMetrics { get => throw null; set { } }
                        public Microsoft.Azure.Storage.Shared.Protocol.LoggingProperties Logging { get => throw null; set { } }
                        public Microsoft.Azure.Storage.Shared.Protocol.MetricsProperties MinuteMetrics { get => throw null; set { } }
                        public Microsoft.Azure.Storage.Shared.Protocol.StaticWebsiteProperties StaticWebsite { get => throw null; set { } }
                    }
                    public sealed class ServiceStats
                    {
                        public Microsoft.Azure.Storage.Shared.Protocol.GeoReplicationStats GeoReplication { get => throw null; }
                    }
                    public sealed class StaticWebsiteProperties
                    {
                        public StaticWebsiteProperties() => throw null;
                        public bool Enabled { get => throw null; set { } }
                        public string ErrorDocument404Path { get => throw null; set { } }
                        public string IndexDocument { get => throw null; set { } }
                    }
                    public static class StorageErrorCodeStrings
                    {
                        public static readonly string AccountAlreadyExists;
                        public static readonly string AccountBeingCreated;
                        public static readonly string AccountIsDisabled;
                        public static readonly string AuthenticationFailed;
                        public static readonly string ConditionHeadersNotSupported;
                        public static readonly string ConditionNotMet;
                        public static readonly string ContainerAlreadyExists;
                        public static readonly string ContainerBeingDeleted;
                        public static readonly string ContainerDisabled;
                        public static readonly string ContainerNotFound;
                        public static readonly string Crc64Mismatch;
                        public static readonly string EmptyMetadataKey;
                        public static readonly string InsufficientAccountPermissions;
                        public static readonly string InternalError;
                        public static readonly string InvalidAuthenticationInfo;
                        public static readonly string InvalidCrc64;
                        public static readonly string InvalidHeaderValue;
                        public static readonly string InvalidHttpVerb;
                        public static readonly string InvalidInput;
                        public static readonly string InvalidMd5;
                        public static readonly string InvalidMetadata;
                        public static readonly string InvalidQueryParameterValue;
                        public static readonly string InvalidRange;
                        public static readonly string InvalidResourceName;
                        public static readonly string InvalidUri;
                        public static readonly string InvalidXmlDocument;
                        public static readonly string InvalidXmlNodeValue;
                        public static readonly string Md5Mismatch;
                        public static readonly string MetadataTooLarge;
                        public static readonly string MissingContentLengthHeader;
                        public static readonly string MissingRequiredHeader;
                        public static readonly string MissingRequiredQueryParameter;
                        public static readonly string MissingRequiredXmlNode;
                        public static readonly string MultipleConditionHeadersNotSupported;
                        public static readonly string OperationTimedOut;
                        public static readonly string OutOfRangeInput;
                        public static readonly string OutOfRangeQueryParameterValue;
                        public static readonly string RequestBodyTooLarge;
                        public static readonly string RequestUrlFailedToParse;
                        public static readonly string ResourceAlreadyExists;
                        public static readonly string ResourceNotFound;
                        public static readonly string ResourceTypeMismatch;
                        public static readonly string ServerBusy;
                        public static readonly string UnsupportedHeader;
                        public static readonly string UnsupportedHttpVerb;
                        public static readonly string UnsupportedQueryParameter;
                        public static readonly string UnsupportedXmlNode;
                    }
                    public enum StorageService
                    {
                        Blob = 0,
                        Queue = 1,
                        Table = 2,
                        File = 3,
                    }
                }
            }
            [System.Flags]
            public enum SharedAccessAccountPermissions
            {
                None = 0,
                Read = 1,
                Add = 2,
                Create = 4,
                Update = 8,
                ProcessMessages = 16,
                Write = 32,
                Delete = 64,
                List = 128,
            }
            public sealed class SharedAccessAccountPolicy
            {
                public SharedAccessAccountPolicy() => throw null;
                public Microsoft.Azure.Storage.IPAddressOrRange IPAddressOrRange { get => throw null; set { } }
                public Microsoft.Azure.Storage.SharedAccessAccountPermissions Permissions { get => throw null; set { } }
                public static string PermissionsToString(Microsoft.Azure.Storage.SharedAccessAccountPermissions permissions) => throw null;
                public Microsoft.Azure.Storage.SharedAccessProtocol? Protocols { get => throw null; set { } }
                public Microsoft.Azure.Storage.SharedAccessAccountResourceTypes ResourceTypes { get => throw null; set { } }
                public static string ResourceTypesToString(Microsoft.Azure.Storage.SharedAccessAccountResourceTypes resourceTypes) => throw null;
                public Microsoft.Azure.Storage.SharedAccessAccountServices Services { get => throw null; set { } }
                public static string ServicesToString(Microsoft.Azure.Storage.SharedAccessAccountServices services) => throw null;
                public System.DateTimeOffset? SharedAccessExpiryTime { get => throw null; set { } }
                public System.DateTimeOffset? SharedAccessStartTime { get => throw null; set { } }
            }
            [System.Flags]
            public enum SharedAccessAccountResourceTypes
            {
                None = 0,
                Service = 1,
                Container = 2,
                Object = 4,
            }
            [System.Flags]
            public enum SharedAccessAccountServices
            {
                None = 0,
                Blob = 1,
                File = 2,
                Queue = 4,
                Table = 8,
            }
            public enum SharedAccessProtocol
            {
                HttpsOnly = 1,
                HttpsOrHttp = 2,
            }
            public class StorageException : System.Exception
            {
                public StorageException() => throw null;
                public StorageException(string message) => throw null;
                public StorageException(string message, System.Exception innerException) => throw null;
                protected StorageException(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContext context) => throw null;
                public StorageException(Microsoft.Azure.Storage.RequestResult res, string message, System.Exception inner) => throw null;
                public override void GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContext context) => throw null;
                public Microsoft.Azure.Storage.RequestResult RequestInformation { get => throw null; }
                public override string ToString() => throw null;
                public static System.Threading.Tasks.Task<Microsoft.Azure.Storage.StorageException> TranslateExceptionAsync(System.Exception ex, Microsoft.Azure.Storage.RequestResult reqResult, System.Func<System.IO.Stream, System.Threading.CancellationToken, System.Threading.Tasks.Task<Microsoft.Azure.Storage.StorageExtendedErrorInformation>> parseErrorAsync, System.Threading.CancellationToken cancellationToken, System.Net.Http.HttpResponseMessage response) => throw null;
            }
            public sealed class StorageExtendedErrorInformation
            {
                public System.Collections.Generic.IDictionary<string, string> AdditionalDetails { get => throw null; }
                public StorageExtendedErrorInformation() => throw null;
                public string ErrorCode { get => throw null; }
                public string ErrorMessage { get => throw null; }
                public static System.Threading.Tasks.Task<Microsoft.Azure.Storage.StorageExtendedErrorInformation> ReadFromStreamAsync(System.IO.Stream inputStream) => throw null;
                public static System.Threading.Tasks.Task<Microsoft.Azure.Storage.StorageExtendedErrorInformation> ReadFromStreamAsync(System.IO.Stream inputStream, System.Threading.CancellationToken cancellationToken) => throw null;
                public System.Threading.Tasks.Task ReadXmlAsync(System.Xml.XmlReader reader, System.Threading.CancellationToken cancellationToken) => throw null;
                public void WriteXml(System.Xml.XmlWriter writer) => throw null;
            }
            public enum StorageLocation
            {
                Primary = 0,
                Secondary = 1,
            }
            public sealed class StorageUri : System.IEquatable<Microsoft.Azure.Storage.StorageUri>
            {
                public StorageUri(System.Uri primaryUri) => throw null;
                public StorageUri(System.Uri primaryUri, System.Uri secondaryUri) => throw null;
                public override bool Equals(object obj) => throw null;
                public bool Equals(Microsoft.Azure.Storage.StorageUri other) => throw null;
                public override int GetHashCode() => throw null;
                public System.Uri GetUri(Microsoft.Azure.Storage.StorageLocation location) => throw null;
                public static bool operator ==(Microsoft.Azure.Storage.StorageUri uri1, Microsoft.Azure.Storage.StorageUri uri2) => throw null;
                public static bool operator !=(Microsoft.Azure.Storage.StorageUri uri1, Microsoft.Azure.Storage.StorageUri uri2) => throw null;
                public System.Uri PrimaryUri { get => throw null; }
                public System.Uri SecondaryUri { get => throw null; }
                public override string ToString() => throw null;
            }
            public sealed class UserDelegationKey
            {
                public UserDelegationKey() => throw null;
                public System.DateTimeOffset? SignedExpiry { get => throw null; }
                public System.Guid? SignedOid { get => throw null; }
                public string SignedService { get => throw null; }
                public System.DateTimeOffset? SignedStart { get => throw null; }
                public System.Guid? SignedTid { get => throw null; }
                public string SignedVersion { get => throw null; }
                public string Value { get => throw null; }
            }
        }
    }
}
