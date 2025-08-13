SELECT kl.LoanId,
reo.* 

--INTO dbo.ReoProperty 
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.Loanguid = l.encompassid
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ReoProperty reo ON reo.encompassid = l.encompassid AND reo.StreetAddress is not null

--DROP TABLE dbo.ReoProperty

--ALTER TABLE dbo.ReoProperty
--ALTER COLUMN ReoPropertyId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.ReoProperty
--ADD CONSTRAINT PK_ReoProperty_ReoPropertyId PRIMARY KEY (ReoPropertyId);

--ALTER TABLE dbo.ReoProperty
--DROP CONSTRAINT [FK_ReoProperty(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.ReoProperty
--ADD CONSTRAINT [FK_ReoProperty(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;