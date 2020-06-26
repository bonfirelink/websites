#!/bin/sh
# Create a symlink to a .common site file

set -e

usage() {
  progname=$(basename "$0")
  echo "usage: ${progname} site file_path"
}

link() {
  site_name="$1"
  file_path="$2"
  link_path=$(echo "${file_path}" | sed "s/\.common/${site_name}/")
  link_dir=$(dirname "${link_path}")
  rel_path=$(realpath --relative-to="${link_dir}" "${file_path}")
  ln -sv "${rel_path}" "${link_path}"
}

# Validate argument length
if [ $# -ne 2 ]; then
  usage
  exit 1
fi

# Prevent creating symlinks in .common
if [ "$1" = '.common' ]; then
  echo "error: symbolic link cannot be created for '.common' site"
  exit 1
fi

if [ ! -d "sites/$1" ]; then
  echo "error: site '$1' doesn't exist"
  exit 1
fi

if ! echo "$2" | grep -qe '^sites\/\.common/'; then
  echo "error: the file path must be contained in 'sites/.common/'"
  exit 1
fi

if [ ! -f "$2" ]; then
  echo "error: $2 is not a file"
  exit 1
fi

link "$1" "$2"
