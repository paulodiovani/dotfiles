#!/bin/bash

# Update jekyll site published on GitHubPages to allow
# scheduled posts.
#
# You must have added you public ssh key to your GitHub account.
# See https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
#
# Usage:
# GHUSER=paulodiovani REPOS=blog.diovani.com BRANCH=master refresh-blog.sh
#
# Env vars:
# GHUSER  GitHub username
# REPOS   repository name to clone from and then push to
# BRANCH  branch where to push to, usually gh-pages

GHUSER=${GHUSER:-$USER}
REPOS=${REPOS:-blog}
BRANCH=${BRANCH:-gh-pages}
URL="git@github.com:$GHUSER/$REPOS.git"
TIMESTAMP=$(printf "%x\n" $(date +%s%N | cut -b1-13))

pushd /tmp && \
git clone -b "$BRANCH" --depth=1 "$URL" "$REPOS.$TIMESTAMP" && \
pushd "$REPOS.$TIMESTAMP" && \
git commit --allow-empty -m "Daily site refresh for $(date --utc)" && \
git push && \
popd && \
popd
