using Xpp.Extraction;

// Extracts X++ metadata objects to TRAP.
//
//   Xpp.Extractor [<path>...] [--file-list <file>] [--trap <file>]
//
// Paths may be files or directories; directories are searched for metadata objects that can
// carry X++ source. When run by the CodeQL CLI the destinations come from the
// CODEQL_EXTRACTOR_XPP_* environment instead, and `--file-list` supplies the files to index.

var paths = new List<string>();
string? trapPath = null;
string? fileList = null;

for (var i = 0; i < args.Length; i++)
{
    switch (args[i])
    {
        case "--trap" when i + 1 < args.Length:
            trapPath = args[++i];
            break;
        case "--file-list" when i + 1 < args.Length:
            fileList = args[++i];
            break;
        default:
            paths.Add(args[i]);
            break;
    }
}

if (fileList is not null)
{
    if (!File.Exists(fileList))
    {
        Console.Error.WriteLine($"file list not found: {fileList}");
        return 2;
    }

    paths.AddRange(File.ReadAllLines(fileList).Where(l => !string.IsNullOrWhiteSpace(l)));
}

if (paths.Count == 0)
{
    Console.Error.WriteLine("usage: Xpp.Extractor [<path>...] [--file-list <file>] [--trap <file>]");
    return 2;
}

try
{
    CompilerPackageResolver.Install();
}
catch (DirectoryNotFoundException e)
{
    Console.Error.WriteLine(e.Message);
    return 2;
}

var files = new List<string>();
foreach (var path in paths)
{
    if (Directory.Exists(path))
    {
        files.AddRange(Directory.EnumerateFiles(path, "*.xml", SearchOption.AllDirectories)
            .Where(XppSourceFile.IsCandidate));
    }
    else if (File.Exists(path))
    {
        files.Add(path);
    }
    else
    {
        Console.Error.WriteLine($"no such path: {path}");
    }
}

var layout = ExtractorLayout.FromEnvironment();
var extractor = new Extractor();

var totalBlocks = 0;
var totalNodes = 0;
var totalUnsupported = 0;
var failed = 0;

// One shared stream when the caller asked for a single TRAP file or stdout; otherwise the CLI
// expects one TRAP file per source file.
TextWriter? shared = trapPath is not null
    ? new StreamWriter(File.Create(trapPath))
    : layout.TrapDirectory is null
        ? Console.Out
        : null;

try
{
    foreach (var file in files.OrderBy(f => f, StringComparer.Ordinal))
    {
        var output = shared;
        if (output is null)
        {
            var destination = layout.TrapPathFor(file)!;
            Directory.CreateDirectory(Path.GetDirectoryName(destination)!);
            output = new StreamWriter(File.Create(destination));
        }

        try
        {
            var result = extractor.Extract(file, new TrapFile(output));
            totalBlocks += result.Blocks;
            totalNodes += result.Nodes;
            totalUnsupported += result.Unsupported;

            foreach (var error in result.Errors)
            {
                failed++;
                Console.Error.WriteLine($"{file}: {error}");
            }
        }
        finally
        {
            if (!ReferenceEquals(output, shared))
                output.Dispose();
        }

        CopyToSourceArchive(file, layout);
    }
}
finally
{
    if (shared is not null && !ReferenceEquals(shared, Console.Out))
        shared.Dispose();
}

Console.Error.WriteLine(
    $"extracted {files.Count} files, {totalBlocks} source blocks, {totalNodes} nodes " +
    $"({totalUnsupported} unsupported, {failed} errors)");

return failed == 0 ? 0 : 1;

// Alerts need the original file in order to display, so it is copied verbatim.
static void CopyToSourceArchive(string file, ExtractorLayout layout)
{
    var destination = layout.ArchivePathFor(file);
    if (destination is null)
        return;

    try
    {
        Directory.CreateDirectory(Path.GetDirectoryName(destination)!);
        File.Copy(file, destination, overwrite: true);
    }
    catch (Exception e)
    {
        Console.Error.WriteLine($"{file}: could not archive source: {e.Message}");
    }
}
