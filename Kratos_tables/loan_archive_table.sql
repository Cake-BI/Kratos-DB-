SELECT kl.LoanId,
kl.LoanNum,
kl.ServiceLoanNumber,
kl.InvestorLoanNumber,
kl.LoanGuId,
lmd.LoanMetaDataId AS LoanArchiveId

--INTO dbo.LoanArchive 
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanMetaData lmd ON lmd.encompassid = kl.loanguid AND lmd.LoanFolder = '(Archive)'

--DROP TABLE LoanArchive

--ALTER TABLE dbo.LoanArchive
--ALTER COLUMN LoanArchiveId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanArchive
--ADD CONSTRAINT PK_LoanArchive_LoanArchiveId PRIMARY KEY (LoanArchiveId);

--ALTER TABLE dbo.LoanArchive
--DROP CONSTRAINT [FK_LoanArchive(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanArchive
--ADD CONSTRAINT [FK_LoanArchive(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

SELECT * FROM LoanArchive