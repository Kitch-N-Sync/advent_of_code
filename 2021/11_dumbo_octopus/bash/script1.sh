#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

declare -A octo

mapfile -t rowdata <$inputfile

last=$((${#rowdata[0]}-1))

clear
#echo "COL 	ROW 	POSI	DATA"
#echo ""

for row in ${!rowdata[@]};do
	for (( column=0; column<${#rowdata[$row]}; column++ ));do
		#Find Position
		#0 1 2
		#3 4 5
		#6 7 8
		pos=0
		case $row in
			0)		;;
			$last)	pos=6;;
			*)		pos=3;;
		esac
		case $column in
			0)		;;
			$last)	((pos+=2));;
			*)		((pos+=1));;
		esac

		octo["$column,$row,pos"]=$pos
		octo["$column,$row,data"]=${rowdata[$row]:$column:1}
		octo["$column,$row,blink"]=0

		#echo "$column	$row	${octo[$column,$row,pos]}	${octo[$column,$row,data]}"
		#read null;echo -en "\033[1A\033[2K"
	done
done

for (( i=0; i<5000; i++ ));do
	#Printing the board
#	clear
#	echo "Step $(($i+1))"
#	. ./printboard.sh
	
	#Increase all by 1 and zero blink
	for (( x=0; x<10; x++ ));do
		for (( y=0; y<10; y++ ));do
			((octo["$x,$y,data"]+=1))
			octo["$x,$y,blink"]=0
		done
	done
	
	#echo "Increased all by 1 and 0'd blink"


	#Check for blinks
	for (( somethingblinked=1; somethingblinked>0; somethingblinked ));do
		somethingblinked=0
		for (( x=0; x<10; x++ ));do
			for (( y=0; y<10; y++ ));do
				if [ ${octo["$x,$y,data"]} -gt 9 ] && [ ${octo["$x,$y,blink"]} -eq 0 ];then
					somethingblinked=1
					((blinkcount+=1))
					octo["$x,$y,blink"]=1
						#0 1 2
						#3 4 5
						#6 7 8
					case ${octo["$x,$y,pos"]} in
						#Up
						[3-8]) ((octo["$x,$(($y-1)),data"]+=1));;&
						#Down
						[0-5]) ((octo["$x,$(($y+1)),data"]+=1));;&
						#Left
						1 | 2 | 4 | 5 | 7 | 8) ((octo["$(($x-1)),$y,data"]+=1));;&
						#Right
						0 | 1 | 3 | 4 | 6 | 7) ((octo["$(($x+1)),$y,data"]+=1));;&
						#Up Left
						4 | 5 | 7 | 8) ((octo["$(($x-1)),$(($y-1)),data"]+=1));;&
						#Up Right
						3 | 4 | 6 | 7) ((octo["$(($x+1)),$(($y-1)),data"]+=1));;&
						#Down Left
						1 | 2 | 4 | 5) ((octo["$(($x-1)),$(($y+1)),data"]+=1));;&
						#Down Right
						0 | 1 | 3 | 4) ((octo["$(($x+1)),$(($y+1)),data"]+=1));;
					esac
				fi
			done
		done
		
		clear
		echo "Step $(($i+1))"
		. ./printboard.sh
#		sleep .05

#		case $somethingblinked in
#			0)	echo "Nothing Blinked"
#				echo ""
#				#. ./printboard.sh;;
#			1)	echo "Something Blinked"
#				#echo ""
#				#. ./printboard.sh;;
		#esac
	done

	synccheck=0

	#Zero out >9
	for (( x=0; x<10; x++ ));do
		for (( y=0; y<10; y++ ));do
			if [ ${octo["$x,$y,data"]} -gt 9 ];then
				octo["$x,$y,data"]=0
				((synccheck+=1))
			fi
		done
	done
	
	if [ $synccheck -eq 100 ];then
		echo "Sync'd at step $(($i+1))"
		break 1
	fi
#	sleep 0.05
done

echo "Total Blinks: $blinkcount"
read null
