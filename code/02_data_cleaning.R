
# ==========================================
# Leukemia Bioinformatics Project
# Phase 3: Data Cleaning and Preprocessing
# ==========================================

# Load required package
library(tidyverse)

# ==========================================
# 1. Import Dataset
# ==========================================

gene_expression <- read.csv(
  "data/gene_expression.csv",
  row.names = 1,
  check.names = FALSE
)

sample_info <- read.csv(
  "data/sample_information.csv",
  row.names = 1,
  check.names = FALSE
)

# Convert expression data into matrix
gene_expression <- as.matrix(gene_expression)

# ==========================================
# 2. Check Dataset Dimensions
# ==========================================

cat("\n===== DATASET DIMENSIONS =====\n")

print(dim(gene_expression))
print(dim(sample_info))

# Check numeric format
stopifnot(is.numeric(gene_expression))

# Check sample alignment
stopifnot(
  identical(
    colnames(gene_expression),
    rownames(sample_info)
  )
)

# ==========================================
# 3. Missing Value Analysis
# ==========================================

missing_expression <- sum(is.na(gene_expression))

missing_metadata <- sum(is.na(sample_info))

cat("\n===== MISSING VALUES =====\n")

cat("Expression missing values:",
    missing_expression, "\n")

cat("Metadata missing values:",
    missing_metadata, "\n")

# Missing values in each metadata column
print(colSums(is.na(sample_info)))

# ==========================================
# 4. Check Infinite Values
# ==========================================

infinite_values <- sum(is.infinite(gene_expression))

cat("\nInfinite values:", infinite_values, "\n")

# ==========================================
# 5. Check Duplicate Probes
# ==========================================

duplicate_probes <- sum(
  duplicated(rownames(gene_expression))
)

cat("Duplicate probes:", duplicate_probes, "\n")

# ==========================================
# 6. Calculate Gene Variance
# ==========================================

gene_variance <- apply(
  gene_expression,
  1,
  var
)

# Check zero variance
zero_variance <- sum(
  gene_variance == 0,
  na.rm = TRUE
)

cat("Zero variance probes:", zero_variance, "\n")

# ==========================================
# 7. Save Gene Variance Results
# ==========================================

write.csv(
  data.frame(
    Probe = names(gene_variance),
    Variance = gene_variance
  ),
  "results/gene_variance.csv",
  row.names = FALSE
)

# ==========================================
# 8. Save Verified Data
# ==========================================

write.csv(
  gene_expression,
  "data/clean_gene_expression.csv"
)

write.csv(
  sample_info,
  "data/clean_sample_information.csv"
)

# ==========================================
# 9. Final Quality Control Report
# ==========================================

cat("\n===== QUALITY CONTROL REPORT =====\n")

cat("Total gene probes:",
    nrow(gene_expression), "\n")

cat("Total samples:",
    ncol(gene_expression), "\n")

cat("Missing expression values:",
    missing_expression, "\n")

cat("Missing metadata values:",
    missing_metadata, "\n")

cat("Infinite values:",
    infinite_values, "\n")

cat("Duplicate probes:",
    duplicate_probes, "\n")

cat("Zero variance probes:",
    zero_variance, "\n")

cat("ALL samples:",
    sum(sample_info$ALL.AML == "ALL"), "\n")

cat("AML samples:",
    sum(sample_info$ALL.AML == "AML"), "\n")

cat("\nData cleaning completed successfully!\n")
