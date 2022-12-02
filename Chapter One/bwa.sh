#!/bin/bash

#$ -o align_out
#$ -e align_err
#$ -cwd
#$ -V

> align_out
> align_err

for fq in /ph-users/rugare/cancer_data/serum/SRR*/*_1.fastq
do
/apps/bio/bwa/0.7.17/bwa mem -t 32 -o `dirname $fq`/`basename $fq _1.fastq`.sam /ph-users/rugare/cancer_data/bwa_mem/Homo_sapiens_assembly38.fasta $fq `dirname $fq`/`basename $fq _1.fastq`_2.f$
done