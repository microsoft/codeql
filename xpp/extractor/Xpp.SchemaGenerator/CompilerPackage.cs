using System.Reflection;

namespace Xpp.SchemaGenerator;

/// <summary>
/// Reflection-only access to the X++ compiler assemblies shipped in
/// <c>Microsoft.Dynamics.AX.Platform.CompilerPackage</c>.
/// </summary>
/// <remarks>
/// Uses <see cref="MetadataLoadContext"/>, which reads PE metadata without executing any code
/// from the package. The package is proprietary and is never committed to this repository; the
/// directory is supplied by the caller or via <c>XPP_COMPILER_PACKAGE</c>.
/// </remarks>
public sealed class CompilerPackage : IDisposable
{
    /// <summary>Assembly declaring the X++ AST node classes.</summary>
    public const string AstAssembly = "Microsoft.Dynamics.AX.Framework.Xlnt.XppCore";

    /// <summary>Namespace shared by the AST node classes.</summary>
    public const string AstNamespace = "Microsoft.Dynamics.AX.Metadata.XppCompiler";

    /// <summary>Root of the X++ AST class hierarchy.</summary>
    public const string AstRoot = AstNamespace + ".Ast";

    private readonly MetadataLoadContext context;

    public CompilerPackage(string packageDirectory)
    {
        if (!Directory.Exists(packageDirectory))
            throw new DirectoryNotFoundException($"Compiler package directory not found: {packageDirectory}");

        PackageDirectory = packageDirectory;

        var paths = Directory.GetFiles(packageDirectory, "*.dll", SearchOption.AllDirectories).ToList();
        var present = paths.Select(Path.GetFileNameWithoutExtension)
                           .ToHashSet(StringComparer.OrdinalIgnoreCase);

        // Package assemblies take precedence; reference assemblies only fill in the BCL.
        foreach (var referenceAssembly in ReferenceAssemblyPaths())
        {
            if (!present.Contains(Path.GetFileNameWithoutExtension(referenceAssembly)))
                paths.Add(referenceAssembly);
        }

        context = new MetadataLoadContext(new PathAssemblyResolver(paths), "mscorlib");
    }

    public string PackageDirectory { get; }

    /// <summary>
    /// Locates the net472 reference assemblies restored alongside this tool. They are required
    /// because the XLNT assemblies target .NET Framework.
    /// </summary>
    private static IEnumerable<string> ReferenceAssemblyPaths()
    {
        var roots = new List<string>();

        var packageRoot = Environment.GetEnvironmentVariable("NUGET_PACKAGES");
        if (string.IsNullOrEmpty(packageRoot))
        {
            packageRoot = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.UserProfile),
                ".nuget", "packages");
        }

        var referencePackage = Path.Combine(packageRoot, "microsoft.netframework.referenceassemblies.net472");
        if (Directory.Exists(referencePackage))
        {
            // Any restored version will do; the BCL surface we need is stable across them.
            foreach (var version in Directory.GetDirectories(referencePackage).OrderByDescending(d => d))
            {
                var dir = Path.Combine(version, "build", ".NETFramework", "v4.7.2");
                if (Directory.Exists(dir))
                {
                    roots.Add(dir);
                    break;
                }
            }
        }

        return roots.SelectMany(r => Directory.GetFiles(r, "*.dll"));
    }

    /// <summary>Every type in the AST assembly, tolerating unresolvable references.</summary>
    public IReadOnlyList<Type> AstAssemblyTypes()
    {
        var assembly = context.LoadFromAssemblyPath(
            Path.Combine(PackageDirectory, AstAssembly + ".dll"));
        try
        {
            return assembly.GetTypes();
        }
        catch (ReflectionTypeLoadException e)
        {
            return e.Types.Where(t => t is not null).ToArray()!;
        }
    }

    /// <summary>The base-class chain of <paramref name="type"/>, outermost last.</summary>
    public static IReadOnlyList<string> BaseChain(Type type)
    {
        var chain = new List<string>();
        var current = type;
        while (true)
        {
            try
            {
                current = current.BaseType;
            }
            catch
            {
                break;
            }

            if (current is null)
                break;

            chain.Add(current.FullName ?? current.Name);
        }

        return chain;
    }

    /// <summary>True if <paramref name="type"/> is <c>Ast</c> or derives from it.</summary>
    public static bool IsAstType(Type type) =>
        type.FullName == AstRoot || BaseChain(type).Contains(AstRoot);

    public void Dispose() => context.Dispose();
}
