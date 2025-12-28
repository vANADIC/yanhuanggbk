#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME=yanhuanggbk:local
CONTAINER_NAME=yanhuangGBK
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOST_DATA_DIR=${HOST_DATA_DIR:-"$SCRIPT_DIR/mudlib/data"}

mkdir -p "$HOST_DATA_DIR"

docker build --platform linux/amd64 -t "$IMAGE_NAME" .

# Remove any stopped container with the same name to avoid name conflicts.
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  docker rm -f "$CONTAINER_NAME" >/dev/null
fi

docker run -d --rm --platform linux/amd64 \
  --name "$CONTAINER_NAME" \
  -p 1234:1234 \
  -v "$HOST_DATA_DIR":/root/hellmud/mudlib/data \
  "$IMAGE_NAME"
echo "Container '$CONTAINER_NAME' started in background. View logs: docker logs -f $CONTAINER_NAME"
