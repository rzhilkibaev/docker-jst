#!/usr/bin/env bash
# this is a docker entrypoint script

set -e
set -o pipefail

# install jst
echo "Installing jst..."
wget -q https://github.com/rzhilkibaev/jst/raw/master/jst/jst -O /usr/local/bin/jst
chmod +x /usr/local/bin/jst

# create working directory
mkdir /opt/jrs
cd /opt/jrs

# run jst
jst $@ --env=ci
