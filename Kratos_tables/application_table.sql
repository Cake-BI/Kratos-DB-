SELECT kl.LoanId,
kl.LoanNum,
a.IncomeOfBorrowersSpouseUsedIndicator,
a.RentAmount,
a.FirstMortgagePrincipalAndInterestAmount,  
a.OtherMortgagePrincipalAndInterestAmount,  
a.HazardInsuranceAmount,
a.RealEstateTaxAmount,  
a.MortgageInsuranceAmount,  
a.HomeownersAssociationDuesAndCondoFeesAmount,  
a.OtherHousingExpenseAmount,  
a.JointAssetLiabilityReportingIndicator,  
a.IncomeOtherThanBorrowerUsedIndicator,  
a.TotalMonthlyPaymentAmount,  
a.MonthlyInstallmentExpenseAmount,  
a.GrossNegativeCashFlow,  
a.TotalAssetsAmount,  
a.NetWorthAmount,  
a.TotalIncomeAmount,  
a.McawTotalMortgagePaymentAmount,  
a.TopRatioPercent,  
a.BottomRatioPercent,  
a.TotalBaseIncomeAmount,  
a.TotalOvertimeAmount,  
a.TotalBonusAmount,  
a.TotalCommissionsAmount,  
a.TotalDividendsInterestAmount,  
a.TotalNetRentalIncomeAmount,  
a.TotalOther1Amount,  
a.TotalOther2Amount,  
a.TotalMortgagesMonthlyPaymentAmount,  
a.ReoTotalMarketValueAmount,  
a.ReoTotalMortgagesAndLiensAmount,  
a.ReoTotalGrossRentalIncomeAmount,  
a.ReoTotalMortgagePaymentsAmount,  
a.ReoTotalMaintenanceAmount,  
a.ReoTotalNetRentalIncomeAmount,  
a.McawBorrowerOtherMonthlyIncomeAmount,  
a.McawCoborrowerOtherMonthlyIncomeAmount, 
a.TotalMortgagesBalanceAmount,  
a.TotalDeposit,  
a.VaSummaryTotalMonthlyGrossIncomeAmount,  
a.SpouseIncomeConsider,  
a.VaSummarySpouseIncomeAmount,  
a.AssetsAvailableAmount,  
a.GrossOtherIncomeAmount,  
a.GrossPositiveCashFlow,  
a.TotalFixedPaymentAmount,  
a.FhaVaTotalNetTakeHomePayAmount,  
a.FhaVaTotalOtherNetIncome,  
a.FhaVaTotalNetIncomeAmount,  
a.FhaVaTotalNetEffectiveIncomeAmount,  
a.FhaVaFamilySupportAmount,  
a.BalanceAvailableFamilySupportGuideline,  
a.FhaVaDebtIncomeRatio,  
a.FhaVaTotalEstimatedMonthlyShelterExpenseAmount,  
a.GrossIncomeForComortSet,  
a.PrimaryResidenceComortSet,  
a.MonthlyExpenseComortSet,  
a.TotalGrossMonthlyIncomeAmount,  
a.MonthlySecondHomeAmount,  
a.FreDebtToHousingGapRatio,  
a.ProposedGroundRentAmount,  
a.ProposedFirstMortgageAmount,  
a.ProposedOtherMortgagesAmount,  
a.ProposedHazardInsuranceAmount,  
a.ProposedRealEstateTaxesAmount,  
a.ProposedMortgageInsuranceAmount,  
a.ProposedDuesAmount,  
a.ProposedOtherAmount,  
a.TotalPrimaryHousingExpenseAmount,  
a.AllOtherPaymentsAmount,  
a.TotalPaymentsAmount,  
a.McawGrossMonthlyIncomeAmount,  
a.MonthlyHousingExpenseAmount,  
a.TotalEmploymentAmount,  
a.PropertyUsageType,  
a.FreddieMacOccupantHousingRatio,  
a.FreddieMacOccupantDebtRatio,  
a.TotalURLA2020AssetsAmount,  
a.TotalOtherAssetsAmount,  
a.TotalAdditionalLoansAmount,  
a.TotalAppliedToDownpayment,  
a.ApplicationIndex,  
a.LoanOfficerId,  
a.LoanOfficerName,  
a.ModifiedUtc,  
a.ApplicationId,
b.BorrowerId

INTO dbo.Application
FROM dbo.Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.Loanguid
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b ON b.encompassid = l.encompassid AND b.fullname is not null
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application a ON a.applicationid = b.applicationid

--DELETE FROM Application

--DROP TABLE dbo.Application

--ALTER TABLE dbo.Application
--ALTER COLUMN BorrowerId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.Application
--ADD CONSTRAINT PK_Application_BorrowerId PRIMARY KEY (BorrowerId);

--ALTER TABLE dbo.Application
--DROP CONSTRAINT [FK_LoanApplication(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.Application 
--ADD CONSTRAINT [FK_Application(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;






