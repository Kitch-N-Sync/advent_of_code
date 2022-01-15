#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

lines=0


while read data;do
	((eleven+=${data:0:1}))
	((ten+=${data:1:1}))
	((nine+=${data:2:1}))
	((eight+=${data:3:1}))
	((seven+=${data:4:1}))
	((six+=${data:5:1}))
	((five+=${data:6:1}))
	((four+=${data:7:1}))
	((three+=${data:8:1}))
	((two+=${data:9:1}))
	((one+=${data:10:1}))
	((zero+=${data:11:1}))
	((lines+=1))
done < $inputfile

((half=$lines/2))

for place in $eleven $ten $nine $eight $seven $six $five $four $three $two $one $zero
do
		if [ $place -gt $half ]
		then
			gamma_str="${gamma_str}1"
			epsilon_str="${epsilon_str}0"
		else
			gamma_str="${gamma_str}0"
			epsilon_str="${epsilon_str}1"
	fi
done

echo "Gamma string = $gamma_str"

i=1
gamma_compare=0
while [ $gamma_compare -ne 2 ]
do
	gamma_compare=0
	while read data
	do
		if [ ${gamma_str:a:i} = ${data:a:i} ]
		then
			((gamma_compare+=1))
			gamma_solution=$data
			echo "${gamma_str:a:i} = ${gamma_str:a:i}"
		else
			echo "${gamma_str:a:i} != ${data:a:i}"
		fi
	done < $file
	((i+=1))
	echo "Start over with i=$i"
	echo "Gamma count = $gamma_compare"
	read pausevar
done

echo "Lines	L/2	2048	1024	512	256	128	64	32	16	8	4	2	0"
echo "$lines	$half	$eleven	$ten	$nine	$eight	$seven	$six	$five	$four	$three	$two	$one	$zero"
echo "Gamma	$gamma_str	$gamma	$gamma_solution"
echo "Epsilon	$epsilon_str	$epsilon"
echo "Final	$final"
