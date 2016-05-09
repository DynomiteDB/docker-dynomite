#!/bin/bash
set -e

# allow the container to be started with `--user`
if [ "$1" = 'dynomite' -a "$(id -u)" = '0' ]; then
    mkdir -p /var/run/dynomitedb
    chown -R dynomite:dynomite /etc/dynomitedb/ /var/run/dynomitedb/ /usr/local/dynomitedb/
    exec gosu dynomite:dynomite "$BASH_SOURCE" "$@"
fi

exec "$@"
