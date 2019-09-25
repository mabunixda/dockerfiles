#!/bin/bash

if [ -z "$CI" ]; then
  exit 0
fi

for d in $(for f in $(git diff-tree --no-commit-id --name-only -r $BITBUCKET_COMMIT); do echo $(dirname $f); done | sort | uniq ); do
  if [ -f "${d}/Dockerfile" ]; then
    ./build_all.sh dofile "${d}/Dockerfile"
  fi
done
