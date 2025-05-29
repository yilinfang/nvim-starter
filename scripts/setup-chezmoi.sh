#!/usr/bin/env bash

# This script is used for setting up chezmoi on a new system.

set -e

PREFIX="$HOME/.pde"
INSTALL_DIR="$PREFIX/bin"
CHEZMOI_DIR="$PREFIX/chezmoi"

mkdir -p "$INSTALL_DIR"
mkdir -p "$CHEZMOI_DIR"

export INSTALL_TARGET_DIR="$CHEZMOI_DIR"
sh -c "curl -fsSL https://raw.githubusercontent.com/yilinfang/dotfiles/master/scripts/install.sh" | sh

ln -s "$CHEZMOI_DIR/chezmoi" "$INSTALL_DIR/chezmoi"
ln -s "$CHEZMOI_DIR/age" "$INSTALL_DIR/age"
ln -s "$CHEZMOI_DIR/age-keygen" "$INSTALL_DIR/age-keygen"
