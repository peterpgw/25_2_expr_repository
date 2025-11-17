#!/bin/bash

date

SAMPLE_NAME="$1"
DIR_FILE="$2"

DIR="$(cat "$DIR_FILE")"


cat "$SAMPLE_NAME" | while read -r line; do
	echo "$line"
	htseq-count -m union -s reverse -r pos -a 0 -i gene_id \
		-f bam $DIR/03_mapping/$line'.STARAligned.sortedByCoord.out.bam' \
		$DIR/00_ref/Mus_musculus.GRCm39.115.gtf > $DIR/04_htseq/$line'_gene.counts'
done

date

