#!/bin/bash

date

FILE="$1"

cat "$FILE" | while read -r line; do
	echo "$line"
	htseq-count -m union -s reverse -r pos -a 0 -i gene_id \
		-f bam /home/peterpgw/class_/03_mapping/$line'.STARAligned.sortedByCoord.out.bam' \
		/home/peterpgw/class_/00_ref/Mus_musculus.GRCm39.115.gtf > /home/peterpgw/class_/06_htseq/$line'_gene.counts'
done

date

