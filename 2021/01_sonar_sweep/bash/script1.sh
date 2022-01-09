#!/bin/bash
file="input"
reading=$(cat $file)
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
