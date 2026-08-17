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

    /// <summary>The object's name, or null if the document is not a metadata object.</summary>
    public static string? ObjectName(XDocument document) =>
        document.Root?.Element("Name")?.Value;

    /// <summary>
    /// Every source block in the document, in file order.
    /// </summary>
    public static IEnumerable<XppSourceBlock> Blocks(string text, XDocument document)
    {
        var sourceCode = document.Root?.Element("SourceCode");
        if (sourceCode is null)
            yield break;

        var declaration = sourceCode.Element("Declaration")?.Value;
        if (!string.IsNullOrWhiteSpace(declaration))
            yield return new XppSourceBlock(null, declaration, LineOf(text, declaration));

        var methods = sourceCode.Element("Methods");
        if (methods is null)
            yield break;

        foreach (var method in methods.Elements("Method"))
        {
            var body = method.Element("Source")?.Value;
            if (string.IsNullOrWhiteSpace(body))
                continue;

            yield return new XppSourceBlock(
                method.Element("Name")?.Value, body, LineOf(text, body));
        }
    }

    /// <summary>
    /// The line on which <paramref name="fragment"/> starts within <paramref name="text"/>.
    /// </summary>
    /// <remarks>
    /// The fragments are CDATA payloads, so they appear verbatim in the file and can be located
    /// by substring search. Anything not found falls back to offset zero, which keeps positions
    /// fragment-relative rather than wrong in an unpredictable way.
    /// </remarks>
    private static int LineOf(string text, string fragment)
    {
        var index = text.IndexOf(fragment, StringComparison.Ordinal);
        if (index < 0)
            return 0;

        var line = 0;
        for (var i = 0; i < index; i++)
        {
            if (text[i] == '\n')
                line++;
        }

        return line;
    }
}
