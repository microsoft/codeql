using System.Collections;

namespace Xpp.Extraction;

/// <summary>
/// Flattens the collection shapes the X++ compiler uses for child nodes.
/// </summary>
public static class AstSequence
{
    /// <summary>
    /// The elements of <paramref name="value"/>, with dictionary entries reduced to their values.
    /// </summary>
    /// <remarks>
    /// The compiler holds some children in dictionaries keyed by name, such as a class's fields
    /// and methods. Iterating one as a bare <see cref="IEnumerable"/> yields
    /// <see cref="KeyValuePair{TKey,TValue}"/> rather than the child, so the entries have to be
    /// unwrapped or those subtrees are labelled wrongly and never traversed.
    /// </remarks>
    public static IEnumerable<object> Elements(object? value)
    {
        switch (value)
        {
            case null:
            case string:
                yield break;

            // Dictionary<,> and the compiler's LinkedDictionary<,> both implement the
            // non-generic interface, which exposes the values directly.
            case IDictionary dictionary:
                foreach (var item in dictionary.Values)
                {
                    if (item is not null)
                        yield return item;
                }

                yield break;

            case IEnumerable sequence:
                foreach (var item in sequence)
                {
                    var unwrapped = Unwrap(item);
                    if (unwrapped is not null)
                        yield return unwrapped;
                }

                yield break;
        }
    }

    /// <summary>
    /// The value of a key/value entry, or the item itself when it is not one.
    /// </summary>
    /// <remarks>
    /// A dictionary typed only as <c>IEnumerable&lt;KeyValuePair&lt;,&gt;&gt;</c> does not reach
    /// the <see cref="IDictionary"/> case above, so entries are also unwrapped here.
    /// </remarks>
    private static object? Unwrap(object? item)
    {
        if (item is null)
            return null;

        var type = item.GetType();
        if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(KeyValuePair<,>))
            return type.GetProperty("Value")?.GetValue(item);

        return item;
    }
}
