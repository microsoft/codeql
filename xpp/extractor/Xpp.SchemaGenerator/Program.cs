using Xpp.SchemaGenerator;

// Regenerates xpp/schema/ast.py from the X++ compiler package's AST hierarchy.
//
//   Xpp.SchemaGenerator <command> [args] [--package <dir>] [--output <file>]
//
// Commands:
//   schema          write the generated schema module
//   report          summarise the reflected model and any unmapped properties
//   type <name>     dump the members of a single type, for investigation

var positional = new List<string>();
string? packageDirectory = null;
string? output = null;

for (var i = 0; i < args.Length; i++)
{
    switch (args[i])
    {
        case "--package" when i + 1 < args.Length:
            packageDirectory = args[++i];
            break;
        case "--output" when i + 1 < args.Length:
            output = args[++i];
            break;
        default:
            positional.Add(args[i]);
            break;
    }
}

var command = positional.Count > 0 ? positional[0] : "report";

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

    case "trap":
        var dbscheme = positional.Count > 1
            ? positional[1]
            : Path.Combine(Directory.GetCurrentDirectory(), "ql", "lib", "xpp.dbscheme");

        if (!File.Exists(dbscheme))
        {
            Console.Error.WriteLine($"dbscheme not found: {dbscheme}");
            Console.Error.WriteLine("Generate it first, then rerun; the TRAP writer is checked against it.");
            return 2;
        }

        var tables = TrapEmitterWriter.ReadDbschemeTables(dbscheme);
        string emitter;
        try
        {
            emitter = TrapEmitterWriter.Render(model, tables);
        }
        catch (InvalidOperationException e)
        {
            Console.Error.WriteLine(e.Message);
            return 1;
        }

        if (output is null)
        {
            Console.Write(emitter);
        }
        else
        {
            Directory.CreateDirectory(Path.GetDirectoryName(Path.GetFullPath(output))!);
            File.WriteAllText(output, emitter);
            Console.Error.WriteLine($"wrote TRAP emitter to {output}, validated against {tables.Count} relations");
        }

        return 0;

    default:
        Console.Error.WriteLine($"Unknown command '{command}'. Expected 'schema', 'trap' or 'report'.");
        return 2;
}
