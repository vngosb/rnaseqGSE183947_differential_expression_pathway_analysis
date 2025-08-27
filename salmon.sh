#!/bin/bash
set -e

# Set paths
TRIM_DIR="/Users/vngosb/Projects/rnaseq_GSE183947/data/trimmed"
SALMON_INDEX="/Users/vngosb/Projects/rnaseq_GSE183947/data/reference/salmon_index"
OUT_DIR="/Users/vngosb/Projects/rnaseq_GSE183947/rnaseq_GSE183947/results/salmon"

mkdir -p "$OUT_DIR"

# Loop through all trimmed R1 files
for fq1 in $TRIM_DIR/*_1_val_1.fq.gz
do
    fq2=${fq1/_1_val_1.fq.gz/_2_val_2.fq.gz}
    sample=$(basename $fq1 _1_val_1.fq.gz)

    echo "Running Salmon quantification for $sample..."

    salmon quant -i $SALMON_INDEX \
        -l A \
        -1 $fq1 \
        -2 $fq2 \
        -p 4 \
        --validateMappings \
        -o $OUT_DIR/$sample
done

echo "All samples processed with Salmon and saved in $OUT_DIR"
