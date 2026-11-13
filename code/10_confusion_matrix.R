# Confusion Matrix Visualization

library(ggplot2)

# Convert confusion matrix into a data frame
cm_data <- as.data.frame(confusion_result$table)

# Create confusion matrix heatmap
p <- ggplot(cm_data, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = 'white', linewidth = 1.5) +
  geom_text(aes(label = Freq), size = 8, fontface = 'bold') +
  scale_fill_gradient(low = 'lightblue', high = 'darkblue') +
  labs(title = 'SVM Classification Confusion Matrix',
       x = 'Actual Leukemia Type',
       y = 'Predicted Leukemia Type',
       fill = 'Number of Samples') +
  theme_minimal()

# Display and save graph
print(p)
ggsave('figures/06_confusion_matrix.png', plot = p,
       width = 7, height = 6, dpi = 300)
