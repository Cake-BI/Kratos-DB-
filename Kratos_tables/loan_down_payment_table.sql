SELECT kl.LoanId,
dp.DownPaymentType,
dp.SourceDescription,
dp.Amount, 
dp.ModifiedUtc,
dp.DownPaymentId

INTO dbo.LoanDownPayment
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.LoanNumber = kl.LoanNum 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Downpayment dp ON dp.encompassid = l.encompassid

--DROP TABLE dbo.LoanDownPayment

--ALTER TABLE dbo.LoanDownPayment
--ALTER COLUMN LoanID NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanDownPayment
--ADD CONSTRAINT PK_LoanDownPayment_LoanId PRIMARY KEY (LoanID);

--ALTER TABLE dbo.LoanDownPayment
--DROP CONSTRAINT [FK_LoanDownPayment(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanDownPayment 
--ADD CONSTRAINT [FK_LoanDownPayment(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


