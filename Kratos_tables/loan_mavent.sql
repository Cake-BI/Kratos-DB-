SELECT kl.LoanId, 
MaventReviewResult,
MaventOfacResult,
MaventOtherResult,
MaventStateResult,
MaventTilaRorResult,
MaventTilaToleranceResult,
MaventAutoOrderIndicator,
MaventHpmlResult,
MaventNmlsResult,
MaventATRQMResult,
AveragePercentageRate,
MaventOrderedBy,
FinanceChargeAmount,
FederalTotalLoanAmount,
StateTotalLoanAmount,
QmPointsAndFeesTotal,
AbilityToRepayLoanType,
QualifiedMortgageLoanType,
QualifiedMortgageEligible,
HigherPricedCoveredTrans,
LoanTermAndFeatures,
QmPointsAndFeesLimit,
MaventOrderedDate,
UnderwritingFactors,
QmPriceBasedLimit,
ReviewId,
MaventCraxResult,
MaventEnterpriseResult,
MaventGseResult,
MaventHighCostResult,
MaventHmdaResult,
m.MaventLicenseResult,
m.MiscellaneousId AS LoanMaventId,
m.ModifiedUtc

INTO dbo.LoanMavent 
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.loanguid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.miscellaneous m ON m.encompassid = l.encompassid
--WHERE LoanNumber = '7508048152'

--SELECT * FROM LoanMavent

SELECT ModifiedUtc FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan
WHERE LoanNumber = '2508048412'

SELECT ModifiedUtc FROM Loan
WHERE LoanNum = '2508048412'

--DROP TABLE dbo.LoanMavent

--ALTER TABLE dbo.LoanMavent
--ALTER COLUMN LoanMaventId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanMavent
--ADD CONSTRAINT PK_LoanMavent_LoanMaventId PRIMARY KEY (LoanMaventId);

--ALTER TABLE dbo.LoanMavent
--DROP CONSTRAINT [FK_LoanMavent(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanMavent
--ADD CONSTRAINT [FK_LoanMavent(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


SELECT lw.Mavent, Count(*)
FROM Residence lw
LEFT JOIN Loan l ON l.loanid = lw.loanid
Group by lw.LoanID 
Having Count(*) > 1


SELECT * FROM Residence
WHERE LoanID = '1025133';




