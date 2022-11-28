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

# Load modules
# Anaconda
module load arch/arch/skylake
module load Anaconda2/5.1.0

#fast_circ.py annotate -r REF -g GENOME -G GTF [-p THREAD] [-o OUT] -f FQ

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294/

source activate circExplorer2

python /hpcfs/users/a1627211/.conda/envs/circExplorer2/bin/fast_circ.py parse \
	-g ${PROJROOT}/refSeq/hg38.fa \
	-r ${PROJROOT}/refSeq/hg38_ref.txt	
	-o ${PROJROOT}/fastq/testDirectory/testAnnotate/ \
	-G ${PROJROOT}/refSeq/hg38_ref.gtf \
	-f FQ 

source deactivate
