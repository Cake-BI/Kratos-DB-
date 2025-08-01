SELECT kl.LoanID,
FUND.FundsWireTo,
FUND.SentToFunderDate,
FUND.FundingType,
FUND.FundingOrderDate,
FUND.FundsSentDate,
FUND.CollateralSentDate,
FUND.FundsReleasedDate,
FUND.WiredToForCreditTo1,
FUND.WiredToForFurtherCreditTo1,
FUND.FundingId,
FUND.ModifiedUtc

INTO dbo.LoanFunding 
FROM dbo.Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.Loannumber = kl.LoanNum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Funding fund ON fund.encompassid = l.encompassid
WHERE fund.fundingid is not null

--DROP TABLE LoanFunding

--ALTER TABLE dbo.LoanFunding
--ALTER COLUMN FundingId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanFunding
--ADD CONSTRAINT PK_LoanFunding_FundingId PRIMARY KEY (FundingId);

--ALTER TABLE dbo.LoanFunding
--DROP CONSTRAINT [FK_LoanFunding(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanFunding
--ADD CONSTRAINT [FK_LoanFunding(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


