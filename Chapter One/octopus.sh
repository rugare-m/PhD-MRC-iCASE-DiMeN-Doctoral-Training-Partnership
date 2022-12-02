#!/bin/bash

#$ -o oct_out
#$ -e oct_err
#$ -cwd
#$ -V

> oct_out
> oct_err

for folder in /ph-users/rugare/cancer_data/serum/SRR*/

do

octopus -R /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/samtools_index/Homo_sapiens_assembly38.fasta -I $folder/`basename $folder`FINAL.bam -o $folder/`basename $folder`oct.vcf -C cancer

done