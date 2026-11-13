# Gene Expression Boxplot

library(ggplot2)

# Convert matrix into long format
expression_df <- data.frame(
  Sample = rep(colnames(gene_expression), each = nrow(gene_expression)),
  Expression = as.vector(gene_expression)
)

# Create boxplot
p <- ggplot(expression_df, aes(x = Sample, y = Expression)) +
  geom_boxplot(fill = 'lightblue', outlier.size = 0.3) +
  labs(title = 'Gene Expression Distribution Across Samples',
       x = 'Samples', y = 'Expression Values') +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

# Display and save
print(p)
ggsave('figures/04_expression_boxplot.png', plot = p, width = 10, height = 6, dpi = 300)
