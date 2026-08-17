using Xpp.Extraction;

// Extracts X++ metadata objects to TRAP.
//
//   Xpp.Extractor <path>... [--trap <file>]
//
// Paths may be files or directories; directories are searched for metadata objects that can
// carry X++ source.

var paths = new List<string>();
string? trapPath = null;

for (var i = 0; i < args.Length; i++)
{
    if (args[i] == "--trap" && i + 1 < args.Length)
        trapPath = args[++i];
    else
        paths.Add(args[i]);
}

if (paths.Count == 0)
{
    Console.Error.WriteLine("usage: Xpp.Extractor <path>... [--trap <file>]");
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

using TextWriter output = trapPath is null
    ? Console.Out
    : new StreamWriter(File.Create(trapPath));

var trap = new TrapFile(output);
var extractor = new Extractor();

var totalBlocks = 0;
var totalNodes = 0;
var totalUnsupported = 0;
var failed = 0;

foreach (var file in files.OrderBy(f => f, StringComparer.Ordinal))
{
    var result = extractor.Extract(file, trap);
    totalBlocks += result.Blocks;
    totalNodes += result.Nodes;
    totalUnsupported += result.Unsupported;

    foreach (var error in result.Errors)
    {
        failed++;
        Console.Error.WriteLine($"{file}: {error}");
    }
}

Console.Error.WriteLine(
    $"extracted {files.Count} files, {totalBlocks} source blocks, {totalNodes} nodes " +
    $"({totalUnsupported} unsupported, {failed} errors)");

return failed == 0 ? 0 : 1;
