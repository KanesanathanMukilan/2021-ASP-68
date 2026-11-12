
# ==========================================
# Leukemia Bioinformatics Project
# Phase 2: Data Import
# ==========================================

# Load required libraries
library(golubEsets)
library(Biobase)
library(tidyverse)

# Load Golub leukemia dataset
data("Golub_Merge", package = "golubEsets")

# Store dataset
leukemia_data <- Golub_Merge

# Extract gene expression matrix
gene_expression <- exprs(leukemia_data)

# Extract patient/sample information
sample_info <- pData(leukemia_data)

# ==========================================
# Dataset Inspection
# ==========================================

# Display first six gene expression rows
head(gene_expression)

# Display first six sample records
head(sample_info)

# Check dimensions
print(dim(gene_expression))

# Number of gene probes
print(nrow(gene_expression))

# Number of samples
print(ncol(gene_expression))

# Sample information dimensions
print(dim(sample_info))

# Check column names
print(colnames(sample_info))

# Check leukemia classification
print(table(sample_info$ALL.AML))

# Verify expected dataset dimensions
stopifnot(
  nrow(gene_expression) == 7129,
  ncol(gene_expression) == 72
)

# Verify sample counts
stopifnot(
  sum(sample_info$ALL.AML == "ALL") == 47,
  sum(sample_info$ALL.AML == "AML") == 25
)

# ==========================================
# Save Original Dataset
# ==========================================

write.csv(
  gene_expression,
  "data/gene_expression.csv"
)

write.csv(
  sample_info,
  "data/sample_information.csv"
)

saveRDS(
  leukemia_data,
  "data/leukemia_dataset.rds"
)

# ==========================================
# Final Message
# ==========================================

cat("\nDataset imported successfully!\n")

cat("Gene probes:", nrow(gene_expression), "\n")
cat("Samples:", ncol(gene_expression), "\n")
cat("ALL:", sum(sample_info$ALL.AML == "ALL"), "\n")
cat("AML:", sum(sample_info$ALL.AML == "AML"), "\n")
