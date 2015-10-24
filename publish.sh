#!/usr/bin/env bash

set -e

commit_message=${1}

if [ -z "$commit_message" ]; then
    echo "We need a commit message"
    exit 1
fi

echo "= Build the site ="
jekyll build

(
    echo "= Commit and push to website ="
    cd _site
    git add -A .
    git commit -m "${commit_message}"
    git push
)

echo "= Commit and push to project  ="
git add -A .
git commit -m "${commit_message}"
git push

