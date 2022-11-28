#!/bin/bash

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=20:00:00
#SBATCH --mem=32GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=melanie.smith@flinders.edu.au

# Load modules
# Anaconda
module load arch/arch/skylake
module load Anaconda2/5.1.0

source activate circExplorer2

PROJROOT=/hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294
ALIGNDIR=${PROJROOT}/fastq/aligned
TESTDIR=${PROJROOT}/fastq/testDirectory/testAligned
TESTPARSED=${PROJROOT}/fastq/testDirectory/testParsed
TESTALIGNDIR=${PROJROOT}/fastq/testDirectory/testAligned

#CIRCexplorer2 parse -t STAR /hpcfs/users/a1627211/directory/projects/20221028_circRNA_SAGCQA0294/fastq/testDirectory/testAligned/KD150_17B_GRCH38_Chimeric.out.junction

for i in ${ALIGNDIR}/*_GRCH38_Chimeric.out.junction
	do 
SampleName=$(basename ${i} _Chimeric.out.junction)

	CIRCexplorer2 parse \
	-t STAR \
	$i \
	-b "${SampleName}"_back_spliced_junction.bed
	
	done

conda deactivate
