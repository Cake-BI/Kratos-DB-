CREATE TABLE dbo.Loan (
LoanID INT Primary Key IDENTITY(1000000,1) NOT NULL,
LoanNum BIGINT,
ServiceLoanNumber NVARCHAR(100),
InvestorLoanNumber NVARCHAR(100),
LoanGuID VARCHAR(40)
)

INSERT INTO dbo.Loan (
LoanNum,
LoanGuID 
)

SELECT l.LoanNumber, 
       l.EncompassId 
FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan l 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanMetaData lmd ON lmd.encompassid = l.encompassid 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF ON CF.ENCOMPASSID = lmd.ENCOMPASSID AND CF.FieldName = 'CX.OHTANI' 
WHERE lmd.LoanFolder IN (
    'Archive - Employee',
    'Completed - Employee', 
    'Adverse Loans',
    'Adverse - Employee',
    'My Pipeline',
    '(Archive)',
    'Funded - Not Purchased',
    'Completed Loans'
)

SELECT * FROM Loan


SELECT ModifiedUtc FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan


--DROP TABLE Loan

--ALTER TABLE dbo.Loan
--ADD CONSTRAINT UQ_Loan_LoanNum UNIQUE (LoanNum);

--UPDATE dbo.Loan
--SET ModifiedUtc = src.ModifiedUtc
--FROM dbo.Loan tgt
--JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan src ON tgt.LoanNum = src.LoanNumber; 


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

/*SELECT 
    fk.name AS ForeignKey_Name,
    tp.name AS Parent_Table,
    cp.name AS Parent_Column,
    tr.name AS Referenced_Table,
    cr.name AS Referenced_Column,
    fk.delete_referential_action_desc AS Delete_Action,
    fk.update_referential_action_desc AS Update_Action
FROM sys.foreign_keys fk
INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
INNER JOIN sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
INNER JOIN sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
WHERE tr.name = 'Loan'  -- Tables that reference the Loan table
ORDER BY tp.name, cp.name;*/

SELECT * FROM LoanHist