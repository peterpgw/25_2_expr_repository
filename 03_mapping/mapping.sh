#!/bin/bash

date

SAMPLE_NAME="$1"
DIR_FILE="$2"

DIR="$(cat "$DIR_FILE")"

cat "$SAMPLE_NAME" | while read -r line; do
	echo "$line"
	STAR \
		--genomeDir $DIR/00_ref/ \
		--runThreadN 6 --runMode alignReads \
		--readFilesIn $DIR/02_cutadapt/$line'_1.clip.fastq' $DIR/02_cutadapt/$line'_2.clip.fastq' \
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
		--sjdbGTFfile $DIR/Mus_musculus.GRCm39.115.gtf \
		--sjdbOverhang 100 \
		--outFileNamePrefix $line."STAR"
        
done

date

