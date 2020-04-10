#!/bin/sh
# Publish landing site to gh-pages branch
# Source: https://gohugo.io/hosting-and-deployment/hosting-on-github/#put-it-into-a-script-1

if [ "$(git status -s)" ]; then
  echo "The working directory is dirty. Please commit any pending changes."
  exit 1;
fi

site="sites/landing"
branch="gh-pages"

echo "Deleting old publication..."
rm -rf "${site}/dist"
mkdir "${site}/dist"
git worktree prune
rm -rf .git/worktrees/dist/

echo "Checking out gh-pages branch into site dist..."
git worktree add -B "${branch}" "${site}/dist" "origin/${branch}"

echo "Removing existing files..."
rm -rf "${site}/dist*"

echo "Generating site..."
cd "${site}" && npm run build

echo "Commiting changes to gh-pages branch..."
cd dist && git add --all && git commit -m "Publish to gh-pages (publish.sh)"

echo "Pushing gh-pages branch..."
git push
