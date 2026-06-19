using Microsoft.AspNetCore.Mvc;
using System;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace TestAsync
{
    public class MyClass
    {
        public string Id { get; set; }
        public MyClass() { }
    }
    
    public class AsyncController : Controller
    {
        public async Task<string> Index(string region = "", string env = "")
        {
            var uri = await this.UriHostString<object>(env, null).ConfigureAwait(false);
            return await this.Sink(uri).ConfigureAwait(false);
        }
        
        private async Task<string> UriHostString<T>(string s, T t) {
            var uriString = $"https://{s}/";
            return uriString;
        }

        private async Task<string> UriPathString<T>(string s, T t) {
            var uriString = $"https://something/{s}/";
            return uriString;
        }
        
        private async Task<string> UriQueryString<T>(MyClass env, T t) {
            var uriString = "https://something/api/" + "env?id=" + env.Id;
            return uriString;
        }

        private async Task<string> Sink(string s) {
            // BAD: a request parameter is incorporated without validation into a Http request
            var webrequest = WebRequest.Create(new Uri(s));

            return s;
        }

        ///////////////////////////
        // out of scope for SSRF query, may be a path injection bug, but we will need to handle separately to avoid FPs

        public async Task<string> PathSanitized(string env = "")
        {
            var uri = await this.UriPathString<object>(env, null).ConfigureAwait(false);
            return await this.Sink(uri).ConfigureAwait(false);
        }

        public async Task<string> QuerySanitized(string env = "")
        {
            MyClass myClass = new MyClass();
            myClass.Id = env;
            var uri = await this.UriQueryString<object>(myClass, null).ConfigureAwait(false);
            return await this.Sink(uri).ConfigureAwait(false);
        }        
    }
}