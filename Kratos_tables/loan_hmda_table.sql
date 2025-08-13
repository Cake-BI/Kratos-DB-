SELECT kl.LoanID,
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
hmda.ModifiedUtc

INTO dbo.LoanHmda
FROM dbo.Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.Loanguid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.HMDA hmda ON hmda.encompassid = l.encompassid

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

SELECT * FROM [WIN-T0FCRL091AK].Encompass.elliedb.HMDA



