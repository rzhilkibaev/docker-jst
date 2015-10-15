#!/usr/bin/env bash
# this is a docker entrypoint script

set -e
set -o pipefail

if [ "$1" = 'shell' ]; then
    /bin/bash
else
    # install jst
    echo "Installing jst..."
    wget -nv https://github.com/rzhilkibaev/jst/raw/master/jst/jst -O /usr/local/bin/jst 2>&1
    chmod +x /usr/local/bin/jst

    # create working directory
    mkdir -p /opt/jrs
    cd /opt/jrs

    # run jst
    jst $@ --env=ci
fi

