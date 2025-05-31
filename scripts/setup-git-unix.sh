#!/usr/bin/env bash

# Function to compare versions
version_ge() {
  # Returns 0 if $1 >= $2
  [ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]
}

# Get Git version
GIT_VERSION=$(git --version | awk '{print $3}')

# User information
git config --global user.name "Yilin Fang"
git config --global user.email "qzfyl98@outlook.com"

# Init
git config --global init.defaultBranch main

# Alias
git config --global alias.a add
git config --global alias.c checkout
git config --global alias.m merge
git config --global alias.aa "add -A"
git config --global alias.cb "checkout -b"
git config --global alias.ci commit
git config --global alias.cm "commit -m"
git config --global alias.st status
git config --global alias.mt mergetool
git config --global alias.pl pull
git config --global alias.ph push
git config --global alias.dl "-c diff.external=difft log -p --ext-diff"
git config --global alias.ds "-c diff.external=difft show --ext-diff"
git config --global alias.dft "-c diff.external=difft diff"

# Core
git config --global core.pager delta

# Interactive
git config --global interactive.diffFilter "delta --color-only"

# Delta
git config --global delta.navigate true

# Merge conflict style
if version_ge "$GIT_VERSION" "2.35.0"; then
  git config --global merge.conflictStyle zdiff3
else
  git config --global merge.conflictStyle diff3
  echo "Warning: zdiff3 conflict style is not supported in Git versions older than 2.35.0. Using diff3 instead."
fi

# Merge tool
git config --global merge.tool nvim

# Mergetool
git config --global mergetool.prompt false
git config --global mergetool.keepBackup false

# Mergetool nvim
git config --global mergetool.nvim.cmd 'nvim -d "$LOCAL" "$MERGED" "$REMOTE"'
git config --global mergetool.nvim.trustExitCode false
