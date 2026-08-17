using System.Runtime.CompilerServices;
using System.Xml.Linq;
using Microsoft.Dynamics.AX.Framework.Xlnt.XppParser;
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

            EmitTree(trap, fileLabel, unit, ref nodes, ref unsupported);
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
    private static void EmitTree(
        ITrapFile trap, Label file, object root, ref int nodes, ref int unsupported)
    {
        var seen = new HashSet<object>(ReferenceEqualityComparer.Instance);
        var pending = new Stack<object>();
        pending.Push(root);

        while (pending.Count > 0)
        {
            var node = pending.Pop();
            if (!seen.Add(node))
                continue;

            nodes++;
            var id = trap.Label(node);
            if (!AstTrapEmitter.Emit(trap, id, node))
                unsupported++;

            EmitLocation(trap, file, id, node);

            foreach (var child in Children(node))
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
        if (node is not Ast ast)
            return;

        var position = ast.Position;

        // Nodes the parser synthesises carry no extent; recording a zero span would put alerts
        // at the top of the file.
        if (position.StartLine <= 0)
            return;

        var location = trap.FreshLabel();
        trap.Tuple(
            "locations", location, file,
            position.StartLine, position.StartCol, position.EndLine, position.EndCol);
        trap.Tuple("locatable_locations", id, location);
    }

    /// <summary>The AST nodes directly reachable from <paramref name="node"/>.</summary>
    private static IEnumerable<object> Children(object node)
    {
        foreach (var property in node.GetType().GetProperties())
        {
            if (property.Name is "Parent" or "ParentAst")
                continue;

            object? value;
            try
            {
                value = property.GetValue(node);
            }
            catch
            {
                continue;
            }

            foreach (var child in Reachable(value))
                yield return child;
        }
    }

    /// <summary>
    /// The AST nodes held by a property value.
    /// </summary>
    /// <remarks>
    /// The compiler groups some children in CLR tuples, such as a `catch` with its handler body
    /// or a switch case with its statements, so tuple slots have to be looked through or those
    /// subtrees are never visited.
    /// </remarks>
    private static IEnumerable<object> Reachable(object? value)
    {
        switch (value)
        {
            case null:
            case string:
                yield break;

            case Ast child:
                yield return child;
                break;

            case ITuple tuple:
                for (var i = 0; i < tuple.Length; i++)
                {
                    foreach (var nested in Reachable(tuple[i]))
                        yield return nested;
                }

                break;

            case System.Collections.IEnumerable:
                // AstSequence reduces dictionary entries to their values; iterating the raw
                // collection would yield KeyValuePair, which is neither an Ast nor a tuple and
                // would silently drop the subtree.
                foreach (var item in AstSequence.Elements(value))
                {
                    foreach (var nested in Reachable(item))
                        yield return nested;
                }

                break;
        }
    }
}
