#!/bin/bash

yearDIR="$(dirname $(realpath $0))"

clear
echo "Add to directory:"
echo "0: New"
i=1
for year in $(ls $yearDIR); do
	if [[ ${year:0:3} = "202" ]]; then
		echo "$i: $year"
		yeardirectories[$i]="$yearDIR/$year/"
		((i+=1))
	fi
done
read -p ">" yearchoice
isnum='^[0-9]+$'
if [[ ${yearchoice^^} = "NEW" ]]; then
	$yearchoice=0
fi
if [[ $yearchoice -eq 0 ]]; then
	read -p "New Year [YYYY] >" addyear
	echo "Make new directory [${addyear}]?" 
	read -p "[y/n] >" confirm
elif [[ $yearchoice =~ $isnum ]]; then
	echo "Adding new directory to ${yeardirectories[1]}"
	echo "Enter directory name [00_name_of_puzzle]"
	read -p "> " newdirname
else
	echo "Unknown option chosen"
fi

