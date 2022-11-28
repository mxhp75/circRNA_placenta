#!/bin/sh

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=10:00:00
#SBATCH --mem=32GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=melanie.smith@flinders.edu.au

# Load modules
module load arch/arch/skylake
module load STAR/2.7.3a

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294

bash  ${PROJROOT}/bashScripts/STAR_index.sh
