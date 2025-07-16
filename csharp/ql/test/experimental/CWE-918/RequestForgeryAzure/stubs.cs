using Azure.Core;
using Azure.Data.AppConfiguration;
using Azure.MyNamespace;
using Azure.Security.KeyVault.Keys;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Storage;
using Microsoft.Extensions.Logging;
using System;

namespace Azure.Data.AppConfiguration
{
    public class ConfigurationClient 
    {
        public ConfigurationClient (Uri endpoint, TokenCredential credential) { }
    }
}

namespace Azure.Security.KeyVault.Keys
{
    public class KeyClient
    {
        public KeyClient(Uri vaultUri, TokenCredential credential) { }
    }
}

namespace Azure.MyNamespace
{
    public class MyClient 
    {
        public MyClient (Uri uri, TokenCredential credential) { }
        public MyClient (Uri uri, string something, TokenCredential credential) { }
        public MyClient (string connectionstring, MyClientOptions options) { }
        public MyClient (string connectionstring, string something, MyClientOptions options) { }
        
    }
    
    public class MyClientOptions
    {
        public MyClientOptions () { }
    }
}

namespace Microsoft.Azure.TestSink
{
    public class DocumentClientWrapper
    {
        public DocumentClientWrapper() {}
        public void CreateDocumentQuery<T>(Uri documentCollectionUri, string sqlExpression){ }
        public void CreateDocumentQuery<T>(Uri documentCollectionUri, SqlQuerySpec sqlQuerySpec){ }
    }
    
    public class SqlQuerySpec
    {
        private string _spec;
        public SqlQuerySpec(string spec) {
            _spec = spec;
        }
    }    
}
