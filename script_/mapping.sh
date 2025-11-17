#!/bin/bash

date

FILE="$1"


cat "$FILE" | while read -r line; do
	echo "$line"
	STAR \
		--genomeDir /home/peterpgw/ref/musculus_GRCm39_112 \
		--runThreadN 6 --runMode alignReads \
		--readFilesIn /home/peterpgw/class_/02_cutadapt/$line'_1.clip.fastq' /home/peterpgw/class_/02_cutadapt/$line'_2.clip.fastq' \
		--outFilterMultimapNmax 10 \
		--outFilterMismatchNoverLmax 0.03 \
		--outFilterMismatchNmax 2 \
		--outMultimapperOrder Random \
		--outSAMmultNmax -1 \
		--outSAMmapqUnique 255 \
		--outSAMtype BAM SortedByCoordinate \
		--outSAMattributes All \
		--outSAMunmapped Within \
		--outReadsUnmapped Fastx \
		--sjdbGTFfile /home/peterpgw/ref/musculus_GRCm39_112/Mus_musculus.GRCm39.112.gtf \
		--sjdbOverhang 100 \
		--outFileNamePrefix $line."STAR"
        
done

date

