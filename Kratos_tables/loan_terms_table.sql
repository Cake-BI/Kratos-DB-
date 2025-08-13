CREATE TABLE dbo.LoanTerms (
    LoanID INT,
    LoanScheduledClosingDate DATETIME,
    ArmDisclosureType VARCHAR(50),
    SubsequentRateAdjustmentMonthsCount INT,
    IndexMarginPercent DECIMAL(10, 3),
    RateAdjustmentPercent DECIMAL(10, 3),
    RateAdjustmentSubsequentCapPercent DECIMAL(10, 3),
    MaxLifeInterestCapPercent DECIMAL(10, 3),
    FloorPercent DECIMAL(10, 3),
    PrepaymentPenaltyTermMonthsCount INT,
    PrepaymentPenaltyPercent DECIMAL(10, 3),
    FullPrepaymentPenaltyOptionType VARCHAR(50),
    BaseLoanAmount DECIMAL(20, 2),
    CombinedLtv DECIMAL(10, 2),
    LoanAmortizationType VARCHAR(50),
    PrincipalAndInterestMonthlyPaymentAmount DECIMAL(20, 2),
    BorrowerRequestedLoanAmount DECIMAL(20, 2),
    PurchasePriceAmount DECIMAL(20, 2),
    PropertyAppraisedValueAmount DECIMAL(20, 2),
    MortgageType VARCHAR(50),
    LoanProgramName VARCHAR(100),
    LenderCaseIdentifier VARCHAR(50),
    LoanAmortizationTermMonths INT,
    OccupancyType VARCHAR(50),
    CreditScoreToUse VARCHAR(50),
    IsEmployeeLoan BIT,
    Ltv DECIMAL(10, 2),
    FirstTimeHomebuyersIndicator BIT,
    LoanPurposeOfRefinanceType VARCHAR(50),
    MaturityDate DATE,
    SubordinateLienAmount DECIMAL(20, 2),
    IncomeVerifyType NVARCHAR(50),
    LoanProductDataID NVARCHAR(100) PRIMARY KEY,
    ModifiedUtc BIGINT

    CONSTRAINT FK_LoanTerms_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);

--DELETE FROM LoanTerms 

--DROP TABLE LoanTerms

--ALTER TABLE dbo.LoanTerms
--DROP CONSTRAINT [FK_LoanTerms(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanTerms
--ADD CONSTRAINT [FK_LoanTerms(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


INSERT INTO dbo.LoanTerms (
    LoanID,
    LoanScheduledClosingDate,
    ArmDisclosureType,
    SubsequentRateAdjustmentMonthsCount,
    IndexMarginPercent,
    RateAdjustmentPercent,
    RateAdjustmentSubsequentCapPercent,
    MaxLifeInterestCapPercent,
    FloorPercent,
    PrepaymentPenaltyTermMonthsCount,
    PrepaymentPenaltyPercent,
    FullPrepaymentPenaltyOptionType,
    BaseLoanAmount,
    CombinedLtv,
    LoanAmortizationType,
    PrincipalAndInterestMonthlyPaymentAmount,
    BorrowerRequestedLoanAmount,
    PurchasePriceAmount,
    PropertyAppraisedValueAmount,
    MortgageType,
    LoanProgramName, 
    LenderCaseIdentifier,
    LoanAmortizationTermMonths,
    OccupancyType,
    CreditScoreToUse,
    IsEmployeeLoan,
    Ltv,
    FirstTimeHomebuyersIndicator,
    LoanPurposeOfRefinanceType,
    MaturityDate,
    SubordinateLienAmount,
    IncomeVerifyType,
    LoanProductDataID,
    ModifiedUtc
)

SELECT kl.LoanID,
lpd.LoanScheduledClosingDate,
lpd.ArmDisclosureType,
lpd.SubsequentRateAdjustmentMonthsCount,
lpd.IndexMarginPercent,
lpd.RateAdjustmentPercent,
lpd.RateAdjustmentSubsequentCapPercent,
lpd.MaxLifeInterestCapPercent,
lpd.FloorPercent,
lpd.PrepaymentPenaltyTermMonthsCount,
lpd.PrepaymentPenaltyPercent,
lpd.FullPrepaymentPenaltyOptionType,
l.BaseLoanAmount,
l.CombinedLtv,
l.LoanAmortizationType,
l.PrincipalAndInterestMonthlyPaymentAmount,
l.BorrowerRequestedLoanAmount,
l.PurchasePriceAmount,
l.PropertyAppraisedValueAmount,
l.MortgageType,
l.LoanProgramName, 
l.LenderCaseIdentifier,
l.LoanAmortizationTermMonths,
l.OccupancyType,
l.CreditScoreToUse,
l.IsEmployeeLoan,
l.Ltv,
l.FirstTimeHomebuyersIndicator,
l.LoanPurposeOfRefinanceType,
l.MaturityDate,
l.SubordinateLienAmount,
cf.StringValue AS IncomeVerifyType,
lpd.LoanProductDataID,
lpd.ModifiedUtc

FROM dbo.loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.loanguid 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanProductData lpd ON lpd.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField cf ON cf.encompassid = lpd.encompassid AND cf.fieldname = 'CX.INCOMEVERIFYTYPE'

SELECT * FROM loanTerms 