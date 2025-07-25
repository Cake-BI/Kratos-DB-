CREATE TABLE dbo.LoanUnderwriting (
    LoanId INT,
    AdverseActionDate DATETIME,
    UCDOrigSubmissionDate DATETIME,
    ModifiedUtc BIGINT
    CONSTRAINT FK_LoanUnderwriting_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);


-- Drop table LoanUnderwriting

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
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum 








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