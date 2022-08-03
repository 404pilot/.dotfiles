#!/bin/bash
# set -x
set -euo pipefail

# get select text
query=$(pbpaste)

# encode text

# search
open "https://aka.ms/AAhkwkl?type=code&text=%22${query}%22"
