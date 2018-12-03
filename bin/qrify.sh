#!/bin/bash

set -e
progname=$(basename $0)

_usage() {
  echo "usage: ${progname} string [outname]"
  echo "  string   String to encode in the QR code"
  echo "  outname  Name of the output file (default=qrcode) "
}

# Check arguments
[ $# -lt 1 ] && _usage && exit 1

# Vars
string="$1"
[ $# -eq 2 ] && outname="$2" || outname=qrcode

# Encode!
qrencode \
  --output "${outname}.svg" \
  --type SVG \
  --margin 0 \
  --foreground 2e2e3a \
  --background ffffff00 \
  "${string}"
