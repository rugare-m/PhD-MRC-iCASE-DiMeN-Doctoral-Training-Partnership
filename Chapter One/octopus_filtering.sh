#!/usr/bin/env bash

#$ -o SRR_filt_out
#$ -e SRR_filt_err
#$ -cwd
#$ -V

> SRR_filt_out
> SRR_filt_err

for vcf in /ph-users/rugare/cancer_data/serum/SRR*/*oct.vcf
do
#Annotate with databases
        java -Xmx8G -jar SnpSift.jar annotate -info AF_gnmd /ph-users/rugare/tools/toolkits/snpEff/databases/somatic-hg38-af-only-gnomad.hg38.vcf.gz $vcf > `dirname $vcf`/db_filtered/annotated_`basename $vcf`
#Remove low quality variants
#Remove variants of low quality
       cat `dirname $vcf`/db_filtered/annotated_`basename $vcf` | java -Xmx8G -jar SnpSift.jar filter "( DP > 20 )" > `dirname $vcf`/db_filtered/tmp1_`basename $vcf`
       cat `dirname $vcf`/db_filtered/tmp1_`basename $vcf` | java -Xmx8G -jar SnpSift.jar filter "( QUAL > 20 )" > `dirname $vcf`/db_filtered/tmp2_`basename $vcf`
#Database filtering
#gnomad
#Make a VCF with >1% variants only from the <quality1_calls.vcf>
        cat  `dirname $vcf`/db_filtered/tmp2_`basename $vcf` | java -Xmx16384m -jar SnpSift.jar filter "(AF_gnmd[ANY] > 0.01)" > `dirname $vcf`/db_filtered/tmp5_`basename $vcf`
#make a header-only VCF using the <quality1_calls.vcf>
        grep "#" `dirname $vcf`/db_filtered/tmp2_`basename $vcf` > `dirname $vcf`/filtered_`basename $vcf`
#subtract >5% variants from the <quality2_calls.vcf> and concat to the header-only VCF
        awk 'NR==FNR{Ar[$1$2$4$5]++;next} !(($1$2$4$5) in Ar)' `dirname $vcf`/db_filtered/tmp5_`basename $vcf`  `dirname $vcf`/db_filtered/tmp2_`basename $vcf` >>  `dirname $vcf`/filtered_`basename $vcf`
done