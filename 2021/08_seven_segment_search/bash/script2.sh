#!/bin/bash

inputfilename="input2"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

cycle=0
i=0
segmentarray="a b c d e f g"
declare -A inputstore
declare -A outputstore
declare -A fbecheckarray

for data in $(< $inputfile);do
	#Alphabetize Data
	tempstring=""
	for alpha in ${segmentarray[@]};do
		if [[ $data = *"$alpha"* ]];then
			tempstring="$tempstring$alpha"
		fi
	done
	data=$tempstring

	#Splitting Data
	if [[ $i -lt 10 ]];then
		inputstore["$cycle,$i"]=$data
	fi
	if [[ $i -gt 9 ]];then
		outputstore["$cycle,$i"]=$data
	fi
	((i+=1))
	if [[ $i -eq 14 ]];then
		i=0
		((cycle+=1))
	fi
done

for (( round=0; round<$cycle; round ++ ));do
	inputdata=(${inputstore["$round,0"]} ${inputstore["$round,1"]} ${inputstore["$round,2"]} ${inputstore["$round,3"]} ${inputstore["$round,4"]} ${inputstore["$round,5"]} ${inputstore["$round,6"]} ${inputstore["$round,7"]} ${inputstore["$round,8"]} ${inputstore["$round,9"]})
	outputdata=(${outputstore["$round,10"]} ${outputstore["$round,11"]} ${outputstore["$round,12"]} ${outputstore["$round,13"]})
	#clear
	#echo "Data Mapped"
	#echo "Input Data:"
	#echo "${inputdata[@]}"
	#echo "Output Data:"
	#echo "${outputdata[@]}"
	#echo ""
	
	#echo "Finding Fseg,Bseg,Eseg..."
	#Find Fseg,Bseg,Eseg
	for i in ${!inputdata[@]};do
		for n in ${segmentarray[*]};do
			if [[ ${inputdata[$i]} = *"$n"* ]];then
				fbecheckarray[$n]=$((${fbecheckarray[$n]}+1))
			fi
		done
	done
	#for n in ${segmentarray[*]};do
		#echo "Found ${fbecheckarray[$n]} $n's"
	#done

	#read null

	for n in ${segmentarray[@]};do
		case "${fbecheckarray[$n]}" in
			4)	Eseg=$n;;
			6)	Bseg=$n;;
			9)	Fseg=$n;;
		esac
	done
	
	##clearing fbecheckarray
	for n in ${segmentarray[*]};do
		fbecheckarray[$n]=0
	done

	#clear
	#echo "Found Bseg,Eseg,Fseg"
	#echo "Input: ${inputdata[@]}"
	#echo "0: $zero"
	#echo "1: $one"
	#echo "2: $two"
	#echo "3: $three"
	#echo "4: $four"
	#echo "5: $five"
	#echo "6: $six"
	#echo "7: $seven"
	#echo "8: $eight"
	#echo "9: $nine"
	#echo "Bseg: $Bseg"
	#echo "Cseg: $Cseg"
	#echo "Eseg: $Eseg"
	#echo "Fseg: $Fseg"
	#read null
	
	#Process Data
	for i in ${!inputdata[@]};do
	
		#1,Cseg,4,7,8
		case "${#inputdata[$i]}" in
			2)	one=${inputdata[$i]}
				Cseg=${one//$Fseg}
				unset inputdata[$i];;
			3)	seven=${inputdata[$i]}
				unset inputdata[$i];;
			4)	four=${inputdata[$i]}
				unset inputdata[$i];;
			7)	eight=${inputdata[$i]}
				unset inputdata[$i];;
		esac
	done
	
	#clear
	#echo "Found 1,4,7,8,Cseg"
	#echo "Input: ${inputdata[@]}"
	#echo "0: $zero"
	#echo "1: $one"
	#echo "2: $two"
	#echo "3: $three"
	#echo "4: $four"
	#echo "5: $five"
	#echo "6: $six"
	#echo "7: $seven"
	#echo "8: $eight"
	#echo "9: $nine"
	#echo "Bseg: $Bseg"
	#echo "Cseg: $Cseg"
	#echo "Eseg: $Eseg"
	#echo "Fseg: $Fseg"
	#read null

	#2
	for i in ${!inputdata[@]};do
		if [[ ${inputdata[$i]} != *"$Fseg"* ]];then
			two=${inputdata[$i]}
			unset inputdata[$i]
		fi
	done
	
	#clear
	#echo "Found 2"
	#echo "Input: ${inputdata[@]}"
	#echo "0: $zero"
	#echo "1: $one"
	#echo "2: $two"
	#echo "3: $three"
	#echo "4: $four"
	#echo "5: $five"
	#echo "6: $six"
	#echo "7: $seven"
	#echo "8: $eight"
	#echo "9: $nine"
	#echo "Bseg: $Bseg"
	#echo "Cseg: $Cseg"
	#echo "Eseg: $Eseg"
	#echo "Fseg: $Fseg"
	#read null

	#5,6
	for i in ${!inputdata[@]};do
		if [[ ${#inputdata[$i]} -eq 5 ]] && [[ ${inputdata[$i]} != *"$Cseg"* ]];then
			five=${inputdata[$i]}
			unset inputdata[$i]
		elif [[ ${#inputdata[$i]} -eq 6 ]] && [[ ${inputdata[$i]} != *"$Cseg"* ]];then
			six=${inputdata[$i]}
			unset inputdata[$i]
		fi
	done
	
	#clear
	#echo "Found 5,6"
	#echo "Input: ${inputdata[@]}"
	#echo "0: $zero"
	#echo "1: $one"
	#echo "2: $two"
	#echo "3: $three"
	#echo "4: $four"
	#echo "5: $five"
	#echo "6: $six"
	#echo "7: $seven"
	#echo "8: $eight"
	#echo "9: $nine"
	#echo "Bseg: $Bseg"
	#echo "Cseg: $Cseg"
	#echo "Eseg: $Eseg"
	#echo "Fseg: $Fseg"
	#read null

	#3
	for i in ${!inputdata[@]};do
		if [[ ${#inputdata[$i]} -eq 5 ]];then
			three=${inputdata[$i]}
			unset inputdata[$i]
		fi
	done
	
	#clear
	#echo "Found 3"
	#echo "Input: ${inputdata[@]}"
	#echo "0: $zero"
	#echo "1: $one"
	#echo "2: $two"
	#echo "3: $three"
	#echo "4: $four"
	#echo "5: $five"
	#echo "6: $six"
	#echo "7: $seven"
	#echo "8: $eight"
	#echo "9: $nine"
	#echo "Bseg: $Bseg"
	#echo "Cseg: $Cseg"
	#echo "Eseg: $Eseg"
	#echo "Fseg: $Fseg"
	#read null

	#0,9
	for i in ${!inputdata[@]};do
		if [[ ${inputdata[$i]} = *"$Eseg"* ]];then
			zero=${inputdata[$i]}
			unset inputdata[$i]
		else
			nine=${inputdata[$i]}
			unset inputdata[$i]
		fi
	done

	#clear
	#echo "Found 0,9"
	#echo "Input: ${inputdata[@]}"
	#echo "0: $zero"
	#echo "1: $one"
	#echo "2: $two"
	#echo "3: $three"
	#echo "4: $four"
	#echo "5: $five"
	#echo "6: $six"
	#echo "7: $seven"
	#echo "8: $eight"
	#echo "9: $nine"
	#echo "Bseg: $Bseg"
	#echo "Cseg: $Cseg"
	#echo "Eseg: $Eseg"
	#echo "Fseg: $Fseg"
	#read null


	for i in ${!outputdata[@]};do
		case ${outputdata[$i]} in
			$zero)	outputdata[$i]=0;;
		    $one)	outputdata[$i]=1;;
            $two)	outputdata[$i]=2;;
            $three)	outputdata[$i]=3;;
            $four)	outputdata[$i]=4;;
            $five)	outputdata[$i]=5;;
            $six)	outputdata[$i]=6;;
            $seven)	outputdata[$i]=7;;
            $eight)	outputdata[$i]=8;;
            $nine)	outputdata[$i]=9;;
		esac
	done
	
	tempout="${outputdata[0]}${outputdata[1]}${outputdata[2]}${outputdata[3]}"
	tempout=$((10#$tempout))
	((finalout+=$tempout))
	echo "Current Output: $finalout"
	#echo "${outputdata[@]}"
	#read null

	unset zero
	unset one
	unset two
	unset three
	unset four
	unset five
	unset six
	unset seven
	unset eight
	unset nine
	unset Bseg
	unset Cseg
	unset Eseg
	unset Fseg
done

echo "Final Output: $finalout"
