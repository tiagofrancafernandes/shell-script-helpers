#!/bin/bash
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ -z $1 ]; then
    echo -e "
    Target dir is not set!
    
    Use:
    ./listen_change.sh /dir/to/watch/changes/
    ";
    exit 0;
fi

if [ -d $1 ]; then
    while true; do
        SLEEP_TIME=2
        inotifywait -e modify,create,delete,move -r $1 && \
        sleep $SLEEP_TIME && \
        $SCRIPTPATH/sync.sh
    done
fi
