#!/bin/sh

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=20:00:00
#SBATCH --mem=32GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=melanie.smith@adelaide.edu.au

# Load modules
# AdapterRemoval
module load arch/arch/skylake
module load AdapterRemoval/2.2.2

#bash /hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294/bashScripts/adapterRemoval.sh
PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294
MIRGDIR=${PROJROOT}/fastq/mergedFiles

#for i in ${MIRGDIR}/*_R1_001.fastq.gz; do ${PROJROOT}/bashScripts/adapterRemoval.sh $i; done

for i in /hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294/fastq/testDirectory/testRaw/*_R1.kapa.header_tagged.fastq.gz; do ${PROJROOT}/bashScripts/testAdapterRemoval.sh $i; done
