#!/bin/bash

inputfile="testinput"

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
		for each in ${lanternfish[@]}
		do
			((total+=${lanternfish[each]}))
		done
		echo "Day $day: $total"
	fi
done

for each in ${lanternfish[@]}
do
	((total+=${lanternfish[each]}))
done
echo "Day 80: $total"
