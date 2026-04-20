# Customer Churn Prediction

## Objective

Predict which customers are likely to stop using a service.

## Dataset

Telecom churn dataset containing:

* tenure
* MonthlyCharges
* TotalCharges
* Contract
* InternetService
* Churn

## Steps Performed

1. Data Cleaning (Removed NA values)
2. Exploratory Data Analysis (EDA)
3. Logistic Regression Model
4. Evaluation using:

   * Accuracy
   * Recall
   * ROC-AUC

## Tools Used

* R
* ggplot2
* pROC

## Results

* Accuracy: 0.798104265402844
* Recall: 0.482142857142857
* AUC: 0.845176267281106

## Visualizations

### Churn Distribution
<img width="600" height="400" alt="churn_distribution" src="https://github.com/user-attachments/assets/bb665948-85e2-45ff-90bb-5cb4f630295e" />

### Tenure vs Churn
<img width="600" height="400" alt="Tenure vs Churn" src="https://github.com/user-attachments/assets/d1e2debc-1c42-48db-b434-4756f2c7b70c" />

### ROC Curve
<img width="600" height="400" alt="ROC Curve" src="https://github.com/user-attachments/assets/0a92c5f2-f564-4747-8e93-b8f4584b662d" />


