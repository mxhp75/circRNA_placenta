#!/bin/sh

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=10:00:00
#SBATCH --mem=32GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=melanie.smith@adelaide.edu.au

# Load modules
# STAR and AdapterRemoval
#module load arch/arch/skylake
#module load AdapterRemoval/2.2.2
#module load STAR/2.7.3a

# Load modules
# SAMtools
#module load arch/arch/haswell
#module load SAMtools/0.1.18-foss-2015b

# Load module
# fastqc
#module load arch/arch/haswell
#module load fastqc/0.11.4

# Executing script
bash /hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294/bashScripts/mergeLanes.sh
