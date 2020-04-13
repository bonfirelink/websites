#!/bin/sh
# Publish site to distribution branch
# Source: https://gohugo.io/hosting-and-deployment/hosting-on-github/#put-it-into-a-script-1

set -e

usage() {
  progname=$(basename "$0")
  echo "usage: ${progname} [-n] site"
  echo "  -n  Dry run, not pushing distribution branch to remote."
}

publish_site() {
  site_name="$1"
  dry_run="$2"

  site_path="sites/${site_name}"
  site_branch="dist/${site_name}"
  git_ref=$(git rev-parse --short=7 HEAD)

  echo "Deleting old static site files..."
  rm -rf "${site_path}/dist"
  mkdir "${site_path}/dist"
  git worktree prune
  rm -rf .git/worktrees/dist/

  echo "Verifying distribution branch is set up"
  init_dist_branch "${site_branch}"

  echo "Checking out distribution branch into site dist directory..."
  git worktree add -B "${site_branch}" "${site_path}/dist" "origin/${site_branch}"

  echo "Removing existing files..."
  rm -rf "${site_path}/dist/*"

  echo "Building static site..."
  make build site="${site_name}"

  echo "Committing and tagging static site..."
  cd "${site_path}/dist"
  git add --all
  # Commit only if there are changes, otherwise `git commit` exits with 1 and stops the show
  git diff-index --quiet HEAD || git commit -m "Publish ${site_name} site from ${git_ref}"
  # TODO: Adapt this when introducing versioning, reusing for now the same tag
  git tag --force -m 'Mysterious transformations' "${site_name}/v1.0.0-latest"

  if [ ! "${dry_run}" = true ]; then
    echo "Pushing branch and tag to remote..."
    git push --tags --force
  fi
}

init_dist_branch() {
  branch="$1"
  remote='origin'
  prev_branch=$(git rev-parse --abbrev-ref HEAD)

  # Do nothing if remote branch exists
  git fetch ${remote}
  if git rev-parse --verify "${remote}/${branch}" >/dev/null 2>&1; then
    return
  fi

  # Fail if local branch exists to prevent destroying useful stuff
  if git rev-parse --verify "${branch}" >/dev/null 2>&1; then
    echo "error: local branch ${branch} already exists"
    exit 1
  fi

  # Create orphan branch locally and push it to remotes
  git checkout --orphan "${branch}"
  git reset --hard
  git commit --allow-empty -m "Initialize distribution branch"
  git push ${remote} "${branch}"
  git checkout "${prev_branch}"
}

# Validate argument length
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  usage
  exit 1
fi

# Validate options
if [ $# -eq 2 ]; then
  case "$1" in
    -n)
      dry_run=true
      shift;;
    *)
      usage
      exit 1;;
  esac
fi

# Prevent losing changes locally (git reset --hard!)
if ! git diff --quiet; then
  echo "The working directory is dirty. Please commit or stash all your changes."
  exit 1;
fi

# Prevent building partial sites
if [ "$1" = '.common' ]; then
  echo "error: site .common cannot be published"
  exit 1
fi

if [ ! -d "sites/$1" ]; then
  echo "error: site $1 doesn't exist"
  exit 1
fi

publish_site "$1" "${dry_run}"
