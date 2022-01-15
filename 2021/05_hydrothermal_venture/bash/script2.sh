#!/bin/bash

inputfilename="input2"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

xdist=999
ydist=999
lineamt=499

declare -A linecoord
declare -A coords
linenum=0
i=0
count=0

#Map data to individual linecoords
for data in $(< $inputfile)
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

##Zero the Map for testfile display
#for (( y = 0; y <= $ydist; y++ ))
#do
	#for (( x = 0; x <= $xdist; x++ ))
	#do
		#coords["$x,$y"]=0
	#done
#done
#
##Display the map after zero
#for (( yy = 0; yy <= $ydist; yy++ ))
#do
	#dispstring=""
	#for (( xx = 0; xx <= $xdist; xx++ ))
	#do
		#dispstring="${dispstring} ${coords[$xx,$yy]}" 
	#done
#echo "$dispstring"
#done
#read null

#What is the straight part of the line
for (( linenum = 0; linenum <= $lineamt; linenum++ ))
do
	#x0 < x1
	if [ ${linecoord["$linenum,x0"]} -eq ${linecoord["$linenum,x1"]} ] && [ ${linecoord["$linenum,y0"]} -lt ${linecoord["$linenum,y1"]} ] || [ ${linecoord["$linenum,x0"]} -lt ${linecoord["$linenum,x1"]} ]
	then
		xstart=${linecoord["$linenum,x0"]}
		xend=${linecoord["$linenum,x1"]}
		ystart=${linecoord["$linenum,y0"]}
		yend=${linecoord["$linenum,y1"]}
	else
		xstart=${linecoord["$linenum,x1"]}
		xend=${linecoord["$linenum,x0"]}
		ystart=${linecoord["$linenum,y1"]}
		yend=${linecoord["$linenum,y0"]}
	fi

	if [ $xstart -eq $xend ]
	then
		for (( y = $ystart; y <= $yend; y++ ))
		do
			((coords["$xstart,$y"]+=1))
		done
	elif [ $ystart -eq $yend ]
	then
		for (( x = $xstart; x <= $xend; x++ ))
		do
			((coords["$x,$ystart"]+=1))
		done
	else
		linelength=$(($xend-$xstart))
		for (( i = 0; i <= $linelength; i++))
		do
			if [ $yend -gt $ystart ]
			then
				((coords["$(($xstart+$i)),$(($ystart+$i))"]+=1))
			else	
				((coords["$(($xstart+$i)),$(($ystart-$i))"]+=1))
			fi		
		done
	fi
		
#	echo "Line ${linecoord["$linenum,x0"]},${linecoord["$linenum,y0"]} - ${linecoord["$linenum,x1"]},${linecoord["$linenum,y1"]}"
	
	##Display the map
	#for (( yy = 0; yy <= $ydist; yy++ ))
	#do
		#dispstring=""
		#for (( xx = 0; xx <= $xdist; xx++ ))
		#do
			#dispstring="${dispstring} ${coords[$xx,$yy]}" 
		#done
	#echo "$dispstring"
	#done
	#read null
	if [ $(($count%100)) -eq 0 ]
	then
		echo "Line $count Mapped"
	fi
	((count+=1))
done
echo "Lines Mapped"

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
	if [ $(($y%50)) -eq 0 ]
	then
		echo "Y$y Mapped"
	fi
done
echo ""
echo "Total = $total"
