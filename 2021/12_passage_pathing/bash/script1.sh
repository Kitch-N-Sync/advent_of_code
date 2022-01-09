#!/bin/bash

inputfile="input2"

#Read exit data
while read data1 data2;do
	#echo "$data1-$data2"
	dataA+=($data1)
	dataB+=($data2)
done < $inputfile
unset data1 data2

exitfrom=(${dataA[@]})
exitto=(${dataB[@]})

#Merge exit data
for (( i=0; i<${#dataA[@]}; i++ ));do
	exitfrom+=( ${dataB[$i]} )
	exitto+=( ${dataA[$i]} )
done
unset dataA[@] dataB[@]

#Remove END from exitfrom and START from exitto
for i in ${!exitfrom[@]};do
	if [ ${exitfrom[$i]} = "end" ] || [ ${exitto[$i]} = "start" ];then
		unset exitfrom[$i]
		unset exitto[$i]
	fi
done

echo "Len : Exitfrom"
echo "${#exitfrom[@]} : ${exitfrom[@]}"
echo "Len : Exitto"
echo "${#exitto[@]} : ${exitto[@]}"
echo ""
read null

#Main Program
path=(",start")
searchexits=("start") #Setup for start
while :;do
	search=(${searchexits[@]})
	unset searchexits[@]
#\
	echo "Current Path  : ${path[@]}"
	echo "Current Search: ${search[@]}"
#/
	#remove dupes from search
	IFS=$'\n' search=($(sort <<<"${search[*]}"));unset IFS
#\
	echo "Search -dupe: ${search[@]}"
	read null
#/
	#Look for current tails in exitfrom and save
	for lookfor in ${search[@]};do
	echo "Looking for $lookfor"
		for i in ${!exitfrom[@]};do
			if [ ${exitfrom[$i]} = $lookfor ];then
				foundexits+=(${exitto[$i]})
				searchexits+=(${exitto[$i]})
			fi
		done
#\
		echo "${#foundexits[@]} Foundexits: ${foundexits[@]}"
		echo "Searchexits: ${searchexits[@]}"
		read null
#/
		#search for all paths that end with this search
		unset dupecount
		for i in ${!path[@]};do
			#find them, duplicate them by length of foundexits-1
			if [ ${path[$i]##*,} = $lookfor ];then
				for (( j=1; j<${#foundexits[@]}; j++ ));do
					path+=(${path[$i]})
				done
				((dupecount+=1))
			fi
		done
#\
		echo "Current Paths duped : ${path[@]}"
		echo "Dupecount : $dupecount"
		read null
#/
		#duplicate foundexits
		for (( i=1; i<$dupecount; i++ ));do
			foundexits+=(${foundexits[*]})
		done
#\
		echo "Foundexits duped : ${foundexits[@]}"
		read null
#/

		#search for all paths again
		for i in ${!path[@]};do
			#find them
			if [ ${path[$i]##*,} = $lookfor ];then
			foundexits=(${foundexits[@]})
			echo "Adding ${foundexits[0]}"
				#checkif foundexit is valid
				if [[ "${foundexits[0]}" =~ [a-z][a-z] ]] && [[ "${path[$i]}" != "*${foundexits[0]}*" ]] || [[ "${foundexits[0]}" =~ [A-Z][A-Z] ]] || [[ "${foundexits[0]}" = "end" ]];then
					#add foundexits
					path[$i]="${path[$i]},${foundexits[0]}"
					echo "Path ${path[$i]} IS VALID"
				else
					echo "Path ${path[$i]},${foundexits[0]} IS NOT VALID"
					unset path[$i]
				fi
				#if a foundexit is END, copy to FINAL and unset
				if [[ ${foundexits[0]} = "end" ]];then
					echo "Complete Path: ${path[$i]}"
					final+=(${path[$i]})
					unset path[$i]
				fi
				unset foundexits[0]
				
			fi
		done
		unset foundexits[@]

	done
done
