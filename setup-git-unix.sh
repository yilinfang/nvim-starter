git config --global init.defaultBranch main

git config --global user.name "Yilin Fang"
git config --global user.email "qzfyl98@outlook.com"

git config --global alias.a "add"
git config --global alias.c "checkout"
git config --global alias.m "merge"
git config --global alias.aa "add -A"
git config --global alias.cb "checkout -b"
git config --global alias.ci "commit"
git config --global alias.cm "commit -m"
git config --global alias.st "status"
git config --global alias.pl "pull"
git config --global alias.ph "push"

# If difft is installed, set some aliases for it
if command -v difft &>/dev/null; then
    git config --global alias.dl "-c diff.external=difft log -p --ext-diff"
    git config --global alias.ds "-c diff.external=difft show --ext-diff"
    git config --global alias.dft "-c diff.external=difft diff"
fi

# If delta is installed, set it as pager
if command -v delta &>/dev/null; then
    git config --global core.pager "delta"
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate "true"
fi

# Set zdiff3 for merge conflicts (available in Git 2.35.0+)
git config --global merge.conflictStyle "zdiff3"
