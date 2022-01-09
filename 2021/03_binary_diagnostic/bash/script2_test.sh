#!/bin/bash

i=1
n=0
gamma_compare=0
initial_input="input"
file_read="file1"
file_write="file2"

cp $initial_input $file_read
echo "File 1:"
cat $file_read
read null

while [ "$gamma_compare" -ne 1 ]
do
	> $file_write
	lines=0
	ones=0

	while read data
	do
		((ones+=${data:n:1}))
		((lines+=1))
	done < $file_read

	((half=$lines/2))

	if [ $ones -lt $half ]
	then
		gamma_str="${gamma_str}0"
	else
		gamma_str="${gamma_str}1"
	fi
	
	echo "Lines	1/2	1's	gamma_str"
	echo "$lines	$half	$ones	$gamma_str"
	read null

	gamma_compare=0
	while read data
	do
		if [ ${gamma_str} -eq ${data:a:i} ]
		then
			((gamma_compare+=1))
			gamma_solution=$data
			echo $gamma_solution >> $file_write
			echo "$gamma_str  = ${data:a:i}"
		else
			echo "$gamma_str != ${data:a:i}"
		fi
	done < $file_read
	echo "Gamma Count = $gamma_compare"
	cp $file_write $file_read
	((i+=1))
	((n+=1))
done

return "$gamma_solution"
