# Customer Churn Prediction

## Objective

Predict which customers are likely to stop using a service.

## Dataset

Telecom churn dataset containing:

* 	gender
* 	SeniorCitizen
* 	Partner
* 	Dependents
* 	tenure
* 	PhoneService
* 	MultipleLines
* 	InternetService
* 	OnlineSecurity
* 	OnlineBackup
* 	DeviceProtection
* 	TechSupport
* 	StreamingTV
* 	StreamingMovies
* 	Contract
* 	PaperlessBilling
* 	PaymentMethod
* 	MonthlyCharges
* 	TotalCharges
* 	Churn

## Steps Performed

1. Data Cleaning (Removed NA values)
2. Exploratory Data Analysis (EDA)
3. Logistic Regression Model
4. Random Forest
5. XGBoost
6. Evaluation using:

   * Accuracy
   * Recall
   * ROC-AUC

## Tool & Library Used

* Excel
* R
* ggplot2
* pROC
* caret
* randomForest
* xgboost

## Results

### Accuracy : 
* Logistic Regression : 0.804878
* Random Forest : 0.7926829
* XGBoost : 0.7804878

### Recall : 
* Logistic Regression : 0.8934426
* Random Forest : 0.9098361
* XGBoost : 0.8688525

### AUC :
* Logistic Regression : 0.8292
* AUC of Random Forest : 0.8182
* AUC of XGBoost : 0.8033

## Visualizations

### Churn Distribution
<img width="600" height="400" alt="Churn Distribution" src="https://github.com/user-attachments/assets/ca24bce3-7bea-44b2-84e1-2900f79c8a83" />

### Tenure vs Churn
<img width="600" height="400" alt="Tenure vs Churn" src="https://github.com/user-attachments/assets/37bca46e-300d-41be-918e-76c004f0d367" />


### ROC Curve
<img width="600" height="400" alt="ROC Curve" src="https://github.com/user-attachments/assets/97912b14-26ea-4e32-8652-1e8f1ab7ff62" />



