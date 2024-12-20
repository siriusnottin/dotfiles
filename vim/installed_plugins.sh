#!/usr/bin/env bash
# Generate list of pathogen plugins.

BUNDLE_DIR=".vim/bundle"
README_FILE="README.md"

# Check if the bundle directory exists
if [ -d "$BUNDLE_DIR" ]; then
  # Update README.md with the list of plugins
  sed -i '' '/### List of plugins/,$d' "$README_FILE"
  {
    echo "### List of plugins"
    echo ""
    for plugin in "$BUNDLE_DIR"/*; do
      plugin_name=$(basename "$plugin")
      echo "- [$plugin_name](https://github.com/$plugin_name)"
    done
  } >>"$README_FILE"
  echo "README.md updated with the list of plugins"
else
  echo "Pathogen bundle directory not found: $BUNDLE_DIR"
fi
