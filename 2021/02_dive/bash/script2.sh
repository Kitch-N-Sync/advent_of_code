#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

horiz=0
depth=0
aim=0

while read -r direction amt _;do
	if [ "$direction" == "up" ];then
		((aim-=$amt))
	elif [ "$direction" == "down" ];then
		((aim+=$amt))
	elif [ "$direction" == "forward" ];then
		((horiz+=$amt))
		((temp=$amt*$aim))
		((depth+=$temp))
	else
		echo "ERROR OCCURRED: Not valid direction"
	fi
done < $inputfile

echo "HPos : $horiz"
echo "Depth: $depth"

