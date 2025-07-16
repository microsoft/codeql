using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Test
{
    
// These should not be flagged since no authorization header is set
    public class TestController : Controller
    {
        public void Index(string subdomain)
        {
            var webrequest = WebRequest.Create(new Uri($"http://{subdomain}.contoso.com/api/getdata"));

            var httpWebrequest = HttpWebRequest.Create(new Uri($"http://{subdomain}.contoso.com/api/getdata"));

            (new HttpClient()).GetAsync(new Uri($"http://{subdomain}.contoso.com/api/getdata"));
        }
    }

// NOTES: test cases where the authorization header is set using
// a simple key-value assignment expression where the key is a string with a
// case-insensitive text "Authorization".
//
// Example:
//
//   req.Headers["Authorization"] = token;
//   req.Headers["authorization"] = token;
//   req.Headers["aUtHoRiZaTiOn"] = token;

    public class Test1Controller : Controller
    {
        public async Task<string> DownloadDataFrom(string subdomain)
        {
            string result = string.Empty;
            var uri = new Uri($"http://{subdomain}.contoso.com/api/getdata");

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(uri);

            req.Method = "GET";
            req.ContentType = "application/json";
            req.Headers["Authorization"] = "Bearer FAKE_TOKEN";

            using (WebResponse res = req.GetResponse())
            {
                if (res != null)
                {
                    using (Stream stream = res.GetResponseStream())
                    {
                        using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
                        {
                            result = reader.ReadToEnd();
                        }
                    }
                }
            }

            return result;
        }
    }
    
// NOTES: test cases where the authorization header is set using
// the function call Headers.Add(key, value) where the key is a string with a
// case-insensitive text "Authorization".
//
// Example:
//
//   req.Headers.Add("Authorization", token);
//   req.Headers.Add("authorization", token);
//   req.Headers.Add("aUtHoRiZaTiOn", token);

    public class Test2Controller : Controller
    {
        public async Task<string> DownloadDataFrom(string subdomain)
        {
            string result = string.Empty;
            var uri = new Uri($"http://{subdomain}.contoso.com/api/getdata");

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(uri);

            req.Method = "GET";
            req.ContentType = "application/json";
            req.Headers.Add("Authorization", "Bearer FAKE_TOKEN");

            using (WebResponse res = req.GetResponse())
            {
                if (res != null)
                {
                    using (Stream stream = res.GetResponseStream())
                    {
                        using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
                        {
                            result = reader.ReadToEnd();
                        }
                    }
                }
            }

            return result;
        }
    }

// NOTES: test cases where the authorization header is set using
// the function call Headers.Add(key, value) where the key is a constant with
// a case-insensitive text "Authorization".
//
// Example:
//
//   req.Headers.Add(AuthorizationHeaderName, token);
//   req.Headers.Add(Constants.AuthHeaderName, token);

    public class Test3Controller : Controller
    {
        [HttpPost]
        [Route("testRoute")]
        public async Task<IActionResult> Create([FromBody] JObject requestObj)
        {
            string hostServerName = requestObj["hostServerName"].ToString();
            string apiVersion = requestObj["apiVersion"].ToString();
            string tenantId = requestObj["tenantId"].ToString();
            HttpWebRequest req = WebRequest.CreateHttp(
                string.Format(
                    "CultureInfo.CurrentCulture",
                    "https://{0}/{1}/something?api-version={2}",
                    hostServerName,
                    tenantId,
                    apiVersion)); // TODO fix

            req.Method = "GET";
            req.Accept = "application/json";
            req.Headers.Add(HttpRequestHeader.Authorization, "Bearer FAKE_TOKEN");
            req.AllowAutoRedirect = false;

            using (HttpWebResponse response = req.GetResponse() as HttpWebResponse)
            {
            }
            return StatusCode(201); // System.Net.HttpStatusCode.Created
        }
    }

// NOTES: test cases where the authorization header is set using
// a simple key-value assignment expression where the key is a constant with
// a case-insensitive text "Authorization".
//
// Example:
//
//   req.Headers[AuthorizationHeaderName] = token;
//   req.Headers[Constants.AuthHeaderName] = token;
//
// Not supported:
//
//   req.Headers[this.Config["AuthHeader"]] = token;

    public class Test4Controller : Controller
    {
        public async Task<string> DownloadDataFrom(string subdomain)
        {
            string result = string.Empty;
            var uri = new Uri($"http://{subdomain}.contoso.com/api/getdata");

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(uri);

            req.Method = "GET";
            req.ContentType = "application/json";
            req.Headers[Constants.AuthHeaderName] = "Bearer FAKE_TOKEN";

            using (WebResponse res = req.GetResponse())
            {
                if (res != null)
                {
                    using (Stream stream = res.GetResponseStream())
                    {
                        using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
                        {
                            result = reader.ReadToEnd();
                        }
                    }
                }
            }

            return result;
        }

        public static class Constants
        {
            public const string AuthHeaderName = "Authorization";
        }
    }

// NOTES: test cases where the authorization header is set using
// an explicit setter inherited from the headers collection. In this case, the
// name of the property must match "Authorization".
//
// Example:
//
//   req.Headers.Authorization = token;

    public class Test5Controller : Controller
    {
        // private static readonly HttpClient Client = new HttpClient();

        public async Task<string> DownloadDataFrom(string subdomain)
        {
            // TODO fix
            // var req = new HttpRequestMessage(HttpMethod.Get, "https://" + subdomain + ".contoso.com/api/getdata");
            // req.Headers.Authorization = new AuthenticationHeaderValue("Bearer", "FAKE_TOKEN");
            // return await Client.SendAsync(req);
            string result = string.Empty;
            var uri = new Uri($"http://{subdomain}.contoso.com/api/getdata");

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(uri);

            req.Method = "GET";
            req.ContentType = "application/json";
            req.Headers["Authorization"] = "Bearer FAKE_TOKEN";

            using (WebResponse res = req.GetResponse())
            {
                if (res != null)
                {
                    using (Stream stream = res.GetResponseStream())
                    {
                        using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
                        {
                            result = reader.ReadToEnd();
                        }
                    }
                }
            }

            return result;
        }
    }
}
