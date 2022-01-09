#!/bin/bash
FGCYAN='\033[36m'
FGDEFAULT='\033[39m'

#Printing the board
for (( y=0; y<10; y++ ));do
	for (( x=0; x<10; x++ ));do
		case ${octo["$x,$y,blink"]} in
			1)	tempstring=$"${tempstring} ${FGCYAN}0${FGDEFAULT}";;
			0)	if [ ${octo["$x,$y,data"]} -eq 9 ];then
					tempstring=$"${tempstring} ="
				else
					tempstring=$"${tempstring} -"
				fi;;
		esac
	done
	printstring=$"${printstring}${tempstring}\n"
	unset tempstring
done
echo -e "$printstring"
unset printstring
#read null;echo -en "\033[1A\033[2K"
