namespace Xpp.Extraction;

/// <summary>
/// Sink for TRAP tuples. The generated <c>AstTrapEmitter</c> writes through this interface, so
/// tests can capture tuples without touching the filesystem.
/// </summary>
public interface ITrapFile
{
    /// <summary>Allocates a label with no stable identity of its own.</summary>
    Label FreshLabel();

    /// <summary>
    /// The label for an AST node, allocated on first use so repeated references to the same node
    /// share one entity.
    /// </summary>
    Label Label(object node);

    /// <summary>
    /// Writes one tuple. Arguments may be <see cref="Label"/>, <see cref="string"/>,
    /// <see cref="int"/> or <see cref="long"/>.
    /// </summary>
    void Tuple(string relation, params object[] arguments);
}
