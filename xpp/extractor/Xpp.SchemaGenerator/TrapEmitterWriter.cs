using System.Text;
using System.Text.RegularExpressions;

namespace Xpp.SchemaGenerator;

/// <summary>
/// Emits the C# that writes TRAP tuples for a parsed X++ AST.
/// </summary>
/// <remarks>
/// The relation names are derived with <see cref="Inflection.Tableize"/> so they match what
/// <c>misc/codegen</c> put in the dbscheme. Every derived name is checked against the committed
/// dbscheme before anything is written, so a divergence fails the build rather than producing a
/// database that silently drops tuples.
/// </remarks>
public static partial class TrapEmitterWriter
{
    private const string AstNamespace = CompilerPackage.AstNamespace;

    [GeneratedRegex(@"^([a-z_][a-z0-9_]*)\(", RegexOptions.Multiline)]
    private static partial Regex TableDeclaration();

    /// <summary>Table names declared by the generated dbscheme.</summary>
    public static HashSet<string> ReadDbschemeTables(string dbschemePath)
    {
        var text = File.ReadAllText(dbschemePath);
        return TableDeclaration().Matches(text)
            .Select(m => m.Groups[1].Value)
            .ToHashSet(StringComparer.Ordinal);
    }

    private static string ClassTable(AstType type) => Inflection.Tableize(type.Name);

    private static string PropertyTable(AstType type, AstProperty property)
    {
        if (property.TableName is not null)
            return property.TableName;

        var qualified = $"{type.Name}_{property.SchemaName}";

        // Predicate tables hold no value column, and the generator names them with `underscore`
        // rather than `tableize`, so they are not pluralised.
        return property.Kind == PropertyKind.Boolean
            ? Inflection.Underscore(qualified)
            : Inflection.Tableize(qualified);
    }

    public static string Render(AstModel model, HashSet<string> dbschemeTables)
    {
        var byName = model.Types.ToDictionary(t => t.Name, StringComparer.Ordinal);
        var missing = new List<string>();

        void Require(string table)
        {
            if (!dbschemeTables.Contains(table))
                missing.Add(table);
        }

        // Only leaf classes get a binding table; everything else is a union in the dbscheme.
        var bases = model.Types.Select(t => t.BaseName).Where(n => n is not null)
            .ToHashSet(StringComparer.Ordinal)!;
        var leaves = model.Types.Where(t => !bases.Contains(t.Name)).ToList();

        var writer = new StringWriter();
        Header(writer);

        writer.WriteLine("internal static class AstTrapEmitter");
        writer.WriteLine("{");

        // Per-class emission of that class's own properties.
        foreach (var type in model.Types.OrderBy(t => t.Name, StringComparer.Ordinal))
        {
            if (type.Properties.Count == 0 || type.IsSynthetic)
                continue;

            writer.WriteLine();
            writer.WriteLine($"    private static void EmitOwn{type.Name}(ITrapFile trap, Label id, object node)");
            writer.WriteLine("    {");
            if (type.IsGeneric)
            {
                // An open generic class cannot be named, so bind its members late.
                writer.WriteLine("        dynamic n = node;");
            }
            else
            {
                writer.WriteLine($"        var n = ({AstNamespace}.{type.Name})node;");
            }

            foreach (var property in type.Properties)
            {
                var table = PropertyTable(type, property);
                Require(table);
                EmitProperty(writer, "        ", table, property, byName);
            }

            writer.WriteLine("    }");
        }

        // Synthetic tuple helpers.
        foreach (var type in model.Types.Where(t => t.IsSynthetic)
                     .OrderBy(t => t.Name, StringComparer.Ordinal))
        {
            var classTable = ClassTable(type);
            Require(classTable);

            writer.WriteLine();
            writer.WriteLine($"    private static Label Emit{type.Name}(ITrapFile trap, ITuple tuple)");
            writer.WriteLine("    {");
            writer.WriteLine("        var id = trap.FreshLabel();");
            writer.WriteLine($"        trap.Tuple(\"{classTable}\", id);");
            foreach (var property in type.Properties)
            {
                var table = PropertyTable(type, property);
                Require(table);
                EmitTupleField(writer, "        ", table, property, byName);
            }

            writer.WriteLine("        return id;");
            writer.WriteLine("    }");
        }

        EmitDispatch(writer, model, byName, leaves, Require);

        writer.WriteLine("}");

        if (missing.Count > 0)
        {
            throw new InvalidOperationException(
                "the following relations are not declared in the dbscheme, so the TRAP writer " +
                "and the dbscheme have diverged:" + Environment.NewLine +
                string.Join(Environment.NewLine, missing.Distinct().OrderBy(x => x).Select(m => "  " + m)));
        }

        return writer.ToString();
    }

    private static void EmitDispatch(
        StringWriter writer, AstModel model, Dictionary<string, AstType> byName,
        List<AstType> leaves, Action<string> require)
    {
        writer.WriteLine();
        writer.WriteLine("    /// <summary>");
        writer.WriteLine("    /// Writes every tuple describing <paramref name=\"node\"/>, returning false when the");
        writer.WriteLine("    /// node's type is not part of the generated schema.");
        writer.WriteLine("    /// </summary>");
        writer.WriteLine("    public static bool Emit(ITrapFile trap, Label id, object node)");
        writer.WriteLine("    {");
        writer.WriteLine("        // Dispatch on the exact runtime type: C# type patterns also match subclasses,");
        writer.WriteLine("        // which would bind a node to an ancestor's table.");
        writer.WriteLine("        switch (node.GetType().FullName)");
        writer.WriteLine("        {");

        foreach (var leaf in leaves.Where(l => !l.IsSynthetic && !l.IsGeneric)
                     .OrderBy(l => l.Name, StringComparer.Ordinal))
        {
            // A generated `...Internal` leaf stands in for its instantiable base class.
            var runtimeName = leaf.Name.EndsWith(AstModel.ConcreteBaseLeafSuffix, StringComparison.Ordinal) &&
                              byName.ContainsKey(leaf.Name[..^AstModel.ConcreteBaseLeafSuffix.Length])
                ? leaf.Name[..^AstModel.ConcreteBaseLeafSuffix.Length]
                : leaf.Name;

            var classTable = ClassTable(leaf);
            require(classTable);

            writer.WriteLine($"            case \"{AstNamespace}.{runtimeName}\":");
            writer.WriteLine($"                trap.Tuple(\"{classTable}\", id);");

            foreach (var ancestor in Ancestry(leaf, byName))
            {
                if (ancestor.Properties.Count > 0)
                    writer.WriteLine($"                EmitOwn{ancestor.Name}(trap, id, node);");
            }

            writer.WriteLine("                return true;");
        }

        writer.WriteLine("            default:");
        writer.WriteLine("                return false;");
        writer.WriteLine("        }");
        writer.WriteLine("    }");
    }

    /// <summary>The class itself and its ancestors, outermost first.</summary>
    private static List<AstType> Ancestry(AstType type, Dictionary<string, AstType> byName)
    {
        var chain = new List<AstType>();
        var current = type;
        var seen = new HashSet<string>(StringComparer.Ordinal);
        while (current is not null && seen.Add(current.Name))
        {
            chain.Add(current);
            current = current.BaseName is not null && byName.TryGetValue(current.BaseName, out var b)
                ? b
                : null;
        }

        chain.Reverse();
        return chain;
    }

    private static void EmitProperty(
        StringWriter writer, string indent, string table, AstProperty property,
        Dictionary<string, AstType> byName)
    {
        var access = $"n.{property.ClrName}";
        EmitValue(writer, indent, table, property, access, byName);
    }

    private static void EmitTupleField(
        StringWriter writer, string indent, string table, AstProperty property,
        Dictionary<string, AstType> byName)
    {
        // Synthetic properties are named Item1..ItemN after their tuple position.
        var position = int.Parse(property.ClrName["Item".Length..]) - 1;
        EmitValue(writer, indent, table, property, $"tuple[{position}]", byName);
    }

    private static void EmitValue(
        StringWriter writer, string indent, string table, AstProperty property, string access,
        Dictionary<string, AstType> byName)
    {
        switch (property.Kind)
        {
            case PropertyKind.Child when IsSynthetic(property, byName):
                writer.WriteLine($"{indent}if ({access} is ITuple t_{property.SchemaName})");
                writer.WriteLine($"{indent}    trap.Tuple(\"{table}\", id, Emit{property.TypeName}(trap, t_{property.SchemaName}));");
                break;

            case PropertyKind.Child:
                writer.WriteLine($"{indent}if ({access} is {{ }} c_{property.SchemaName})");
                writer.WriteLine($"{indent}    trap.Tuple(\"{table}\", id, trap.Label(c_{property.SchemaName}));");
                break;

            case PropertyKind.ChildList when IsSynthetic(property, byName):
                Loop(writer, indent, access, property,
                    $"trap.Tuple(\"{table}\", id, i, Emit{property.TypeName}(trap, (ITuple)item));",
                    "ITuple");
                break;

            case PropertyKind.ChildList:
                Loop(writer, indent, access, property,
                    $"trap.Tuple(\"{table}\", id, i, trap.Label(item));",
                    "object");
                break;

            case PropertyKind.String:
                writer.WriteLine($"{indent}if ({access} is string s_{property.SchemaName})");
                writer.WriteLine($"{indent}    trap.Tuple(\"{table}\", id, s_{property.SchemaName});");
                break;

            case PropertyKind.Boolean:
                // Covers `bool`, `bool?` and the boxed value of a tuple slot.
                writer.WriteLine($"{indent}if ({access} is true)");
                writer.WriteLine($"{indent}    trap.Tuple(\"{table}\", id);");
                break;

            case PropertyKind.Int:
                writer.WriteLine($"{indent}if ({access} is {{ }} v_{property.SchemaName})");
                writer.WriteLine($"{indent}    trap.Tuple(\"{table}\", id, System.Convert.ToInt64(v_{property.SchemaName}));");
                break;

            case PropertyKind.Enum:
                writer.WriteLine($"{indent}if ({access} is {{ }} e_{property.SchemaName})");
                writer.WriteLine($"{indent}    trap.Tuple(\"{table}\", id, e_{property.SchemaName}.ToString());");
                break;

            case PropertyKind.StringList:
                Loop(writer, indent, access, property,
                    $"trap.Tuple(\"{table}\", id, i, (string)item);", "string");
                break;

            case PropertyKind.IntList:
                Loop(writer, indent, access, property,
                    $"trap.Tuple(\"{table}\", id, i, System.Convert.ToInt64(item));", "object");
                break;

            case PropertyKind.EnumList:
                Loop(writer, indent, access, property,
                    $"trap.Tuple(\"{table}\", id, i, item.ToString());", "object");
                break;
        }
    }

    private static void Loop(
        StringWriter writer, string indent, string access, AstProperty property, string body,
        string _)
    {
        var seq = $"seq_{property.SchemaName}";
        // AstSequence flattens dictionary entries to their values; iterating the raw collection
        // would yield KeyValuePair and label the wrong thing.
        writer.WriteLine($"{indent}{{");
        writer.WriteLine($"{indent}    var i = 0;");
        writer.WriteLine($"{indent}    foreach (var item in AstSequence.Elements({access}))");
        writer.WriteLine($"{indent}    {{");
        writer.WriteLine($"{indent}        {body}");
        writer.WriteLine($"{indent}        i++;");
        writer.WriteLine($"{indent}    }}");
        writer.WriteLine($"{indent}}}");
    }

    private static bool IsSynthetic(AstProperty property, Dictionary<string, AstType> byName) =>
        property.TypeName is not null &&
        byName.TryGetValue(property.TypeName, out var t) &&
        t.IsSynthetic;

    private static void Header(StringWriter writer)
    {
        writer.WriteLine("// Generated by xpp/extractor/Xpp.SchemaGenerator, do not edit by hand.");
        writer.WriteLine("//");
        writer.WriteLine("// Relation names are validated against xpp/ql/lib/xpp.dbscheme at generation time.");
        writer.WriteLine("// Regenerate with `xpp/tools/generate-schema.sh`.");
        writer.WriteLine();
        writer.WriteLine("using System.Runtime.CompilerServices;");
        writer.WriteLine("using Xpp.Extraction;");
        writer.WriteLine();
        writer.WriteLine("namespace Xpp.Extraction.Generated;");
        writer.WriteLine();
    }
}
