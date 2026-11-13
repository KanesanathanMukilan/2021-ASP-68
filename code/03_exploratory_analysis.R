# Exploratory Data Analysis - Sample Distribution

library(ggplot2)

# Load sample information
sample_info <- read.csv('data/clean_sample_information.csv', row.names = 1)

# Count samples in each leukemia type
sample_counts <- as.data.frame(table(sample_info$ALL.AML))
colnames(sample_counts) <- c('Leukemia_Type', 'Number_of_Samples')

# Create bar chart
p <- ggplot(sample_counts, aes(x = Leukemia_Type, y = Number_of_Samples, fill = Leukemia_Type)) +
  geom_col(width = 0.6) +
  labs(title = 'Distribution of Leukemia Samples',
       x = 'Leukemia Type',
       y = 'Number of Samples') +
  theme_minimal() +
  theme(legend.position = 'none')

# Display and save chart
print(p)
ggsave('figures/01_sample_distribution.png', plot = p, width = 7, height = 5, dpi = 300)
