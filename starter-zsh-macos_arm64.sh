#!/bin/bash

# Set up directories
INSTALL_DIR="$HOME/bin"
TEMP_DIR="$HOME/tmp"
NEOVIM_DIR="$HOME/neovim"
NODEJS_DIR="$HOME/nodejs"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
TMUX_CONFIG_DIR="$HOME/.tmux"
TMUX_CONF="$HOME/.tmux.conf"
TMUX_CONF_LOCAL="$HOME/.tmux.conf.local"

# URLs for tools
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-macos-arm64.tar.gz"
NODEJS_URL="https://nodejs.org/dist/v22.14.0/node-v22.14.0-darwin-arm64.tar.gz"
FD_URL="https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-apple-darwin.tar.gz"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-aarch64-apple-darwin.tar.gz"
FZF_URL="https://github.com/junegunn/fzf/releases/download/v0.60.1/fzf-0.60.1-darwin_amd64.tar.gz"
LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/download/v0.46.0/lazygit_0.46.0_Darwin_arm64.tar.gz"

# Configuration repositories
NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
OHMYTMUX_REPO="https://github.com/yilinfang/.tmux.git"

# Create necessary directories if they do not exist
mkdir -p "$INSTALL_DIR"
mkdir -p "$TEMP_DIR"
mkdir -p "$NEOVIM_DIR"
mkdir -p "$NODEJS_DIR"

# Download and install Neovim
echo "Downloading Neovim..."
curl -L "$NEOVIM_URL" -o "$TEMP_DIR/nvim.tar.gz"
echo "Extracting Neovim..."
tar -xzf "$TEMP_DIR/nvim.tar.gz" -C "$NEOVIM_DIR" --strip-components=1
ln -sf "$NEOVIM_DIR/bin/nvim" "$INSTALL_DIR/nvim"

# Download and install Node.js
echo "Downloading Node.js..."
curl -L "$NODEJS_URL" -o "$TEMP_DIR/node.tar.gz"
echo "Extracting Node.js..."
tar -xzf "$TEMP_DIR/node.tar.gz" -C "$NODEJS_DIR" --strip-components=1
ln -sf "$NODEJS_DIR/bin/node" "$INSTALL_DIR/node"
ln -sf "$NODEJS_DIR/bin/npm" "$INSTALL_DIR/npm"
ln -sf "$NODEJS_DIR/bin/npx" "$INSTALL_DIR/npx"

# Download and install fd
echo "Downloading fd..."
curl -L "$FD_URL" -o "$TEMP_DIR/fd.tar.gz"
echo "Extracting fd..."
tar -xzf "$TEMP_DIR/fd.tar.gz" -C "$TEMP_DIR"
FD_BINARY=$(find "$TEMP_DIR" -type f -name "fd" | head -n 1)
if [ -n "$FD_BINARY" ]; then
  mv "$FD_BINARY" "$INSTALL_DIR/fd"
else
  echo "Error: fd binary not found in the extracted files."
fi

# Download and install ripgrep
echo "Downloading ripgrep..."
curl -L "$RG_URL" -o "$TEMP_DIR/rg.tar.gz"
echo "Extracting ripgrep..."
tar -xzf "$TEMP_DIR/rg.tar.gz" -C "$TEMP_DIR"
RG_BINARY=$(find "$TEMP_DIR" -type f -name "rg" | head -n 1)
if [ -n "$RG_BINARY" ]; then
  mv "$RG_BINARY" "$INSTALL_DIR/rg"
else
  echo "Error: ripgrep binary not found in the extracted files."
fi

# Download and install fzf
echo "Downloading fzf..."
curl -L "$FZF_URL" -o "$TEMP_DIR/fzf.tar.gz"
echo "Extracting fzf..."
tar -xzf "$TEMP_DIR/fzf.tar.gz" -C "$TEMP_DIR"
mv "$TEMP_DIR/fzf" "$INSTALL_DIR/fzf"

# Download and install lazygit
echo "Downloading lazygit..."
curl -L "$LAZYGIT_URL" -o "$TEMP_DIR/lazygit.tar.gz"
echo "Extracting lazygit..."
tar -xzf "$TEMP_DIR/lazygit.tar.gz" -C "$TEMP_DIR"
mv "$TEMP_DIR/lazygit" "$INSTALL_DIR/lazygit"

# Clone or update Neovim configuration
if [ -d "$NVIM_CONFIG_DIR" ]; then
  if [ -d "$NVIM_CONFIG_DIR/.git" ]; then
    echo "Updating existing Neovim configuration..."
    git -C "$NVIM_CONFIG_DIR" pull --ff-only || echo "Failed to update Neovim configuration. Resolve conflicts manually."
  else
    echo "Directory $NVIM_CONFIG_DIR exists but is not a Git repository. Backing it up..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.bak.$(date +%s)"
    echo "Cloning Neovim configuration..."
    git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"
  fi
else
  echo "Cloning Neovim configuration..."
  git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"
fi

# Clone or update Oh My Tmux configuration
if [ -d "$TMUX_CONFIG_DIR" ]; then
  if [ -d "$TMUX_CONFIG_DIR/.git" ]; then
    echo "Updating existing Tmux configuration..."
    git -C "$TMUX_CONFIG_DIR" pull --ff-only || echo "Failed to update Tmux configuration. Resolve conflicts manually."
  else
    echo "Directory $TMUX_CONFIG_DIR exists but is not a Git repository. Backing it up..."
    mv "$TMUX_CONFIG_DIR" "$TMUX_CONFIG_DIR.bak.$(date +%s)"
    echo "Cloning Tmux configuration..."
    git clone "$OHMYTMUX_REPO" "$TMUX_CONFIG_DIR"
  fi
else
  echo "Cloning Tmux configuration..."
  git clone "$OHMYTMUX_REPO" "$TMUX_CONFIG_DIR"
fi

# Create symbolic links for Tmux configuration
echo "Creating symbolic links for Tmux configuration..."

# Handle .tmux.conf
if [ -L "$TMUX_CONF" ]; then
  rm "$TMUX_CONF"
elif [ -f "$TMUX_CONF" ]; then
  mv "$TMUX_CONF" "$TMUX_CONF.bak.$(date +%s)"
fi
ln -s "$TMUX_CONFIG_DIR/.tmux.conf" "$TMUX_CONF"

# Handle .tmux.conf.local
if [ -L "$TMUX_CONF_LOCAL" ]; then
  rm "$TMUX_CONF_LOCAL"
elif [ -f "$TMUX_CONF_LOCAL" ]; then
  mv "$TMUX_CONF_LOCAL" "$TMUX_CONF_LOCAL.bak.$(date +%s)"
fi
ln -s "$TMUX_CONFIG_DIR/.tmux.conf.local" "$TMUX_CONF_LOCAL"

# Add local bin directory to PATH
# Check for both .zshrc (default in newer macOS) and .bashrc
if [ -f "$HOME/.zshrc" ]; then
  if ! grep -q "export PATH=\$HOME/bin:\$PATH" "$HOME/.zshrc"; then
    echo 'export PATH=$HOME/bin:$PATH' >>"$HOME/.zshrc"
  fi
  if ! grep -q "source <(fzf --zsh)" "$HOME/.zshrc"; then
    echo 'source <(fzf --zsh)' >>"$HOME/.zshrc"
  fi
fi

if [ -f "$HOME/.bashrc" ]; then
  if ! grep -q "export PATH=\$HOME/bin:\$PATH" "$HOME/.bashrc"; then
    echo 'export PATH=$HOME/bin:$PATH' >>"$HOME/.bashrc"
  fi
  if ! grep -q "eval \"\$(fzf --bash)\"" "$HOME/.bashrc"; then
    echo '# Set up fzf key bindings and fuzzy completion' >>"$HOME/.bashrc"
    echo 'eval "$(fzf --bash)"' >>"$HOME/.bashrc"
  fi
fi

# Clean up temporary files
rm -rf "$TEMP_DIR"

# Inform the user
echo "Installation complete!"
echo "Please run 'source ~/.zshrc' (or 'source ~/.bashrc' if using bash) or restart your shell to update the PATH."
