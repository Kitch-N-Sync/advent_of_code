#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

mapfile -td, lanternfish < $inputfile

for day in {0..79}
do
	for (( lfnum=0; lfnum<${#lanternfish[@]}; lfnum++ ))
	do
		case "${lanternfish[$lfnum]}" in
			0)	lanternfish[$lfnum]=6
				lanternfish+=(9);;
			*)	((lanternfish[$lfnum]-=1));;
		esac
	done
	if [ $(($day%10)) -eq 0 ]
	then
		echo "Day $day: ${#lanternfish[@]}"
	fi
done

echo "Day 80: ${#lanternfish[@]}"
