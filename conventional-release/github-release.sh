#!/bin/bash

# Specify the path to your changelog file
changelog_file="CHANGELOG.md"

# Get the latest version from git tags
latest_version=$(git describe --tags --abbrev=0 | sed 's/^v//')

# Get the details of the last release
release_details=$(awk -v ver="$latest_version" '/^## /{if (f) exit; else f=1} f{print} $0 ~ "^## " ver{f=1}' "$changelog_file")

echo "$release_details" >RELEASE.md
gh release create v$latest_version --notes-file RELEASE.md

echo $release_details
