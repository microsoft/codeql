using System.Collections;
using System.Reflection;
using Microsoft.Dynamics.AX.Framework.Xlnt.XppParser;

namespace Xpp.Extraction;

/// <summary>
/// An <see cref="IXppcMetadataProvider"/> that knows about nothing.
/// </summary>
/// <remarks>
/// Parsing method bodies needs no metadata at all, but a class or interface header does: the
/// parser looks up the base type named by `extends`. Supplying an empty provider lets the header
/// parse and leaves the base type unresolved, which is the right trade for an extractor that
/// records source structure rather than resolved types.
///
/// The interface has more than eighty members, nearly all of which would be an empty default, so
/// it is implemented with <see cref="DispatchProxy"/> rather than by hand.
/// </remarks>
public class NullMetadataProvider : DispatchProxy
{
    public static IXppcMetadataProvider Create() =>
        Create<IXppcMetadataProvider, NullMetadataProvider>()!;

    protected override object? Invoke(MethodInfo? targetMethod, object?[]? args)
    {
        var returnType = targetMethod?.ReturnType;
        if (returnType is null || returnType == typeof(void))
            return null;

        // Callers iterate returned sequences directly, so an empty one is safer than null.
        if (returnType != typeof(string) &&
            typeof(IEnumerable).IsAssignableFrom(returnType))
        {
            var element = returnType.IsGenericType
                ? returnType.GetGenericArguments().FirstOrDefault() ?? typeof(object)
                : typeof(object);

            if (returnType.IsAssignableFrom(element.MakeArrayType()))
                return Array.CreateInstance(element, 0);
        }

        return returnType.IsValueType ? Activator.CreateInstance(returnType) : null;
    }
}
