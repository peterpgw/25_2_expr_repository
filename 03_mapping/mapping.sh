#!/bin/bash

## Job name
#SBATCH -J mapping

## Use valid partition
#SBATCH -p 256core

## Number of compute nodes
#SBATCH --nodes=1

## Tasks per node
#SBATCH --ntasks-per-node=1

## CPU per task
#SBATCH --cpus-per-task=6

## Memory limit
#SBATCH --mem=8G

## Output file
#SBATCH --out=_mapping_%j.out
#SBATCH --error=_mapping_%j.err




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
		--sjdbGTFfile $DIR/00_ref/Mus_musculus.GRCm39.115.gtf \
i		--sjdbOverhang 100 \
		--outFileNamePrefix $line."STAR"
        
done

date

