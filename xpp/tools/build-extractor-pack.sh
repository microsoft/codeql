#!/bin/bash
# Assembles the X++ extractor pack.
#
#   xpp/tools/build-extractor-pack.sh [output-dir]
#
# Produces a directory the CodeQL CLI can use via `--search-path`, laid out as the CLI expects:
#
#   <output>/xpp/codeql-extractor.yml
#   <output>/xpp/xpp.dbscheme(.stats)
#   <output>/xpp/tools/{index-files,autobuild,qltest}.{sh,cmd}
#   <output>/xpp/tools/<platform>/Xpp.Extractor
#
# The proprietary compiler package is not bundled; the extractor resolves it at run time from
# XPP_COMPILER_PACKAGE.

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
xpp_root="$(dirname "$here")"
output="${1:-$xpp_root/extractor-pack}"

case "$(uname -s)" in
    Darwin) platform="osx64" ;;
    Linux) platform="linux64" ;;
    *) platform="win64" ;;
esac

pack="$output/xpp"

# Resolve $pack without requiring it to exist yet, so it can be compared with the source tree.
pack_parent="$(cd "$(dirname "$pack")" 2>/dev/null && pwd || true)"
if [ -z "$pack_parent" ]; then
    echo "output directory does not exist: $(dirname "$pack")" >&2
    exit 2
fi
pack_abs="$pack_parent/$(basename "$pack")"
xpp_abs="$(cd "$xpp_root" && pwd)"

# Passing the repository root would make $pack the source tree itself, and the removal below
# would delete it.
if [ "$pack_abs" = "$xpp_abs" ]; then
    echo "refusing to build into the source tree: $pack_abs" >&2
    exit 2
fi

if [ -e "$pack_abs" ]; then
    # Only ever remove something that is itself a previously built pack.
    if [ ! -f "$pack_abs/codeql-extractor.yml" ]; then
        echo "refusing to remove $pack_abs: it is not a generated extractor pack" >&2
        exit 2
    fi
    rm -rf "$pack_abs"
fi

pack="$pack_abs"
mkdir -p "$pack/tools/$platform"

cp "$xpp_root/codeql-extractor.yml" "$pack/"
cp "$xpp_root/ql/lib/xpp.dbscheme" "$pack/"
cp "$xpp_root/ql/lib/xpp.dbscheme.stats" "$pack/"

for script in index-files autobuild qltest; do
    cp "$here/$script.sh" "$here/$script.cmd" "$pack/tools/"
done
chmod +x "$pack/tools/"*.sh

dotnet publish "$xpp_root/extractor/Xpp.Extractor" \
    -c Release \
    -o "$pack/tools/$platform" \
    --nologo \
    -v quiet

echo "extractor pack written to $pack"
