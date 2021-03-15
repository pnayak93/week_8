# week_8

The featurecounts.sh file is used to generate a slurm batch job for creating a counts matrix for every aligned RG.bam file created during the aligning step of RNAseq. These counts files will be processed in DEseq2 in the following week.

The featurecounts.sh file is meant to be kept in the same directory as the sorted bam files, and looks as follows:

```
#!/bin/bash
#SBATCH --job-name=featurecountRNA      ## Name of the job.
#SBATCH -A ecoevo283         ## account to charge
#SBATCH -p standard          ## partition/queue name
#SBATCH --cpus-per-task=12    ## number of cores the job needs, can the programs you run make used of multiple cores?

prefix=*sort.bam
module load subread/2.0.1
gtf="/data/class/ecoevo283/pnayak/seq_symlinks/ref/dmel-all-r6.13.gtf"
featureCounts -p -T 12 -t exon -g gene_id -Q 30 -F GTF -a $gtf -o fly_counts_2.txt $prefix

```

For DNAseq files, the mergeDNA.sh file merges bam files together, then uses this output to generate vcf files. 
The mergevcf file merges all the vcf files together for SNP calling.
both of these files are run as batch slurm jobs.


