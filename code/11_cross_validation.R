# Phase 6 - 5-Fold Cross-Validation

library(caret)
library(e1071)

# Set reproducibility
set.seed(123)

# Create five folds
folds <- createFolds(y_train, k = 5, list = TRUE)

# Store predictions for all training samples
cv_predictions <- factor(rep(NA, length(y_train)),
                         levels = levels(y_train))

# Perform cross-validation
for (i in seq_along(folds)) {

  validation_index <- folds[[i]]
  training_index <- setdiff(seq_along(y_train), validation_index)

  x_train_fold <- train_selected[training_index, , drop = FALSE]
  x_valid_fold <- train_selected[validation_index, , drop = FALSE]

  # Calculate scaling values using fold training data only
  fold_center <- colMeans(x_train_fold)
  fold_scale <- apply(x_train_fold, 2, sd)

  # Remove genes with zero variance in this fold
  valid_genes <- is.finite(fold_scale) & fold_scale > 0

  x_train_fold <- x_train_fold[, valid_genes, drop = FALSE]
  x_valid_fold <- x_valid_fold[, valid_genes, drop = FALSE]

  fold_center <- fold_center[valid_genes]
  fold_scale <- fold_scale[valid_genes]

  # Standardize training and validation data
  x_train_fold <- scale(x_train_fold, center = fold_center, scale = fold_scale)
  x_valid_fold <- scale(x_valid_fold, center = fold_center, scale = fold_scale)

  # Train SVM model
  fold_model <- svm(x = x_train_fold, y = y_train[training_index],
                    kernel = 'linear', cost = 1, scale = FALSE)

  # Predict validation samples
  cv_predictions[validation_index] <- predict(fold_model, x_valid_fold)
}

# Evaluate cross-validation predictions
cv_result <- confusionMatrix(data = cv_predictions,
                             reference = y_train,
                             positive = 'ALL')

# Display results
print(cv_result)

# Save results
capture.output(cv_result, file = 'results/cross_validation_results.txt')
write.csv(data.frame(Actual = y_train,
                     Predicted = cv_predictions),
          'results/cross_validation_predictions.csv', row.names = FALSE)
