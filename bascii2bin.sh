#!/bin/bash

infile_name=$1
infile_dir="$(dirname $(realpath $0))"
infile_noext="${infile_name%.*}"
outfile="${infile_dir}/${infile_noext}.bin"

bit_length=$(expr length "$(head -n 1 $1)")
zero_str="000"
addl_zeros=${zero_str:0:((4 - $bit_length % 4))}
unset bit_length zero_str

#Add zeros to beginnning of line
sed "s/^/$addl_zeros/" $1 \
	| tr -d $'\n' \
	| while read -N 4 nibble; do \
		printf '%x' "$((2#${nibble}))"; \
	done \
	| xxd -r -p \
	> ${outfile}
