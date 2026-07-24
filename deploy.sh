#!/bin/bash
# Deploy AirSpotX to o2switch — airspotx.xavier-kain.fr
set -euo pipefail
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
SSH_KEY="/home/xavier/.ssh/o2switch_key"
REMOTE_USER="wito4771"
REMOTE_HOST="bretelle.o2switch.net"
REMOTE_DIR="/home/wito4771/airspotx.xavier-kain.fr"

echo "[$(date '+%F %T')] Deploying to airspotx.xavier-kain.fr..."
ssh -i "$SSH_KEY" "$REMOTE_USER@$REMOTE_HOST" "mkdir -p $REMOTE_DIR"
rsync -avz --delete -e "ssh -i $SSH_KEY" \
  --exclude '.git' --exclude '.gitignore' --exclude 'deploy.sh' --exclude 'README.md' --exclude '.DS_Store' \
  "$SRC_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" 2>&1 | tail -5
echo "[$(date '+%F %T')] Deploy complete!"
curl -s -o /dev/null -w "HTTP %{http_code}\n" "https://airspotx.xavier-kain.fr/" || true
