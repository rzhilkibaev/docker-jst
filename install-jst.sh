#!/usr/bin/env bash
set -e

wget -nv https://github.com/rzhilkibaev/jst/raw/master/jst/jst -O /home/jst/bin/jst 2>&1
chmod +x /home/jst/bin/jst
