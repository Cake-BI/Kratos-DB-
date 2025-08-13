SELECT kl.LoanId,
kl.LoanNum,
kl.ServiceLoanNumber,
kl.InvestorLoanNumber,
kl.LoanGuId,
lmd.LoanMetaDataId AS LoanCompletedId

INTO dbo.LoanCompleted 
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanMetaData lmd ON lmd.encompassid = kl.loanguid AND lmd.LoanFolder = 'Completed Loans'

--DROP TABLE LoanCompleted

--ALTER TABLE dbo.LoanCompleted
--ALTER COLUMN LoanCompletedId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanCompleted
--ADD CONSTRAINT PK_LoanCompleted_LoanCompletedId PRIMARY KEY (LoanCompletedId);

--ALTER TABLE dbo.LoanCompleted
--DROP CONSTRAINT [FK_LoanCompleted(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanCompleted
--ADD CONSTRAINT [FK_LoanCompleted(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;
