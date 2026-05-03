CREATE DATABASE loan_project;
USE loan_project;
CREATE TABLE loan_data (
    loan_limit VARCHAR(20),
    Gender VARCHAR(10),
    approv_in_adv VARCHAR(10),
    loan_type VARCHAR(20),
    loan_purpose VARCHAR(50),
    Credit_Worthiness VARCHAR(20),
    open_credit VARCHAR(10),
    business_or_commercial VARCHAR(10),
    loan_amount FLOAT,
    rate_of_interest FLOAT,
    Interest_rate_spread FLOAT,
    Upfront_charges FLOAT,
    term INT,
    Neg_ammortization VARCHAR(10),
    interest_only VARCHAR(10),
    lump_sum_payment VARCHAR(10),
    property_value FLOAT,
    construction_type VARCHAR(20),
    occupancy_type VARCHAR(20),
    Secured_by VARCHAR(20),
    total_units VARCHAR(20),
    income FLOAT,
    credit_type VARCHAR(20),
    Credit_Score INT,
    co_applicant_credit_type VARCHAR(20),
    age VARCHAR(20),
    submission_of_application VARCHAR(20),
    LTV FLOAT,
    Region VARCHAR(20),
    Security_Type VARCHAR(20),
    Status INT,
    dtir1 FLOAT,
    Default_Probability FLOAT,
    Risk_Category VARCHAR(20)
);
SHOW TABLES;
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/loan_risk_scored.csv'
INTO TABLE loan_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM loan_data;

SELECT
    Risk_Category,
    COUNT(*) AS Customers,
    AVG(Status) * 100 AS Default_Rate
FROM loan_data
GROUP BY Risk_Category;

SELECT
    Region,
    COUNT(*) AS Total_Loans
FROM loan_data
GROUP BY Region;

SELECT
    Risk_Category,
    AVG(loan_amount) AS Avg_Loan_Amount
FROM loan_data
GROUP BY Risk_Category;

SELECT *
FROM loan_data
WHERE Risk_Category = 'High Risk';
