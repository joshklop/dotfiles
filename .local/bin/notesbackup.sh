#!/bin/bash

GIT=$(which git)

cd "$HOME/repos/notes"

${GIT} add --all
${GIT} commit -m "Add notes"
${GIT} push

cd -
