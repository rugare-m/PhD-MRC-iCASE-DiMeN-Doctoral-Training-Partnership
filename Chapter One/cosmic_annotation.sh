#!/usr/bin/env bash

#$ -o cosmic_out
#$ -e cosmic_err
#$ -cwd
#$ -V

> cosmic_out
> cosmic_err


for vcf in /ph-users/rugare/cancer_data/serum/SRR*/filtered_*
do
java -Xmx8G -jar SnpSift.jar annotate -id -noInfo /ph-users/rugare/tools/toolkits/snpEff/databases/CosmicComb.vcf.gz $vcf > `dirname $vcf`/COSMIC_`basename $vcf`
done