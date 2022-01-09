#!/bin/bash 

calloutfile="numbers"
boardfile="boards2"
declare -A boardsarray
boardnum=0
itemnum=0

#Map callouts to array
mapfile -td, callouts < $calloutfile
echo "CALLOUTS MAPPED"

#map board data to array
for data in $(< $boardfile)
do
	boardsarray["${boardnum},${itemnum}"]=$data
	((itemnum+=1))
	if [ $itemnum -eq 25 ]
	then
		itemnum=0
		((boardnum+=1))
	fi
done
echo "BOARD DATA MAPPED"

#Check board data for callout and mark as 100 if match
for data in ${callouts[@]}
do
	for board in {0..99}
	do
		for num in {0..24}
		do
			if [ ${boardsarray[$board,$num]} -eq $data ]
			then
				boardsarray["${board},${num}"]="100"
			fi
		done
		#Check if winning board
		#Vertical
		for v in {0..4}
		do
			((vertsum=${boardsarray[$board,$v]}+${boardsarray[$board,$(($v+5))]}+${boardsarray[$board,$(($v+10))]}+${boardsarray[$board,$(($v+15))]}+${boardsarray[$board,$(($v+20))]}))
			if [ $vertsum -eq 500 ]
			then
				winboard=$board
				winnum=$data
				break 4
			fi
		done
		#Horizontal
		for v in {0..20..5}
		do
			((horizsum=${boardsarray[$board,$v]}+${boardsarray[$board,$(($v+1))]}+${boardsarray[$board,$(($v+2))]}+${boardsarray[$board,$(($v+3))]}+${boardsarray[$board,$(($v+4))]}))
			if [ $horizsum -eq 500 ]
			then
				winboard=$board
				winnum=$data
				break 4
			fi
		done
	done
	echo "CALLOUT $data FINISHED"
done

#Calculate winning board answer
for num in {0..24}
do
	if [ ${boardsarray[$winboard,$num]} -eq 100 ]
	then
		boardsarray["$winboard,$num"]="XX"
	else
		((winsum+=${boardsarray[$winboard,$num]}))
	fi
done

#Print Winning Board
echo ""
echo "Winning Board!!"
echo "Board = $winboard"
echo "Score = $winsum  Winning Callout = $winnum"
for v in {0..20..5}
do
	echo "${boardsarray[$board,$v]}	${boardsarray[$board,$(($v+1))]}	${boardsarray[$board,$(($v+2))]}	${boardsarray[$board,$(($v+3))]}	${boardsarray[$board,$(($v+4))]}"
done

#Calculate final answer
((final=$winsum*$winnum))
echo "Final Answer: $final"





