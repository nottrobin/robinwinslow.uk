#!/usr/bin/env bash

set -e

commit_message=${1}

if [ -z "$commit_message" ]; then
    echo "We need a commit message"
    exit 1
fi

# First commit the actual site
jekyll build
(
    cd _site
    git add -A .
    git commit -m "${commit_message}"
    git push
)

# Now commit to project
git add -A .
git commit -m "${commit_message}"
git push

