using System.Xml;
using System.Xml.Linq;

namespace Xpp.Extraction;

/// <summary>One block of X++ source embedded in a metadata XML file.</summary>
/// <param name="Name">Method name, or null for a class declaration.</param>
/// <param name="Source">The X++ text.</param>
/// <param name="LineOffset">
/// Zero-based line at which <paramref name="Source"/> begins within the containing file, so the
/// parser can report positions relative to the file rather than the fragment.
/// </param>
public sealed record XppSourceBlock(string? Name, string Source, int LineOffset);

/// <summary>
/// Reads the X++ source embedded in a D365 F&amp;O metadata object.
/// </summary>
/// <remarks>
/// X++ is not stored as standalone files. Each object is an XML document — `AxClass/Foo.xml`,
/// `AxTable/Bar.xml` and so on — whose `SourceCode` element holds the declaration and each
/// method body in CDATA sections.
/// </remarks>
public static class XppSourceFile
{
    /// <summary>Metadata object directories that can contain X++ source.</summary>
    private static readonly string[] SourceBearingDirectories =
    [
        "AxClass", "AxTable", "AxForm", "AxQuery", "AxView", "AxMap", "AxDataEntityView",
        "AxTableExtension", "AxFormExtension", "AxClassExtension", "AxViewExtension",
    ];

    /// <summary>
    /// True if <paramref name="path"/> looks like an X++ metadata object rather than an
    /// unrelated XML file.
    /// </summary>
    public static bool IsCandidate(string path)
    {
        if (!path.EndsWith(".xml", StringComparison.OrdinalIgnoreCase))
            return false;

        var directory = Path.GetFileName(Path.GetDirectoryName(path));
        return directory is not null &&
               SourceBearingDirectories.Contains(directory, StringComparer.OrdinalIgnoreCase);
    }

    /// <summary>
    /// Parses <paramref name="text"/> keeping line information, which the source blocks need in
    /// order to report file-relative positions.
    /// </summary>
    public static XDocument Parse(string text) => XDocument.Parse(text, LoadOptions.SetLineInfo);

    /// <summary>The object's name, or null if the document is not a metadata object.</summary>
    public static string? ObjectName(XDocument document) =>
        document.Root?.Element("Name")?.Value;

    /// <summary>
    /// Every source block in the document, in file order.
    /// </summary>
    public static IEnumerable<XppSourceBlock> Blocks(XDocument document)
    {
        var sourceCode = document.Root?.Element("SourceCode");
        if (sourceCode is null)
            yield break;

        var declaration = sourceCode.Element("Declaration");
        if (declaration is not null && !string.IsNullOrWhiteSpace(declaration.Value))
            yield return new XppSourceBlock(null, declaration.Value, LineOffsetOf(declaration));

        var methods = sourceCode.Element("Methods");
        if (methods is null)
            yield break;

        foreach (var method in methods.Elements("Method"))
        {
            var source = method.Element("Source");
            if (source is null || string.IsNullOrWhiteSpace(source.Value))
                continue;

            yield return new XppSourceBlock(
                method.Element("Name")?.Value, source.Value, LineOffsetOf(source));
        }
    }

    /// <summary>
    /// The line offset to give the parser for the CDATA payload of <paramref name="element"/>.
    /// </summary>
    /// <remarks>
    /// This comes from the XML line information rather than from searching the raw text for the
    /// payload. An XML parser normalises CRLF to LF inside element values, so on the
    /// Windows-authored files that F&amp;O produces the payload never matches the bytes on disk
    /// and a search-based offset silently collapses to zero.
    ///
    /// The element's reported line is where <c>&lt;Source&gt;&lt;![CDATA[</c> sits, and the
    /// payload begins immediately after, so the offset is one less than that line.
    /// </remarks>
    private static int LineOffsetOf(XElement element)
    {
        var info = (IXmlLineInfo)element;
        return info.HasLineInfo() ? Math.Max(0, info.LineNumber - 1) : 0;
    }
}
