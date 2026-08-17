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
rm -rf "$pack"
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
