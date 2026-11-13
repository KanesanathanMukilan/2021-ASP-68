# Gene Expression Distribution

library(ggplot2)

# Convert expression matrix into a data frame
expression_values <- data.frame(Expression = as.vector(gene_expression))

# Create histogram
p <- ggplot(expression_values, aes(x = Expression)) +
  geom_histogram(bins = 50, fill = 'steelblue', color = 'white') +
  labs(title = 'Distribution of Gene Expression Values',
       x = 'Gene Expression Value',
       y = 'Frequency') +
  theme_minimal()

# Display and save chart
print(p)
ggsave('figures/02_expression_distribution.png', plot = p, width = 8, height = 5, dpi = 300)
