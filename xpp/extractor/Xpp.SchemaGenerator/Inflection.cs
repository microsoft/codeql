using System.Text;
using System.Text.RegularExpressions;

namespace Xpp.SchemaGenerator;

/// <summary>
/// The subset of the Python <c>inflection</c> package's behaviour that <c>misc/codegen</c>
/// relies on when deriving dbscheme table names.
/// </summary>
/// <remarks>
/// Table names are produced by <c>inflection.tableize</c>, so the TRAP writer has to agree with
/// it exactly. Rather than trust this reimplementation, the generator validates every name it
/// produces against the committed dbscheme and fails if one is missing.
/// </remarks>
public static partial class Inflection
{
    private static readonly (Regex Pattern, string Replacement)[] PluralRules =
    [
        (MakeRegex("(quiz)$"), "$1zes"),
        (MakeRegex("^(oxen)$"), "$1"),
        (MakeRegex("^(ox)$"), "$1en"),
        (MakeRegex("(m|l)ouse$"), "$1ice"),
        (MakeRegex("(matr|vert|ind)(?:ix|ex)$"), "$1ices"),
        (MakeRegex("(x|ch|ss|sh)$"), "$1es"),
        (MakeRegex("([^aeiouy]|qu)y$"), "$1ies"),
        (MakeRegex("(hive)$"), "$1s"),
        (MakeRegex("(?:([^f])fe|([lr])f)$"), "$1$2ves"),
        (MakeRegex("sis$"), "ses"),
        (MakeRegex("([ti])um$"), "$1a"),
        (MakeRegex("(buffal|tomat)o$"), "$1oes"),
        (MakeRegex("(bu)s$"), "$1ses"),
        (MakeRegex("(alias|status)$"), "$1es"),
        (MakeRegex("(octop|vir)us$"), "$1i"),
        (MakeRegex("(ax|test)is$"), "$1es"),
        (MakeRegex("s$"), "s"),
        (MakeRegex("$"), "s"),
    ];

    private static Regex MakeRegex(string pattern) =>
        new(pattern, RegexOptions.IgnoreCase | RegexOptions.Compiled);

    /// <summary>Pluralises a lower_snake_case word, matching <c>inflection.pluralize</c>.</summary>
    public static string Pluralize(string word)
    {
        if (word.Length == 0)
            return word;

        // `inflection` scans its rule list in order and applies the first match, so the specific
        // rules must be tried before the catch-all that simply appends "s".
        foreach (var (pattern, replacement) in PluralRules)
        {
            if (pattern.IsMatch(word))
                return pattern.Replace(word, replacement, 1);
        }

        return word;
    }

    /// <summary>Converts a CLR PascalCase identifier to snake_case, matching <c>underscore</c>.</summary>
    public static string Underscore(string name)
    {
        var builder = new StringBuilder(name.Length + 8);
        for (var i = 0; i < name.Length; i++)
        {
            var c = name[i];
            if (char.IsUpper(c))
            {
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

    /// <summary>Equivalent of <c>inflection.tableize</c>: underscore, then pluralise.</summary>
    public static string Tableize(string name) => Pluralize(Underscore(name));
}
