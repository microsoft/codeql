cargo build --release

cargo run --release --bin codeql-extractor-iac -- generate --dbscheme ql/lib/iac.dbscheme --library ql/lib/codeql/iac/ast/internal/TreeSitter.qll
codeql query format -i ql\lib\codeql\iac\ast\internal\TreeSitter.qll

if (Test-Path -Path extractor-pack) {
	rm -Recurse -Force extractor-pack
}
mkdir extractor-pack | Out-Null
cp codeql-extractor.yml, ql\lib\iac.dbscheme, ql\lib\iac.dbscheme.stats extractor-pack
cp -Recurse downgrades extractor-pack
cp -Recurse tools extractor-pack
mkdir extractor-pack\tools\win64 | Out-Null
cp target\release\codeql-extractor-iac.exe extractor-pack\tools\win64\extractor.exe
