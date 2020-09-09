#!/bin/bash
# set -x
set -euo pipefail

AWS_CREDENTIALS_FILE="${HOME}/.aws/credentials"
AWS_CREDENTIALS_FILE_ORIGIN="${HOME}/.aws/credentials.origin"

cp $AWS_CREDENTIALS_FILE_ORIGIN $AWS_CREDENTIALS_FILE

pbpaste >> $AWS_CREDENTIALS_FILE

sed -i.bak -e '$d' $AWS_CREDENTIALS_FILE
