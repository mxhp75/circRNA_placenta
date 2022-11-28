
#!/bin/bash

## Melanie Smith ##
## 20221104 ##

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
TRIMDIR=${PROJROOT}/fastq/trimmed       		# input files for STAR align
GENOMEDIR=/hpcfs/users/a1627211/Refs/STAR_GRCh38_index	# location of STAR index files
ALIGNDIR=${PROJROOT}/fastq/aligned			# output of STAR align

##--------------------------------------------------------------------------------------------##
## Settings
##--------------------------------------------------------------------------------------------##

THREADS=16
build=GRCH38

##--------------------------------------------------------------------------------------------##
## Check the aligned data directory exists, else exit with error
##--------------------------------------------------------------------------------------------##

if [ ! -d "${ALIGNDIR}" ]
  then
     mkdir -pv "${ALIGNDIR}"
 fi

##--------------------------------------------------------------------------------------------##
## Align the trimmed reads with STAR (runMode default = alignReads)
##--------------------------------------------------------------------------------------------##


# files in `xxxx.pair1.truncated.gz` format

for FQGZ in ${TRIMDIR}/*.pair1.truncated.gz; do

SampleName=$(basename ${FQGZ} .pair1.truncated.gz)

	STAR \
	--chimSegmentMin 10 \
	--runThreadN ${THREADS} \
	--genomeDir ${GENOMEDIR} \
	--genomeLoad NoSharedMemory \
	--readFilesIn ${FQGZ} ${FQGZ/.pair1.truncated.gz/.pair2.truncated.gz} \
	--readFilesCommand zcat \
	--outSAMtype BAM Unsorted \
	--outFilterType BySJout \
	--outSAMattrRGline ID:"${SampleName}" \
                           LB:library \
                           PL:illumina \
                           PU:machine \
                           SM:"${build}" \
	--outFileNamePrefix ${ALIGNDIR}/"${SampleName}"_"${build}"_
done
