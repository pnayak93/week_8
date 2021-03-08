#!/bin/bash
#SBATCH --job-name=mergeDNA      ## Name of the job.
#SBATCH -A ecoevo283         ## account to charge 
#SBATCH -p standard          ## partition/queue name
#SBATCH --array=1-4         ## number of tasks to launch, given hint below wc -l $file is helpful
#SBATCH --cpus-per-task=2    ## number of cores the job needs, can the programs you run make used of multiple cores?

# just load all the stuff I might need, I will try to quit having you find modules...
module load bwa/0.7.17
module load samtools/1.10
module load bcftools/1.10.2
module load python/3.8.0
module load java/1.8.0
module load gatk/4.1.9.0
module load picard-tools/1.87
module load bamtools/2.5.1        # bamtools merge is useful
module load freebayes/1.3.2       # fasta_generate_regions.py is useful
module load vcftools/0.1.16

file="prefix2.txt"
ref="/data/class/ecoevo283/pnayak/seq_symlinks/ref/dmel-all-chromosome-r6.13.fasta"
mergebam="/data/class/ecoevo283/pnayak/seq_symlinks/DNAseq/bam/mergebam/"
prefix=`head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1`

# merge lanes within samples
# this is an incredible useful shell trick you wouldn't learn for a few years = $(printf 'I=%s ' ${prefix}*.RG.bam)
# what is it doing?
java -jar /opt/apps/picard-tools/1.87/MergeSamFiles.jar $(printf 'I=%s ' *${prefix}*.RG.bam) O="$mergebam"${prefix}.merge.bam
/opt/apps/gatk/4.1.9.0/gatk MarkDuplicatesSpark -I "$mergebam"${prefix}.merge.bam -O "$mergebam"${prefix}.dedup.bam -M "$mergebam"${prefix}.dedup.metrics.txt
## no recalibration unless dealing with human data (low SNP density, many HQ known SNPs)
## call genotype on each sample
/opt/apps/gatk/4.1.9.0/gatk HaplotypeCaller -R $ref -I "$mergebam"${prefix}.dedup.bam --minimum-mapping-quality 30 -ERC GVCF -O "$mergebam"${prefix}.g.vcf.gz
## end merge and call SNPs

