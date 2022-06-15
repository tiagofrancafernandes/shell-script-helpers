#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ -z $1 ]; then
	CONFIG_FILE=$SCRIPTPATH/sync_settings.sh;
else
	CONFIG_FILE=$1;
fi

if [ -f "$CONFIG_FILE" ]; then

	#load config file
	source $CONFIG_FILE;

	if [[ ! -z $SYNC_SSH && $SYNC_SSH == 'yes' ]]; then
		rsync -4 -t -h -z -r --delete-excluded --rsh="ssh -p$SYNC_SSH_PORT" $SYNC_SOURCE $SYNC_TARGET
	else
		rsync -4 -t -h -z -r --delete-excluded $SYNC_SOURCE $SYNC_TARGET
	fi

else

echo -e "Config file dont found!
Add the file config as param.
Like:

./sync.sh /path/to/config.sh

To gen config file run:

echo '
SYNC_SSH=\"no\" #yes/no
SYNC_SSH_PORT=22
SYNC_SSH_KEY=\"./key.pem\"

#local or remote user@host;/target/on/server/
SYNC_SOURCE=\"/tmp/rsync/source/\"
SYNC_TARGET=\"/tmp/rsync/desk/\"

' > sync_settings.sh

";

fi
