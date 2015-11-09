#!/usr/bin/env bash
# this is a docker entrypoint script

set -e
set -o pipefail

if [ "$1" = 'shell' ]; then
    exec /bin/bash
else
    echo "Installing jst..."
    . /home/jst/install-jst.sh

    exec jst "$@" --env=ci --verbose
fi
