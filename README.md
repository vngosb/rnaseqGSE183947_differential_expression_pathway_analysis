# RNA-seq Differential Expression & Pathway Analysis
This project demonstrates a complete RNA-seq analysis pipeline from raw sequencing reads to differential expression results, using public data from GSE183947.
It was built to showcase core bioinformatics skills: reproducible pipelines, QC, read quantification, and statistical analysis with DESeq2.
📂 Project Structure
rnaseq_GSE183947/
│── metadata/               # metadata and sample information
│    ├── SRR_Acc_List.txt
│    ├── SraRunTable.csv
│    ├── samplesheet.txt
│
│── scripts/                # reproducible pipeline scripts
│    ├── deseq2.r
│    ├── download_fastqs.sh
│    ├── fastqc.sh
│    ├── fastqc_trimmed.sh
│    ├── salmon.sh
│    ├── trim.sh
│    ├── tximport.r
│
│── results/
│    └── deseq2/
│        ├── DESeq2_results.csv
│        ├── PCA_plot.png
│        ├── Heatmap_top30.png
│        └── Volcano_plot.png
│
│── requirements.txt        # software + package dependencies
│── rnaseq_analysis.ipynb   # polished report notebook
│── README.md               # project overview

Workflow Overview
[INSERT IMAGE]
Visualization
PCA plot (sample clustering) ![Alt text](./results/PCA_plot.png)
Heatmap (top 30 DE genes)
Volcano plot (significant DE genes)
📊 Results
PCA plot shows clear separation between tumor and normal samples.
Heatmap of the top 30 differentially expressed genes.
Volcano plot highlights significantly up/downregulated genes.
Full differential expression results are in:
📄 results/deseq2/DESeq2_results.csv
⚙️ Reproducibility
Dependencies
See requirements.txt for a full list.
Key tools used:
fastqc, multiqc, trim-galore
salmon (v1.10.3)
R (>=4.2.0) with DESeq2, tximport, ggplot2, pheatmap
Running the pipeline
Clone the repo:
git clone https://github.com/yourusername/rnaseq_GSE183947.git
cd rnaseq_GSE183947
Download raw FASTQ files (not included here):
bash scripts/download_fastqs.sh
Run Salmon quantification:
bash scripts/run_salmon.sh
Run DESeq2 analysis in R:
Rscript scripts/deseq2_analysis.R
📌 Notes
Raw FASTQ data are not included due to size. They can be fetched from GEO (GSE183947) or SRA using the metadata files in /metadata/.
Paths in scripts are relative to the repo root, so the pipeline should work after cloning.
✨ Portfolio Relevance
This project demonstrates:
Handling and documenting public RNA-seq datasets
Building a reproducible workflow with bash + R
Performing quality control, quantification, and DE analysis
Producing publication-style plots
Best practices for GitHub project organization
