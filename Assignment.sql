CREATE TABLE Hospital(
	Hospital_Name Varchar(50),
	Location Varchar(50),
	Department Varchar(50),
	Doctors_Count	Int,
	Patients_Count	Int,
	Admission_Date	Date,
	Discharge_Date	Date,
	Medical_Expenses Numeric(10,2)

);

SELECT*FROM Hospital;

-- 1. Total Number of Patients 
-- Q.Write an SQL query to find the total number of patients across all hospitals.
SELECT SUM(Patients_Count) AS Total_Patients
FROM Hospital;

-- 2. Average Number of Doctors per Hospital 
-- Q.Retrieve the average count of doctors available in each hospital.
SELECT Hospital_Name, Avg(Doctors_Count) AS Average_Doctors
FROM Hospital
GROUP BY Hospital_Name;

-- 3.Top 3 Departments with the Highest Number of Patients 
-- Q.Find the top 3 hospital departments that have the highest number of patients. 
SELECT Department, SUM(Patients_Count) AS Total_Patients
FROM Hospital
GROUP BY Department
ORDER BY Total_Patients DESC
LIMIT 3;

-- 4.Hospital with the Maximum Medical Expenses 
-- Q.Identify the hospital that recorded the highest medical expenses. 
SELECT Hospital_Name, SUM(Medical_Expenses) AS Total_Expenses
FROM Hospital
GROUP BY Hospital_Name
ORDER BY Total_Expenses DESC
LIMIT 1;


-- 5. Daily Average Medical Expenses 
-- Q.Calculate the average medical expenses per day for each hospital.
SELECT 
    Hospital_Name,
    AVG(Medical_Expenses / (Discharge_Date - Admission_Date)) AS Avg_Daily_Expense
FROM Hospital
WHERE Discharge_Date > Admission_Date
GROUP BY Hospital_Name;

-- 6.Longest Hospital Stay 
-- Q.Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
SELECT 
    Hospital_Name,
    Department,
    (Discharge_Date - Admission_Date) AS Stay_Duration
FROM Hospital
ORDER BY Stay_Duration DESC
LIMIT 1;

-- 7.Total Patients Treated Per City 
-- Q.Count the total number of patients treated in each city.
SELECT Location AS City, SUM(Patients_Count) AS Total_Patients
FROM Hospital
GROUP BY Location;

-- 8. Average Length of Stay Per Department 
-- Q.Calculate the average number of days patients spend in each department.
SELECT 
    Department,
    AVG(Discharge_Date - Admission_Date) AS Avg_Stay_Days
FROM Hospital
GROUP BY Department;

-- 9.Identify the Department with the Lowest Number of Patients 
-- Q.Find the department with the least number of patients.
SELECT Department, SUM(Patients_Count) AS Total_Patients
FROM Hospital
GROUP BY Department
ORDER BY Total_Patients ASC
LIMIT 1;

-- 10. Monthly Medical Expenses Report 
-- Q.Group the data by month and calculate the total medical expenses for each month.
SELECT 
    DATE_TRUNC('month', Admission_Date) AS Month,
    SUM(Medical_Expenses) AS Total_Monthly_Expenses
FROM Hospital
GROUP BY Month
ORDER BY Month;
