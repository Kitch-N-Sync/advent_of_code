#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))/"
inputfile="$inputfiledir/$inputfilename"

reading=$(cat $inputfile)
groupsum0=0
total=-3
triarray0=0
triarray1=0

echo 'tria0	tria1	tria2	grps0	grps1	tot'
for item in $(< $inputfile)
do
	triarray2=$item
	groupsum1=$((triarray0+triarray1+triarray2))

	if [ $groupsum1 -gt $groupsum0 ]
	then
		((total+=1))
	fi

	echo "${triarray0}	${triarray1}	${triarray2}	${groupsum0}	${groupsum1}	${total}"

	triarray0=$triarray1
	triarray1=$triarray2
	groupsum0=$groupsum1

done
echo $total
