SELECT kl.LoanId,
kl.LoanNum,
kl.ServiceLoanNumber,
kl.InvestorLoanNumber,
kl.LoanGuId,
lmd.LoanMetaDataId AS LoanAdverseId

--INTO dbo.LoanAdverse
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanMetaData lmd ON lmd.encompassid = kl.loanguid AND lmd.LoanFolder = 'Adverse Loans'

--DROP TABLE LoanAdverse

--ALTER TABLE dbo.LoanAdverse
--ALTER COLUMN LoanAdverseId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanAdverse
--ADD CONSTRAINT PK_LoanAdverse_LoanAdverseId PRIMARY KEY (LoanAdverseId);

--ALTER TABLE dbo.LoanAdverse
--DROP CONSTRAINT [FK_LoanAdverse(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanAdverse
--ADD CONSTRAINT [FK_LoanAdverse(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

SELECT * FROM LoanAdverse
