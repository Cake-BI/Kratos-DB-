SELECT kl.LoanId,
i.Owner,
i.IncomeType,
i.Amount,
i.ApplicationId,
b.BorrowerId,
i.IncomeId, 
i.ModifiedUtc 


--INTO dbo.Income 
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.LoanNumber = kl.LoanNum 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b ON b.encompassId = l.encompassId AND b.FullName is not null
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Income I ON I.applicationid = b.applicationid AND i.Owner = b.ApplicantType

--DROP TABLE Income

--ALTER TABLE dbo.Income
--ALTER COLUMN IncomeId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.Income
--ADD CONSTRAINT PK_Income_IncomeId PRIMARY KEY (IncomeId);

--ALTER TABLE dbo.Income 
--DROP CONSTRAINT [FK_Income(LoanID)_Loan(LoanID)];

ALTER TABLE dbo.Income
ADD CONSTRAINT [FK_Income(LoanID)_Loan(LoanID)]
FOREIGN KEY (LoanID)
REFERENCES dbo.Loan(LoanID)
ON DELETE CASCADE;

--ALTER TABLE dbo.Income
--ADD CONSTRAINT [FK_Income(ApplicationId)_Application(ApplicationId)]
--FOREIGN KEY (ApplicationId)
--REFERENCES dbo.Application(ApplicationId)
--ON DELETE CASCADE;

SELECT * FROM Income
Where owner is null



SELECT * FROM Loan l 
Left Join borrower b ON b.loanId = l.loanId 
Left Join Income i ON i.borrowerid = b.borrowerid and i.owner = b.applicanttype 
WHERE l.loannum = '2411041520'



