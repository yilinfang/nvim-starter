#!/usr/bin/env bash

# Add [user] section
git config --global user.name "Yilin Fang"
git config --global user.email "qzfyl98@outlook.com"

# Add [alias] section
git config --global alias.a "add"
git config --global alias.c "checkout"
git config --global alias.m "merge"
git config --global alias.aa "add -A"
git config --global alias.cb "checkout -b"
git config --global alias.ci "commit"
git config --global alias.cm "commit -m"
git config --global alias.st "status"
git config --global alias.p "pull"
git config --global alias.P "push"
git config --global alias.dl "-c diff.external=difft log -p --ext-diff"
git config --global alias.ds "-c diff.external=difft show --ext-diff"
git config --global alias.dft "-c diff.external=difft diff"

# Add [core] section
git config --global core.pager "delta"

# Add [interactive] section
git config --global interactive.diffFilter "delta --color-only"

# Add [delta] section
git config --global delta.navigate "true"

# Add [merge] section
git config --global merge.conflictStyle "zdiff3"

echo "Git configuration set up successfully."
