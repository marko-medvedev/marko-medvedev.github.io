#!/usr/bin/env bash
# Install the redirect page on math.uchicago.edu/~medvedev/.
#
#   bash uchicago-redirect/deploy.sh
#
# Runs from YOUR MAC. Nothing is pasted into the remote shell, so terminal
# encoding, bracketed paste and tcsh history expansion cannot mangle anything.
# One ssh connection, one password prompt.
#
# It backs the current index.html up to index-old-<date>.html on the server,
# then streams the redirect page in over the same connection. Nothing is deleted.
#
# Override the target if needed:
#   PDS_WEB_HOST=medvedev@math.uchicago.edu PDS_WEB_DIR=public_html bash deploy.sh

set -euo pipefail

HOST="${PDS_WEB_HOST:-medvedev@math.uchicago.edu}"
DIR="${PDS_WEB_DIR:-public_html}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/index.html"

[ -f "$SRC" ] || { echo "missing $SRC" >&2; exit 1; }

echo "==> Deploying $(wc -c < "$SRC" | tr -d ' ') bytes to $HOST:~/$DIR/index.html"
echo "    (local md5: $(md5 -q "$SRC" 2>/dev/null || md5sum "$SRC" | cut -d' ' -f1))"

# Remote command is csh/tcsh-safe: backticks not $(), no bashisms.
ssh "$HOST" "cd $DIR && cp -p index.html index-old-\`date +%Y%m%d\`.html && cat > index.html && chmod 644 index.html && ls -l index.html index-old-\`date +%Y%m%d\`.html && md5sum index.html" < "$SRC"

echo
echo "==> Verify:"
echo "    curl -s https://math.uchicago.edu/~medvedev/"
