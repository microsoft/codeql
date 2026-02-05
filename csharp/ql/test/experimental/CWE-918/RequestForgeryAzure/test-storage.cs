using Azure.Identity;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.ChangeFeed;
using Azure.Storage.Files.DataLake;
using Azure.Storage.Files.Shares;
using Azure.Storage.Queues;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Storage;
using Microsoft.Azure.Storage.Blob;
using Microsoft.Azure.Storage.Core;
using System;
using System.Threading.Tasks;

namespace TestStorage
{
    public class HomeController : Controller
    {
        public void Index(string region = "", string env = "")
        {
            // BAD: a request parameter is incorporated without validation into a Http request
            var client = new BlobContainerClient(new Uri($"https://{env}/"));

            var client2 = new BlobServiceClient(new Uri($"https://{env}/"));

            var client3 = new BlobClient("https://something", region, env);

            BlobUriBuilder blobUriBuilder = new BlobUriBuilder(new Uri($"https://{region}/"));
            var client4 = new BlobClient(blobUriBuilder.ToString(), blobUriBuilder.BlobContainerName, blobUriBuilder.BlobName);
            var client5 = new BlobServiceClient(blobUriBuilder.ToUri());

            var client6 = new BlobChangeFeedClient(new Uri($"https://{env}/"));
            
            var client7 = new DataLakeDirectoryClient(new Uri($"https://{env}/")); // TODO MaD
            
            DataLakeUriBuilder dataLakeUriBuilder = new DataLakeUriBuilder(new Uri($"https://{region}/"));
            var client8 = new DataLakeDirectoryClient(dataLakeUriBuilder.ToUri()); // TODO MaD
            var client9 = new DataLakeDirectoryClient(dataLakeUriBuilder.ToString(), dataLakeUriBuilder.FileSystemName, dataLakeUriBuilder.DirectoryOrFilePath); // TODO MaD
            
            var client10 = new ShareClient($"https://{env}/", region); // TODO MaD
            
            ShareUriBuilder shareUriBuilder = new ShareUriBuilder(new Uri($"https://{region}/"));
            var client11 = new  ShareFileClient(shareUriBuilder.ToUri()); // TODO MaD
            var client12 = new  ShareFileClient(shareUriBuilder.ToString(), shareUriBuilder.ShareName, shareUriBuilder.DirectoryOrFilePath); // TODO MaD
            
            var client13 = new QueueClient($"https://{env}/", region);
            
            QueueUriBuilder queueUriBuilder = new QueueUriBuilder(new Uri($"https://{region}/"));
            var client14 = new QueueClient(queueUriBuilder.ToUri());
            var client15 = new QueueClient(queueUriBuilder.ToString(), queueUriBuilder.QueueName);
            
            // deprecated client in Microsoft.Azure.Storage
            var client16 = new CloudStorageAccount(new Microsoft.Azure.Storage.Auth.StorageCredentials(), region, env, true); // TODO MaD
            
            // deprecated client in Microsoft.Azure.Storage.Blobs
            var client17 = new CloudBlobClient(new Uri($"https://{env}/")); // TODO MaD

            // deprecated client in Microsoft.Azure.Storage.Blobs
            StorageUri storageUri = new StorageUri(new Uri($"https://{region}/"), new Uri($"https://{env}/"));
            var client18 = new CloudBlobClient(storageUri, new Microsoft.Azure.Storage.Auth.StorageCredentials()); // TODO MaD
            
            UriQueryBuilder uriQueryBuilder = new UriQueryBuilder();
            uriQueryBuilder.Add("a", region); // Setting Uri query should not be flagged
            var uri = new Uri($"https://{env}/");
            var uri2 = uriQueryBuilder.AddToUri(uri);
            var client19 = new CloudAppendBlob(uri2); // TODO MaD
        }

        ///////////////////////////
        // out of scope for SSRF query, may be a path injection bug, but we will need to handle separately to avoid FPs
        public void AzureBlobContainerGood(string region = "", string env = "")
        {
            var client = new BlobContainerClient(new Uri($"https://something/{env}/"));
        }
 
        public void AzureBlobNameValidatorGood(string region = "", string env = "")
        {
            try
            {
                NameValidator.ValidateContainerName(region);
                NameValidator.ValidateBlobName(env);
            }
            catch(FormatException e)
            {
                throw new Exception("The ContainerName or BlobName is invalid format.");
            }

            var client = new BlobClient("https://something", region, env);
        }
    }
}