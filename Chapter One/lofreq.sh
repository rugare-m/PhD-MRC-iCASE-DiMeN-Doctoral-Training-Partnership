#!/bin/bash

#$ -o lfreq_out
#$ -e lfreq_err
#$ -cwd
#$ -V

> lfreq_out
> lfreq_err

for folder in /ph-users/rugare/cancer_data/serum/SRR*/

do

lofreq indelqual --dindel -f /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/bowtie2_index/Homo_sapiens_assembly38.fasta $folder/`basename $folder`FINAL.bam
lofreq call --call-indels -f /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/bowtie2_index/Homo_sapiens_assembly38.fasta -s -S /ph-users/rugare/tools/toolkits/snpEff/databases/resources-broad-hg38-v0-Homo_sapiens_assembly38.dbsnp138.vcf -o $folder/`basename $folder`lofreq.vcf $folder/`basename $folder`FINAL.bam


done