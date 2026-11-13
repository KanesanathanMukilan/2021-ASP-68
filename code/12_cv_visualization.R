# Cross-validation confusion matrix

library(ggplot2)

cv_cm_data <- as.data.frame(cv_result$table)

p <- ggplot(cv_cm_data,
            aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = 'white', linewidth = 1.5) +
  geom_text(aes(label = Freq), size = 8, fontface = 'bold') +
  scale_fill_gradient(low = 'lightblue', high = 'darkblue') +
  labs(title = '5-Fold Cross-Validation Confusion Matrix',
       x = 'Actual Leukemia Type',
       y = 'Predicted Leukemia Type') +
  theme_minimal()

print(p)
ggsave('figures/07_cross_validation_matrix.png',
       plot = p, width = 7, height = 6, dpi = 300)
