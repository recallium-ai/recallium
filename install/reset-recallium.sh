#!/bin/bash
# =============================================================================
# Recallium Reset Script (Linux/macOS)
# Stops container and deletes all volumes (DATA LOSS WARNING)
#
# Usage:
#   ./reset-recallium.sh
# =============================================================================

set -e

ENV_FILE="recallium.env"
CONTAINER_NAME="recallium"
IMAGE="recalliumai/recallium:latest"

# Load variables from env file if it exists
if [ -f "$ENV_FILE" ]; then
    set -a
    source "$ENV_FILE"
    set +a
fi

VOLUME_NAME="${VOLUME_NAME:-recallium-v1}"

echo "=============================================="
echo "  Recallium Reset - DATA LOSS WARNING"
echo "=============================================="
echo ""
echo "This will permanently delete:"
echo "  - Container: $CONTAINER_NAME"
echo "  - Volume: ${VOLUME_NAME} (database)"
echo "  - Volume: ${VOLUME_NAME}-wal (write-ahead logs)"
echo "  - Volume: ${VOLUME_NAME}-docs (documents)"
echo "  - Volume: ${VOLUME_NAME}-secrets (secrets)"
echo "  - Image: $IMAGE"
echo ""
echo "ALL YOUR MEMORIES AND DATA WILL BE LOST!"
echo ""
read -p "Are you sure you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 0
fi

echo ""
echo "[Recallium] Stopping container..."
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "[Recallium] Removing volumes..."
docker volume rm "${VOLUME_NAME}" 2>/dev/null || true
docker volume rm "${VOLUME_NAME}-wal" 2>/dev/null || true
docker volume rm "${VOLUME_NAME}-docs" 2>/dev/null || true
docker volume rm "${VOLUME_NAME}-secrets" 2>/dev/null || true

echo "[Recallium] Removing image..."
docker rmi "$IMAGE" 2>/dev/null || true

echo ""
echo "=============================================="
echo "  Recallium has been completely reset."
echo "=============================================="
echo ""
echo "Run ./start-recallium.sh to start fresh."
echo ""
