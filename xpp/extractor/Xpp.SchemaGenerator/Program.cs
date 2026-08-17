using Xpp.SchemaGenerator;

// Regenerates xpp/schema/ast.py from the X++ compiler package's AST hierarchy.
//
//   Xpp.SchemaGenerator <command> [--package <dir>] [--output <file>]
//
// Commands:
//   schema   write the generated schema module
//   report   summarise the reflected model and any unmapped properties

var command = args.FirstOrDefault() ?? "report";

string? packageDirectory = null;
string? output = null;

for (var i = 1; i < args.Length - 1; i++)
{
    switch (args[i])
    {
        case "--package":
            packageDirectory = args[++i];
            break;
        case "--output":
            output = args[++i];
            break;
    }
}

packageDirectory ??= Environment.GetEnvironmentVariable("XPP_COMPILER_PACKAGE");

if (string.IsNullOrEmpty(packageDirectory))
{
    Console.Error.WriteLine(
        "No compiler package directory. Pass --package <dir> or set XPP_COMPILER_PACKAGE.");
    return 2;
}

using var package = new CompilerPackage(packageDirectory);
var model = AstModel.Build(package);

switch (command)
{
    case "schema":
        var schema = SchemaWriter.Render(model);
        if (output is null)
        {
            Console.Write(schema);
        }
        else
        {
            Directory.CreateDirectory(Path.GetDirectoryName(Path.GetFullPath(output))!);
            File.WriteAllText(output, schema);
            Console.Error.WriteLine(
                $"wrote {model.Types.Count} types to {output} ({model.Diagnostics.Count} diagnostics)");
        }

        return 0;

    case "report":
        Console.Write(SchemaWriter.RenderReport(model));
        return 0;

    default:
        Console.Error.WriteLine($"Unknown command '{command}'. Expected 'schema' or 'report'.");
        return 2;
}
