# RNA-seq Differential Expression & Pathway Analysis

This project demonstrates a complete RNA-seq analysis pipeline from raw sequencing reads to differential expression results, using public data from **GSE183947**.  
It showcases core bioinformatics skills: reproducible pipelines, QC, read quantification, and statistical analysis with **DESeq2**.

---

## 📂 Project Structure

rnaseq_GSE183947/
│── metadata/ # metadata and sample information
│ ├── SRR_Acc_List.txt
│ ├── SraRunTable.csv
│ ├── samplesheet.txt
│
│── scripts/ # reproducible pipeline scripts
│ ├── deseq2.r
│ ├── download_fastqs.sh
│ ├── fastqc.sh
│ ├── fastqc_trimmed.sh
│ ├── salmon.sh
│ ├── trim.sh
│ ├── tximport.r
│
│── results/
│ └── deseq2/
│ ├── DESeq2_results.csv
│ ├── PCA_plot.png
│ ├── Heatmap_top30.png
│ └── Volcano_plot.png
│
│── requirements.txt # software + package dependencies
│── rnaseq_analysis.ipynb # polished report notebook
│── README.md # project overview


---

## Workflow Overview

![Workflow Overview](./results/WORKFLOW_IMAGE.png)

---

## Visualization

**PCA plot (sample clustering)**  
![PCA Plot](./results/deseq2/PCA_plot.png)

**Heatmap (top 30 DE genes)**  
![Heatmap](./results/deseq2/Heatmap_top30.png)

**Volcano plot (significant DE genes)**  
![Volcano Plot](./results/deseq2/Volcano_plot.png)

---

## Results

- PCA plot shows clear separation between tumor and normal samples.  
- Heatmap of the top 30 differentially expressed genes highlights expression patterns.  
- Volcano plot highlights significantly up- and down-regulated genes.  

Full differential expression results are in:  
📄 `results/deseq2/DESeq2_results.csv`

---

## ⚙️ Reproducibility

### Dependencies

See `requirements.txt` for a full list. Key tools used:

- `fastqc`, `multiqc`, `trim-galore`  
- `salmon (v1.10.3)`  
- R (>=4.2.0) with **DESeq2**, **tximport**, **ggplot2**, **pheatmap**

### Running the pipeline

```bash
# Clone the repo
git clone https://github.com/vngosb/rnaseq_GSE183947.git
cd rnaseq_GSE183947

# Download raw FASTQ files (not included here)
bash scripts/download_fastqs.sh

# Run Salmon quantification
bash scripts/salmon.sh

# Run DESeq2 analysis in R
Rscript scripts/deseq2.r
