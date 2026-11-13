# PCA Analysis

# Transpose matrix: samples as rows, genes as columns
pca_result <- prcomp(t(gene_expression), scale. = TRUE)

# Prepare PCA data
pca_data <- data.frame(
  PC1 = pca_result$x[, 1],
  PC2 = pca_result$x[, 2],
  Leukemia_Type = sample_info$ALL.AML
)

# Calculate explained variance
variance_percent <- round(100 * summary(pca_result)$importance[2, 1:2], 2)

# Create PCA plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Leukemia_Type)) +
  geom_point(size = 3, alpha = 0.8) +
  labs(
    title = 'PCA of Leukemia Gene Expression',
    x = paste0('PC1 (', variance_percent[1], '%)'),
    y = paste0('PC2 (', variance_percent[2], '%)' )
  ) +
  theme_minimal()

# Display and save PCA plot
print(p)
ggsave('figures/03_pca_analysis.png', plot = p, width = 8, height = 6, dpi = 300)

# Save explained variance
write.csv(data.frame(
  PC = c('PC1', 'PC2'),
  Explained_Variance_Percent = variance_percent
), 'results/pca_variance.csv', row.names = FALSE)
