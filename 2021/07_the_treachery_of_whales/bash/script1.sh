#!/bin/bash

inputfile="input"

mapfile -td, inputpos < $inputfile

IFS=$'\n'
initpos=($(sort -n<<<"${inputpos[*]}"))
unset IFS
unset inputpos[@]

minpos=${initpos[0]}
maxpos=${initpos[-1]}

echo "Max: $maxpos"
echo "Min: $minpos"
read null

dupecheck=""
dupei=0

initlen=${#initpos[@]}

for (( i=0; i<$initlen; i++ ));do
	#echo "0:${initpos[0]}	1:${initpos[1]}	2:${initpos[2]}	3:${initpos[3]}	4:${initpos[4]}	5:${initpos[5]}	6:${initpos[6]}	7:${initpos[7]}	8:${initpos[8]}	9:${initpos[9]}"
	if [ "${initpos[$i]}" = "$dupecheck" ];then
		unset initpos[$i]
		((dupecount[$dupei]+=1))

	else
		dupecheck=${initpos[$i]}
		dupei=$i
		dupecount[$dupei]=1
	fi
done

fuel=$(($maxpos*50000))

for (( testpos=$(($minpos+1)); testpos<$maxpos; testpos++ ));do
	fuelcheck=0
	for i in ${!initpos[@]};do
		val=$((${initpos[$i]}-$testpos))
		val=${val#-}
		val=$(($val*${dupecount[$i]}))
		((fuelcheck+=$val))
	done
	if [ $fuelcheck -lt $fuel ];then
		fuel=$fuelcheck
		fuelpos=$testpos
	fi
	echo "Fuel Check $testpos: $fuelcheck"
done

echo "Final Fuel: $fuel at $fuelpos"
