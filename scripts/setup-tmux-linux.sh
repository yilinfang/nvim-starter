#!/usr/bin/env bash

# This script is used to install tmux in Linux.

set -e # Exit on error

PREFIX="$HOME/.pde"
INSTALL_DIR="$PREFIX/bin"
TEMP_DIR="$PREFIX/tmp"
TMUX_DIR="$PREFIX/tmux"

TMUX_URL="https://github.com/yilinfang/static-tmux-builder/releases/download/3.5a/tmux-static-musl.tar.gz"

# Create necessary directories
mkdir -p "$INSTALL_DIR" "$TMUX_DIR"

install_tmux() {
  echo "Installing tmux..."
  rm -rf "$TMUX_DIR"
  mkdir -p "$TMUX_DIR"
  curl -L "$TMUX_URL" -o "$TEMP_DIR/tmux.tar.gz"
  tar -xzf "$TEMP_DIR/tmux.tar.gz" -C "$TMUX_DIR"
  TMUX_BINARY=$(find "$TMUX_DIR" -type f -name "tmux" | head -n 1)
  if [ -n "$TMUX_BINARY" ]; then
    # Create a symbolic link to the tmux binary
    ln -sf "$TMUX_BINARY" "$INSTALL_DIR/tmux"
    echo "tmux installed successfully at $INSTALL_DIR/tmux"
  else
    echo "Failed to find tmux binary in the extracted files."
    exit 1
  fi
}

main() {
  install_tmux

  # Clean up temporary files
  rm -rf "$TEMP_DIR"
}

main "$@"
