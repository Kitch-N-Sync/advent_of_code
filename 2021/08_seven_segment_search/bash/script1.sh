#!/bin/bash

inputfile="input2"

while read -a display;do
	echo "Len of ${display[$i]} = ${#display[$i]}"
	case "${#display[$i]}" in
		2)	((onecount+=1))
			((totalcount+=1))
			echo "This is a one";;
		3) ((sevencount+=1))
			((totalcount+=1))
			echo "This is a seven";;
		4) ((fourcount+=1))
			((totalcount+=1))
			echo "This is a four";;
		7) ((eightcount+=1))
			((totalcount+=1))
			echo "This is an eight";;
	esac
done <$inputfile

echo "1's:	$onecount"
echo "4's:	$fourcount"
echo "7's:	$sevencount"
echo "8's:	$eightcount"
echo "Total: $totalcount"

