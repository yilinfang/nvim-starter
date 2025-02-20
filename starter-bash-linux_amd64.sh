#!/bin/bash

# Set up directories
INSTALL_DIR="$HOME/bin"
TEMP_DIR="$HOME/tmp"
NEOVIM_DIR="$HOME/neovim"
NODEJS_DIR="$HOME/nodejs"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"

# URLs for tools
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz"
NODEJS_URL="https://nodejs.org/dist/v22.14.0/node-v22.14.0-linux-x64.tar.xz"
ZELLIJ_URL="https://github.com/zellij-org/zellij/releases/download/v0.41.2/zellij-x86_64-unknown-linux-musl.tar.gz"
FD_URL="https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz"
FZF_URL="https://github.com/junegunn/fzf/releases/download/v0.60.1/fzf-0.60.1-linux_amd64.tar.gz"
LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/download/v0.46.0/lazygit_0.46.0_Linux_x86_64.tar.gz"

# Configuration repositories
NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
ZELLIJ_CONFIG_REPO="https://github.com/yilinfang/zellij.git"

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
curl -L "$NODEJS_URL" -o "$TEMP_DIR/node.tar.xz"
echo "Extracting Node.js..."
tar -xf "$TEMP_DIR/node.tar.xz" -C "$NODEJS_DIR" --strip-components=1
ln -sf "$NODEJS_DIR/bin/node" "$INSTALL_DIR/node"
ln -sf "$NODEJS_DIR/bin/npm" "$INSTALL_DIR/npm"
ln -sf "$NODEJS_DIR/bin/npx" "$INSTALL_DIR/npx"

# Download and install Zellij
echo "Downloading Zellij..."
curl -L "$ZELLIJ_URL" -o "$TEMP_DIR/zellij.tar.gz"
echo "Extracting Zellij..."
tar -xzf "$TEMP_DIR/zellij.tar.gz" -C "$TEMP_DIR"
mv "$TEMP_DIR/zellij" "$INSTALL_DIR/zellij"

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

# Clone or update Zellij configuration
if [ -d "$ZELLIJ_CONFIG_DIR" ]; then
    if [ -d "$ZELLIJ_CONFIG_DIR/.git" ]; then
        echo "Updating existing Zellij configuration..."
        git -C "$ZELLIJ_CONFIG_DIR" pull --ff-only || echo "Failed to update Zellij configuration. Resolve conflicts manually."
    else
        echo "Directory $ZELLIJ_CONFIG_DIR exists but is not a Git repository. Backing it up..."
        mv "$ZELLIJ_CONFIG_DIR" "$ZELLIJ_CONFIG_DIR.bak.$(date +%s)"
        echo "Cloning Zellij configuration..."
        git clone "$ZELLIJ_CONFIG_REPO" "$ZELLIJ_CONFIG_DIR"
    fi
else
    echo "Cloning Zellij configuration..."
    git clone "$ZELLIJ_CONFIG_REPO" "$ZELLIJ_CONFIG_DIR"
fi

# Add local bin directory to PATH
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "export PATH=\$HOME/bin:\$PATH" "$HOME/.bashrc"; then
        echo 'export PATH=$HOME/bin:$PATH' >> "$HOME/.bashrc"
    fi
fi

# Clean up temporary files
rm -rf "$TEMP_DIR"

# Inform the user
echo "Installation complete!"
echo "Please run 'source ~/.bashrc' or restart your shell to update the PATH."
