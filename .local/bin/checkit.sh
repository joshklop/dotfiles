#!/bin/bash

# TODO: if HEAD is attached, get the branch name.
# Otherwise get the commit hash.
# https://stackoverflow.com/questions/6245570/how-do-i-get-the-current-branch-name-in-git

original_commit=$(git rev-parse HEAD)

root_dir=$(git rev-parse --show-toplevel)

git rev-list --reverse "$1".."$2" | while read -r commit; do
    echo $commit
    git checkout $commit
    "$root_dir"/.git/hooks/pre-commit
    if [ ! $? -eq 0 ]; then
        echo "ERROR on commit $commit"
        exit $status
    fi
done

git checkout $original_commit
