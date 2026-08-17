namespace Xpp.Extraction;

/// <summary>
/// A TRAP label: the identity of one entity within a single TRAP file.
/// </summary>
public readonly record struct Label(int Value)
{
    public override string ToString() => "#" + Value;
}
