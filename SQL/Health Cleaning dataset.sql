use healthcare_db;

select * from healthcare limit 10;


-- Query 1 — Patients By Medical conditions

SELECT Medical_Condition, 
       COUNT(*) AS Total_Patients,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare), 2) AS Percentage
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Total_Patients DESC;



-- Query 2 — Average Billing Amount for every condition 
SELECT Medical_Condition,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing,
       ROUND(MIN(Billing_Amount), 2) AS Min_Billing,
       ROUND(MAX(Billing_Amount), 2) AS Max_Billing
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Avg_Billing DESC;


-- Query 3 — Gender wise patient count and average age


SELECT Gender,
       COUNT(*) AS Total_Patients,
       ROUND(AVG(Age), 1) AS Avg_Age,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing
FROM healthcare
GROUP BY Gender;



-- Query 4 — Insurance Provider wise revenue

SELECT Insurance_Provider,
       COUNT(*) AS Total_Patients,
       ROUND(SUM(Billing_Amount), 2) AS Total_Revenue,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Revenue
FROM healthcare
GROUP BY Insurance_Provider
ORDER BY Total_Revenue DESC;


-- Query 5 — Admission Type breakdown

SELECT Admission_Type,
       COUNT(*) AS Total_Cases,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing,
       ROUND(AVG(Length_of_Stay), 1) AS Avg_Stay_Days
FROM healthcare
GROUP BY Admission_Type
ORDER BY Total_Cases DESC;


-- Query 6 — Top 10 Hospitals with Highest Revenue


SELECT Hospital,
       COUNT(*) AS Total_Patients,
       ROUND(SUM(Billing_Amount), 2) AS Total_Revenue
FROM healthcare
GROUP BY Hospital
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Query 7 — Age Group wise analysis


SELECT 
    CASE 
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 39 THEN '20-39'
        WHEN Age BETWEEN 40 AND 59 THEN '40-59'
        WHEN Age BETWEEN 60 AND 79 THEN '60-79'
        ELSE '80+'
    END AS Age_Group,
    COUNT(*) AS Total_Patients,
    ROUND(AVG(Billing_Amount), 2) AS Avg_Billing,
    Medical_Condition
FROM healthcare
GROUP BY Age_Group, Medical_Condition
ORDER BY Age_Group, Total_Patients DESC;

-- Query 8 — Test Results and Billing  relation


SELECT Test_Results,
       COUNT(*) AS Total_Patients,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing,
       ROUND(AVG(Length_of_Stay), 1) AS Avg_Stay_Days
FROM healthcare
GROUP BY Test_Results
ORDER BY Avg_Billing DESC;

-- Query 9 — Top 10 Doctors who has treated more no of patients


SELECT Doctor,
       COUNT(*) AS Total_Patients,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing,
       COUNT(DISTINCT Medical_Condition) AS Conditions_Treated
FROM healthcare
GROUP BY Doctor
ORDER BY Total_Patients DESC
LIMIT 10;

-- Query 10 — Blood Type and Medical Condition pattern


SELECT Blood_Type,
       Medical_Condition,
       COUNT(*) AS Total_Cases
FROM healthcare
GROUP BY Blood_Type, Medical_Condition
ORDER BY Blood_Type, Total_Cases DESC;


-- Query 11 — Monthly Admissions trend


SELECT 
    YEAR(Date_of_Admission) AS Year,
    MONTH(Date_of_Admission) AS Month,
    COUNT(*) AS Total_Admissions,
    ROUND(SUM(Billing_Amount), 2) AS Monthly_Revenue
FROM healthcare
GROUP BY Year, Month
ORDER BY Year, Month;

-- Query 12 — High Risk Patients — with Abnormal results 


SELECT Medical_Condition,
       Admission_Type,
       COUNT(*) AS Abnormal_Cases,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing,
       ROUND(AVG(Length_of_Stay), 1) AS Avg_Stay
FROM healthcare
WHERE Test_Results = 'Abnormal'
GROUP BY Medical_Condition, Admission_Type
ORDER BY Abnormal_Cases DESC;

-- Query 13 — Medication usage in every Condition 


SELECT Medical_Condition,
       Medication,
       COUNT(*) AS Times_Prescribed,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing
FROM healthcare
GROUP BY Medical_Condition, Medication
ORDER BY Medical_Condition, Times_Prescribed DESC;

-- Query 14 — Long Stay Patients — more then 30 days


SELECT Medical_Condition,
       Gender,
       Age,
       Hospital,
       Length_of_Stay,
       ROUND(Billing_Amount, 2) AS Billing_Amount,
       Test_Results
FROM healthcare
WHERE Length_of_Stay > 30
ORDER BY Length_of_Stay DESC
LIMIT 20;

-- Query 15 — Insurance vs Condition — Most costly combination


SELECT Insurance_Provider,
       Medical_Condition,
       COUNT(*) AS Total_Cases,
       ROUND(AVG(Billing_Amount), 2) AS Avg_Billing,
       ROUND(SUM(Billing_Amount), 2) AS Total_Billing
FROM healthcare
GROUP BY Insurance_Provider, Medical_Condition
ORDER BY Avg_Billing DESC
LIMIT 15;
