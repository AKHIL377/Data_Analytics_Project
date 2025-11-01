create database if not exists bank_DB;

use bank_DB;

create table Debit_Credit_data(
Customer_ID varchar(250),
Customer_Name varchar(100),
Account_Number int,
Transaction_Date date,
Transaction_Type varchar(20),
Amount int,
Balance int,
Des varchar(50),
Branch varchar(50),
Transaction_Method varchar(50),
Currency varchar(10),
Bank_Name varchar(50)
);

select *from Debit_Credit_data;

SHOW VARIABLES LIKE 'datadir';
SHOW VARIABLES LIKE 'secure_file_priv';

ALTER TABLE Debit_Credit_data MODIFY Account_Number BIGINT;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Debit_Credit_Banking Data.csv'
INTO TABLE Debit_Credit_data
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

---------------------------------------------------------------
SELECT 
    SUM(Amount) AS Total_Credit_Amount
FROM Debit_Credit_data
WHERE Transaction_Type = 'Credit';
---------------------------------------------------------------
SELECT 
    SUM(Amount) AS Total_Debit_Amount
FROM Debit_Credit_data
WHERE Transaction_Type = 'Debit';
---------------------------------------------------------------
SELECT 
    ROUND(
        (SUM(CASE WHEN Transaction_Type = 'Credit' THEN Amount ELSE 0 END) /
         SUM(CASE WHEN Transaction_Type = 'Debit' THEN Amount ELSE 0 END)),
        2
    ) AS Credit_to_Debit_Ratio
FROM Debit_Credit_data;
---------------------------------------------------------------
SELECT 
    (SUM(CASE WHEN Transaction_Type = 'Credit' THEN Amount ELSE 0 END) -
     SUM(CASE WHEN Transaction_Type = 'Debit' THEN Amount ELSE 0 END)) AS Net_Transaction_Amount
FROM Debit_Credit_data;
---------------------------------------------------------------
SELECT
    DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
    COUNT(*) AS Transactions_Per_Month
FROM Debit_Credit_data
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY Month;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create table Bank_Data_Analytics(
    State_Abbr VARCHAR(10),
    Account_ID VARCHAR(50),
    Age VARCHAR(20),
    BH_Name VARCHAR(100),
    Bank_Name VARCHAR(100),
    Branc_Name VARCHAR(100),
    Caste VARCHAR(50),
    Center_Id VARCHAR(50),
    City VARCHAR(50),
    Client_id VARCHAR(50),
    Client_Name VARCHAR(100),
    Close_Client VARCHAR(10),
    Closed_Date DATE,
    Credif_Officer_Name VARCHAR(100),
    Date_of_Birth DATE,
    Disb_By VARCHAR(100),
    Disbursement_Date DATE,
    Disbursement_Date_Years VARCHAR(20),
    Gender_ID VARCHAR(10),
    Home_Ownership VARCHAR(50),
    Loan_Status VARCHAR(50),
    Loan_Transferdate VARCHAR(20),
    NextMeetingDate DATE,
    Product_Code VARCHAR(20),
    Grade VARCHAR(5),
    Sub_Grade VARCHAR(5),
    Product_Id VARCHAR(20),
    Purpose_Category VARCHAR(50),
    Region_Name VARCHAR(50),
    Religion VARCHAR(50),
    Verification_Status VARCHAR(50),
    State_Abbr_2 VARCHAR(10),
    State_Name VARCHAR(50),
    Tranfer_Logic VARCHAR(10),
    Is_Delinquent_Loan CHAR(1),
    Is_Default_Loan CHAR(1),
    Age_T INT,
    Delinq_2_Yrs INT,
    Application_Type VARCHAR(50),
    Loan_Amount int,
    Funded_Amount int,
    Funded_Amount_Inv int,
    Term VARCHAR(50),
    Int_Rate DECIMAL(10,4),
    Total_Pymnt int,
    Total_Pymnt_inv int,
    Total_Rec_Prncp int,
    Total_Fees DECIMAL(10,2),
    Total_Rrec_int DECIMAL(15,2),
    Total_Rec_Late_fee DECIMAL(15,2),
    Recoveries DECIMAL(15,2),
    Collection_Recovery_fee DECIMAL(15,2)
);

select *from Bank_Data_Analytics;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bank_Data_Analytics.csv'
INTO TABLE Bank_Data_Analytics
CHARACTER SET latin1
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

--------------------------------------------------------------------
SELECT FORMAT(SUM(Loan_Amount), 2) AS Total_Loan_Amount_Funded
FROM Bank_Data_Analytics;
--------------------------------------------------------------------
SELECT COUNT(*) AS Total_Loans
FROM Bank_Data_Analytics;
--------------------------------------------------------------------
SELECT FORMAT(SUM(Total_Rrec_int), 2) AS Total_Interest
FROM Bank_Data_Analytics;
--------------------------------------------------------------------
SELECT FORMAT(SUM(Total_Rec_Prncp + Total_Rrec_int), 2) AS Total_Collection
FROM Bank_Data_Analytics;
