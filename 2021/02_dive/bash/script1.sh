#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

horiz=0
depth=0

while read -r direction amt _;do
	echo "Dir_   : $direction"
	if [ "$direction" == "up" ];then
		((depth-=$amt))
		dir_txt="up		"
	elif [ "$direction" == "down" ];then
		((depth+=$amt))
		dir_txt="down		"
	elif [ "$direction" == "forward" ];then
		((horiz+=$amt))
		dir_txt="forward	"
	else
		echo "ERROR OCCURRED: Not valid direction"
	fi
	echo "Dir_txt: $dir_txt"
done < $inputfile

echo "HPos : $horiz"
echo "Depth: $depth"

