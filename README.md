# week_8

The featurecounts.sh file is used to generate a slurm batch job for creating a counts ile for every aligned RG.bam file created during the aligning step of RNAseq. These counts files will be processed in DEseq2 in the following week.

For DNAseq files, the mergeDNA.sh file merges bam files together, then uses this output to generate vcf files. The mergevcf file merges all the vcf files together for SNP calling.

