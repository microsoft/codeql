using System.Reflection;
using System.Runtime.Loader;

namespace Xpp.Extraction;

/// <summary>
/// Resolves the X++ compiler assemblies from an extracted
/// <c>Microsoft.Dynamics.AX.Platform.CompilerPackage</c> at run time.
/// </summary>
/// <remarks>
/// The package is proprietary, so it is neither committed nor copied into build output. The
/// extractor locates it through <c>XPP_COMPILER_PACKAGE</c> instead, which also keeps a single
/// copy shared between the extractor and any other tool that needs it.
/// </remarks>
public static class CompilerPackageResolver
{
    public const string PackageVariable = "XPP_COMPILER_PACKAGE";

    private static bool installed;

    /// <summary>
    /// Starts resolving compiler assemblies from <paramref name="packageDirectory"/>, or from
    /// <c>XPP_COMPILER_PACKAGE</c> when it is null.
    /// </summary>
    /// <exception cref="DirectoryNotFoundException">
    /// The package directory is unset or does not exist.
    /// </exception>
    public static void Install(string? packageDirectory = null)
    {
        if (installed)
            return;

        packageDirectory ??= Environment.GetEnvironmentVariable(PackageVariable);

        if (string.IsNullOrEmpty(packageDirectory))
        {
            throw new DirectoryNotFoundException(
                $"{PackageVariable} is not set. Point it at an extracted " +
                "Microsoft.Dynamics.AX.Platform.CompilerPackage.");
        }

        if (!Directory.Exists(packageDirectory))
        {
            throw new DirectoryNotFoundException(
                $"{PackageVariable} does not exist: {packageDirectory}");
        }

        var root = packageDirectory;
        AssemblyLoadContext.Default.Resolving += (context, name) =>
        {
            var candidate = Path.Combine(root, name.Name + ".dll");
            return File.Exists(candidate) ? context.LoadFromAssemblyPath(candidate) : null;
        };

        installed = true;
    }
}
