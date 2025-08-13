SELECT kl.LoanId,
kl.LoanNum,
kl.ServiceLoanNumber,
kl.InvestorLoanNumber,
kl.LoanGuId,
lmd.LoanMetaDataId AS LoanFundedId

INTO dbo.LoanFundedNotPurchased
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanMetaData lmd ON lmd.encompassid = kl.loanguid AND lmd.LoanFolder = 'Funded - Not Purchased'

--DROP TABLE LoanFundedNotPurchased

--ALTER TABLE dbo.LoanFundedNotPurchased
--ALTER COLUMN LoanFundedId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanFundedNotPurchased
--ADD CONSTRAINT PK_LoanFundedNotPurchased_LoanFundedId PRIMARY KEY (LoanFundedId);

--ALTER TABLE dbo.LoanFundedNotPurchased
--DROP CONSTRAINT [FK_LoanFundedNotPurchased(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanFundedNotPurchased
--ADD CONSTRAINT [FK_LoanFundedNotPurchased(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

