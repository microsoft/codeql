using Azure.Core;
using Azure.Identity;
using Azure.Security.KeyVault.Keys;
using Azure.Security.KeyVault.Secrets;
using Azure.Storage.Blobs;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace TestKeyVault
{
    public class HomeController : Controller
    {
        public void Index(string region = "", string env = "")
        {
            // BAD: a request parameter is incorporated without validation into a Http request
            var client = new KeyClient(new Uri($"https://{env}/"), new AzureCliCredential());

            var client2 = new SecretClient(new Uri($"https://{env}/"), new AzureCliCredential());
            KeyVaultSecret kvSecret = client2.GetSecret("someString");
            
            // RequestUriBuilder via MemberInitializer
            var requestUriBuilder = new RequestUriBuilder
            {
                Scheme = "https",
                Host = env,
                Port = 443,
            };
            var client3 = new KeyClient(requestUriBuilder.ToUri(), new AzureCliCredential()); // TODO finish MaD for KeyClient
        }
        
        ////// Test examples for SsrfBarrierAzure.qll //////
        
        public void IsUriHostNode(string env = "")
        {
            Uri myUri = new Uri($"https://{env}/");
            String host = myUri.Host; // PropertyRead of "System.Uri.Host"
        }

        public void UriVariableHasBeenCheckedForUriSchemeHttps(string env = "")
        {
            Uri myUri = new Uri($"https://{env}/");
            
            if (myUri.Scheme == Uri.UriSchemeHttps) // Validate scheme is HTTPS TODO
            {
                Console.WriteLine("Uri scheme is https");
            }
        }

        public void UriVariableHostHasBeenUsedInASelectionStmt(string env = "")
        {
            Uri myUri = new Uri($"https://{env}/");
            List<string> hostList = new List<string> { ".something.com"};
            
            if (myUri.Host.EndsWith(hostList[0])) // Validate host ends with
            {
                Console.WriteLine("Uri host ends with .something.com");
            }
        }

        public void IsLiteralStartingWithDotAndNotInterpolated(string region = "", string env = "")
        {
            String a = ".something.com"; // Literal starting with dot, matches Uri pattern
            String b = "../something.com";
            String c = ".   something.com";
            String d = "node" + ".   ";
            String e = $"{env}{region}" + ".   something.com";
            Uri uri = new Uri("../something.com");
        }
        
        public void IsAkvDomainsNode(string env = "")
        {
            String a = ".something.com"; // Literal starting with dot
            Console.WriteLine(a);
            
            String s = "";
            s = new String(".something.com"); // literal is child of ObjectCreation
            
            Uri myUri = new Uri($"https://{env}/");
            if (myUri.Host.EndsWith(s)) // source is a VariableAccess of that object
            {
                Console.WriteLine("Uri host ends with .something.com"); 
            } 
        }
        
        public void ExistsTrueFlowsToEnableTenantDiscoveryProperty()
        {
            BlobClientOptions blobClientOptions = new BlobClientOptions();
            blobClientOptions.EnableTenantDiscovery = true; // EnableTenantDiscovery set to true
        }

        ///////////////////////////
        // out of scope for SSRF query, may be a path injection bug, but we will need to handle separately to avoid FPs

        public void AzureKeyClientGood(string region = "", string env = "")
        {
            var client = new KeyClient(new Uri($"https://something/{env}/"), new AzureCliCredential());
        }

        public void AzureSecretClientGood(string region = "", string env = "")
        {
            var client = new SecretClient(new Uri($"https://something/{env}/"), new AzureCliCredential());
            KeyVaultSecret kvSecret = client.GetSecret("someString");
        }
    }
}