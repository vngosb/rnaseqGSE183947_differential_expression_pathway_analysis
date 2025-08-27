#!/bin/bash

# Set paths
DATA_DIR="data/fastq"
OUT_DIR="results/qc"

# Create output directory if it doesn’t exist
mkdir -p $OUT_DIR

echo "Running FastQC..."

fastqc $DATA_DIR/*.fastq.gz -o $OUT_DIR -t 4

echo "Summarizing with MultiQC..."
cd $OUT_DIR
multiqc .

echo "FastQC complete. Results saved in $OUT_DIR"
