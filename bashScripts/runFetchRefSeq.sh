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
module load arch/arch/skylake
module load Anaconda2/5.1.0

source activate circExplorer2

python /hpcfs/users/a1627211/.conda/envs/circExplorer2/bin/fetch_ucsc.py hg38 ref hg38_ref.txt > hg38_ref.txt

source deactivate
