# Phase 5 - SVM Classification

library(caret)
library(e1071)

# Match sample information with expression matrix
sample_info <- sample_info[colnames(gene_expression), , drop = FALSE]
stopifnot(identical(colnames(gene_expression), rownames(sample_info)))

# Prepare target variable
y <- factor(sample_info$ALL.AML, levels = c('ALL', 'AML'))

# Split dataset into training and testing sets
set.seed(123)
train_index <- createDataPartition(y, p = 0.70, list = FALSE)

# Separate training and testing data
train_x <- t(gene_expression[, train_index, drop = FALSE])
test_x <- t(gene_expression[, -train_index, drop = FALSE])
y_train <- y[train_index]
y_test <- y[-train_index]

# Select top 100 variable genes using training data only
gene_variance <- apply(train_x, 2, var)
gene_variance[!is.finite(gene_variance)] <- 0
top_genes <- names(sort(gene_variance, decreasing = TRUE))[1:100]

# Remove genes with zero variance
top_genes <- top_genes[gene_variance[top_genes] > 0]

# Prepare selected gene data
train_selected <- train_x[, top_genes, drop = FALSE]
test_selected <- test_x[, top_genes, drop = FALSE]

# Standardize using training data statistics
train_scaled <- scale(train_selected)
centers <- attr(train_scaled, 'scaled:center')
scales <- attr(train_scaled, 'scaled:scale')
test_scaled <- scale(test_selected, center = centers, scale = scales)

# Save prepared datasets
write.csv(data.frame(Sample = rownames(train_scaled),
                     Leukemia_Type = y_train),
          'results/training_samples.csv', row.names = FALSE)
write.csv(data.frame(Sample = rownames(test_scaled),
                     Leukemia_Type = y_test),
          'results/testing_samples.csv', row.names = FALSE)

# Display dataset sizes
cat('Training samples:', nrow(train_scaled), '\n')
cat('Testing samples:', nrow(test_scaled), '\n')
cat('Selected genes:', length(top_genes), '\n')
