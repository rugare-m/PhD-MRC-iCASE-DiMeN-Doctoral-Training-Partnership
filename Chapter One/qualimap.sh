#!/bin/bash

#$ -o qmap_out
#$ -e qmap_err
#$ -cwd
#$ -V

> qmap_out
> qmap_err


for folder in /ph-users/rugare/cancer_data/serum/SRR*

do

mkdir  $folder/final_qualimap
mkdir  $folder/original_qualimap

qualimap bamqc -bam  $folder/`basename $folder`FINAL.bam  -outdir $folder/final_qualimap
qualimap bamqc -bam  $folder/`basename $folder`.sort.bam  -outdir $folder/original_qualimap --java-mem-size=8G -nt 16 -nw 800

done