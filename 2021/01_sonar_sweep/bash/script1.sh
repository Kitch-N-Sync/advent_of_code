#!/bin/bash

inputfilename="input"
inputfiledir="$(dirname $(dirname $(realpath $0)))"
inputfile="$inputfiledir/$inputfilename"

reading=$(cat $inputfile)
item1=0
total=-1

for item2 in $reading
do

if [ $item2 -gt $item1 ]
then
((total+=1))
fi

item1=$item2
done
echo $total
