import SsrfBaseFlow
import experimental.code.csharp.String_Concatenation.ConcatenateStringSantizer

/**
 * Holds for `HttpMethod` argument in `System.Net.Http.HttpRequestMessage` constructor
 */
private class RequestMessageConstructorBarrier extends Barrier {
  RequestMessageConstructorBarrier() {
    exists(ObjectCreation oc |
      oc.getType().hasFullyQualifiedName("System.Net.Http", "HttpRequestMessage")
    |
      oc.getArgumentForName("method") = this.asExpr()
      or
      // property assignment to `HttpRequestMessage.RequestUri` overrides the RequestUri from HttpRequestMessage constructor, would have its own alert
      exists(PropertyAccess pa, Assignment a |
        a.getLValue() = pa and
        pa.getTarget().hasFullyQualifiedName("System.Net.Http.HttpRequestMessage", "RequestUri") and
        DataFlow::localExprFlow(oc, pa.getQualifier()) and
        this.asExpr() = oc.getAnArgument()
      )
    )
  }
}

/**
 * Holds for parameter read or write of `WebRequest`, `HttpWebRequest`, and `HttpRequestMessage` other than
 * reading `RequestUri`, `Address`, `Content`, `CookieContainer`, `Headers`, `Host`, `Referer`, and `ServicePoint`
 * writing `RequestUri`, `Address`, `Host`, `ServicePoint`
 * For example:
 * `request.Content = body;` will hold
 * `request.RequestUri` will not hold
 */
private class RequestMessagePropertyBarrier extends Barrier {
  RequestMessagePropertyBarrier() {
    // Read access other than these properties are out of scope for the SSRF queries
    exists(Property p, string s |
      p = this.asExpr().(PropertyAccess).getTarget() and
      (
        p.hasFullyQualifiedName("System.Net.WebRequest", s) or
        p.hasFullyQualifiedName("System.Net.HttpWebRequest", s) or
        p.hasFullyQualifiedName("System.Net.Http.HttpRequestMessage", s)
      ) and
      not s in [
          "Address", "Content", "CookieContainer", "Headers", "Host", "Referer", "RequestUri",
          "ServicePoint"
        ]
    )
    or
    // Assignment to properties other than these are out of scope for the SSRF queries
    exists(PropertyAccess pa, Property p, AssignExpr ae, string s |
      p = pa.getTarget() and
      (
        p.hasFullyQualifiedName("System.Net.WebRequest", s) or
        p.hasFullyQualifiedName("System.Net.HttpWebRequest", s) or
        p.hasFullyQualifiedName("System.Net.Http.HttpRequestMessage", s)
      ) and
      ae.getLValue() = pa and
      ae.getRValue() = this.asExpr() and
      not s in ["Address", "Host", "RequestUri", "ServicePoint"]
    )
  }
}

/**
 * Holds for `path` or `extraValue` arguments in `System.UriBuilder` constructor
 * `extraValue` can be either a fragement `#a` or a query `?a=b`
 *
 * Holds for `System.UriBuilder` constructor when `System.UriBuilder.Host` property is set
 */
private class UriBuilderConstructorBarrier extends Barrier {
  UriBuilderConstructorBarrier() {
    exists(ObjectCreation oc | oc.getType().hasFullyQualifiedName("System", "UriBuilder") |
      oc.getArgumentForName("path") = this.asExpr()
      or
      oc.getArgumentForName("extraValue") = this.asExpr()
      or
      // property assignment to `UriBuilder.Host` overrides the host from UriBuilder constructor, would have its own alert
      exists(PropertyAccess pa, Assignment a |
        a.getLValue() = pa and
        pa.getTarget().hasFullyQualifiedName("System.UriBuilder", "Host") and
        DataFlow::localExprFlow(oc, pa.getQualifier()) and
        this.asExpr() = oc.getAnArgument()
      )
    )
  }
}

/**
 * Holds for parameter read or write of `System.UriBuilder` other than
 * `Host` and `Uri`
 * For example:
 * `uriBuilder.Path = node;` will hold
 * `string url2 = $"https://something.com/{uriBuilder.Path}"` will hold
 * `uriBuilder.Host = node;` will not hold
 * `string url2 = $"https://{uriBuilder.Host}"` will not hold
 */
private class UriBuilderPropertyBarrier extends Barrier {
  UriBuilderPropertyBarrier() {
    // Read access to these properties are out of scope for the SSRF queries
    exists(Property p, string qname, string s |
      p = this.asExpr().(PropertyAccess).getTarget() and
      p.hasFullyQualifiedName(qname, s) and
      qname =
        [
          "Azure.Data.Tables.TableUriBuilder", "Azure.Storage.Blobs.BlobUriBuilder",
          "Azure.Storage.Files.DataLake.DataLakeUriBuilder",
          "Azure.Storage.Files.Shares.ShareUriBuilder", "Azure.Storage.Queues.QueueUriBuilder",
          "System.UriBuilder"
        ] and
      s = ["Fragment", "MessageId", "Password", "Sas", "Snapshot", "UserName", "VersionId"] // TODO add path, query?
    )
    or
    // Assignment to properties other than these are out of scope for the SSRF queries
    exists(PropertyAccess pa, Property p, AssignExpr ae, string qname, string s |
      p = pa.getTarget() and
      p.hasFullyQualifiedName(qname, s) and
      ae.getLValue() = pa and
      ae.getRValue() = this.asExpr() and
      qname =
        [
          "Azure.Core.RequestUriBuilder", "Azure.Data.Tables.TableUriBuilder",
          "Azure.Storage.Blobs.BlobUriBuilder", "Azure.Storage.Files.DataLake.DataLakeUriBuilder",
          "Azure.Storage.Files.Shares.ShareUriBuilder", "Azure.Storage.Queues.QueueUriBuilder",
          "System.UriBuilder"
        ] and
      not s =
        [
          "AccountName", "BlobName", "BlobContainerName", "FileSystemName", "Host", "QueueName",
          "ShareName", "Tablename", "Uri"
        ]
    )
  }
}

/**
 * Holds for adding queries to `Microsoft.Azure.Storage.Core.UriQueryBuilder`
 * For example:
 * `uriQueryBuilder.Add("myKey", "myValue");` will hold
 * `var myUri = uriQueryBuilder.AddToUri(myUri);` will not hold
 */
private class UriQueryBuilderBarrier extends Barrier {
  UriQueryBuilderBarrier() {
    // Read access to these properties are out of scope for the SSRF queries
    exists(MethodCall c, string s |
      c.getTarget().hasFullyQualifiedName("Microsoft.Azure.Storage.Core.UriQueryBuilder", s) and
      s = ["Add", "AddRange"] and
      this.asExpr() = c.getAnArgument()
    )
  }
}

/**
 * Holds for parameter read or write of `System.Uri` other than
 * `AbsoluteUri`, `Authority`, `DnsSafeHost`, `Host`, `IdnHost`, `LocalPath`, and `OriginalString`
 * For example:
 * `Uri uri = new Uri(myUri.PathAndQuery, UriKind.Relative);` will hold
 * `Uri uri = new Uri(myUri.Host);` will not hold
 */
private class UriPropertyBarrier extends Barrier {
  UriPropertyBarrier() {
    // Read access other than these properties are out of scope for the SSRF queries
    exists(Property p, string s |
      p = this.asExpr().(PropertyAccess).getTarget() and
      p.hasFullyQualifiedName("System.Uri", s) and
      not s =
        [
          "AbsoluteUri", "Authority", "DnsSafeHost", "Host", "IdnHost", "LocalPath",
          "OriginalString"
        ]
    )
    // System.Uri does not have any properties that can be set
  }
}

/**
 * Holds when the untrusted input is not the host of a url argument to an API call
 */
private class PathAndQueryBarrier extends Barrier {
  PathAndQueryBarrier() {
    // NOTE: There may be other type of path injection issues, but the attacker does not control the server on the URL
    this.(StringCreationSanitizerSSRF).stringContainsSanitizer()
  }
}

/**
 * Holds if the node is being used for string construction in a way that it is used after a "/" character,
 * but not "//", or after "?<parameter>=, or after "#". For example:
 * `https://{something}/{node}` will hold
 * `"https://something/" + "node"` will hold
 * `https://something?a={node}` will hold
 * `https://something#{node}` will hold
 * `stringBuilder.Append("https://something/").Append(node)` will hold
 * `string.Format("https://something/{0}", node)` will hold
 * `string.Join("/", new String[]{ "https://something", node })` will hold
 * `https://{node}` will not hold
 * `"https://" + node` will not hold
 * `stringBuilder.Append("https://").Append(node)` will not hold
 * `string.Format("https://{0}", node)` will not hold
 * `string.Join(null, new String[]{ "https://", node })` will not hold
 *
 * Holds when the node is an argument of a constructor or method from `String` or `StringBuilder`
 * that flows to a `Uri` or `UriBuilder` that flows to `RequestForgerySink`, or when the node is a
 * child of `RequestForgerySink`. For example:
 *   `var url = $"https://something/{node}/"; Uri uri = new Uri(url); (new HttpClient()).GetAsync(uri);` will hold
 *   `(new HttpClient()).GetAsync(new Uri($"https://something/{node}/"))` will hold
 *   `logger.Info($"something/{node}")` will not hold
 */
private class StringCreationSanitizerSSRF extends StringCreationSanitizer {
  override predicate stringContainsSanitizer() {
    super.stringContainsSanitizer() and
    exists(string s | s = this.getPredecessorString() and s.length() > 0 |
      // We will ignore the SSRF case if the injectable portion is part of the path, query, or fragment
      // matches '/' in 'something/' but not in server address 'https://something'
      s.matches("%/%") and not s.matches("%://%")
      or
      // matches 'https://something/'
      s.matches("%://%/%")
      or
      s.regexpMatch(".*[?#&=()].*")
    )
  }
}
