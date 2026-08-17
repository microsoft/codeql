using System.Reflection;
using System.Text;

namespace Xpp.SchemaGenerator;

public enum PropertyKind
{
    /// <summary>A single owned AST child.</summary>
    Child,

    /// <summary>An ordered collection of owned AST children.</summary>
    ChildList,

    String,
    StringList,
    Boolean,
    Int,
    IntList,

    /// <summary>A CLR enum, recorded by member name.</summary>
    Enum,

    /// <summary>A collection of CLR enums, recorded by member name.</summary>
    EnumList,

    /// <summary>Deliberately not represented in the schema.</summary>
    Skipped,
}

public sealed record AstProperty(
    string ClrName,
    string SchemaName,
    PropertyKind Kind,
    string? TypeName,
    string? SkipReason)
{
    /// <summary>
    /// Explicit dbscheme table name, set when the derived name would clash with another
    /// declaration. See <see cref="AstModel.ResolveTableNameConflicts"/>.
    /// </summary>
    public string? TableName { get; init; }
}

public sealed record AstType(
    string Name,
    string? BaseName,
    bool IsAbstract,
    IReadOnlyList<AstProperty> Properties,
    bool IsSynthetic = false);

/// <summary>
/// The X++ AST hierarchy, reflected out of the compiler package and classified into the shape
/// <c>misc/codegen</c> consumes.
/// </summary>
public sealed class AstModel
{
    /// <summary>
    /// Back-references to the containing node. The schema models containment top-down, so these
    /// would introduce cycles.
    /// </summary>
    private static readonly HashSet<string> BackReferences = new(StringComparer.Ordinal)
    {
        "Parent",
        "ParentAst",
    };

    /// <summary>Base class for tuple-derived synthetic classes.</summary>
    public const string SyntheticBase = "XppTuple";

    private const string PositionType = "Microsoft.Dynamics.AX.Metadata.XppCompiler.TextPosition";

    /// <summary>
    /// Types that are not part of the <c>Ast</c> hierarchy but are still worth extracting. They
    /// are declared by hand in the schema prelude and referenced by the generated classes.
    /// </summary>
    private static readonly Dictionary<string, string> ExternalTypes = new(StringComparer.Ordinal)
    {
        ["Microsoft.Dynamics.AX.Framework.Xlnt.XppParser.Comment"] = "Comment",
    };

    public required IReadOnlyList<AstType> Types { get; init; }

    public required IReadOnlyList<string> Diagnostics { get; init; }

    public static AstModel Build(CompilerPackage package)
    {
        var astTypes = package.AstAssemblyTypes()
            .Where(CompilerPackage.IsAstType)
            .Where(t => t.FullName != CompilerPackage.AstRoot)
            .OrderBy(t => t.Name, StringComparer.Ordinal)
            .ToList();

        var known = astTypes.Select(TypeName).ToHashSet(StringComparer.Ordinal);
        known.Add("Ast");

        var context = new BuildContext(known);
        var result = new List<AstType>();

        foreach (var type in astTypes)
        {
            string? baseName = null;
            try
            {
                var baseType = type.BaseType;
                if (baseType is not null && CompilerPackage.IsAstType(baseType))
                    baseName = TypeName(baseType);
            }
            catch
            {
                // Unresolvable base; reported below.
            }

            if (baseName is null)
            {
                context.Diagnostics.Add($"{type.Name}: could not resolve an Ast base type, rooting at Ast");
                baseName = "Ast";
            }

            var properties = new List<AstProperty>();
            PropertyInfo[] declared;
            try
            {
                declared = type.GetProperties(
                    BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
            }
            catch (Exception e)
            {
                context.Diagnostics.Add($"{type.Name}: could not read properties ({e.GetType().Name})");
                declared = [];
            }

            foreach (var property in declared.OrderBy(p => p.Name, StringComparer.Ordinal))
            {
                var classified = context.Classify(type, property);
                if (classified.Kind != PropertyKind.Skipped)
                    properties.Add(classified);
            }

            result.Add(new AstType(TypeName(type), baseName, type.IsAbstract, properties));
        }

        result.AddRange(context.Synthetics.Values.OrderBy(t => t.Name, StringComparer.Ordinal));
        result = DropInheritedRedeclarations(result);
        result = DropUnreferencedSynthetics(result);
        result = DropRedundantPresenceFlags(result);
        result = ResolveTableNameConflicts(result);

        return new AstModel { Types = result, Diagnostics = context.Diagnostics };
    }

    /// <summary>Mutable state threaded through classification.</summary>
    private sealed class BuildContext(HashSet<string> known)
    {
        public List<string> Diagnostics { get; } = [];

        public Dictionary<string, AstType> Synthetics { get; } = new(StringComparer.Ordinal);

        public AstProperty Classify(Type owner, PropertyInfo property)
        {
            var schemaName = ToSnakeCase(property.Name);

            AstProperty Skip(string reason) =>
                new(property.Name, schemaName, PropertyKind.Skipped, null, reason);

            if (BackReferences.Contains(property.Name))
                return Skip("back-reference");

            Type propertyType;
            try
            {
                propertyType = property.PropertyType;
            }
            catch (Exception e)
            {
                Diagnostics.Add($"{owner.Name}.{property.Name}: unresolvable type ({e.GetType().Name})");
                return Skip("unresolvable type");
            }

            if (FullName(propertyType) == PositionType)
                return Skip("source extent, carried by locations");

            // Dictionaries of AST values: the key is always the value's own name, so only the
            // values are represented.
            var dictionaryValue = DictionaryValue(propertyType);
            if (dictionaryValue is not null)
            {
                if (IsKnownAst(dictionaryValue))
                    return new AstProperty(property.Name, schemaName, PropertyKind.ChildList, TypeName(dictionaryValue), null);

                Diagnostics.Add(
                    $"{owner.Name}.{property.Name}: dictionary of unsupported value type " +
                    $"'{FullName(dictionaryValue)}'");
                return Skip("unsupported dictionary value");
            }

            var element = CollectionElement(propertyType);
            if (element is not null)
                return ClassifyCollection(owner, property, schemaName, element);

            if (IsKnownAst(propertyType))
                return new AstProperty(property.Name, schemaName, PropertyKind.Child, TypeName(propertyType), null);

            if (ExternalTypes.TryGetValue(FullName(propertyType), out var external))
                return new AstProperty(property.Name, schemaName, PropertyKind.Child, external, null);

            if (IsTuple(propertyType))
            {
                var synthetic = SynthesizeTuple(owner, property, propertyType);
                return synthetic is null
                    ? Skip("unsupported tuple")
                    : new AstProperty(property.Name, schemaName, PropertyKind.Child, synthetic, null);
            }

            return ClassifyScalar(owner, property, schemaName, propertyType, Skip);
        }

        private AstProperty ClassifyCollection(
            Type owner, PropertyInfo property, string schemaName, Type element)
        {
            if (IsKnownAst(element))
                return new AstProperty(property.Name, schemaName, PropertyKind.ChildList, TypeName(element), null);

            if (ExternalTypes.TryGetValue(FullName(element), out var externalElement))
                return new AstProperty(property.Name, schemaName, PropertyKind.ChildList, externalElement, null);

            if (IsTuple(element))
            {
                var synthetic = SynthesizeTuple(owner, property, element);
                return synthetic is null
                    ? new AstProperty(property.Name, schemaName, PropertyKind.Skipped, null, "unsupported tuple")
                    : new AstProperty(property.Name, schemaName, PropertyKind.ChildList, synthetic, null);
            }

            if (FullName(element) == PositionType)
            {
                return new AstProperty(
                    property.Name, schemaName, PropertyKind.Skipped, null, "source extents");
            }

            if (IsEnum(element))
                return new AstProperty(property.Name, schemaName, PropertyKind.EnumList, TypeName(element), null);

            switch (FullName(element))
            {
                case "System.String":
                    return new AstProperty(property.Name, schemaName, PropertyKind.StringList, null, null);
                case "System.Int32":
                case "System.Int64":
                    return new AstProperty(property.Name, schemaName, PropertyKind.IntList, null, null);
            }

            Diagnostics.Add(
                $"{owner.Name}.{property.Name}: collection of unsupported element type " +
                $"'{FullName(element)}'");
            return new AstProperty(
                property.Name, schemaName, PropertyKind.Skipped, null, "unsupported collection element");
        }

        private AstProperty ClassifyScalar(
            Type owner, PropertyInfo property, string schemaName, Type propertyType,
            Func<string, AstProperty> skip)
        {
            if (IsEnum(propertyType))
                return new AstProperty(property.Name, schemaName, PropertyKind.Enum, TypeName(propertyType), null);

            var underlying = NullableUnderlying(propertyType) ?? propertyType;

            if (IsEnum(underlying))
                return new AstProperty(property.Name, schemaName, PropertyKind.Enum, TypeName(underlying), null);

            switch (FullName(underlying))
            {
                case "System.String":
                    return new AstProperty(property.Name, schemaName, PropertyKind.String, null, null);
                case "System.Boolean":
                    return new AstProperty(property.Name, schemaName, PropertyKind.Boolean, null, null);
                case "System.Int32":
                case "System.Int64":
                    return new AstProperty(property.Name, schemaName, PropertyKind.Int, null, null);
            }

            Diagnostics.Add($"{owner.Name}.{property.Name}: unsupported type '{FullName(propertyType)}'");
            return skip("unsupported type");
        }

        /// <summary>
        /// Creates (or reuses) a schema class standing in for a CLR tuple, since the schema has
        /// no tuple type. The name is derived from the declaring property so it is stable.
        /// </summary>
        private string? SynthesizeTuple(Type owner, PropertyInfo property, Type tuple)
        {
            Type[] arguments;
            try
            {
                arguments = tuple.GetGenericArguments();
            }
            catch
            {
                return null;
            }

            // The "Entry" suffix keeps the generated table name distinct from the one derived
            // from the declaring property itself.
            var name = TypeName(owner) + Singularize(property.Name) + "Entry";
            if (Synthetics.ContainsKey(name))
                return name;

            var used = new HashSet<string>(StringComparer.Ordinal);
            var fields = new List<AstProperty>();

            for (var i = 0; i < arguments.Length; i++)
            {
                var argument = arguments[i];
                var position = i + 1;

                var nested = CollectionElement(argument);
                if (nested is not null && IsKnownAst(nested))
                {
                    fields.Add(new AstProperty(
                        $"Item{position}", Unique(used, ToSnakeCase(TypeName(nested)) + "s"),
                        PropertyKind.ChildList, TypeName(nested), null));
                    continue;
                }

                if (IsKnownAst(argument))
                {
                    fields.Add(new AstProperty(
                        $"Item{position}", Unique(used, ToSnakeCase(TypeName(argument))),
                        PropertyKind.Child, TypeName(argument), null));
                    continue;
                }

                if (ExternalTypes.TryGetValue(FullName(argument), out var external))
                {
                    fields.Add(new AstProperty(
                        $"Item{position}", Unique(used, ToSnakeCase(external)),
                        PropertyKind.Child, external, null));
                    continue;
                }

                if (FullName(argument) == PositionType)
                    continue;

                var kind = FullName(argument) switch
                {
                    "System.String" => PropertyKind.String,
                    "System.Boolean" => PropertyKind.Boolean,
                    "System.Int32" or "System.Int64" => PropertyKind.Int,
                    _ => PropertyKind.Skipped,
                };

                if (kind == PropertyKind.Skipped)
                {
                    Diagnostics.Add(
                        $"{owner.Name}.{property.Name}: tuple element {position} has unsupported " +
                        $"type '{FullName(argument)}'");
                    return null;
                }

                fields.Add(new AstProperty(
                    $"Item{position}", Unique(used, $"item{position}"), kind, null, null));
            }

            Synthetics[name] = new AstType(name, SyntheticBase, false, fields, IsSynthetic: true);
            return name;
        }

        private static string Unique(HashSet<string> used, string candidate)
        {
            var name = candidate;
            var suffix = 2;
            while (!used.Add(name))
                name = $"{candidate}{suffix++}";
            return name;
        }

        private bool IsKnownAst(Type type)
        {
            try
            {
                return CompilerPackage.IsAstType(type) && known.Contains(TypeName(type));
            }
            catch
            {
                return false;
            }
        }
    }

    /// <summary>
    /// Gives an explicit dbscheme table name to properties whose derived name would clash with a
    /// class table.
    /// </summary>
    /// <remarks>
    /// The generator derives a property's table from <c>tableize("{Class}_{property}")</c> and a
    /// class's table from <c>tableize(Class)</c>. X++ has classes such as
    /// <c>QueryDataSourceHaving</c> alongside a <c>QueryDataSource.Having</c> property, which
    /// collide. Since <c>tableize</c> is <c>pluralize</c> composed with <c>underscore</c>, equal
    /// underscored forms imply equal table names, so comparing underscored forms is enough to
    /// detect the clash without reimplementing English pluralisation.
    /// </remarks>
    /// <summary>
    /// Drops <c>HasX</c> booleans that duplicate the <c>hasX()</c> predicate the QL generator
    /// already emits for an optional <c>X</c> property on the same class.
    /// </summary>
    /// <summary>
    /// Property names inherited from the hand-written prelude by every generated class.
    /// </summary>
    private static readonly string[] PreludeProperties = ["location", "is_unknown"];

    /// <summary>
    /// Removes properties that an ancestor already declares.
    /// </summary>
    /// <remarks>
    /// The X++ compiler's classes frequently re-declare an inherited property, either to narrow
    /// its type or simply as a `new` member. The schema models inheritance directly, so the
    /// ancestor's declaration is the one to keep; re-emitting it on the subclass produces a
    /// conflicting, non-overriding QL predicate.
    /// </remarks>
    private static List<AstType> DropInheritedRedeclarations(List<AstType> types)
    {
        var byName = types.ToDictionary(t => t.Name, StringComparer.Ordinal);

        HashSet<string> InheritedNames(AstType type)
        {
            var names = new HashSet<string>(PreludeProperties, StringComparer.Ordinal);
            var seen = new HashSet<string>(StringComparer.Ordinal) { type.Name };

            var baseName = type.BaseName;
            while (baseName is not null && byName.TryGetValue(baseName, out var ancestor))
            {
                if (!seen.Add(ancestor.Name))
                    break;

                foreach (var property in ancestor.Properties)
                    names.Add(property.SchemaName);

                baseName = ancestor.BaseName;
            }

            return names;
        }

        return types.Select(type =>
        {
            var inherited = InheritedNames(type);
            var properties = type.Properties
                .Where(p => !inherited.Contains(p.SchemaName))
                .ToList();

            return properties.Count == type.Properties.Count
                ? type
                : type with { Properties = properties };
        }).ToList();
    }

    /// <summary>
    /// Drops synthetic tuple classes left unreferenced, which happens when the property that
    /// introduced one turns out to be an inherited re-declaration.
    /// </summary>
    private static List<AstType> DropUnreferencedSynthetics(List<AstType> types)
    {
        var referenced = types
            .SelectMany(t => t.Properties)
            .Select(p => p.TypeName)
            .Where(n => n is not null)
            .ToHashSet(StringComparer.Ordinal)!;

        return types.Where(t => !t.IsSynthetic || referenced.Contains(t.Name)).ToList();
    }

    private static List<AstType> DropRedundantPresenceFlags(List<AstType> types)
    {
        return types.Select(type =>
        {
            var optionalNames = type.Properties
                .Where(p => p.Kind is PropertyKind.String or PropertyKind.Int or
                            PropertyKind.Enum or PropertyKind.Child)
                .Select(p => p.SchemaName)
                .ToHashSet(StringComparer.Ordinal);

            var properties = type.Properties.Where(p =>
            {
                if (p.Kind != PropertyKind.Boolean)
                    return true;
                if (!p.SchemaName.StartsWith("has_", StringComparison.Ordinal))
                    return true;
                return !optionalNames.Contains(p.SchemaName["has_".Length..]);
            }).ToList();

            return properties.Count == type.Properties.Count
                ? type
                : type with { Properties = properties };
        }).ToList();
    }

    private static List<AstType> ResolveTableNameConflicts(List<AstType> types)
    {
        var classForms = types
            .Select(t => Singularize(ToSnakeCase(t.Name)))
            .ToHashSet(StringComparer.Ordinal);

        return types.Select(type =>
        {
            var owner = ToSnakeCase(type.Name);
            var properties = type.Properties.Select(property =>
            {
                var derived = $"{owner}_{property.SchemaName}";
                return classForms.Contains(Singularize(derived))
                    ? property with { TableName = derived + "_prop" }
                    : property;
            }).ToList();

            return type with { Properties = properties };
        }).ToList();
    }

    private static string FullName(Type type)
    {
        try
        {
            return type.FullName ?? type.Name;
        }
        catch
        {
            return type.Name;
        }
    }

    /// <summary>
    /// The schema-safe name of a type. CLR generic type names carry an arity suffix
    /// (<c>Foo`1</c>) that is not a valid Python identifier.
    /// </summary>
    private static string TypeName(Type type)
    {
        var name = type.Name;
        var tick = name.IndexOf('`');
        return tick < 0 ? name : name[..tick];
    }

    private static bool IsEnum(Type type)
    {
        try
        {
            return type.IsEnum;
        }
        catch
        {
            return false;
        }
    }

    /// <summary>
    /// <see cref="Nullable.GetUnderlyingType"/> compares against runtime types and so does not
    /// work inside a <c>MetadataLoadContext</c>; match on the generic definition instead.
    /// </summary>
    private static Type? NullableUnderlying(Type type)
    {
        try
        {
            if (!type.IsGenericType)
                return null;
            var definition = FullName(type.GetGenericTypeDefinition());
            return definition.StartsWith("System.Nullable`1", StringComparison.Ordinal)
                ? type.GetGenericArguments()[0]
                : null;
        }
        catch
        {
            return null;
        }
    }

    private static bool IsTuple(Type type)
    {
        try
        {
            if (!type.IsGenericType)
                return false;
            var definition = FullName(type.GetGenericTypeDefinition());
            return definition.StartsWith("System.Tuple`", StringComparison.Ordinal) ||
                   definition.StartsWith("System.ValueTuple`", StringComparison.Ordinal);
        }
        catch
        {
            return false;
        }
    }

    /// <summary>Value type if <paramref name="type"/> is a dictionary, else null.</summary>
    private static Type? DictionaryValue(Type type)
    {
        try
        {
            if (!type.IsGenericType)
                return null;

            var definition = FullName(type.GetGenericTypeDefinition());
            var isDictionary =
                definition.StartsWith("System.Collections.Generic.IDictionary`2", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.Dictionary`2", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.IReadOnlyDictionary`2", StringComparison.Ordinal) ||
                definition.StartsWith("Microsoft.Dynamics.AX.Metadata.XppCompiler.LinkedDictionary`2", StringComparison.Ordinal);

            return isDictionary ? type.GetGenericArguments()[1] : null;
        }
        catch
        {
            return null;
        }
    }

    /// <summary>Element type if <paramref name="type"/> is a supported collection, else null.</summary>
    private static Type? CollectionElement(Type type)
    {
        try
        {
            if (type.IsArray)
                return type.GetElementType();

            if (!type.IsGenericType)
                return null;

            var definition = FullName(type.GetGenericTypeDefinition());
            var isCollection =
                definition.StartsWith("System.Collections.Generic.List`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.IList`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.ICollection`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.IEnumerable`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.IReadOnlyList`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.ISet`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.Generic.HashSet`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.ObjectModel.Collection`1", StringComparison.Ordinal) ||
                definition.StartsWith("System.Collections.ObjectModel.ReadOnlyCollection`1", StringComparison.Ordinal);

            return isCollection ? type.GetGenericArguments()[0] : null;
        }
        catch
        {
            return null;
        }
    }

    /// <summary>Crude singularisation, good enough for the property names in this hierarchy.</summary>
    public static string Singularize(string name)
    {
        if (name.EndsWith("ies", StringComparison.Ordinal))
            return name[..^3] + "y";

        // Latin-ish and already-singular endings that must not lose a trailing "s".
        foreach (var ending in new[] { "ss", "us", "is" })
        {
            if (name.EndsWith(ending, StringComparison.Ordinal))
                return name;
        }

        // "Catches", "Boxes", "Bushes", "Buzzes" drop the whole "es".
        foreach (var ending in new[] { "ches", "shes", "sses", "xes", "zes" })
        {
            if (name.EndsWith(ending, StringComparison.Ordinal))
                return name[..^2];
        }

        if (name.EndsWith("s", StringComparison.Ordinal))
            return name[..^1];

        return name;
    }

    /// <summary>Converts a CLR PascalCase identifier to the snake_case the schema uses.</summary>
    public static string ToSnakeCase(string name)
    {
        var builder = new StringBuilder(name.Length + 8);
        for (var i = 0; i < name.Length; i++)
        {
            var c = name[i];
            if (char.IsUpper(c))
            {
                // Break before a new word, but keep runs of capitals (e.g. "XppType") together.
                var previousIsLower = i > 0 && !char.IsUpper(name[i - 1]) && name[i - 1] != '_';
                var nextIsLower = i + 1 < name.Length && char.IsLower(name[i + 1]);
                if (i > 0 && (previousIsLower || (char.IsUpper(name[i - 1]) && nextIsLower)))
                    builder.Append('_');
                builder.Append(char.ToLowerInvariant(c));
            }
            else
            {
                builder.Append(c);
            }
        }

        return builder.ToString();
    }
}
