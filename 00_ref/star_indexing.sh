#$/bin/bash

echo "indexing_ref"
STAR --runMode genomeGenerate \
	--genomeDir /home/peterpgw/class_/00_ref \
	--genomeFastaFiles /home/peterpgw/class_/00_ref/Mus_musculus.GRCm39.dna.primary_assembly.fa \
       	--runThreadN 6

