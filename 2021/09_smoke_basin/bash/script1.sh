#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

filelen=($(wc -l $inputfile))
lowpoints=0

mapfile -t filerow < $inputfile

for row in ${!filerow[@]};do
	for (( i=0; i<${#filerow[$row]}; i++));do
		isless=0
		pos=4

		#LEFT
		if [ $i -ne 0 ];then
			if [ ${filerow[$row]:$i:1} -lt ${filerow[$row]:$(($i-1)):1} ];then
				((isless+=1))
			fi
		else
			((pos-=1))
		fi

		#RIGHT
		if [ $i -lt $((${#filerow[$row]}-1)) ];then
			if [ ${filerow[$row]:$i:1} -lt ${filerow[$row]:$(($i+1)):1} ];then
				((isless+=1))
			fi
		else
			((pos-=1))
		fi

		#UP
		if [ $row -ne 0 ];then
			if [ ${filerow[$row]:$i:1} -lt ${filerow[$(($row-1))]:$i:1} ];then
				((isless+=1))
			fi
		else
			((pos-=1))
		fi

		#DOWN
		if [ $row -ne $(($filelen-1)) ];then
			if [ ${filerow[$row]:$i:1} -lt ${filerow[$(($row+1))]:$i:1} ];then
				((isless+=1))
			fi
		else
			((pos-=1))
		fi

		if [ $pos -eq $isless ];then
			((total+=${filerow[$row]:$i:1}))
			((total+=1))
		fi

	done
	echo "Row $row Total = $total"
done
