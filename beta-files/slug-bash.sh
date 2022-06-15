#!/bin/bash
##########################################
# Author: Tiago França <tiagofranca.com> #
# Date: Mai 24, 2021 03:28               #
##########################################


remove_special_characters()
{
	INPUT="$@"
	declare -a acc
	declare -a noa
	acc=('$' 'Ã¨' 'Ãª' 'Ã©' 'À' 'Á' 'Â' 'Ã' 'Ä' 'Å' 'Æ' 'Ç' 'È' 'É' 'Ê' 'Ë' 'Ì' 'Í' 'Î' 'Ï' 'Ð' 'Ñ' 'Ò' 'Ó' 'Ô' 'Õ' 'Ö' 'Ø' 'Ù' 'Ú' 'Û' 'Ü' 'Ý' 'ß' 'à' 'á' 'â' 'ã' 'ä' 'å' 'æ' 'ç' 'è' 'é' 'ê' 'ë' 'ì' 'í' 'î' 'ï' 'ñ' 'ò' 'ó' 'ô' 'õ' 'ö' 'ø' 'ù' 'ú' 'û' 'ü' 'ý' 'ÿ' 'Ā' 'ā' 'Ă' 'ă' 'Ą' 'ą' 'Ć' 'ć' 'Ĉ' 'ĉ' 'Ċ' 'ċ' 'Č' 'č' 'Ď' 'ď' 'Đ' 'đ' 'Ē' 'ē' 'Ĕ' 'ĕ' 'Ė' 'ė' 'Ę' 'ę' 'Ě' 'ě' 'Ĝ' 'ĝ' 'Ğ' 'ğ' 'Ġ' 'ġ' 'Ģ' 'ģ' 'Ĥ' 'ĥ' 'Ħ' 'ħ' 'Ĩ' 'ĩ' 'Ī' 'ī' 'Ĭ' 'ĭ' 'Į' 'į' 'İ' 'ı' 'Ĳ' 'ĳ' 'Ĵ' 'ĵ' 'Ķ' 'ķ' 'Ĺ' 'ĺ' 'Ļ' 'ļ' 'Ľ' 'ľ' 'Ŀ' 'ŀ' 'Ł' 'ł' 'Ń' 'ń' 'Ņ' 'ņ' 'Ň' 'ň' 'ŉ' 'Ō' 'ō' 'Ŏ' 'ŏ' 'Ő' 'ő' 'Œ' 'œ' 'Ŕ' 'ŕ' 'Ŗ' 'ŗ' 'Ř' 'ř' 'Ś' 'ś' 'Ŝ' 'ŝ' 'Ş' 'ş' 'Š' 'š' 'Ţ' 'ţ' 'Ť' 'ť' 'Ŧ' 'ŧ' 'Ũ' 'ũ' 'Ū' 'ū' 'Ŭ' 'ŭ' 'Ů' 'ů' 'Ű' 'ű' 'Ų' 'ų' 'Ŵ' 'ŵ' 'Ŷ' 'ŷ' 'Ÿ' 'Ź' 'ź' 'Ż' 'ż' 'Ž' 'ž' 'ſ' 'ƒ' 'Ơ' 'ơ' 'Ư' 'ư' 'Ǎ' 'ǎ' 'Ǐ' 'ǐ' 'Ǒ' 'ǒ' 'Ǔ' 'ǔ' 'Ǖ' 'ǖ' 'Ǘ' 'ǘ' 'Ǚ' 'ǚ' 'Ǜ' 'ǜ' 'Ǻ' 'ǻ' 'Ǽ' 'ǽ' 'Ǿ' 'ǿ');
	noa=('S' 'e' 'e' 'e' 'A' 'A' 'A' 'A' 'A' 'A' 'AE' 'C' 'E' 'E' 'E' 'E' 'I' 'I' 'I' 'I' 'D' 'N' 'O' 'O' 'O' 'O' 'O' 'O' 'U' 'U' 'U' 'U' 'Y' 's' 'a' 'a' 'a' 'a' 'a' 'a' 'ae' 'c' 'e' 'e' 'e' 'e' 'i' 'i' 'i' 'i' 'n' 'o' 'o' 'o' 'o' 'o' 'o' 'u' 'u' 'u' 'u' 'y' 'y' 'A' 'a' 'A' 'a' 'A' 'a' 'C' 'c' 'C' 'c' 'C' 'c' 'C' 'c' 'D' 'd' 'D' 'd' 'E' 'e' 'E' 'e' 'E' 'e' 'E' 'e' 'E' 'e' 'G' 'g' 'G' 'g' 'G' 'g' 'G' 'g' 'H' 'h' 'H' 'h' 'I' 'i' 'I' 'i' 'I' 'i' 'I' 'i' 'I' 'i' 'IJ' 'ij' 'J' 'j' 'K' 'k' 'L' 'l' 'L' 'l' 'L' 'l' 'L' 'l' 'l' 'l' 'N' 'n' 'N' 'n' 'N' 'n' 'n' 'O' 'o' 'O' 'o' 'O' 'o' 'OE' 'oe' 'R' 'r' 'R' 'r' 'R' 'r' 'S' 's' 'S' 's' 'S' 's' 'S' 's' 'T' 't' 'T' 't' 'T' 't' 'U' 'u' 'U' 'u' 'U' 'u' 'U' 'u' 'U' 'u' 'U' 'u' 'W' 'w' 'Y' 'y' 'Y' 'Z' 'z' 'Z' 'z' 'Z' 'z' 's' 'f' 'O' 'o' 'U' 'u' 'A' 'a' 'I' 'i' 'O' 'o' 'U' 'u' 'U' 'u' 'U' 'u' 'U' 'u' 'U' 'u' 'A' 'a' 'AE' 'ae' 'O' 'o');

	i=0
	length=${#INPUT}
	while [[ $i -lt $length ]]; do
		char=${INPUT:$i:1};
		#echo $i:$char
		j=0
		for letter in "${acc[@]}"
		do
			if [[ "$letter" == "$char" ]]; then
				char="${noa[$j]}"
			fi
			((j++))
		done
		((i++))
		OUTPUT=$OUTPUT$char
	done

	echo $OUTPUT

	return;
}

_slugfy()
{
	echo `remove_special_characters "$@"` | sed 's/[^a-zA-Z0-9]/-/g' |sed 's/--/-/g' | sed 's/--/-/g'
}


###### Running this file via CLI
if ! [ -z $1 ]; then
	to_slugfy=$(echo $1 |grep -E '(-s|--slug|--slugfy)'|wc -l)

	if ! [ $to_slugfy = 0 ]; then
		echo `_slugfy "${@:2}"`;
		exit 0;
	fi

	to_remove_special_chars=$(echo $1 |grep -E '(-c|--clear|--remove-special-chars)'|wc -l)

	if ! [ $to_remove_special_chars = '0' ]; then
		echo `remove_special_characters "${@:2}"`;
		exit 0;
	fi

	echo `_slugfy "$@"`;
	exit 0;
fi

## Load aliases
__slugfy_aliases()
{
	alias slugfy=_slugfy
	alias slugfy-branch='f(){ git checkout -b `_slugfy $@` ; unset -f f; };f'
	alias slug=_slugfy
	alias slug-branch='f(){ git checkout -b `_slugfy $@` ; unset -f f; };f'
}
