#!/bin/bash

# Set paths
DATA_DIR="rnaseq_GSE183947/data/trimmed"
OUT_DIR="rnaseq_GSE183947/data/qc_trimmed"

# Create output directory if it doesn’t exist
mkdir -p $OUT_DIR

echo "Running FastQC on Trimmed..."

fastqc /Users/vngosb/projects/rnaseq_GSE183947/data/trimmed/*.fq.gz \
  -o /Users/vngosb/projects/rnaseq_GSE183947/data/qc_trimmed -t 2


echo "Summarizing with MultiQC..."

multiqc /Users/vngosb/projects/rnaseq_GSE183947/data/qc_trimmed \
  -o /Users/vngosb/projects/rnaseq_GSE183947/data/qc_trimmed
  
cd $OUT_DIR
multiqc .

echo "FastQC on Trimmed complete. Results saved in $OUT_DIR"
