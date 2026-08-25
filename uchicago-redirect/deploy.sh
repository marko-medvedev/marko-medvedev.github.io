#!/usr/bin/env bash
# Install the redirect page on math.uchicago.edu/~medvedev/.
#
#   bash uchicago-redirect/deploy.sh
#
# Backs the current index.html up to index-old-<date>.html on the server first,
# then uploads the redirect page. Asks for your UChicago password (twice — once
# per ssh/scp call). Nothing is deleted.

set -euo pipefail

HOST="${PDS_WEB_HOST:-medvedev@math.uchicago.edu}"
DIR="${PDS_WEB_DIR:-~/public_html}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d)"

echo "==> Backing up existing page on $HOST:$DIR"
ssh "$HOST" "cd $DIR && [ -f index.html ] && cp -p index.html index-old-$STAMP.html && ls -l index.html index-old-$STAMP.html"

echo "==> Uploading redirect page"
scp "$HERE/index.html" "$HOST:$DIR/index.html"

echo "==> Done. Verify:"
echo "    curl -sI https://math.uchicago.edu/~medvedev/ | head -3"
