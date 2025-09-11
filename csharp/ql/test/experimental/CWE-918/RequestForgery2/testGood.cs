using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Globalization;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;

namespace Test
{  
    public class GoodController : Controller
    {
        private ILogger logger;
        private const string _urlTemplate = "api/{0}";
        private const string _formatString = _urlTemplate + "/v2";

        ///////////////////////////
        // out of scope for SSRF query, may be a path injection bug, but we will need to handle separately to avoid FPs

        // Concatentation via InterpolatedString
        public void IpsPathEndsInSlash(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"https://something/{env}/"));
        }

        public void IpsPathDoesNotEndInSlash(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"https://something/something-{env}"));
        }

        public void IpsPathInAnyChild(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"https://something/{region}-{env}"));
        }

        public void IpsQuery(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"https://something?q={env}"));
        }

        public void IpsQuery2(string region = "", string env = "")
        {
            const string host = "https://something?q=a";
            (new HttpClient()).GetAsync(new Uri($"{host}&{env}=b"));
        }

        public void IpsEquals(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"something={env}"));
        }

        public void IpsFragment(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"https://something#{env}"));
        }

        public void IpsParenthesis(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"https://something.com/a({env})"));
        }
       
        public void IpsNonLocalVariable(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri($"{AppConstants.BaseUrl}{env}"));
        }

        // Concatentation via AddExpr
        public void AddPathEndsInSlash(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri(@"https://something/" + env));
        }

        public void AddPathDoesNotEndInSlash(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri(@"https://something/something-" + env));
        }

        public void AddPathInAnyChild(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri(@"https://something/" + region + "-" + env));
        }

        public void AddQuery(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri(@"something?q=" + env));
        }

        // Concatentation via InterpolatedString and AddExpr
        public void IpsAndAdd1(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri(@"https://something/" + $"{region}-{env}"));
        }

        public void IpsAndAdd2(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri(@"https://something" + $"/{region}/" + env) );
        }

        public void IpsAndAdd3(string region = "", string env = "")
        {
            const string host = "something";
            (new HttpClient()).GetAsync(new Uri($"https://{host}/" + env));
        }

        public void IpsAndAdd4(string region = "", string env = "")
        {
            const string host = "something";
            (new HttpClient()).GetAsync(new Uri($"https://" + $"{host}/" + $"{region}/{env}"));
        }

        // Local constant is not a remote source
        public void LocalConstant(string region = "", string env = "")
        {
            const string host = "https://something/";
            (new HttpClient()).GetAsync(new Uri($"{host}{env}"));
        }

        // Concatentation via String Builder
        public void StringBuilderAppend1(string region = "", string env = "")
        {
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.Append("https://something/");
            stringBuilder.Append(env);
            (new HttpClient()).GetAsync(new Uri(stringBuilder.ToString()));
        }

        public void StringBuilderAppend2(string region = "", string env = "")
        {
            StringBuilder stringBuilder = new StringBuilder("https://something/");
            stringBuilder.Append(env);
            (new HttpClient()).GetAsync(new Uri(stringBuilder.ToString()));
        }

        public void StringBuilderAppend3(string region = "", string env = "")
        {
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.Append("https://something/").Append(env).Append(region);
            (new HttpClient()).GetAsync(new Uri(stringBuilder.ToString()));
        }

        // Concatentation via String.Concat
        public void StringConcatenate(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new Uri(string.Concat("https://something/", region, "&q=", env)));
        }

        public void FalseNegativeFix(string region = "", string env = "")
        {
            var unused = $"https://something/{region}/"; // region should not be listed as sanitized
            Uri uri = NonLocal.GetUri(env);
            
            (new HttpClient()).GetAsync(uri);
        }

        public void ExtendedClass(string region = "", string env = "")
        {
            Uri uri = new Uri("https://something/");
            MyUri myUri = new MyUri(uri);
            
            (new HttpClient()).GetAsync((Uri)myUri);
        }

        // Concatentation via String.Format
        public void StringFormat(string region = "", string env = "")
        {
            const string host = "something";
            (new HttpClient()).GetAsync(new Uri(string.Format(CultureInfo.InvariantCulture, "https://{0}/{1}/{2}", host, region, env)));
        }

        public void StringFormat2(string region = "", string env = "")
        {
            const string host = "something";
            const string one = "something";
            const string two = "something";
            (new HttpClient()).GetAsync(new Uri(string.Format("https://{0}.vault.azure.com{1}{2}_node/{3}", host, one, two, env)));
        }

        // Complex concatentation via String.Format
        public void StringFormat3(string region = "", string env = "")
        {
            string fixFormatFpEnv = env;
            string fixFormatFpRegion = region;
            string s = string.Format(_formatString, fixFormatFpEnv + fixFormatFpRegion);
            (new HttpClient()).GetAsync(s);
        }
        
        // String.Format arguments
        public void StringFormat4(string region = "")
        {
            string s = string.Format("{0}{1}{2}", "something", "/", region);
            (new HttpClient()).GetAsync(s);
        }
        
        // string.Format 
        public void StringFormat5(Guid guid)
        {
            string s = string.Format(@"something/{0}", guid);
            (new HttpClient()).GetAsync(s);
        }

        // Concatentation via StringBuilder.AppendFormat
        public void StringBuilderAppendFormat(string region = "", string env = "")
        {
            const string host = "something";
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.AppendFormat("https://{0}/{1}", host, env);

            (new HttpClient()).GetAsync(new Uri(stringBuilder.ToString()));
        }

        // Concatentation via String.Join
        public void StringJoin1(string region = "", string env = "")
        {
            var stringJoin = string.Join("/", new String[]{ "https://something/", region, env });
            (new HttpClient()).GetAsync(new Uri(stringJoin));
        }

        public void StringJoin2(string region = "", string env = "")
        {
            char c = '/';
            var stringJoin = string.Join(c, new String[]{ "https://something/", region, env });
            (new HttpClient()).GetAsync(new Uri(stringJoin));
        }

        public void StringJoin3(string region = "", string env = "")
        {
            String[] stringArray = { "https://something/", region, "&q=", env };
            var stringJoin = string.Join("", stringArray);
            (new HttpClient()).GetAsync(new Uri(stringJoin));
        }

        // Concatentation via UriBuilder
        public void UriBuilder(string region = "", string env = "")
        {
            (new HttpClient()).GetAsync(new UriBuilder("https", "something", 443, region, env).Uri);
        }

        public void UriBuilderPathAndQuery(string region = "", string env = "")
        {
            var uriBuilder = new UriBuilder
            {
                Scheme = "https",
                Host = "something",
                Port = 443,
                Path = region, // Path not a relevant sink for the SSRF queries
                Query = env, // Query not a relevant sink for the SSRF queries
            };
            (new HttpClient()).GetAsync(uriBuilder.Uri);
        }
        
        public void UriBuilderPath(string region = "", string env = "")
        {
            var uriBuilder = new UriBuilder("https", region, 443, "something", env);
            
            // Path not a relevant sink for the SSRF queries
            (new HttpClient()).GetAsync(new Uri($"https://something/{uriBuilder.Path}"));
        }
        
        public void UriBuilderOverwrite(string region = "")
        {
            var uriBuilder = new UriBuilder(region);
            uriBuilder.Host = "something"; // Host from constructor overwritten
            
            (new HttpClient()).GetAsync(uriBuilder.Uri);
        }
        
        public void UriPathAndQuery(string region = "", string env = "")
        {
            var uriBuilder = new UriBuilder("https", region, 443, "something", env);
            
            // PathAndQuery not a relevant sink for the SSRF queries
            Uri uri = new Uri(uriBuilder.Uri.PathAndQuery, UriKind.Relative);
                        
            (new HttpClient()).GetAsync(uri);
        }

        public void RequestMessageContent(IRequest request)
        {
            string uri = "https://something.com/";

            var message = new HttpRequestMessage(HttpMethod.Get, uri);
            // RequestMessage content not a relavent sink for the SSRF queries
            message.Content = new StreamContent(request.InputStream); 

            (new HttpClient()).SendAsync(message);
        }
        
        public void RequestMessageMethod(HttpMethod method)
        {
            string uri = "https://something.com/";

            // Arguments other than Uri are not flagged
            var message = new HttpRequestMessage(method, uri);
            (new HttpClient()).SendAsync(message);
        }
        
        public void RequestMessageOverwriteLocal(string region)
        {
            var request = new HttpRequestMessage(HttpMethod.Get, region);
            request.RequestUri = new Uri("https://something.com/"); // Uri from constructor overritten
            (new HttpClient()).SendAsync(request);
        }
        
        public void CustomHttpClientOtherArgument(IPAddress target)
        {
            string uri = "https://something.com/";
            var request = new HttpRequestMessage(HttpMethod.Get, uri);
            // Arguments other than HttpRequestMessage are not flagged
            this.SendAsync("message", 443, request, target);
        }
        
        public void SendAsync(string message, int servicePort,
            HttpRequestMessage request, IPAddress target)
        {
            var s = message + servicePort + request.RequestUri.PathAndQuery + target.AddressFamily.ToString();
        }
        
        // untrusted input used to open file
        public void FileRead(string env)
        {
            // url is read from file, is not from remote source
            // this should be flagged for file path traversal, but is not SSRF
            string url = System.IO.File.ReadAllText($"{env}.txt");
            (new HttpClient()).GetAsync(new Uri(url));
        }
    }
    
    public class NonLocal
    {
        public static Uri GetUri(string env = "")
        {
            var uriString = $"https://something/{env}/";
            return new Uri(uriString);
        }
    }
    
    public class MyUri : Uri
    {
        public MyUri(Uri uri)
        : base(uri.AbsolutePath) { }
    }

    public interface IRequest : IDisposable
    {
        Stream InputStream { get; }
    }
    
    public class RequestWrapper : IRequest
    {
        private readonly Microsoft.AspNetCore.Http.HttpRequest request;

        internal RequestWrapper(Microsoft.AspNetCore.Http.HttpRequest request)
        {
            this.request = request;
        }
        
        public Stream InputStream => this.request.Body;
        
        public void Dispose()
        {
            // No disposal needed.
        }
    }
    
    public static class AppConstants
    {
        public const string BaseUrl = "https://something/";
    }
}
