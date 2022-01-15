#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"


mapfile -td, lanternfish < $inputfile

for day in {0..255}
do
	for (( lfnum=0; lfnum<${#lanternfish[@]}; lfnum++ ))
	do
		case "${lanternfish[$lfnum]}" in
			0)	lanternfish[$lfnum]=6
				lanternfish+=(9);;
			*)	((lanternfish[$lfnum]-=1));;
		esac
	done
		echo "${lanternfish[@]}"
		echo ""
	#if [ $(($day%50)) -eq 0 ]
	#then
		#echo "Day $day: ${#lanternfish[@]}"
	#fi
done

echo "Day 80: ${#lanternfish[@]}"
