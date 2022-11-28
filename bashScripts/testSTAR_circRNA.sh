
#!/bin/bash

## Melanie Smith ##
## 20221114 ##

## Run on Phoenix ##
## STAR alignment of trimmed fastq files: RNase-R RNAseq ##

##--------------------------------------------------------------------------------------------##
## Load modules (modules loaded in the run script)
##--------------------------------------------------------------------------------------------##

#module load arch/arch/skylake
#module load STAR/2.7.3a

PICARD=$EBROOTPICARD/picard.jar

##--------------------------------------------------------------------------------------------##
## Directory paths
##--------------------------------------------------------------------------------------------##

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294
TESTTRIMDIR=${PROJROOT}/fastq/testDirectory/testTrimmed       	# input files for STAR align
GENOMEDIR=/hpcfs/users/a1627211/Refs/STAR_GRCh38_index 		# location of STAR index files
TESTALIGNDIR=${PROJROOT}/fastq/testDirectory/testAligned	# output of STAR align

##--------------------------------------------------------------------------------------------##
## Settings
##--------------------------------------------------------------------------------------------##

THREADS=16
build=GRCH38
##--------------------------------------------------------------------------------------------##
## Check the aligned data directory exists, else exit with error
##--------------------------------------------------------------------------------------------##

if [ ! -d "${TESTALIGNDIR}" ]
  then
     mkdir -pv "${TESTALIGNDIR}"
 fi

##--------------------------------------------------------------------------------------------##
## Align the trimmed reads with STAR (runMode default = alignReads)
##--------------------------------------------------------------------------------------------##


# files in `xxxx.truncated.gz` format

for FQGZ in ${TESTTRIMDIR}/*.truncated.gz; do

SampleName=$(basename ${FQGZ} .truncated.gz)

	STAR \
	--chimSegmentMin 10 \
	--runThreadN ${THREADS} \
	--genomeDir ${GENOMEDIR} \
	--genomeLoad NoSharedMemory \
	--readFilesIn ${FQGZ} \
	--readFilesCommand zcat \
	--outSAMtype BAM Unsorted \
	--outFilterType BySJout \
	--outSAMattrRGline ID:"${SampleName}" \
                           LB:library \
                           PL:illumina \
                           PU:machine \
                           SM:"${build}" \
	--outFileNamePrefix ${TESTALIGNDIR}/"${SampleName}"_"${build}"_
done
