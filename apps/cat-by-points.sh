#!/bin/bash

cat_by_points ()
{
	local FILE=$1
	local START=${2:-1}
	local DEFAULT_END="$(($START+5))"
	local END=${3:-$DEFAULT_END}

	if [ ! "$FILE" ]; then
		echo "error: Please, enter a valid file";
		exit 2;
	fi

	regex_num='^[0-9]+$'

	if ! [[ $START =~ $regex_num ]] ; then
		echo "error: START Line is not a number" >&2; exit 1
	fi

	if ! [[ $END =~ $regex_num ]] ; then
		echo "error: END Line is not a number" >&2; exit 1
	fi

	if [ $END -le -1 ]; then
		echo "error: The END Line need be a posive value";
		exit 3;
	fi

	if [ $START -le -1 ]; then
		echo "error: The START Line need be a posive value";
		exit 3;
	fi

	if [ -f $FILE ]; then
		awk "NR < $START { next } { print } NR == $END { exit }" "$FILE"
	else
		echo "error: File '$FILE' not found!";
	exit 2
	fi

}

cat_by_points "$@"
