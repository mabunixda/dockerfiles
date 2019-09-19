#!/bin/bash

if [ -z "$CI" ]; then
  exit 0
fi
for d in $(git diff-tree --no-commit-id --name-only -r $BITBUCKET_COMMIT | xargs dirname | sort | uniq); do
  if [ -f "${d}/Dockerfile" ]; then
    ./build_all.sh dofile "${d}/Dockerfile"
  fi
done
