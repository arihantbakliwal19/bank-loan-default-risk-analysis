# Step 1 — Import libraries

import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score

# Step 2 — Load dataset

df = pd.read_csv("loan_default_cleaned.csv")

print("Dataset loaded successfully")
print(df.shape)

# Step 3 — Encode categorical variables

label_encoders = {}

for col in df.select_dtypes(include='object').columns:
    le = LabelEncoder()
    df[col] = le.fit_transform(df[col])
    label_encoders[col] = le

# Step 4 — Define features and target

X = df.drop("Status", axis=1)
y = df["Status"]

# Step 5 — Train-test split

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.2,
    random_state=42
)

# Step 6 — Train logistic regression model

model = LogisticRegression(
    max_iter=1000,
    solver="liblinear"
)

model.fit(X_train, y_train)

# Step 7 — Predict

y_pred = model.predict(X_test)

accuracy = accuracy_score(y_test, y_pred)

print("Model Accuracy:", accuracy)

# Step 8 — Probability of default

df["Default_Probability"] = model.predict_proba(X)[:, 1]

# Step 9 — Risk category

def risk_category(p):

    if p < 0.30:
        return "Low Risk"

    elif p < 0.60:
        return "Medium Risk"

    else:
        return "High Risk"

df["Risk_Category"] = df["Default_Probability"].apply(risk_category)

# Step 10 — Export dataset for SQL / Power BI

df.to_csv("loan_risk_scored.csv", index=False)