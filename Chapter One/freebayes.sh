#!/bin/bash

#$ -o fbayes_out
#$ -e fbayes_err
#$ -cwd
#$ -V

> fbayes_out
> fbayes_err


for folder in /ph-users/rugare/cancer_data/serum/SRR*/

do

freebayes -f /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/bowtie2_index/Homo_sapiens_assembly38.fasta $folder/`basename $folder`FINAL.bam >$folder/`basename $folder`fbayes.vcf

done
