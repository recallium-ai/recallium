#!/bin/bash
# =============================================================================
# Recallium Download Memories Script (Linux/macOS)
# Downloads all memories as a timestamped zip file
#
# Usage:
#   ./download-memories.sh
# =============================================================================

set -e

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=============================================="
echo "  Recallium Memory Export"
echo "=============================================="
echo ""

echo "[Recallium] Downloading memories export..."
curl -o "recallium-export-$(date +%Y%m%d-%H%M%S).zip" http://localhost:8001/api/data/export

echo ""
echo "=============================================="
echo "  Download complete!"
echo "=============================================="
echo ""
