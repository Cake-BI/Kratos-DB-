SELECT kl.LoanId,
cc.Section1000SellerPaidTotalAmount,
cc.Section1000BorrowerPaidTotalAmount,
cc.AggregateAdjustmentFwbc,
cc.AdjustmentFactor,
cc.ClosingCostId, 
cc.ModifiedUtc


INTO dbo.LoanClosingCost
FROM dbo.Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.LoanGuID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingCost cc ON cc.encompassId = l.encompassid

--DROP TABLE LoanClosingCost

--ALTER TABLE dbo.LoanClosingCost
--ALTER COLUMN ClosingCostId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanClosingCost
--ADD CONSTRAINT PK_LoanClosingCost_ClosingCostId PRIMARY KEY (ClosingCostId);

--ALTER TABLE dbo.LoanClosingCost
--DROP CONSTRAINT [FK_LoanClosingCost(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanClosingCost
--ADD CONSTRAINT [FK_LoanClosingCost(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

--EXAMPLE FOR UPDATING A COLUMN THAT WAS FORGOTTEN IN THE INITIAL CREATION--

/* UPDATE lcc
SET lcc.Section1000OtherCreditsAmount = cc.Section1000OtherCreditsAmount
FROM dbo.LoanClosingCost lcc
JOIN dbo.Loan kl ON lcc.LoanId = kl.LoanId
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.Loannumber = kl.LoanNum
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingCost cc ON cc.encompassId = l.encompassid; */


SELECT * FROM loanclosingcost

