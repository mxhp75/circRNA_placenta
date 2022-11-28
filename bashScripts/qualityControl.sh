#!/bin/bash -l

##--------------------------------------------------------------------------------------------##
## Load modules
##--------------------------------------------------------------------------------------------##

module load arch/arch/skylake
module load Anaconda3/2020.07

##--------------------------------------------------------------------------------------------##
## activate the required Conda environment
##--------------------------------------------------------------------------------------------##

conda activate qualityControl

##--------------------------------------------------------------------------------------------##
## set project root directory
##--------------------------------------------------------------------------------------------##

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294

##--------------------------------------------------------------------------------------------##
## set up log file
##--------------------------------------------------------------------------------------------##

mkdir -p ${PROJROOT}/log
exec 1> ${PROJROOT}/log/qualitycontrol.log 2>&1
set -ex

mkdir -p ${PROJROOT}/trim_data/{qc,multiqc} ${PROJROOT}/multiqc

##--------------------------------------------------------------------------------------------##
## set number of threads
##--------------------------------------------------------------------------------------------##

THREADS=8


##--------------------------------------------------------------------------------------------##
## set project sub-directories
##--------------------------------------------------------------------------------------------##

TRIMFQ=${PROJROOT}/trim_data
TRIMQC=${TRIMFQ}/qc


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
## Check the raw directory exists, else exit with error
##--------------------------------------------------------------------------------------------##

if [[ ! -d ${RAWFQ} ]]
  then
    echo -e "${RAWFQ} not found.\nExiting with Error code 1\n"
    exit 1
fi
echo -e "Found ${RAWFQ}\n"

##--------------------------------------------------------------------------------------------##
## Check the trimmed data  QC directory exists, else exit with error
##--------------------------------------------------------------------------------------------##

if [[ ! -d ${TRIMQC} ]]
  then
    echo -e "${TRIMQC} not found.\nExiting with Error code 1\n"
    exit 1
fi
echo -e "Found ${TRIMQC}\n"

##--------------------------------------------------------------------------------------------##
## trim reads to remove adapter sequence and discard poor quality reads
##--------------------------------------------------------------------------------------------##

  if [[ ! -e ${TRIMFQ}/${base1%.fastq.gz}_trim.fastq.gz || ! -e ${TRIMFQ}/${base2%.fastq.gz}_trim.fastq.gz ]]
    then
      echo -e "Running fastp on ${F}\n"
      fastp \
        -i ${R1} -I ${R2} \
        -o ${TRIMFQ}/${base1%.fastq.gz}_trim.fastq.gz \
        -O ${TRIMFQ}/${base2%.fastq.gz}_trim.fastq.gz \
        --cut_right --cut_window_size 4 --cut_mean_quality 20 \
        --length_required 75
  fi

##--------------------------------------------------------------------------------------------##
## find forward and reverse trimmed read files (change file names as needed)
##--------------------------------------------------------------------------------------------##

for TR1 in ${TRIMFQ}/*_R1_001_trim.fastq.gz; do
  echo -e "Found ${TR1}\n"
  TR2=${TR1%_R1_001_trim.fastq.gz}_R2_001_trim.fastq.gz
  echo -e "The TR2 file should be ${TR2}\n"

##--------------------------------------------------------------------------------------------##
## run FastQC on trimmed reads, unless already performed
##--------------------------------------------------------------------------------------------##

  for F in $TR1 $TR2; do
    echo $F
    baseF=$(basename $F)
    if [[ ! -f ${TRIMQC}/${baseF%.fastq.gz}_fastqc.html  ]]
      then
        echo -e "Running FastQC on ${baseF}\n"
        fastqc -o ${TRIMQC} -t ${THREADS} ${F}
      else
        echo -e "FastQC already performed on ${F}, skipping\n"
    fi
  done
done


##--------------------------------------------------------------------------------------------##
## collate raw QC data into multiQC report
##--------------------------------------------------------------------------------------------##

if [[ ! -f ${RAWQC}/multiqc/multiqc-report_rawdata.html  ]]
  then
    multiqc \
    --outdir ${RAWQC}/multiqc \
    --filename multiqc-report_rawdata.html \
    ${RAWQC}
fi


##--------------------------------------------------------------------------------------------##
## collate trimmed data into multiQC report
##--------------------------------------------------------------------------------------------##

if [[ ! -f ${TRIMQC}/multiqc/multiqc-report_trimdata.html  ]]
  then
    multiqc \
    --outdir ${TRIMQC}/multiqc \
    --filename multiqc-report_trimdata.html \
    ${TRIMQC}
fi

##--------------------------------------------------------------------------------------------##
## Conda deactivate
##--------------------------------------------------------------------------------------------##

conda deactivate
