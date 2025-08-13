SELECT kl.LoanId,
gfe.*

INTO dbo.FeeItemization 
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.Loanguid = l.encompassid 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Gfe2010Fee gfe ON gfe.encompassid = l.encompassid

DELETE FROM FeeItemization

--ALTER TABLE FeeItemization 
--DROP COLUMN Gfe2010Id, EncompassId, CreatedUtc, DcModifiedUtc;

--DROP TABLE FeeItemization

--ALTER TABLE dbo.FeeItemization
--ALTER COLUMN Gfe2010FeeId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.FeeItemization
--ADD CONSTRAINT PK_FeeItemization_Gfe2010FeeId PRIMARY KEY (Gfe2010FeeId);

--ALTER TABLE dbo.FeeItemization 
--DROP CONSTRAINT [FK_FeeItemization(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.FeeItemization
--ADD CONSTRAINT [FK_FeeItemization(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


