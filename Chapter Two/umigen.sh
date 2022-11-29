#!/usr/bin/env bash

#$ -o umigen_out
#$ -e umigen_err
#$ -cwd
#$ -V

> umigen_out
> umigen_err

python3 umi-gen.py snv -i /ph-users/rugare/umigen/SRR10296599.sort.bam -b /ph-users/rugare/umigen/SRR10296599.bed -f /ph-users/rugare/cancer_data/bwa_mem/Homo_sapiens_assembly38.fasta  -o /ph-users/rugare/umigen/SRR10296599 -n SRR10296599 -d 20000
