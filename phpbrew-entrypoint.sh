#!/bin/bash
set -e

export PHPBREW_SET_PROMPT=1
source /root/.phpbrew/bashrc
phpbrew switch 7.2.3
php --version

exec "$@"