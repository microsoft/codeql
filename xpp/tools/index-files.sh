#!/bin/bash
set -eu

exec "$CODEQL_EXTRACTOR_XPP_ROOT/tools/$CODEQL_PLATFORM/Xpp.Extractor" --file-list "$1"
