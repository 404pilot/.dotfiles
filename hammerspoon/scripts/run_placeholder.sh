#!/bin/bash
# set -x
set -euo pipefail

# get select text
placeholder=$(pbpaste)

# search
open "https://www.google.com/search?q=$placeholder"
