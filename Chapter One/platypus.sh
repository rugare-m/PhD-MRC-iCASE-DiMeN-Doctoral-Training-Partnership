#!/bin/bash

#$ -o plat_out
#$ -e plat_err
#$ -cwd
#$ -V

> plat_out
> plat_err


for folder in /ph-users/rugare/cancer_data/serum/SRR*
do
platypus callVariants --bamFiles=$folder/`basename $folder`FINAL.bam  --refFile=/ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/bowtie2_index/Homo_sapiens_assembly38.fasta --output=$folder/`basename $folder`platy.vcf
done