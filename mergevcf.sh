#!/bin/bash
#SBATCH --job-name=mergevcf      ## Name of the job.
#SBATCH -A ecoevo283         ## account to charge 
#SBATCH -p standard          ## partition/queue name
#SBATCH --cpus-per-task=2    ## number of cores the job needs, can the programs you run make used of multiple cores?

module load java/1.8.0
module load gatk/4.1.9.0

ref="/data/class/ecoevo283/pnayak/seq_symlinks/ref/dmel-all-chromosome-r6.13.fasta"
merge=/data/class/ecoevo283/pnayak/seq_symlinks/DNAseq/bam/mergebam

# another dirty shell trick, you can't printf -V...
/opt/apps/gatk/4.1.9.0/gatk CombineGVCFs -R $ref $(printf -- '-V %s ' $merge/*.g.vcf.gz) -O allsample.g.vcf.gz
## and merge gVCFs
