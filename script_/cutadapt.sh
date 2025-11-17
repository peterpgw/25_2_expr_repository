#!/bin/bash

date

FILE="$1"

cat "$FILE" | while read -r line; do
        echo "$line"
        cutadapt -q 30 -j 2 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
		-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --minimum-length 30 \
		--pair-filter any -o /home/peterpgw/class_/02_cutadapt/$line"_1.clip_test_.fastq" -p /home/peterpgw/class_/02_cutadapt/$line"_2.clip_test_.fastq" \
		/home/peterpgw/class_/01_raw/$line"_1.fastq.gz" \
		/home/peterpgw/class_/01_raw/$line"_2.fastq.gz"


done

date

