#!/usr/bin/env bash

# This script removes sensitive configuration files.

for encypted_file in $(chezmoi managed --include encrypted --path-style absolute); do
	rm -rf "$encypted_file"
done
