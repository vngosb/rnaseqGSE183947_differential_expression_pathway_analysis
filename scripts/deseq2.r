#!/usr/bin/env Rscript

suppressMessages(library(DESeq2))
suppressMessages(library(readr))
suppressMessages(library(ggplot2))
suppressMessages(library(EnhancedVolcano))
suppressMessages(library(pheatmap))

# Set paths
counts_file <- "results/gene_counts_matrix.tsv"
metadata_file <- "metadata/samplesheet.txt"
out_dir <- "rnaseq_GSE183947/results/deseq2"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# Load data
counts <- read.table(counts_file, header=TRUE, row.names=1, sep="\t")
meta <- read.table(metadata_file, header=TRUE, sep="\t", row.names=1)


# Ensure column order matches metadata
counts <- counts[, rownames(meta)]

# DESeq2 analysis
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = meta,
                              design = ~ condition)

dds <- DESeq(dds)
res <- results(dds)

# Save results
write.csv(as.data.frame(res),
          file = file.path(out_dir, "DESeq2_results.csv"))

cat("DESeq2 complete. Results saved to:", file.path(out_dir, "DESeq2_results.csv"), "\n")

# PCA Plot
vsd <- vst(dds, blind = FALSE)
pca_data <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)
percentVar <- round(100 * attr(pca_data, "percentVar"))

p_pca <- ggplot(pca_data, aes(PC1, PC2, color = condition)) +
  geom_point(size = 4) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  theme_bw(base_size = 14)

ggsave(file.path(out_dir, "PCA_plot.png"), p_pca, width = 6, height = 5)

cat("PCA plot saved to:", file.path(out_dir, "PCA_plot.png"), "\n")

# Volcano Plot
p_volcano <- EnhancedVolcano(res,
                             lab = rownames(res),
                             x = 'log2FoldChange',
                             y = 'pvalue',
                             pCutoff = 0.05,
                             FCcutoff = 1.0,
                             title = 'Tumor vs Normal',
                             subtitle = 'Differentially Expressed Genes',
                             caption = 'DESeq2',
                             legendLabels = c('NS','Log2FC','p-value','p-value & Log2FC'),
                             legendPosition = 'right',
                             pointSize = 2.5)

ggsave(file.path(out_dir, "Volcano_plot.png"), p_volcano, width = 7, height = 6)

cat("Volcano plot saved to:", file.path(out_dir, "Volcano_plot.png"), "\n")

# Heatmap, top 30 by adjusted p-value
topgenes <- head(order(res$padj, na.last = NA), 30)

mat <- assay(vsd)[topgenes, ]
mat <- mat - rowMeans(mat)  # center by row (gene)

annotation <- as.data.frame(colData(vsd)[, "condition", drop = FALSE])

pheatmap(mat,
         annotation_col = annotation,
         show_rownames = TRUE,
         fontsize_row = 7,
         fontsize_col = 10,
         scale = "row",
         color = colorRampPalette(c("navy", "white", "firebrick3"))(50),
         filename = file.path(out_dir, "Heatmap_top30.png"),
         width = 6, height = 8)

cat("Heatmap saved to:", file.path(out_dir, "Heatmap_top30.png"), "\n")

