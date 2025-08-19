SELECT kl.LoanID,
cf.StringValue,
hmda.LegalEntityIdentifier,
hmda.UniversalLoanId,
hmda.ApplicationDate,
hmda.LoanType,
hmda.LoanPurpose,
hmda.Preapprovals,
hmda.LoanAmount,
hmda.ActionTaken,
hmda.ContactName,
hmda.ContactEmailAddress,
hmda.ContactPhoneNumber,
hmda.ContactOfficeStreetAddress,
hmda.ContactOfficeCity,
hmda.ContactOfficeState,
hmda.ContactOfficeZipCode,
hmda.FederalAgency,
hmda.FederalTaxpayerIdNumber,
hmda.CensusTrack,
hmda.Income,
hmda.TypeOfPurchaser,
hmda.RateSpread,
hmda.HoepaStatus,
hmda.LienStatus,
hmda.TotalLoanCosts,
hmda.TotalPointsAndFees,
hmda.OriginationCharges,
hmda.DiscountPoints,
hmda.LenderCredits,
hmda.InterestRate,
hmda.PrepaymentPenaltyPeriod,
hmda.DebtToIncomeRatio,
hmda.LoanTerm,
hmda.PropertyValue,
hmda.ManufacturedSecuredProperyType,
hmda.ManufacturedHomeLandPropertyInterest,
hmda.SubmissionOfApplication,
hmda.InitiallyPayableToYourInstitution,
hmda.ReverseMortgage,
hmda.OpenEndLineOfCredit,
hmda.BusinessOrCommercialPurpose,
hmda.HmdaId,
kl.ModifiedUtc

--INTO dbo.LoanHmda
FROM dbo.Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.Loanguid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.HMDA hmda ON hmda.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField cf ON cf.encompassid = hmda.encompassid AND cf.FieldName = 'CX.OHTANI'


--DROP TABLE LoanHmda

--ALTER TABLE dbo.LoanHmda
--ALTER COLUMN HmdaId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanHmda
--ADD CONSTRAINT PK_LoanHmda_HmdaId PRIMARY KEY (HmdaId);

--ALTER TABLE dbo.LoanHmda
--DROP CONSTRAINT [FK_LoanHmda(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanHmda
--ADD CONSTRAINT [FK_LoanHmda(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

SELECT StringValue, ModifiedUtc FROM LoanHmda
WHERE loanID = '1027091'

SELECT * FROM Loan 
WHERE LoanNum = '7508048121'

SELECT ModifiedUtc FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan
WHERE encompassid = 'c9046f5f-f374-4a2f-ab2f-1644a8ddba79'

SELECT loan.modifiedutc, p.ModifiedUtc FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Ratelock p ON p.encompassid = loan.encompassid
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application a ON a.encompassid = p.encompassid
WHERE p.encompassid = 'c9046f5f-f374-4a2f-ab2f-1644a8ddba79'

WHERE LoanId = '1027091'



