# 1. Load Dataset
data <- read.csv("D://Churn_data.csv")

str(data)
summary(data)

# 2. Data Cleaning (FIXED)
# Remove NA
data <- na.omit(data)

# Clean target FIRST (CRITICAL)
data$Churn <- trimws(data$Churn)
data$Churn <- ifelse(data$Churn %in% c("Yes","yes","1"), 1, 0)
data$Churn <- as.numeric(data$Churn)

# Convert categorical features to factor
for(col in names(data)) {
  if(is.character(data[[col]])) {
    data[[col]] <- as.factor(data[[col]])
  }
}

# 3. EDA
library(ggplot2)

ggplot(data, aes(x = factor(Churn))) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  ggtitle("Churn Distribution")

if("tenure" %in% names(data)){
  ggplot(data, aes(x = tenure, fill = factor(Churn))) +
    geom_histogram(binwidth = 5, alpha = 0.6, position = "identity") +
    theme_minimal()
}

# 4. Train-Test Split
library(caret)

set.seed(123)
trainIndex <- createDataPartition(data$Churn, p = 0.7, list = FALSE)

train <- data[trainIndex, ]
test  <- data[-trainIndex, ]

# Align factor levels (IMPORTANT)
for(col in names(train)) {
  if(is.factor(train[[col]])) {
    levels(test[[col]]) <- levels(train[[col]])
  }
}


# 5. Logistic Regression
train$Churn <- factor(train$Churn)
test$Churn  <- factor(test$Churn)

model_log <- glm(Churn ~ ., data = train, family = "binomial")

prob_log <- predict(model_log, test, type = "response")
pred_log <- ifelse(prob_log > 0.5, 1, 0)

# 6. Random Forest
library(randomForest)

model_rf <- randomForest(Churn ~ ., data = train, ntree = 100)
pred_rf <- predict(model_rf, test)
prob_rf <- predict(model_rf, test, type = "prob")[,2]

# 7. XGBoost (FINAL FIX)
library(xgboost)

# Convert to numeric matrix
train_matrix <- model.matrix(Churn ~ . -1, data = train)
test_matrix  <- model.matrix(Churn ~ . -1, data = test)

# Labels MUST be numeric 0/1
train_label <- as.character(train$Churn)
test_label  <- as.numeric(as.character(test$Churn))

# Safety check (DON'T REMOVE)
if(any(is.na(train_label))) stop("NA in train_label")
if(any(is.infinite(train_label))) stop("Inf in train_label")

model_xgb <- xgboost(
  x = train_matrix,
  y = train_label,
  max_depth = 6,
  learning_rate = 0.1,
  nrounds = 100,
  objective = "binary:logistic"
)

prob_xgb <- predict(model_xgb, test_matrix)
pred_xgb <- ifelse(prob_xgb > 0.5, 1, 0)

# 8. Evaluation
library(pROC)
library(caret)

# Logistic
confusionMatrix(factor(pred_log), factor(test_label))
roc_log <- roc(test_label, prob_log)
auc(roc_log)

# Random Forest
confusionMatrix(pred_rf, factor(test_label))
roc_rf <- roc(test_label, prob_rf)
auc(roc_rf)

# XGBoost
confusionMatrix(factor(pred_xgb), factor(test_label))
roc_xgb <- roc(test_label, prob_xgb)
auc(roc_xgb)

# 9. ROC Curve
plot(roc_log, col="blue")
plot(roc_rf, col="green", add=TRUE)
plot(roc_xgb, col="red", add=TRUE)

legend("bottomright",
       legend=c("Logistic","RF","XGB"),
       col=c("blue","green","red"), lwd=2)
