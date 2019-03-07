#!/bin/sh
# From https://gist.github.com/jdelStrother/1042552/258bd00e2d5a1bf4efa7c38f1568a57fb3ec2113
# Auto-applies changes from the index to a previous commit
# eg 
#   git add foo
#   git autofix HEAD~3

target="$(git rev-parse $1)"
dirty="$(git diff --name-only --exit-code HEAD)"

git commit --fixup=$target && 
  ( test -z "$dirty" || git stash ) &&
  GIT_EDITOR=cat git rebase --interactive --autosquash $target~1 &&
  ( test -z "$dirty" || git stash pop )
