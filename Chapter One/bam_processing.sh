#!/bin/bash

#$ -o qcontrol_out
#$ -e qcontrol_err
#$ -cwd
#$ -V

> qcontrol_out
> qcontrol_err


for dir in /ph-users/rugare/cancer_data/serum/SRR*/
do
#Remove unmapped reads
/apps/bio/samtools/1.9/bin/samtools view -b -F 4 $dir/`basename $dir`.sort.bam > $dir/`basename $dir`_um.bam

/apps/bio/samtools/1.9/bin/samtools index $dir/`basename $dir`_um.bam

#Remove Duplicates
java -jar /ph-users/rugare/tools/toolkits/picard.jar MarkDuplicates \
      I=$dir/`basename $dir`_um.bam \
      O=$dir/`basename $dir`_dedup.bam \
      M=$dir/rm_dup_metrics.txt \
      REMOVE_DUPLICATES=true

/apps/bio/samtools/1.9/bin/samtools index $dir/`basename $dir`_dedup.bam

#Add read groups to the BAM
java -jar /ph-users/rugare/tools/toolkits/picard.jar AddOrReplaceReadGroups \
I=$dir/`basename $dir`_dedup.bam \
O=$dir/`basename $dir`_rg.bam \
RGID=1 \
RGLB=lib2 \
RGPL=illumina \
RGPU=unit1 \
RGSM=3


#Index rgBAM
/apps/bio/samtools/1.9/bin/samtools index $dir/`basename $dir`_rg.bam


#BaseQualityRecalibration
gatk BaseRecalibrator \
   -I $dir/`basename $dir`_rg.bam \
   -R /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/samtools_index/Homo_sapiens_assembly38.fasta \
   --known-sites /ph-users/rugare/tools/toolkits/snpEff/databases/resources-broad-hg38-v0-Homo_sapiens_assembly38.dbsnp138.vcf \
   -L chr3 \
   -L chr5 \
   -L chr6 \
   -L chr10 \
   -L chr13 \
   -L chr14 \
   -L chr16 \
   -L chr17 \
   -O $dir/calibration.table

#Apply Recalibration
gatk ApplyBQSR \
        -R /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/samtools_index/Homo_sapiens_assembly38.fasta \
        -I $dir/`basename $dir`_rg.bam \
        --bqsr-recal-file $dir/calibration.table \
        -O $dir/`basename $dir`FINAL.bam

/apps/bio/samtools/1.9/bin/samtools index $dir/`basename $dir`FINAL.bam

#BQSR comparison table
gatk BaseRecalibrator \
   -I $dir/`basename $dir`FINAL.bam \
   -R /ph-users/rugare/cancer_data/Nonacus/NonacusTools_v1.1/samtools_index/Homo_sapiens_assembly38.fasta \
   --known-sites /ph-users/rugare/tools/toolkits/snpEff/databases/resources-broad-hg38-v0-Homo_sapiens_assembly38.dbsnp138.vcf \
   -L chr3 \
   -L chr5 \
   -L chr6 \
   -L chr10 \
   -L chr13 \
   -L chr14 \
   -L chr16 \
   -L chr17 \
   -O $dir/post_calibration.table
done
