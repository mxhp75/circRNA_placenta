#!/bin/sh

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=40:00:00
#SBATCH --mem=64GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=melanie.smith@flinders.edu.au

# Load modules
module load arch/arch/skylake
module load STAR/2.7.3a

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294
# run test files
#bash  ${PROJROOT}/bashScripts/testSTAR_circRNA.sh

# run lab files
bash  ${PROJROOT}/bashScripts/STAR_circRNA.sh
