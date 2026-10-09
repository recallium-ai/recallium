#!/bin/bash
# =============================================================================
# Recallium Update Script (Linux/macOS)
# Updates to the latest version from git while preserving your configuration
#
# Usage:
#   ./update-recallium.sh
# =============================================================================

set -e

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ENV_FILE="recallium.env"
ENV_BACKUP="recallium.env.backup"

echo "=============================================="
echo "  Recallium Update"
echo "=============================================="
echo ""

# Backup env file if it exists
if [ -f "$ENV_FILE" ]; then
    echo "[Recallium] Backing up $ENV_FILE..."
    cp "$ENV_FILE" "$ENV_BACKUP"
fi

# Force pull latest from git
echo "[Recallium] Pulling latest updates from git..."
git fetch --all
git reset --hard origin/main

# Restore env file from backup
if [ -f "$ENV_BACKUP" ]; then
    echo "[Recallium] Restoring your configuration..."
    cp "$ENV_BACKUP" "$ENV_FILE"
    echo "[Recallium] Backup preserved at $ENV_BACKUP"
fi

echo ""
echo "=============================================="
echo "  Update complete!"
echo "=============================================="
echo ""
echo "  Your configuration has been preserved."
echo "  Run ./start-recallium.sh to start with the new version."
echo ""
