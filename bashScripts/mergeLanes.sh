#!/bin/bash

##--------------------------------------------------------------------------------------------##
## Concatenate multi lane raw fastqs into individual R1/R2 files per sample
##--------------------------------------------------------------------------------------------##

##--------------------------------------------------------------------------------------------##
## set project directories
##--------------------------------------------------------------------------------------------##

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294
RAWFASTQ=${PROJROOT}/fastq
INPUTFILES=${PROJROOT}/bashScripts
OUTPUTFILES=${PROJROOT}/fastq/mergedFiles

##--------------------------------------------------------------------------------------------##
## set up log file
##--------------------------------------------------------------------------------------------##

mkdir -p ${PROJROOT}/log
exec 1> ${PROJROOT}/log/qualitycontrol.log 2>&1
set -ex

##--------------------------------------------------------------------------------------------##
## Check the project root directories exist, else exit with error
##--------------------------------------------------------------------------------------------##

if [[ ! -d ${PROJROOT} ]]
  then
    echo -e "${PROJROOT} not found.\nExiting with Error code 1\n"
    exit 1
fi
echo -e "Found ${PROJROOT}\n"

##--------------------------------------------------------------------------------------------##
## Check the output file directories exist, else exit with error
##--------------------------------------------------------------------------------------------##

mkdir -p ${PROJROOT}/fastq/mergedFiles

if [[ ! -d ${OUTPUTFILES} ]]
  then
    echo -e "${OUTPUTFILES} not found.\nExiting with Error code 1\n"
    exit 1
fi
echo -e "Found ${OUTPUTFILES}\n"

##--------------------------------------------------------------------------------------------##
## Concatenate fastq files
##--------------------------------------------------------------------------------------------##

while read line
        do
                L1=${RAWFASTQ}/L01/$(echo "$line" | cut -f 1)
                L2=${RAWFASTQ}/L02/$(echo "$line" | cut -f 2)
                L3=${RAWFASTQ}/L03/$(echo "$line" | cut -f 3)
                L4=${RAWFASTQ}/L04/$(echo "$line" | cut -f 4)
                MERGE=$(echo "$line" | cut -f 5)
                cat ${L1} ${L2} ${L3} ${L4} > ${OUTPUTFILES}/${MERGE}
        done < ${INPUTFILES}/mergeInputFile.txt
