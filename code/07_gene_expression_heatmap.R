# Gene Expression Heatmap

library(pheatmap)

# Calculate gene variance
gene_variance <- apply(gene_expression, 1, var)

# Select top 50 variable genes
top_genes <- names(sort(gene_variance, decreasing = TRUE))[1:50]
top_expression <- gene_expression[top_genes, ]

# Create sample annotation
annotation <- data.frame(
  Leukemia_Type = sample_info$ALL.AML
)
rownames(annotation) <- rownames(sample_info)

# Create and save heatmap
png('figures/05_gene_expression_heatmap.png', width = 1200, height = 1000)
pheatmap(top_expression,
         scale = 'row',
         annotation_col = annotation,
         show_rownames = FALSE,
         main = 'Top 50 Variable Genes in Leukemia Samples')
dev.off()
