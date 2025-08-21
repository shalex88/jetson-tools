#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INPUT=$1

# Check if input is provided
if [ -z "$INPUT" ]; then
    echo "Usage: $0 <path/to/executable>"
    echo "Example: $0 /home/user/myapp/program"
    echo "         $0 ./build/myprogram"
    exit 1
fi

# Get the absolute path of the input file
INPUT_ABSOLUTE=$(realpath "$INPUT")

# Split the path into directory and filename
INPUT_DIR=$(dirname "$INPUT_ABSOLUTE")
INPUT_FILENAME=$(basename "$INPUT_ABSOLUTE")

# Check if file exists
if [ ! -f "$INPUT_ABSOLUTE" ]; then
    echo "Error: File '$INPUT_ABSOLUTE' does not exist"
    exit 1
fi

# Run the container with the directory mounted and execute the file from /workspace/
"$SCRIPT_DIR/../jetson-cross-toolchain-docker/run_container.sh" --args "-v $INPUT_DIR:/workspace" --exec "qemu-aarch64-static -L /l4t/targetfs/usr /workspace/$INPUT_FILENAME"