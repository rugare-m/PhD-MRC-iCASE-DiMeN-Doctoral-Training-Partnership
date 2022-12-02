#!/bin/bash

#$ -o mut_out
#$ -e mut_err
#$ -cwd
#$ -V

> mut_out
> mut_err


for folder in /ph-users/rugare/cancer_data/serum/SRR*/
do
gatk Mutect2 \
   -R /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/samtools_index/Homo_sapiens_assembly38.fasta \
   -I $folder/`basename $folder`FINAL.bam \
   -O $folder/`basename $folder`mut2.vcf
done
