#!/bin/bash

date

SAMPLE_NAME="$1"
DIR_FILE="$2"

DIR="$(cat "$DIR_FILE")"

cat "$SAMPLE_NAME" | while read -r line; do
        echo "$line"
        cutadapt -q 30 -j 2 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
		-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --minimum-length 30 \
		--pair-filter any -o $DIR/02_cutadapt/$line"_1.clip_test_.fastq" -p $DIR/02_cutadapt/$line"_2.clip_test_.fastq" \
		$DIR/01_raw/$line"_1.fastq.gz" \
		$DIR/01_raw/$line"_2.fastq.gz"


done

date

