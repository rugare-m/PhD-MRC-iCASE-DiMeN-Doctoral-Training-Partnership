#This script downloads the real dataset used to benchmark the variant callers

while read line
    do
        /ph-users/rugare/cancer_data/serum/sratoolkit.3.0.0-centos_linux64/bin/prefetch $line -O ./$line
        /ph-users/rugare/cancer_data/serum/sratoolkit.3.0.0-centos_linux64/bin/fasterq-dump ./$line/$line
    done < SRP073475.txt