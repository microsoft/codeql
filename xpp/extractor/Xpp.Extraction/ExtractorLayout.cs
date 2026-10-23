namespace Xpp.Extraction;

/// <summary>
/// The environment CodeQL sets up for an extractor run.
/// </summary>
/// <remarks>
/// The CLI passes the TRAP and source-archive destinations through
/// <c>CODEQL_EXTRACTOR_XPP_*</c> variables rather than on the command line.
/// </remarks>
public sealed record ExtractorLayout(
    string? TrapDirectory,
    string? SourceArchiveDirectory,
    string? SourceRoot)
{
    public static ExtractorLayout FromEnvironment() =>
        new(
            Environment.GetEnvironmentVariable("CODEQL_EXTRACTOR_XPP_TRAP_DIR"),
            Environment.GetEnvironmentVariable("CODEQL_EXTRACTOR_XPP_SOURCE_ARCHIVE_DIR"),
            Environment.GetEnvironmentVariable("CODEQL_EXTRACTOR_XPP_WIP_DATABASE") is not null
                ? Directory.GetCurrentDirectory()
                : null);

    /// <summary>
    /// Where the TRAP for <paramref name="sourcePath"/> should be written, or null when the
    /// caller wants TRAP on standard output instead.
    /// </summary>
    public string? TrapPathFor(string sourcePath)
    {
        if (TrapDirectory is null)
            return null;

        return Path.Combine(TrapDirectory, Relative(sourcePath) + ".trap");
    }

    /// <summary>Where <paramref name="sourcePath"/> should be copied for the source archive.</summary>
    public string? ArchivePathFor(string sourcePath)
    {
        if (SourceArchiveDirectory is null)
            return null;

        return Path.Combine(SourceArchiveDirectory, Relative(sourcePath));
    }

    /// <summary>
    /// A path safe to append to a destination directory: rooted paths are flattened by dropping
    /// the root, matching how the CLI lays out both trees.
    /// </summary>
    private string Relative(string sourcePath)
    {
        var full = Path.GetFullPath(sourcePath);

        if (SourceRoot is not null)
        {
            var relative = Path.GetRelativePath(SourceRoot, full);
            if (!relative.StartsWith("..", StringComparison.Ordinal))
                return relative;
        }

        return full.TrimStart(Path.DirectorySeparatorChar, '/')
                   .Replace(':', '_');
    }
}
