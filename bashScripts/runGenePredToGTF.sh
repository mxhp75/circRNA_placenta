#!/bin/bash

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=1:00:00
#SBATCH --mem=16GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=melanie.smith@flinders.edu.au

## Didn't work on Phoenix - ended up using AFW

# Load modules
# Anaconda
module load arch/arch/haswell
module load Anaconda3/4.3.1

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294

source activate ucsc-genepredtogtf 

cut -f2-11 ${PROJROOT}/refSeq/hg38_ref.txt|genePredToGtf file stdin ${PROJROOT}/refSeq/hg38_ref.gtf

source deactivate
