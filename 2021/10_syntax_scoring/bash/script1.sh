#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

mapfile -t filerow <$inputfile

for row in ${!filerow[@]};do
	for (( i=0; i<${#filerow[$row]}; i++ ));do

		#clear
		#echo "ROW: $row"
		#echo "${filerow[$row]}"
		#for (( j=0; j<$i; j++ ));do
		#	printf ' '
		#done
		#	printf '^\n'
		#echo "Checkarray"
		#echo "${checkarray[@]}"
		#echo ""

		case ${filerow[$row]:$i:1} in
		"(")	checkarray+=(")");;
		"[")	checkarray+=("]");;
		"{")	checkarray+=("}");;
		"<")	checkarray+=(">");;
		")")	if [ ${checkarray[-1]} = ")" ];then
					unset checkarray[-1]
				else
					#echo "Corrupted Line"
					#echo "Expected:	${checkarray[-1]}"
					#echo "Read:		${filerow[$row]:$i:1}"
					((total+=3))
					#read null
					break 1
				fi;;
		"]")	if [ ${checkarray[-1]} = "]" ];then
					unset checkarray[-1]
				else
					#echo "Corrupted Line"
					#echo "Expected:	${checkarray[-1]}"
					#echo "Read:		${filerow[$row]:$i:1}"
					((total+=57))
					#read null
					break 1
				fi;;
		"}")	if [ ${checkarray[-1]} = "}" ];then
					unset checkarray[-1]
				else
					#echo "Corrupted Line"
					#echo "Expected:	${checkarray[-1]}"
					#echo "Read:		${filerow[$row]:$i:1}"
					((total+=1197))
					#read null
					break 1
				fi;;
		">")	if [ ${checkarray[-1]} = ">" ];then
					unset checkarray[-1]
				else
					#echo "Corrupted Line"
					#echo "Expected:	${checkarray[-1]}"
					#echo "Read:		${filerow[$row]:$i:1}"
					((total+=25137))
					#read null
					break 1
				fi;;
		esac
	done
	unset checkarray[@]
done

echo "Total Points: $total"
