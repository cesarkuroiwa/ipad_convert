#!/bin/sh

input=$1
output=$2

if [ -z "$input" -o -z "$output" ]
then
		echo "Usage: $0 <input_file> <output_file> [<subtitle_file>]"
		exit 1
fi

subtitle=""
if [ -n "$3" ]
then
	enc=`file $3 | grep -i utf-8`	
	utf8=""
	if [ -n "$enc" ]
	then
		utf8="-utf8"
	fi
	subtitle="$utf8 -sub $3"
fi

mencoder -ovc x264 -x264encopts global_header:bframes=0 -oac faac -faacopts br=160:mpeg=4:object=2:raw -of lavf $input -o $output $subtitle
