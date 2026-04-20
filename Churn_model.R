# 1. Import a dataset
data <- read.csv("D:/Churn_data.csv")

# 2. Basic inspection
str(data)
summary(data)

# 3. Data cleaning
data <- na.omit(data)
data$Churn <- as.factor(data$Churn)

# 4. Load libraries
library(ggplot2)
library(pROC)

# 5. EDA (visualization)
# Churn distribution
ggplot(data, aes(x = Churn)) + 
  geom_bar(fill = "maroon") + 
  theme_minimal()

# Tenure vs Churn
ggplot(data, aes(x = tenure, fill = Churn)) +
  geom_histogram(binwidth = 5) +
  theme_minimal()

# 6. Train-Test Split
set.seed(123)
train_index <- sample(1:nrow(data), 0.7 * nrow(data))
train <- data[train_index, ]
test  <- data[-train_index, ]

# 7. Logistic Regression Model

model_log <- glm(Churn ~ tenure + MonthlyCharges + TotalCharges + 
                   Contract + InternetService,
                 data = data,
                 family = "binomial")
print(model_log)


pred_dt <- predict(model_log, test, type = "terms")

# 8. Predictions
prob <- predict(model_log, newdata = test, type = "response")

# Convert probabilities to class labels
pred <- ifelse(prob > 0.5, "Yes", "No")
pred <- as.factor(pred)

# 9 Recall calculation
# True Positives
TP <- sum(pred == "Yes" & test$Churn == "Yes")

# False Negatives
FN <- sum(pred == "No" & test$Churn == "Yes")

# Recall
recall <- TP / (TP + FN)

print(paste("Recall:", recall))

# 10. Accuracy
accuracy <- mean(pred == test$Churn)
print(paste("Accuracy:", accuracy))

# 11. ROC Curve & AUC
roc_obj <- roc(test$Churn, prob)
plot(roc_obj, col = "purple")

auc_value <- auc(roc_obj)
print(paste("AUC:", auc_value))
