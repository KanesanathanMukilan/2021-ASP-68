# Train SVM Classification Model

library(e1071)
library(caret)

# Train the SVM model
svm_model <- svm(
  x = train_scaled,
  y = y_train,
  kernel = 'linear',
  cost = 1,
  scale = FALSE
)

# Predict leukemia types for test samples
predictions <- predict(svm_model, test_scaled)

# Evaluate model performance
confusion_result <- confusionMatrix(
  data = predictions,
  reference = y_test,
  positive = 'ALL'
)

# Display evaluation results
print(confusion_result)

# Save model and predictions
saveRDS(svm_model, 'results/svm_model.rds')
write.csv(data.frame(
  Actual = y_test,
  Predicted = predictions
), 'results/svm_predictions.csv', row.names = FALSE)

# Save evaluation report
capture.output(confusion_result, file = 'results/svm_evaluation.txt')
