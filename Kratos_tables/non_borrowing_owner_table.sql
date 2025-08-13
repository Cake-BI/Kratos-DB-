SELECT kl.LoanId,
nbo.*

--INTO dbo.NonBorrowingOwner
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.Loanguid = l.encompassid 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.NonBorrowingOwner nbo ON nbo.encompassid = l.encompassid



--DROP TABLE dbo.NonBorrowingOwner

--ALTER TABLE dbo.NonBorrowingOwner
--ALTER COLUMN NonBorrowingOwnerId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.NonBorrowingOwner
--ADD CONSTRAINT PK_NonBorrowingOwner_NonBorrowingOwnerId PRIMARY KEY (NonBorrowingOwnerId);

--ALTER TABLE dbo.NonBorrowingOwner
--DROP CONSTRAINT [FK_NonBorrowingOwner(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.NonBorrowingOwner 
--ADD CONSTRAINT [FK_NonBorrowingOwner(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

--ALTER TABLE NonBorrowingOwner 
--DROP COLUMN encompassId, dcmodifiedutc, createdutc, entitydeleted, Id