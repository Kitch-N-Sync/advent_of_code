#!/bin/bash

input_file="input2"
xdist=999
ydist=999
lineamt=499

declare -A linecoord
declare -A coords
linenum=0
i=0

#Map data to individual linecoords
for data in $(< $input_file)
do
	case "$i" in
		0) linecoord["$linenum,x0"]=$data;;
		1) linecoord["$linenum,y0"]=$data;;
		2) linecoord["$linenum,x1"]=$data;;
		3) linecoord["$linenum,y1"]=$data;;
	esac

	((i+=1))

	if [ $i -eq 4 ]
	then
		i=0
		#echo "Line $linenum Mapped"
		((linenum+=1))
	fi
done
echo "Linecoords Mapped"

#Zero out the map
#for (( x = 0; x <= $xdist; x++ ))
#do
#	for (( y = 0; y <= $ydist; y++ ))
#	do
#		coords["$x,$y"]=0
#	done
#	echo "Map X$x Zeroed"
#done
#echo "Map Zeroed Out"

#What is the straight part of the line
for (( linenum = 0; linenum <= $lineamt; linenum++ ))
do
	if [ ${linecoord["$linenum,y0"]} -eq ${linecoord["$linenum,y1"]} ]
	then
		#Y is straight, which X is bigger
		ydraw=${linecoord["$linenum,y0"]}
		if [ ${linecoord["$linenum,x0"]} -gt ${linecoord["$linenum,x1"]} ]
		then
			#x0 is bigger
			for (( xdraw = ${linecoord["$linenum,x1"]}; xdraw <= ${linecoord["$linenum,x0"]}; xdraw++ ))
			do
				((coords["$xdraw,$ydraw"]+=1))
			done
		else
			#x1 is bigger
			for (( xdraw = ${linecoord["$linenum,x0"]}; xdraw <= ${linecoord["$linenum,x1"]}; xdraw++ ))
			do
				((coords["$xdraw,$ydraw"]+=1))
			done
		fi
	elif [ ${linecoord["$linenum,x0"]} -eq ${linecoord["$linenum,x1"]} ]
	then
		#X is straight, which Y is bigger
		xdraw=${linecoord["$linenum,x0"]}
		if [ ${linecoord["$linenum,y0"]} -gt ${linecoord["$linenum,y1"]} ]
		then
			#y0 is bigger
			for (( ydraw = ${linecoord["$linenum,y1"]}; ydraw <= ${linecoord["$linenum,y0"]}; ydraw++ ))
			do
				((coords["$xdraw,$ydraw"]+=1))
			done
		else
			#y1 is bigger
			for (( ydraw = ${linecoord["$linenum,y0"]}; ydraw <= ${linecoord["$linenum,y1"]}; ydraw++ ))
			do
				((coords["$xdraw,$ydraw"]+=1))
			done
		fi
	fi
	#echo "Line ${linecoord["$linenum,x0"]},${linecoord["$linenum,y0"]} - ${linecoord["$linenum,x1"]},${linecoord["$linenum,y1"]}"
done

echo "Lines Mapped"

#Display the map
#for (( y = 0; y <= $ydist; y++ ))
#do
#	dispstring=""
#	for (( x = 0; x <= $xdist; x++ ))
#	do
#		dispstring="${dispstring} ${coords[$x,$y]}" 
#	done
#	echo "$dispstring"
#done

#Total for the answer
for (( y = 0; y <= $ydist; y++ ))
do
	dispstring=""
	for (( x = 0; x <= $xdist; x++ ))
	do
		if [ ! -z ${coords["$x,$y"]} ]
		then
			if [ ${coords["$x,$y"]} -gt 1 ]
			then
				((total+=1)) 
			fi
		fi
	done
	echo "Y$y Mapped"
done
echo ""
echo "Total = $total"
