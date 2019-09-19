#!/bin/bash

if [ -z "$CI" ]; then
  exit 0
fi
CHANGES=$(git diff-tree --no-commit-id --name-only -r $BITBUCKET_COMMIT | xargs dirname | sort | uniq)
for d in $( $CHANGES  ); do
  ./build_all.sh dofile "${d}/Dockerfile"
done
