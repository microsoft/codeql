using System.Collections.Specialized;

namespace System.Web
{
    public class UnvalidatedRequestValuesBase
    {
        public string RawUrl => null;
    }

    public class HttpRequestBase
    {
        public virtual UnvalidatedRequestValuesBase Unvalidated => null;
        public virtual System.Collections.Specialized.NameValueCollection QueryString => null;
        public virtual string RawUrl => null;

        public string this[string o] => null;
    }

    public class HttpResponseBase
    {
        public void Write(object obj) { }
        public virtual void AppendHeader(string name, string value) { }
        public virtual void Redirect(string url) { }
        public virtual void RedirectPermanent(string url) { }
        public virtual int StatusCode { get; set; }
        public virtual void AddHeader(string name, string value) { }
        public virtual void End() { }
        public virtual string RedirectLocation { get; set; }
        public virtual NameValueCollection Headers => null;

    }

    public class HttpContextBase
    {
        public virtual HttpRequestBase Request => null;
        public virtual HttpResponseBase Response => null;
    }

    public class HtmlString : IHtmlString
    {
        public HtmlString(string s)
        {
        }

        public string ToHtmlString() => null;
    }

    public class HttpServerUtility
    {
        public void Transfer(string path) { }
        public string UrlEncode(string s) => null;
        public string HtmlEncode(string s) => null;
    }

    public class HttpApplication : IHttpHandler
    {
        public HttpServerUtility Server { get; }

        public Routing.RouteTable RouteTable { get; }
    }
}

namespace System.Web.Mvc
{
    public class Controller
    {
        public ViewResult View() => null;
        public HttpRequestBase Request => null;
        public HttpResponseBase Response => null;
        protected internal virtual RedirectResult RedirectPermanent(string url) => null;
        protected internal RedirectToRouteResult RedirectToRoute(string routeName) => null;
        public UrlHelper Url { get; set; }
        protected internal virtual RedirectResult Redirect(string url) => null;
    }

    public class MvcHtmlString : HtmlString
    {
        public MvcHtmlString(string s) : base(s) { }
    }

    public class RoutePrefixAttribute : Attribute
    {
        public virtual string Prefix { get; private set; }
        public RoutePrefixAttribute(string prefix) { }
    }

    public sealed class RouteAttribute : Attribute
    {

        public RouteAttribute(string template) { }
    }

    public class RedirectToRouteResult : ActionResult { }
}


namespace System.Web.UI
{
    public class Control
    {
    }

    public class Page
    {
        public System.Security.Principal.IPrincipal User { get; }
        public System.Web.HttpRequest Request { get; }
        public HttpResponse Response => null;
    }

    interface IPostBackDataHandler
    {
    }

    interface IPostBackEventHandler
    {
    }

    interface ITextControl
    {
        string Text { get; set; }
    }

    interface IEditableTextControl : ITextControl
    {
    }
}

namespace System.Web.UI.WebControls
{
    public class WebControl : Control
    {
    }

    public class TextBox : WebControl, IPostBackDataHandler, IEditableTextControl, ITextControl
    {
        public string Text { get; set; }
    }

    public class Calendar : WebControl, IPostBackEventHandler
    {
        public string Caption { get; set; }
    }

    public class Table : WebControl, IPostBackEventHandler
    {
        public string Caption { get; set; }
    }

    public class Label : WebControl, ITextControl
    {
        public virtual string Text { get; set; }
    }
}


namespace System.Web
{
    public interface IHttpHandler
    {
    }

    public interface IServiceProvider
    {
    }

    public class UnvalidatedRequestValues
    {
        public NameValueCollection QueryString { get; }
    }

    public class HttpRequest
    {
        public NameValueCollection QueryString => null;
        public string ApplicationPath => null;
        public string MapPath(string s) => null;
        public string MapPath(string s, string t, bool b) => null;
        public UnvalidatedRequestValues Unvalidated { get; }
        public string RawUrl { get; set; }
        public HttpCookieCollection Cookies => null;
        public bool IsAuthenticated { get; set; }
    }

    public class HttpRequestWrapper : System.Web.HttpRequestBase
    {
        public HttpRequestWrapper(HttpRequest r) { }
    }

    public class HttpResponse
    {
        public void Write(object o) { }
        public void Write(string s) { }
        public void WriteFile(string s) { }
        public HttpCookieCollection Cookies => null;
        public void AddHeader(string name, string value) { }
        public void Redirect(string url) { }
        public void AppendHeader(string name, string value) { }
        public void End() { }
        public string RedirectLocation { get; set; }
        public int StatusCode { get; set; }
        public void RedirectPermanent(string url) { }
        public virtual NameValueCollection Headers { get; set; }


    }

    public class HttpContext : IServiceProvider
    {
        public HttpRequest Request => null;
        public HttpResponse Response => null;
        public SessionState.HttpSessionState Session => null;
        public HttpServerUtility Server => null;
        public static HttpContext Current => null;
    }

    public class HttpCookie
    {
        public HttpCookie(string name)
        {
        }

        public HttpCookie(string name, string value)
        {
        }

        public string Value { get; set; }
        public NameValueCollection Values => null;
        public string this[string s] { get => null; set { } }
        public bool Secure { get; set; }
        public bool HttpOnly { get; set; }
        public System.DateTime Expires { get; set; }
    }

    public abstract class HttpCookieCollection : System.Collections.Specialized.NameObjectCollectionBase
    {
        public HttpCookie this[int i] => null;
        public HttpCookie this[string i] => null;
    }
}

namespace System.Web.SessionState
{
    public class HttpSessionState
    {
        public object this[string name] { get => null; set { } }
        public void Abandon() { }
        public void Clear() { }
    }
}

namespace System.Web.Mvc
{
    public class ControllerContext
    {
    }

    public class ViewContext : ControllerContext
    {
    }

    public interface IViewDataContainer
    {
    }

    public class HtmlHelper
    {
        public HtmlHelper(ViewContext vc, IViewDataContainer dc)
        {
        }

        public IHtmlString Raw(object o) => null;
        public IHtmlString Raw(string s) => null;
    }

    public class ActionResult
    {
    }

    public class FilterAttribute : Attribute
    {
    }

    public class ActionMethodSelectorAttribute : Attribute
    {
    }

    public class HttpPostAttribute : ActionMethodSelectorAttribute
    {
    }

    public interface IAuthorizationFilter
    {
    }

    public class ValidateAntiForgeryTokenAttribute : FilterAttribute
    {
    }

    public class NonActionAttribute : ActionMethodSelectorAttribute
    {
    }

    public class AuthorizationContext : ControllerContext
    {
    }

    public class ControllerBase
    {
    }

    public class ViewResultBase : ActionResult
    {
    }

    public class ViewResult : ViewResultBase
    {
    }

    interface IFilterProvider
    {
    }

    public class GlobalFilterCollection : IFilterProvider
    {
        public void Add(object filter) { }
    }

    public static class GlobalFilters
    {
        public static GlobalFilterCollection Filters => null;
    }

    public class UrlHelper
    {
        public UrlHelper(Routing.RequestContext requestContext) { }
        public virtual bool IsLocalUrl(string url) => false;
    }

    public class RedirectResult : ActionResult
    {
        public bool Permanent { get; set; }
        public string Url => null;

        public RedirectResult(string url) : this(url, permanent: false) { }
        public RedirectResult(string url, bool permanent) { }
    }
}

namespace System.Web.Routing
{
    public class RequestContext
    {
    }

    public class Route
    {
    }

    public class RouteTable
    {
        public RouteCollection Routes { get; }
    }

    public class RouteCollection
    {
        public Route MapPageRoute(string routeName, string routeUrl, string physicalFile, bool checkPhysicalUrlAccess) { return null; }
    }
}

namespace System.Web.Security
{
    class MachineKey
    {
        public static byte[] Protect(byte[] userData, params string[] purposes) => null;
    }

    class Membership
    {
        public static bool ValidateUser(string username, string password) => false;
        public static MembershipUser CreateUser(string username, string password) => null;
    }

    class FormsAuthentication
    {
        public static bool Authenticate(string name, string password) => false;
    }

    public class MembershipUser
    {
        public MembershipUser() { }
        public MembershipUser(
            string providerName,
            string name,
            object providerUserKey,
            string email,
            string passwordQuestion,
            string comment,
            bool isApproved,
            bool isLockedOut,
            DateTime creationDate,
            DateTime lastLoginDate,
            DateTime lastActivityDate,
            DateTime lastPasswordChangedDate,
            DateTime lastLockoutDate
        )
        { }
        public virtual bool ChangePassword(string oldPassword, string newPassword) => false;
    }
}

namespace System.Web.Helpers
{
    public static class AntiForgery
    {
        public static void Validate() { }
    }
}

namespace System.Web.WebPages
{
    public static class RequestExtensions
    {
        public static bool IsUrlLocalToHost(this System.Web.HttpRequestBase request, string url) => throw null;
    }

}

namespace System.Web.Script.Serialization
{
    // Generated from `System.Web.Script.Serialization.JavaScriptSerializer` in `System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35`
    public class JavaScriptSerializer
    {
        public JavaScriptSerializer() => throw null;
        public JavaScriptSerializer(System.Web.Script.Serialization.JavaScriptTypeResolver resolver) => throw null;
        public object DeserializeObject(string input) => throw null;
        public T Deserialize<T>(string input) => throw null;
        public object Deserialize(string input, Type targetType) => throw null;
    }

    // Generated from `System.Web.Script.Serialization.JavaScriptTypeResolver` in `System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35`
    abstract public class JavaScriptTypeResolver
    {
    }

    // Generated from `System.Web.Script.Serialization.SimpleTypeResolver` in `System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35`
    public class SimpleTypeResolver : System.Web.Script.Serialization.JavaScriptTypeResolver
    {
        public SimpleTypeResolver() => throw null;
    }
}
