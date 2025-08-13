SELECT kl.LoanId,
dp.DownPaymentType,
dp.SourceDescription,
dp.Amount, 
dp.ModifiedUtc,
dp.DownPaymentId

INTO dbo.LoanDownPayment
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.Loanguid 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Downpayment dp ON dp.encompassid = l.encompassid

--DROP TABLE dbo.LoanDownPayment

--ALTER TABLE dbo.LoanDownPayment
--ALTER COLUMN DownPaymentId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanDownPayment
--ADD CONSTRAINT PK_LoanDownPayment_LoanId PRIMARY KEY (LoanID);

--ALTER TABLE dbo.LoanDownPayment
--DROP CONSTRAINT [FK_LoanDownPayment(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanDownPayment 
--ADD CONSTRAINT [FK_LoanDownPayment(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Loan' 
    AND COLUMN_NAME = 'LoanID'
    AND TABLE_SCHEMA = 'dbo';

    SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'LoanDownPayment' 
    AND COLUMN_NAME = 'LoanId'
    AND TABLE_SCHEMA = 'dbo';