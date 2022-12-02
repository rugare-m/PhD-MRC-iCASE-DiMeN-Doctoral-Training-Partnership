#!/bin/bash

#$ -o bcf_out
#$ -e bcf_err
#$ -cwd
#$ -V

> bcf_out
> bcf_err

for folder in /ph-users/rugare/cancer_data/serum/SRR*/

do

bcftools mpileup -Ou -f /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/samtools_index/Homo_sapiens_assembly38.fasta $folder/`basename $folder`FINAL.bam | bcftools call -mv -Ov -o $folder/`basename $folder`bcf.vcf

done
