#!/bin/bash

# Set paths
DATA_DIR="data/fastq"
OUT_DIR="data/trimmed"

# Create output directory if it doesn’t exist
mkdir -p $OUT_DIR

echo "Running Trim Galore..."

for fq1 in /Users/vngosb/projects/rnaseq_GSE183947/data/fastq/*_1.fastq.gz
do
    fq2=${fq1/_1.fastq.gz/_2.fastq.gz}
    trim_galore --paired -o /Users/vngosb/projects/rnaseq_GSE183947/data/trimmed $fq1 $fq2
done

echo "Trim complete. Results saved in $OUT_DIR"
