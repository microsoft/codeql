#!/bin/bash
set -eu

# X++ is extracted from source with no build step: walk the source root for metadata objects
# that carry X++ and extract them.
exec "$CODEQL_EXTRACTOR_XPP_ROOT/tools/$CODEQL_PLATFORM/Xpp.Extractor" .
