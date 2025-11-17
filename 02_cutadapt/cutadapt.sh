#!/bin/bash
## Job name
#SBATCH -J cutadapt

## Use valid partition
#SBATCH -p 256core

## Number of compute nodes
#SBATCH --nodes=2

## Tasks per node
#SBATCH --ntasks-per-node=2

## CPU per task
#SBATCH --cpus-per-task=1

## Memory limit 
#SBATCH --mem=1G

## Output file
#SBATCH --out=_cutadapt_%j.out
#SBATCH --error=_cutadapt_%j.err



date

SAMPLE_NAME="$1"
DIR_FILE="$2"

DIR="$(cat "$DIR_FILE")"

cat "$SAMPLE_NAME" | while read -r line; do
        echo "$line"
        cutadapt -q 30 -j 2 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
		-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --minimum-length 30 \
		--pair-filter any -o $DIR/02_cutadapt/$line"_1.clip.fastq" -p $DIR/02_cutadapt/$line"_2.clip.fastq" \
		$DIR/01_raw/$line"_1.fastq.gz" \
		$DIR/01_raw/$line"_2.fastq.gz"


done

date

