#!/bin/bash

# TODO: if HEAD is attached, get the branch name.
# Otherwise get the commit hash.
# https://stackoverflow.com/questions/6245570/how-do-i-get-the-current-branch-name-in-git

ignore_errors=0
if [ "$3" -eq "-i" ]; then
    ignore_errors=1
fi


original_commit=$(git rev-parse HEAD)

git rev-list --reverse "$1".."$2" | while read -r commit; do
    echo $commit
    git checkout $commit
    git hook run pre-commit
    status=$?
    if [ ! $status -eq 0 ]; then
        echo "ERROR on commit $commit"
        if [ ! $ignore_errors ]; then
            exit $status
        fi
    fi
done

git checkout $original_commit
