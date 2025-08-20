#!/bin/bash
set -euo pipefail

CURRENT_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Current script directory: $CURRENT_SCRIPT_DIR"

# Variables
IMAGE_NAME="jetson-cross-toolchain:latest"
DOCKERFILE_PATH="$CURRENT_SCRIPT_DIR/Dockerfile"
DOCKERFILE_DIR="$CURRENT_SCRIPT_DIR"

echo "Building Docker image: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" "$DOCKERFILE_DIR"

echo "Docker image '$IMAGE_NAME' built successfully."