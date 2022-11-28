#!/bin/bash

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=2:00:00
#SBATCH --mem=32GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=melanie.smith@flinders.edu.au

# Load modules
# Anaconda
module load arch/arch/skylake
module load Anaconda2/5.1.0

## drop the decimal and number after the decimal in column 1
## sed -i 's/\.2//g' test2_backslplice_junction.bed
## sed -i 's/\.1//g' test2_backslplice_junction.bed
source activate circExplorer2

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294
ALIGNDIR=${PROJROOT}/fastq/aligned
PARSEDDIR=${PROJROOT}/fastq/parsed
TESTALIGNEDDIR=${PROJROOT}/fastq/testDirectory/testAligned
TESTANNOTATEDIR=${PROJROOT}/fastq/testDirectory/testAnnotate
GENOMEDIR=/hpcfs/users/a1627211/Refs/ref_genomes
OUTPUTDIR=${PROJROOT}/fastq/knownCirc

for i in ${PARSEDDIR}/*_GRCH38_back_spliced_junction.bed
        do
SampleName=$(basename ${i} _back_spliced_junction.bed)

CIRCexplorer2 annotate \
        -r ${PROJROOT}/refSeq/hg38_ref_no_ch.txt \
        -g ${GENOMEDIR}/ensembl_homo_sapiens.GRCh38.dna.primary_assembly.fa \
        -b $i \
        -o ${OUTPUTDIR}/"${SampleName}"_known_circ.txt

	done

#CIRCexplorer2 annotate \
#	-r ${PROJROOT}/refSeq/hg38_ref_no_ch.txt \
#	-g /hpcfs/users/a1627211/Refs/ref_genomes/ensembl_homo_sapiens.GRCh38.dna.primary_assembly.fa \
#	-b ${PROJROOT}/fastq/testDirectory/testParsed/back_spliced_junction.bed \
#	-o ${TESTANNOTATEDIR}/testOutput.out.txt

conda deactivate
