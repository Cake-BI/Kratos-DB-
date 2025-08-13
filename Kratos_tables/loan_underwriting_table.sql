CREATE TABLE dbo.LoanUnderwriting (
    LoanId INT,
    AdverseActionDate DATETIME,
    UCDOrigSubmissionDate DATETIME,
    ModifiedUtc BIGINT
    CONSTRAINT FK_LoanUnderwriting_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);

--DELETE FROM LoanUnderwriting

--Drop table LoanUnderwriting

--ALTER TABLE dbo.LoanUnderwriting
--DROP CONSTRAINT [FK_LoanUnderwriting(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanUnderwriting
--ADD CONSTRAINT [FK_LoanUnderwriting(LoanId)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

INSERT INTO dbo.LoanUnderwriting (
    LoanId,
    AdverseActionDate,
    UCDOrigSubmissionDate,
    ModifiedUtc
)

SELECT kl.LoanId, 
l.AdverseActionDate,
l.UCDOrigSubmissionDate,
l.modifiedutc

FROM dbo.loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.loanguid 








/* SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE,
    IS_NULLABLE
FROM [WIN-T0FCRL091AK].Encompass.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Loan'
  AND TABLE_SCHEMA = 'elliedb'  -- adjust schema if needed
--ORDER BY COLUMN_NAME */ 