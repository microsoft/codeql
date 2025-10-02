using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.Services.WebApi;
using System;
using System.Globalization;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Test
{  
    public class BadController : Controller
    {
        private const string _urlTemplate = "https://{0}";
        private const string _formatString = _urlTemplate + "/{1}-v2";

        public void Index(string region = "", string env = "")
        {
            Console.Write($"something/{region}/{env}");

            // BAD: a request parameter is incorporated without validation into a Http request
            
            // Concatentation via InterpolatedString
            var webrequest = WebRequest.Create(new Uri($"https://{env}/"));

            var httpWebrequest = HttpWebRequest.Create(new Uri($"https://{env}/"));

            (new HttpClient()).GetAsync(new Uri($"https://{env}/"));

            (new HttpClient()).GetAsync(new Uri($"https://something-{env}/"));

            // Concatentation via AddExpr
            (new HttpClient()).GetAsync(new Uri(@"https://" + env));

            (new HttpClient()).GetAsync(new Uri(@"https://something-" + env));

            // Concatentation via String Builder
            StringBuilder stringBuilder1 = new StringBuilder("https://");
            stringBuilder1.Append(env);
            stringBuilder1.Append("/home/sites");
            (new HttpClient()).GetAsync(new Uri(stringBuilder1.ToString()));

            StringBuilder stringBuilder2 = new StringBuilder();
            stringBuilder2.Append("https://").Append(env).Append("/home/sites");
            (new HttpClient()).GetAsync(new Uri(stringBuilder2.ToString()));

            StringBuilder stringBuilder3 = new StringBuilder();
            stringBuilder3.Append("https://");
            stringBuilder3.Append(env);
            stringBuilder3.Append("/home/sites");
            (new HttpClient()).GetAsync(new Uri(stringBuilder3.ToString()));

            // Concatentation via String.Concat
            (new HttpClient()).GetAsync(new Uri(string.Concat("https://", env)));

            // Concatentation via String.Format
            (new HttpClient()).GetAsync(new Uri(string.Format("https://{0}/", env)));
            
            // Complex concatentation via String.Format
            string fixFormatFpEnv = env;
            string fixFormatFpRegion = region;
            string s = string.Format(CultureInfo.InvariantCulture, _formatString, fixFormatFpEnv, fixFormatFpRegion);
            (new HttpClient()).GetAsync(s);

            // Concatentation via StringBuilder.AppendFormat
            StringBuilder stringBuilder4 = new StringBuilder();
            stringBuilder4.AppendFormat("https://{0}/", env);
            (new HttpClient()).GetAsync(new Uri(stringBuilder4.ToString()));

            // Concatentation via String.Join
            var stringJoin = string.Join("", new String[]{"https://", env});
            (new HttpClient()).GetAsync(new Uri(stringJoin));

            // Uri variable
            var uri = new Uri($"https://{env}/");
            (new HttpClient()).GetAsync(uri);
            
            // Uri TryCreate
            Uri outUri;
            Uri.TryCreate($"https://{env}/", UriKind.Absolute, out outUri);
            var request = new HttpRequestMessage(HttpMethod.Get, outUri.AbsoluteUri);
            (new HttpClient()).SendAsync(request);

            // UriBuilder via string
            (new HttpClient()).GetAsync(new UriBuilder($"https://{env}/").Uri);

            // UriBuilder via Uri variable
            var uri2 = new Uri($"https://{env}/");
            (new HttpClient()).GetAsync(new UriBuilder(uri2).Uri);

            // UriBuilder via parameters
            (new HttpClient()).GetAsync(new UriBuilder("https", env).Uri);

            // UriBuilder via parameters, including port
            (new HttpClient()).GetAsync(new UriBuilder("https", env, 443).Uri);
            
            // UriBuilder via MemberInitializer
            var uriBuilder = new UriBuilder
            {
                Scheme = "https",
                Host = env,
                Port = 443,
            };
            (new HttpClient()).GetAsync(uriBuilder.Uri);
            
            // UriBuilder constructor overwritten
            var uriBuilder2 = new UriBuilder(region);
            uriBuilder2.Host = env; // Host should be flagged            
            (new HttpClient()).GetAsync(uriBuilder2.Uri);
            
            // RelativeUri parameter behaves in unexpected ways
            var absoluteUri = new Uri($"https://something.com/");
            var relativeUri = new Uri(env);
            var combinedUri = new Uri(absoluteUri, relativeUri); // Second arg is relative
            (new HttpClient()).GetAsync(combinedUri);

            (new HttpClient()).GetAsync(new Uri(absoluteUri, combinedUri)); // Second arg is absolute
            
            // Visual Studio Sink
            var client = new VssConnection(new Uri($"https://{env}/")); // TODO finish MaD for VssConnection

            // Custom HttpClient
            var uri3 = $"https://{env}/";
            var request2 = new HttpRequestMessage(HttpMethod.Get, uri3);
            var target = new IPAddress(new byte[] { 127, 0, 0, 1 });
            // HttpRequestMessage is flagged
            this.Send("message", 443, request2, target); // TODO add back sink for custom extension

            // HttpClient wrapper
            this.SendAsync(request2);

            // HttpRequestMessage property assignment
            var request3 = new HttpRequestMessage();
            request3.RequestUri = new Uri($"https://{env}/");
            (new HttpClient()).SendAsync(request3); // TODO add to query instead of local MaD
        }

        public void Send(string message, int servicePort,
            HttpRequestMessage request, IPAddress target)
        {
            var s = message + servicePort + request.RequestUri.PathAndQuery + target.AddressFamily.ToString();
        }
        
        public void SendAsync(HttpRequestMessage request)
        {
            (new HttpClient()).SendAsync(request); 
        }
    }
}
