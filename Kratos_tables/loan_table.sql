CREATE TABLE dbo.Loan (
LoanID INT Primary Key IDENTITY(1000000,1) NOT NULL,
LoanNum BIGINT,
ServiceLoanNumber NVARCHAR(100),
InvestorLoanNumber NVARCHAR(100),
LoanGuID VARCHAR(40)
)

Insert Into dbo.Loan (
LoanNum,
LoanGuID
)
SELECT LoanNumber,
EncompassID

From [WIN-T0FCRL091AK].Encompass.elliedb.Loan 



-- Drop Table Loan 

ALTER TABLE Borrower
ADD CONSTRAINT FK_Borrower_LoanID
FOREIGN KEY (LoanID)
REFERENCES Loan(LoanID);

ALTER TABLE Borrower
DROP CONSTRAINT FK_borrower_LoanID;




SELECT TOP 10 * FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan
WHERE loannumber = 2405039130

SELECT TOP 10 * FROM Property











SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH 
FROM [WIN-T0FCRL091AK].Encompass.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Loan' 
  AND TABLE_SCHEMA = 'elliedb'
ORDER BY COLUMN_NAME ASC;