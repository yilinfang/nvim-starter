#!/usr/bin/env bash

# This script is used to do some patching for the Solarized Dark (or related) theme.

PREFIX="$HOME/.pde"
INSTALL_DIR="$PREFIX/bin"

# Define blocks with unique marker comments
FISH_PATCH_BLOCK="
# --- solarized-dark-patch BEGIN ---
# Set BAT_THEME if bat is installed
if test -f \"$INSTALL_DIR/bat\"
  set -gx BAT_THEME \"Solarized (dark)\"
end

# Set DFT_BACKGROUND to light if difft is installed
# Fix color issue with difft when using the solarized-dark-based theme
if test -f \"$INSTALL_DIR/difft\"
  set -gx DFT_BACKGROUND light
end
# --- solarized-dark-patch END ---
"

SH_PATCH_BLOCK="
# --- solarized-dark-patch BEGIN ---
# Set BAT_THEME for bat if installed
if [ -f \"$INSTALL_DIR/bat\" ]; then
  export BAT_THEME=\"Solarized (dark)\"
fi

# Set DFT_BACKGROUND to light if difft is installed
# Fix color issue with difft when using the solarized-dark-based theme
if [ -f \"$INSTALL_DIR/difft\" ]; then
  export DFT_BACKGROUND=\"light\"
fi
# --- solarized-dark-patch END ---
"

# For init.fish
if [ -f "$PREFIX/init.fish" ]; then
  if ! grep -q 'solarized-dark-patch BEGIN' "$PREFIX/init.fish"; then
    printf "%s\n" "$FISH_PATCH_BLOCK" >>"$PREFIX/init.fish"
  fi
fi

# For init.sh
if [ -f "$PREFIX/init.sh" ]; then
  if ! grep -q 'solarized-dark-patch BEGIN' "$PREFIX/init.sh"; then
    printf "%s\n" "$SH_PATCH_BLOCK" >>"$PREFIX/init.sh"
  fi
fi
