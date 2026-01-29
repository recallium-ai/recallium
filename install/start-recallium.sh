#!/bin/bash
# =============================================================================
# Recallium Quick Start Script (Linux/macOS)
# Downloads and runs Recallium from DockerHub
#
# Prerequisites:
#   1. Docker installed and running
#   2. recallium.env file in the same directory
#
# Usage:
#   ./start-recallium.sh
# =============================================================================

set -e

ENV_FILE="recallium.env"
IMAGE="recalliumai/recallium:latest"
CONTAINER_NAME="recallium"

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo "[Error] Docker is not installed. Please install Docker first."
    echo "  https://docs.docker.com/get-docker/"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo "[Error] Docker daemon is not running. Please start Docker."
    exit 1
fi

# Check for env file
if [ ! -f "$ENV_FILE" ]; then
    echo "[Error] Environment file '$ENV_FILE' not found."
    echo ""
    echo "Please create $ENV_FILE with your configuration."
    echo "See README.md for configuration options."
    exit 1
fi

# Load variables from env file for volume/port configuration
set -a
source "$ENV_FILE"
set +a

# Use values from env file (with defaults)
VOLUME_NAME="${VOLUME_NAME:-recallium-v1}"
API_PORT="${HOST_API_PORT:-8001}"
UI_PORT="${HOST_UI_PORT:-9001}"
DB_PORT="${HOST_POSTGRES_PORT:-5433}"

# Stop existing container
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "[Recallium] Pulling latest image..."
docker pull "$IMAGE"

echo "[Recallium] Starting container..."
docker run -d \
    --name "$CONTAINER_NAME" \
    --restart unless-stopped \
    --env-file "$ENV_FILE" \
    -p "${API_PORT}:8000" \
    -p "${UI_PORT}:9000" \
    -p "${DB_PORT}:5432" \
    -v "${VOLUME_NAME}":/data \
    -v "${VOLUME_NAME}-wal":/wal \
    -v "${VOLUME_NAME}-docs":/documents \
    -v "${VOLUME_NAME}-secrets":/secrets \
    --add-host=host.docker.internal:host-gateway \
    "$IMAGE"

echo ""
echo "[Recallium] Started! Waiting for services to initialize..."
sleep 15

echo ""
echo "=============================================="
echo "  Recallium is running!"
echo "=============================================="
echo ""
echo "  Web UI:  http://127.0.0.1:${UI_PORT}"
echo "  MCP API: http://127.0.0.1:${API_PORT}/mcp"
echo "  Health:  http://127.0.0.1:${API_PORT}/health"
echo ""
echo "  Logs:    docker logs -f $CONTAINER_NAME"
echo "  Stop:    docker stop $CONTAINER_NAME"
echo "  Restart: docker restart $CONTAINER_NAME"
echo ""
echo "  Opening Web UI in your browser..."
echo ""

# Open browser (works on macOS and Linux)
if command -v open &> /dev/null; then
    open "http://127.0.0.1:${UI_PORT}"
elif command -v xdg-open &> /dev/null; then
    xdg-open "http://127.0.0.1:${UI_PORT}"
else
    echo "  Please open http://127.0.0.1:${UI_PORT} in your browser"
fi
