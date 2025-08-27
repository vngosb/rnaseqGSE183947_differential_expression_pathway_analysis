#!/usr/bin/env Rscript

# Load libraries
suppressMessages(library(tximport))
suppressMessages(library(readr))


# Set paths
salmon_dir <- "/Users/vngosb/Projects/rnaseq_GSE183947/results/salmon"
tx2gene_file <- "/Users/vngosb/Projects/rnaseq_GSE183947/data/reference/tx2gene.csv"
out_file <- "/Users/vngosb/Projects/rnaseq_GSE183947/results/gene_counts_matrix.tsv"

# Collect all quant.sf files
files <- list.files(salmon_dir, pattern = "quant.sf", full.names = TRUE, recursive = TRUE)

if (length(files) == 0) {
    stop("No quant.sf files found in: ", salmon_dir)
}

# Assign sample names from directory structure
names(files) <- basename(dirname(files))

cat("Found quant.sf files for samples:\n")
print(names(files))


# Transcript to Gene mapping

tx2gene <- read_csv(tx2gene_file, col_names = c("TXNAME", "GENEID"))

# Run tximport
txi <- tximport(files, type="salmon", tx2gene=tx2gene, countsFromAbundance="no")

# Make sure counts are integers and non-negative
counts <- round(txi$counts)
counts[counts < 0] <- 0

# Save gene-level counts matrix
write.table(counts, out_file, sep="\t", quote=FALSE, col.names=NA)

cat("Gene-level count matrix saved to:", out_file, "\n")
