#!/bin/bash

#$ -o fastqc_out
#$ -e fastqc_err
#$ -cwd
#$ -V

> fastqc_out
> fastqc_err


for folder in /ph-users/rugare/cancer_data/serum/SRR*
do
mkdir  $folder/fastqc
fastqc -o $folder/fastqc -f fastq $folder/`basename $folder`_2.fastq $folder/`basename $folder`_1.fastq
done
