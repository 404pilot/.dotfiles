#!/bin/bash
# set -x
set -euo pipefail

latest_file=$(find -E $HOME/Downloads/Downloads-Edge -type f -regex ".*\.(log|out)" -print0 | xargs -0 ls -t | head -1)

open "$latest_file"
