#!/bin/bash
#SBATCH --job-name=featurecountRNA      ## Name of the job.
#SBATCH -A ecoevo283         ## account to charge 
#SBATCH -p standard          ## partition/queue name
#SBATCH --cpus-per-task=12    ## number of cores the job needs, can the programs you run make used of multiple cores?

prefix=*sort.bam
module load subread/2.0.1
gtf="/data/class/ecoevo283/pnayak/seq_symlinks/ref/dmel-all-r6.13.gtf"
featureCounts -p -T 12 -t exon -g gene_id -Q 30 -F GTF -a $gtf -o fly_counts_2.txt $prefix
