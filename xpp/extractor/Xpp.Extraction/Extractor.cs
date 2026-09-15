using System.Runtime.CompilerServices;
using System.Xml.Linq;
using Microsoft.Dynamics.AX.Framework.Xlnt.XppParser;
using XppComment = Microsoft.Dynamics.AX.Framework.Xlnt.XppParser.Comment;
using Microsoft.Dynamics.AX.Metadata.XppCompiler;
using Xpp.Extraction.Generated;

namespace Xpp.Extraction;

/// <summary>Outcome of extracting a single metadata object.</summary>
public sealed record ExtractionResult(
    string Path,
    int Blocks,
    int Nodes,
    int Unsupported,
    IReadOnlyList<string> Errors);

/// <summary>
/// Parses the X++ in a metadata object and writes the resulting AST as TRAP.
/// </summary>
public sealed class Extractor
{
    /// <summary>
    /// Method bodies parse without metadata; class and interface headers need a provider in
    /// order to look up the type named by `extends`.
    /// </summary>
    private readonly IXppcMetadataProvider metadata = NullMetadataProvider.Create();

    public ExtractionResult Extract(string path, ITrapFile trap)
    {
        var text = File.ReadAllText(path);
        var errors = new List<string>();

        XDocument document;
        try
        {
            document = XppSourceFile.Parse(text);
        }
        catch (Exception e)
        {
            return new ExtractionResult(path, 0, 0, 0, [$"malformed XML: {e.Message}"]);
        }

        var name = XppSourceFile.ObjectName(document) ?? Path.GetFileNameWithoutExtension(path);
        var elementType = ElementType(path);

        var fileLabel = trap.FreshLabel();
        trap.Tuple("files", fileLabel, path);

        var blocks = 0;
        var nodes = 0;
        var unsupported = 0;

        // Shared across blocks so a node reachable from two of them is only emitted once.
        var seen = new HashSet<object>(ReferenceEqualityComparer.Instance);

        foreach (var block in XppSourceFile.Blocks(document))
        {
            blocks++;
            var context = new ParserContext(elementType, name);
            var diagnostics = new DiagnosticsHandler();
            var macros = new MacroLibrary();
            var lineOffset = block.LineOffset;

            Ast? unit;
            try
            {
                // The declaration block holds the class or interface header; everything else is
                // a method body.
                unit = block.Name is null
                    ? Pass1.ParseClassOrInterface(
                        context, block.Source, metadata, diagnostics, macros,
                        ref lineOffset, 0, [])
                    : Pass1.ParseMethod(
                        context, block.Source, metadata, diagnostics, macros, ref lineOffset, 0);
            }
            catch (Exception e)
            {
                errors.Add($"{name}.{block.Name ?? "<declaration>"}: {e.GetType().Name}: {e.Message}");
                continue;
            }

            if (unit is null)
                continue;

            EmitTree(trap, fileLabel, unit, seen, ref nodes, ref unsupported);
        }

        return new ExtractionResult(path, blocks, nodes, unsupported, errors);
    }

    /// <summary>
    /// The parser's name for the kind of object being parsed, derived from the metadata
    /// directory. The directories carry an `Ax` prefix that the parser does not accept.
    /// </summary>
    private static string ElementType(string path)
    {
        var directory = Path.GetFileName(Path.GetDirectoryName(path)) ?? "AxClass";
        return directory.StartsWith("Ax", StringComparison.Ordinal)
            ? directory["Ax".Length..]
            : directory;
    }

    /// <summary>Walks the AST, writing each node's tuples exactly once.</summary>
    /// <remarks>
    /// Children come back from the emitter rather than being re-read here. Some of the
    /// compiler's node properties are structs, which box to a fresh object on every read, so
    /// reading a property twice yields two objects and therefore two different labels: one for
    /// the reference and one for the definition, leaving both dangling.
    /// </remarks>
    private static void EmitTree(
        ITrapFile trap, Label file, object root, HashSet<object> seen,
        ref int nodes, ref int unsupported)
    {
        var pending = new Stack<object>();
        pending.Push(root);

        var children = new List<object>();

        while (pending.Count > 0)
        {
            var node = pending.Pop();
            if (!seen.Add(node))
                continue;

            nodes++;
            var id = trap.Label(node);
            children.Clear();

            // Comments are referenced by CompilationUnit but are not Ast nodes, so the
            // generated emitter does not know them.
            if (node is XppComment comment)
            {
                trap.Tuple("comments", id);
                if (comment.Text is { } text)
                    trap.Tuple("comment_texts", id, text);
            }
            else if (!AstTrapEmitter.Emit(trap, id, node, children))
            {
                unsupported++;
            }

            EmitLocation(trap, file, id, node);

            foreach (var child in children)
                pending.Push(child);
        }
    }

    /// <summary>
    /// Records where <paramref name="node"/> came from.
    /// </summary>
    /// <remarks>
    /// The parser was given the source block's line offset, so these positions are already
    /// relative to the containing file rather than to the extracted fragment.
    /// </remarks>
    private static void EmitLocation(ITrapFile trap, Label file, Label id, object node)
    {
        var position = node switch
        {
            Ast ast => ast.Position,
            XppComment comment => comment.Position,
            _ => null,
        };

        // Nodes the parser synthesises carry no extent, and TextPosition is a reference type so
        // it can also be absent outright. Recording a zero span would put alerts at line 1.
        if (position is null || position.StartLine <= 0)
            return;

        var location = trap.FreshLabel();
        trap.Tuple(
            "locations", location, file,
            position.StartLine, position.StartCol, position.EndLine, position.EndCol);
        trap.Tuple("locatable_locations", id, location);
    }
}
