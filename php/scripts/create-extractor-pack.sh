#!/bin/bash
set -eux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  platform="linux64"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  platform="osx64"
else
  echo "Unknown OS"
  exit 1
fi
cd "$(dirname "$0")/.."

(cd extractor && cargo build --release)

# we are in a cargo workspace rooted at the git checkout
BIN_DIR=../target/release
"$BIN_DIR/codeql-extractor-php" generate --dbscheme ql/lib/php.dbscheme --library ql/lib/codeql/php/ast/internal/TreeSitter.qll

codeql query format -i ql/lib/codeql/php/ast/internal/TreeSitter.qll

rm -rf extractor-pack
mkdir -p extractor-pack
cp -r codeql-extractor.yml tools extractor-pack/
mkdir -p extractor-pack/tools/${platform}
cp "$BIN_DIR/codeql-extractor-php" extractor-pack/tools/${platform}/extractor
