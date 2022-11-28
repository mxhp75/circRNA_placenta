#!/bin/bash

## Melanie Smith ##
## 20221103 ##

## Run on Phoenix ##
## for i in /hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294/fastq/testDirectory/*_R1_001.fastq.gz; do /hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294/bashScripts/adapterRemoval.sh $i; done
## Adapter Trimming of fastq samples RNase-R RNAseq ##


##--------------------------------------------------------------------------------------------##
## Directory paths
##--------------------------------------------------------------------------------------------##

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294
MERGEDIR=${PROJROOT}/fastq/mergedFiles    # input files AdapterRemoval
TRIMDIR=${PROJROOT}/fastq/trimmed	# output files AdaoterRemoval


## Required files

DATA=$1
NAME=$(basename ${DATA} _R1_001.fastq.gz) # input file needs to be format 'xxxx_R1_001.fastq.gz'

##--------------------------------------------------------------------------------------------##
## Settings
##--------------------------------------------------------------------------------------------##

THREADS="16"

##--------------------------------------------------------------------------------------------##
# 1. Trim the reads with adapteremoval
##--------------------------------------------------------------------------------------------##

 if [ ! -d "${TRIMDIR}/log" ]
  then
     mkdir -pv "${TRIMDIR}/log"
 fi

# Loop over out FASTQ files
#for i in ${MERGEDIR}/*.fastq.gz
#do
  # Echo what file(s) we found
#  echo "Found $(basename ${i})"

AdapterRemoval \
    --file1 <(zcat ${DATA}) \
    --file2 <(zcat ${DATA/_R1_001/_R2_001}) \
    --basename ${TRIMDIR}/${NAME} \
    --trimns \
    --minlength 20 \
    --trimqualities \
    --threads ${THREADS} \
    --gzip

#SETTINGS=${TRIMDIR}/log/$(basename ${i/%.fastq.gz/.settings/})
#  echo "AdapterRemoval settings file will be written to ${SETTINGS}"

#done


