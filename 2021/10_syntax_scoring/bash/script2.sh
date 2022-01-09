#!/bin/bash

inputfile="input"

mapfile -t filerow <$inputfile

for row in ${!filerow[@]};do
	echo "Row $row: ${filerow[$row]}"
	for (( i=0; i<${#filerow[$row]}; i++ ));do
		case ${filerow[$row]:$i:1} in
		"(")	checkarray+=(")");;
		"[")	checkarray+=("]");;
		"{")	checkarray+=("}");;
		"<")	checkarray+=(">");;
		")")	if [ ${checkarray[-1]} = ")" ];then
					unset checkarray[-1]
				else
					unset checkarray[@]
					break 1
				fi;;
		"]")	if [ ${checkarray[-1]} = "]" ];then
					unset checkarray[-1]
				else
					unset checkarray[@]
					break 1
				fi;;
		"}")	if [ ${checkarray[-1]} = "}" ];then
					unset checkarray[-1]
				else
					unset checkarray[@]
					break 1
				fi;;
		">")	if [ ${checkarray[-1]} = ">" ];then
					unset checkarray[-1]
				else
					unset checkarray[@]
					break 1
				fi;;
		esac
	done
	#echo "Row $row Checkarray: ${checkarray[@]}"
	if [ ${#checkarray[@]} -gt 0 ];then
		for (( j=$((${#checkarray[@]}-1)); j>=0; j-- ));do
			((temptotal*=5))
			case ${checkarray[$j]} in
				")")	((temptotal+=1));;
				"]")	((temptotal+=2));;
				"}")	((temptotal+=3));;
				">")	((temptotal+=4));;
			esac
		done
		((total[$row]+=$temptotal))
		unset temptotal
		unset checkarray[@]
	fi
	#echo "Row $row Total: ${total[$row]}"
	#read null
done

echo "Total:	${total[@]}"
IFS=$'\n'
	total=($(sort -n<<<"${total[*]}"))
unset IFS
echo "Sort: ${total[@]}"

position=$((${#total[@]}-1))
position=$(($position/2))

echo "Number: ${#total[@]}"
echo "Middle: $position"
echo "Final Score: ${total[$position]}"

