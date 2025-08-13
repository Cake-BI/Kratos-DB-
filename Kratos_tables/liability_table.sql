SELECT kl.LoanId, li.* 

INTO dbo.Liability
FROM dbo.Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.loanguid 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Liability li ON li.encompassid = l.encompassid

--DROP TABLE Liability 

--ALTER TABLE dbo.Liability
--ALTER COLUMN LiabilityId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.Liability
--ADD CONSTRAINT PK_Liability_LiabilityId PRIMARY KEY (LiabilityId);

--ALTER TABLE dbo.Liability
--DROP CONSTRAINT [FK_Liabilty(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.Liability
--ADD CONSTRAINT [FK_LiabilityId(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

