
#!/bin/bash

## Melanie Smith ##
## 20221113 ##

## Run on Phoenix ##
## Make a new STAR genome index for GRCh38 ##

##--------------------------------------------------------------------------------------------##
## Load modules (modules loaded in the run script)
##--------------------------------------------------------------------------------------------##

#module load arch/arch/skylake
#module load STAR/2.7.3a

PICARD=$EBROOTPICARD/picard.jar

##--------------------------------------------------------------------------------------------##
## Settings
##--------------------------------------------------------------------------------------------##

THREADS=16
build=GRCH38

REFS=/hpcfs/users/a1627211/Refs

##--------------------------------------------------------------------------------------------##
## Create new STAR index using ensembl GRCh38
##--------------------------------------------------------------------------------------------##

STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ${REFS}/STAR_GRCh38_index/ --genomeFastaFiles ${REFS}/ref_genomes/ensembl_homo_sapiens.GRCh38.dna.primary_assembly.fa --sjdbGTFfile ${REFS}/ref_annotations/ensembl_homo_sapiens.GRCh38.106.gtf --sjdbOverhang 99
