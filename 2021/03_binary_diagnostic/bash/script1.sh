#!/bin/bash

file="input"
lines=0


while read data;do
	((eleven+=${data:0:1}))
	((ten+=${data:1:1}))
	((nine+=${data:2:1}))
	((eight+=${data:3:1}))
	((seven+=${data:4:1}))
	((six+=${data:5:1}))
	((five+=${data:6:1}))
	((four+=${data:7:1}))
	((three+=${data:8:1}))
	((two+=${data:9:1}))
	((one+=${data:10:1}))
	((zero+=${data:11:1}))
	((lines+=1))
done < $file

((half=$lines/2))

for place in $eleven $ten $nine $eight $seven $six $five $four $three $two $one $zero
do
		if [ $place -gt $half ]
		then
			gamma_str="${gamma_str}1"
			epsilon_str="${epsilon_str}0"
		else
			gamma_str="${gamma_str}0"
			epsilon_str="${epsilon_str}1"
	fi
done

((gamma=${gamma_str:0:1}*2048+${gamma_str:1:1}*1024+${gamma_str:2:1}*512+${gamma_str:3:1}*256+${gamma_str:4:1}*128+${gamma_str:5:1}*64+${gamma_str:6:1}*32+${gamma_str:7:1}*16+${gamma_str:8:1}*8+${gamma_str:9:1}*4+${gamma_str:10:1}*2+${gamma_str:11:1}*1))
((epsilon=${epsilon_str:0:1}*2048+${epsilon_str:1:1}*1024+${epsilon_str:2:1}*512+${epsilon_str:3:1}*256+${epsilon_str:4:1}*128+${epsilon_str:5:1}*64+${epsilon_str:6:1}*32+${epsilon_str:7:1}*16+${epsilon_str:8:1}*8+${epsilon_str:9:1}*4+${epsilon_str:10:1}*2+${epsilon_str:11:1}*1))

((final=$gamma*$epsilon))

echo "Lines	L/2	2048	1024	512	256	128	64	32	16	8	4	2	0"
echo "$lines	$half	$eleven	$ten	$nine	$eight	$seven	$six	$five	$four	$three	$two	$one	$zero"
echo "Gamma	$gamma_str	$gamma"
echo "Epsilon	$epsilon_str	$epsilon"
echo "Final	$final"
