#!/bin/bash

is_number()
{
  number=$1
  re='^[0-9]+$'
  if [[ $number =~ $re ]]; then
    echo 1
  else
    echo 0
  fi
}

## Function to 'go to line' on nano
__nano_go()
{
  ## PS: The param '-P or --positionlog' preserve the last positionlog of the file.

  ## Example of a env NANO_PARAMS
  ## Add the below line to ~/.bashrc file or custom params to Nano editor
  ## export NANO_PARAMS='-$ -T 2 -l -y -P -e -A -i'

  NANO_AS_SUDO=${NANO_AS_SUDO:-no}

  if [ $NANO_AS_SUDO = 'yes' ]; then
    local _sp='----------------------------'
    echo -e "$_sp\n| ! Runing as root user ! |\n$_sp\n"
    sleep 0.5

    NANO_RUN="sudo $(which nano) $NANO_PARAMS"
  else
    NANO_RUN="$(which nano) $NANO_PARAMS"
  fi

  str=$1
  file=${str%%:*}
  file=${file:-'nofile'}

  if [ $file = 'nofile' ]; then
    echo -e "Error: please enter a valid file!"
    return
  fi

  if ! [ -f $file ]; then
    echo -e "Error:\nThe file \"$file\" not exists!\nA new file will be created."
    $NANO_RUN $file
    return
  fi

  line=${str#*:}

  if ! [ $(is_number $line) = '1' ]; then
    line=1

    ## PS: The param '-P or --positionlog' preserve the last positionlog of the file.
    has_positionlog=$(echo $NANO_PARAMS | grep -E '(P|positionlog)' | wc -l)

    if ! [ has_positionlog = '0' ]; then
      $NANO_RUN $file
      return
    fi

  fi

  $NANO_RUN +$line $file
}

## Aliases to __nano_go
go-nano()
{
  __nano_go $@;
}

go-nano-sudo()
{
  local NANO_AS_SUDO="yes"
  __nano_go $@
}

__go_nano_aliases()
{
  if [[ -z $NANO_PARAMS ]]; then
    NANO_PARAMS='-$ -T 2 -l -y -P -e -A -i'
  fi

  alias nano_go=__nano_go
  alias nano-go=__nano_go
  alias snano='NANO_AS_SUDO="yes"; __nano_go'
  alias nano-bin='$(which nano)'
  alias snano-bin='sudo $(which nano)'
}

###### Running this file via CLI
if ! [ -z $1 ]; then
  if [ "$EUID" -ne 0 ]; then
    go-nano $@
  else
    go-nano-sudo $@
  fi
fi
