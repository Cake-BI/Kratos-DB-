CREATE TABLE dbo.Loan (
LoanID INT Primary Key IDENTITY(1000000,1) NOT NULL,
LoanNum BIGINT,
ServiceLoanNumber NVARCHAR(100),
InvestorLoanNumber NVARCHAR(100),
LoanGuID VARCHAR(40)
)


--ALTER TABLE dbo.Loan
--ADD CONSTRAINT UQ_Loan_LoanNum UNIQUE (LoanNum);

--ALTER TABLE dbo.Loan
--ADD ModifiedUtc BIGINT;


--UPDATE dbo.Loan
--SET ModifiedUtc = src.ModifiedUtc
--FROM dbo.Loan tgt
--JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan src ON tgt.LoanNum = src.LoanNumber; 


--Drop Table Loan 


--SELECT TOP 10 * FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan
--WHERE loannumber = '2405039130'



SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH 
FROM [WIN-T0FCRL091AK].Encompass.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Borrower' 
  AND TABLE_SCHEMA = 'elliedb'
ORDER BY COLUMN_NAME ASC;