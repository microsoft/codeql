using System.Globalization;
using System.Runtime.CompilerServices;
using System.Text;

namespace Xpp.Extraction;

/// <summary>
/// Writes TRAP tuples to a <see cref="TextWriter"/>.
/// </summary>
public sealed class TrapFile(TextWriter writer) : ITrapFile
{
    // Reference equality: two distinct AST nodes are distinct entities even if they compare
    // equal, and the compiler's AST nodes do not override Equals anyway.
    private readonly Dictionary<object, Label> labels = new(ReferenceEqualityComparer.Instance);

    private int next;

    public Label FreshLabel()
    {
        var label = new Label(++next);
        writer.Write(label);
        writer.WriteLine("=*");
        return label;
    }

    public Label Label(object node)
    {
        if (labels.TryGetValue(node, out var existing))
            return existing;

        var label = FreshLabel();
        labels[node] = label;
        return label;
    }

    public void Tuple(string relation, params object[] arguments)
    {
        var line = new StringBuilder(relation.Length + 16 * arguments.Length);
        line.Append(relation).Append('(');
        for (var i = 0; i < arguments.Length; i++)
        {
            if (i > 0)
                line.Append(',');
            Append(line, arguments[i]);
        }

        line.Append(')');
        writer.WriteLine(line.ToString());
    }

    private static void Append(StringBuilder line, object argument)
    {
        switch (argument)
        {
            case Label label:
                line.Append(label);
                break;
            case string text:
                line.Append('"').Append(text.Replace("\"", "\"\"")).Append('"');
                break;
            case bool flag:
                line.Append(flag ? '1' : '0');
                break;
            default:
                line.Append(Convert.ToString(argument, CultureInfo.InvariantCulture));
                break;
        }
    }
}
