#!/bin/sh
set -e

LIST_FILE=$1

if [ ! -f "$LIST_FILE" ]; then
    echo "Error: $LIST_FILE not found."
    exit 1
fi

mkdir -p plugins/

while IFS=, read -r repo bin_name || [ -n "$repo" ]; do
    # Skip blank / comment lines
    case "$repo" in
        "#"*) continue ;;
        "") continue ;;
    esac

    # Parse repository name
    repo_name=$(basename "$repo" .git)

    # Set default bin_name
    if [ -z "$bin_name" ]; then
        bin_name="$repo_name"
    fi

    # Build plugins
    git clone --depth 1 "$repo"
    cd "$repo_name"
    echo go build -o "../plugins/$bin_name"
    go build -o "../plugins/$bin_name"

    # Clean up
    cd ..
    rm -rf "$repo_name"
done < "$LIST_FILE"
