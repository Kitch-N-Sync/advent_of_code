#!/bin/bash

inputfile="input"

mapfile -td, inputfish < $inputfile

fish1=(0 0 0 0 0 0 0 0)
fish2=(0 0 0 0 0 0 0 0)

for (( lfnum=0; lfnum<${#inputfish[@]}; lfnum++ ))
do
	(("fish1[${inputfish[${lfnum}]}]"+=1))
done

#echo "Init: ${fish1[@]}"
#read null

for day in {0..255}
do
	fish2[0]=${fish1[1]}
	fish2[1]=${fish1[2]}
	fish2[2]=${fish1[3]}
	fish2[3]=${fish1[4]}
	fish2[4]=${fish1[5]}
	fish2[5]=${fish1[6]}
	fish2[6]=$((fish1[7]+fish1[0]))
	fish2[7]=${fish1[8]}
	fish2[8]=${fish1[0]}

	for i in {0..8}
	do
		fish1[$i]=${fish2[$i]}
	done

#	echo "Fish: ${fish1[@]}"
#	read null

	total=0

	for i in ${fish1[@]}
	do
		let total+=$i
	done

	echo "Day $(($day+1)): $total"
	#read null

done
