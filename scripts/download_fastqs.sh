#!/bin/bash
set -e

# Set paths
FASTQ_DIR="data/fastq"
SRR_LIST="metadata/SRR_Acc_List.txt"

mkdir -p "$FASTQ_DIR"

while read SRR; do
    echo "Downloading and converting $SRR..."
    fasterq-dump $SRR --outdir "$FASTQ_DIR" --split-files --threads 1

    # Compress resulting FASTQs
    gzip -f "$FASTQ_DIR/${SRR}_1.fastq"
    gzip -f "$FASTQ_DIR/${SRR}_2.fastq"

    echo "$SRR done."
done < "$SRR_LIST"

echo "All samples downloaded and converted."
