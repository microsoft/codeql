#!/bin/bash
# Regenerates the X++ schema, dbscheme and QL classes.
#
# The schema is derived by reflection from the X++ compiler's own AST hierarchy in
# Microsoft.Dynamics.AX.Framework.Xlnt.XppCore.dll, which ships in the proprietary
# Microsoft.Dynamics.AX.Platform.CompilerPackage. That package is not committed here, so point
# XPP_COMPILER_PACKAGE at an extracted copy:
#
#   XPP_COMPILER_PACKAGE=/path/to/extracted/nupkg xpp/tools/generate-schema.sh
#
# The generated schema, dbscheme and QL are committed, so this is only needed when moving to a
# new platform release.

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
xpp_root="$(dirname "$here")"
repo_root="$(dirname "$xpp_root")"

if [ -z "${XPP_COMPILER_PACKAGE:-}" ]; then
    echo "XPP_COMPILER_PACKAGE is not set." >&2
    echo "Point it at an extracted Microsoft.Dynamics.AX.Platform.CompilerPackage." >&2
    exit 2
fi

PYTHON="${PYTHON:-python3}"

echo "==> generating schema/ast.py from $XPP_COMPILER_PACKAGE"
dotnet run --project "$xpp_root/extractor/Xpp.SchemaGenerator" -c Release -- \
    schema \
    --package "$XPP_COMPILER_PACKAGE" \
    --output "$xpp_root/schema/ast.py"

echo "==> running misc/codegen"
cd "$xpp_root"
PYTHONPATH="$repo_root" "$PYTHON" "$repo_root/misc/codegen/codegen.py"

echo "==> done"
