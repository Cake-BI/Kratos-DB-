USE [kratos]
GO

/****** Object:  View [dbo].[vwLoan]    Script Date: 7/22/2025 9:23:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[vwLoan]

as

WITH CFNumPivot AS (
    SELECT EncompassId, [CX.DEBTSERVICECOVERAGERATIO], [CX.MTGLATEX30MOS12], [CX.MTGLATEX60MOS12],[CX.MTGLATEX90MOS12], [CX.MTGLATEX120MOS12], [CX.MTGLATEX30MOS13TO24], [CX.MTGLATEX60MOS13TO24], [CX.MTGLATEX90MOS13TO24], [CX.MTGLATEX120MOS13TO24]
    FROM (
        SELECT EncompassId, FieldName, NumericValue
        FROM [WIN-T0FCRL091AK].Encompass.elliedb.CustomField
        WHERE FieldName IN ('CX.DEBTSERVICECOVERAGERATIO', 'CX.MTGLATEX30MOS12', 'CX.MTGLATEX60MOS12', 'CX.MTGLATEX90MOS12', 'CX.MTGLATEX120MOS12', 'CX.MTGLATEX30MOS13TO24', 'CX.MTGLATEX60MOS13TO24', 'CX.MTGLATEX90MOS13TO24', 'CX.MTGLATEX120MOS13TO24') AND NumericValue IS NOT NULL
    ) src
    PIVOT (
        MAX(NumericValue) FOR FieldName IN ([CX.DEBTSERVICECOVERAGERATIO], [CX.MTGLATEX30MOS12], [CX.MTGLATEX60MOS12], [CX.MTGLATEX90MOS12], [CX.MTGLATEX120MOS12], [CX.MTGLATEX30MOS13TO24], [CX.MTGLATEX60MOS13TO24], [CX.MTGLATEX90MOS13TO24], [CX.MTGLATEX120MOS13TO24])
    ) p
),

CFStringPivot AS (
    SELECT EncompassId, [CX.LoanPayAch], [CX.NonQMFlag], [CX.IncomeVerifyType], [CX.HousingEventType], [CX.HousingEventSeasoning], [CX.BankruptcyType], [CX.BankruptcyOutcome], [CX.BankruptcySeasoning], [CX.PrepaymentPenalty], [CX.PrepaymentStructure], [CX.VestingLLC], [CX.NY.CEMAIndicator], [CX.ExceptionDetails], [CX.ExceptionGranted], [CX.LP.STR],[CX.VacantProperty]
    FROM (
        SELECT EncompassId, FieldName, StringValue
        FROM [WIN-T0FCRL091AK].Encompass.elliedb.CustomField
        WHERE FieldName IN ('CX.LoanPayAch', 'CX.NonQMFlag', 'CX.IncomeVerifyType', 'CX.HousingEventType', 'CX.HousingEventSeasoning', 'CX.BankruptcyType', 'CX.BankruptcyOutcome', 'CX.BankruptcySeasoning', 'CX.PrepaymentPenalty', 'CX.PrepaymentStructure', 'CX.VestingLLC', 'CX.NY.CEMAIndicator', 'CX.ExceptionDetails', 'CX.ExceptionGranted','CX.LP.STR','CX.VacantProperty') AND StringValue IS NOT NULL
    ) src
    PIVOT (
        MAX(StringValue) FOR FieldName IN ([CX.LoanPayAch], [CX.NonQMFlag], [CX.IncomeVerifyType], [CX.HousingEventType], [CX.HousingEventSeasoning], [CX.BankruptcyType], [CX.BankruptcyOutcome], [CX.BankruptcySeasoning], [CX.PrepaymentPenalty], [CX.PrepaymentStructure], [CX.VestingLLC], [CX.NY.CEMAIndicator], [CX.ExceptionDetails], [CX.ExceptionGranted], [CX.LP.STR], [CX.VacantProperty])
    ) p
),

PPPPivot as (
    SELECT EncompassId, [PrepaymentPenalty/0], [PrepaymentPenalty/1], [PrepaymentPenalty/2], [PrepaymentPenalty/3], [PrepaymentPenalty/4]
    FROM ( 
        SELECT EncompassId, Id, PrepaymentPenaltyPercent
        FROM [WIN-T0FCRL091AK].Encompass.elliedb.PrepaymentPenalty
        where Id in ('PrepaymentPenalty/0', 'PrepaymentPenalty/1', 'PrepaymentPenalty/2', 'PrepaymentPenalty/3', 'PrepaymentPenalty/4') and PrepaymentPenaltyPercent is not null
    ) src
    PIVOT (
        MAX(PrepaymentPenaltyPercent) FOR Id IN ([PrepaymentPenalty/0], [PrepaymentPenalty/1], [PrepaymentPenalty/2], [PrepaymentPenalty/3], [PrepaymentPenalty/4])
    ) p
),

ContactsPivot as (
    SELECT EncompassId, [Broker_Lender], [Appraisal_Company], [Loan_Underwriter], [Warehouse], [Investor], [Settlement_Agent]
    FROM ( 
        SELECT EncompassId, ContactType,[Name]
        FROM [WIN-T0FCRL091AK].Encompass.elliedb.Contact
        where ContactType in ('Broker_Lender', 'Appraisal_Company', 'Loan_Underwriter', 'Warehouse', 'Investor', 'Settlement_Agent') and [Name] is not null
    ) src
    PIVOT (
        MAX([Name]) FOR ContactType IN ([Broker_Lender], [Appraisal_Company], [Loan_Underwriter], [Warehouse], [Investor], [Settlement_Agent])
    ) p
)


--select * from ContactsPivot

--add date pivot if needed here, skip for now


SELECT
L.Encompassid,
LM.LoanFolder,
LoanStatus = hmda.ActionTaken,
L.LoanNumber,
L.CreatedUtc,
L.OrganizationCode,
L.BaseLoanAmount,
L.RequestedInterestRatePercent,
L.LenderPaidClosingCostsAmount,
hmda.ApplicationDate,
L.MilestoneFileStartedDate,
L.MilestoneSubmittedDate,
L.MilestoneApprovedDate,
L.MilestoneFundedDate,
MilestoneLastCompleted = v.VirtualFieldValue,
L.MilestoneCurrentName,
L.CombinedLtv,
L.LoanAmortizationType,
L.PrincipalAndInterestMonthlyPaymentAmount,
L.BorrowerRequestedLoanAmount,
L.BorrowerFullName,
LB.BorrowerLastName,
LB.Bor1CitizenshipType,
L.PurchasePriceAmount,
L.PropertyAppraisedValueAmount,
L.MortgageType,
L.LoanProgramName,
L.ReferralSource,
L.LenderCaseIdentifier,
L.LoanAmortizationTermMonths,
L.OccupancyType,  --what is diff between this and Property_PropertyUsageType?
L.CreditScoreToUse,
--L.CommitmentNumber,
L.ModifiedUtc as EncompassModifiedUtc,
L.IsEmployeeLoan,
--L.InverviewerName as InterviewerName,
L.Channel,
L.Ltv,
DSCR = cast(cf.[CX.DEBTSERVICECOVERAGERATIO] as decimal(7,2)),
DTI = case when cf.[CX.DEBTSERVICECOVERAGERATIO] is null or cf.[CX.DEBTSERVICECOVERAGERATIO] = 0 then hmda.DebtToIncomeRatio else null end,
L.FirstTimeHomebuyersIndicator,
L.LoanPurposeOfRefinanceType,
--L.LoanSource,
L.MersNumber,
L.AdverseActionDate,
VACreditScore = VLD.CreditScore,
FHA.ClosingDate,
HUD.CaseAssignedDate,
P.StreetAddress as PropertyStreetAddress,
P.City as PropertyCity,
P.State as PropertyState,
P.PostalCode as PropertyPostalCode,
P.County as PropertyCounty,
P.FinancedNumberOfUnits,
P.StructureBuiltYear,
P.PropertyUsageType as Property_PropertyUsageType,
P.RuralAreaIndicator,
P.LoanPurposeType as PurposeOfLoan,
P.PropertyExistingLienAmount,
P.RefinancePropertyExistingLienAmount,
P.GseRefinancePurposeType,
P.RefinanceProposedImprovementsDescription,
P.PropertyRightsType,
TSUM.PropertyType as TSUMPropertyType,
DP.DownPaymentType,
L.MilestoneCurrentDateUtc,
LPD.ScheduledFirstPaymentDate,
LPD.EscrowWaiverIndicator,
LPD.BalloonIndicator,
LienPosition = LPD.LienPriorityType,
LPD.GsePropertyType,
LPD.LoanScheduledClosingDate,
LS.ProgramCode,
hmda.LoanTerm,
Loan_Program_Code = cast(hmda.LoanTerm/12 as varchar) + 'yr ' + LE1.LoanProduct,
RL.Date as RateLockDate,
LS.LockExpiresDate,
M.RateRegistrationRegistrationDate,
M.RateRegistrationExpirationDate,
RL.Interest,
RL.Impounds,
RL.RequestImpoundWaived,
GFE.FundingAmount,
FUND.FundsWireTo,
FUND.SentToFunderDate,
FUND.FundingType,
FUND.FundingOrderDate,
FUND.FundsSentDate,
FUND.CollateralSentDate,
FUND.FundsReleasedDate,
FUND.WiredToForCreditTo1,
FUND.WiredToForFurtherCreditTo1,
FEE.BorPaidAmount as PrePaidInterestBorPaidAmount,
FEE.SellerPaidAmount as PrePaidInterestSellerPaidAmount,
RZ.LateChargeDays,
RZ.ClosingDisclosureSentDate,
RZ.LenderPaidMortgageInsuranceIndicator,
RZ.FinancedPortionTotalLoanAmount,
RZ.GfeApplicationDate,
RZ.InterestOnlyMonths,
CC.Section1000SellerPaidTotalAmount,
CC.Section1000BorrowerPaidTotalAmount,
CC.AggregateAdjustmentFwbc,
CC.AdjustmentFactor,
CDOC.DisbursementDate,
CD2.InitialEscrowSubTotal,
HUD1ES.StartingBalance as ClosingEscrowStartingBalance,
ATRQMCOMMON.IsHigherPricedLoan,
--C1.ReferenceNumber,
US.DeniedDate,
L.MaturityDate,
L.UCDOrigSubmissionDate,
LoanPayAch = isnull(cf1.[CX.LoanPayAch],'N'),
lb.FNFlag,
IncomeVerifyType = case when lb.FnFlag = 'Y' then 'Foreign National' else cf1.[CX.IncomeVerifyType] end,
Loan_ARM_Index = lpd.ArmDisclosureType,
Loan_ARM_Term_Hybrid = lpd.SubsequentRateAdjustmentMonthsCount,
Loan_ARM_Margin = lpd.IndexMarginPercent,
Loan_ARM_RateCap_1st = lpd.RateAdjustmentPercent,
Loan_ARM_RateCap_Subsequent = lpd.RateAdjustmentSubsequentCapPercent,
Loan_ARM_RateLifeCap = lpd.MaxLifeInterestCapPercent,
Loan_ARM_RateFloor_Life = lpd.FloorPercent,
NonQMFlag = cf1.[CX.NonQMFlag],
L.SubordinateLienAmount,
RZ.InterestOnlyIndicator,
P.NonwarrantableProjectIndicator,
OneYrPayHist = cast(isnull(cast(cf.[CX.MTGLATEX30MOS12] as int),0) as varchar) + 'x' + cast(isnull(cast(cf.[CX.MTGLATEX60MOS12] as int),0) as varchar) + 'x' + cast(isnull(cast(cf.[CX.MTGLATEX90MOS12] as int),0) as varchar) + 'x' + cast(isnull(cast(cf.[CX.MTGLATEX120MOS12] as int),0) as varchar),
TwoYrPayHist = cast(isnull(cast(cf.[CX.MTGLATEX30MOS13TO24] as int),0) as varchar) + 'x' + cast(isnull(cast(cf.[CX.MTGLATEX60MOS13TO24] as int),0) as varchar) + 'x' + cast(isnull(cast(cf.[CX.MTGLATEX90MOS13TO24] as int),0) as varchar) + 'x' + cast(isnull(cast(cf.[CX.MTGLATEX120MOS13TO24] as int),0) as varchar),
HousingEventType = cf1.[CX.HousingEventType],
HousingEventSeasoning = cf1.[CX.HousingEventSeasoning],
BankruptcyType = cf1.[CX.BankruptcyType],
BankruptcyOutcome = cf1.[CX.BankruptcyOutcome],
BankruptcySeasoning = cf1.[CX.BankruptcySeasoning],
PrepaymentPenaltyTermMonths = lpd.PrepaymentPenaltyTermMonthsCount, -- total ppp months 0, 12, 24, 36, 48, 60
PrepaymentPenaltyPercent = cast(lpd.PrepaymentPenaltyPercent as int), -- 0, 1, 2, 3, 4, 5
PrepaymentPenalty = cf1.[CX.PrepaymentPenalty],  --1 Year, 2 Year, 3 Year, 4 Year, 5 Year, None
lpd.FullPrepaymentPenaltyOptionType, -- 'Hard'
PrepaymentPentaltyStructure = case when lpd.[PrepaymentPenaltyPercent] is null and lpd.PrepaymentPenaltyTermMonthsCount is not null then '6mo. interest'
                                when lpd.PrepaymentPenaltyPercent <> 0 and ppp.[PrepaymentPenalty/0] is not null then 'Step Down'
                                when lpd.PrepaymentPenaltyPercent > 0 then cast(cast(lpd.PrepaymentPenaltyPercent as int) as varchar) + '% FIXED'
                                else null end,
PrepayPenaltyCalc = case when lpd.[PrepaymentPenaltyPercent] = 5 and cf1.[CX.PrepaymentPenalty] = '5 YEAR' and ppp.[PrepaymentPenalty/0] is null then '5/5/5/5/5'
                        when lpd.[PrepaymentPenaltyPercent] = 5 and cf1.[CX.PrepaymentPenalty] = '4 YEAR' and ppp.[PrepaymentPenalty/0] is null then '5/5/5/5/0'
                        when lpd.[PrepaymentPenaltyPercent] = 5 and cf1.[CX.PrepaymentPenalty] = '3 YEAR' and ppp.[PrepaymentPenalty/0] is null then '5/5/5/0/0'
                        when lpd.[PrepaymentPenaltyPercent] = 5 and cf1.[CX.PrepaymentPenalty] = '2 YEAR' and ppp.[PrepaymentPenalty/0] is null then '5/5/0/0/0'
                        when lpd.[PrepaymentPenaltyPercent] = 5 and cf1.[CX.PrepaymentPenalty] = '1 YEAR' and ppp.[PrepaymentPenalty/0] is null then '5/0/0/0/0'
                        when lpd.[PrepaymentPenaltyPercent] = 3 and cf1.[CX.PrepaymentPenalty] = '5 YEAR' and ppp.[PrepaymentPenalty/0] is null then '3/3/3/3/3'
                        when lpd.[PrepaymentPenaltyPercent] = 3 and cf1.[CX.PrepaymentPenalty] = '4 YEAR' and ppp.[PrepaymentPenalty/0] is null then '3/3/3/3/0'
                        when lpd.[PrepaymentPenaltyPercent] = 3 and cf1.[CX.PrepaymentPenalty] = '3 YEAR' and ppp.[PrepaymentPenalty/0] is null then '3/3/3/0/0'
                        when lpd.[PrepaymentPenaltyPercent] = 3 and cf1.[CX.PrepaymentPenalty] = '2 YEAR' and ppp.[PrepaymentPenalty/0] is null then '3/3/0/0/0'
                        when lpd.[PrepaymentPenaltyPercent] = 3 and cf1.[CX.PrepaymentPenalty] = '1 YEAR' and ppp.[PrepaymentPenalty/0] is null then '3/0/0/0/0'
--step down & 6 mos interest
                        else ISNULL(cast(cast(lpd.PrepaymentPenaltyPercent as int) as varchar), '0') + '/' + 
                            ISNULL(cast(cast(ppp.[PrepaymentPenalty/0] as int) as varchar), '0') + '/' + 
                            ISNULL(cast(cast(ppp.[PrepaymentPenalty/1] as int) as varchar), '0') + '/' + 
                            ISNULL(cast(cast(ppp.[PrepaymentPenalty/2] as int) as varchar), '0') + '/' + 
                            ISNULL(cast(cast(ppp.[PrepaymentPenalty/3] as int) as varchar), '0') --+ '/' + 
                            --ISNULL(cast(cast(ppp.[PrepaymentPenalty/4] as int) as varchar), '0')
                        end,
ppp.[PrepaymentPenalty/0],
ppp.[PrepaymentPenalty/1],
ppp.[PrepaymentPenalty/2],
ppp.[PrepaymentPenalty/3],
--ppp.[PrepaymentPenalty/4],
PollyPPPStructure = cf1.[CX.PrepaymentStructure], -- Polly push field: 'None', 'Fixed', 'Step Down', '6mo. interest'
HPML = case when s32.Section35ResultOfSecurityYieldTest = 'does' then 'Y' else 'N' end,
VestingInLLC = cf1.[CX.VestingLLC], -- 'Y' or 'N'
CEMAIndicator = cf1.[CX.NY.CEMAIndicator], -- 'Y' or 'N'
SelfEmployedFlag = lb.SEFlag,
lb.Bor1SEBit,
lb.Bor2SEBit,
RL.PlanCode,
BuySideBasePrice = RL.BuySidePriceRate,
BuySidePriceAdjustments = RL.BuySidePriceTotalAdjustment,
BuySideTotalPrice = RL.BuySidePriceNetBuyPrice,
SellSideBasePrice = RL.SellSidePriceRate,
SellSidePriceAdjustments = RL.SellSidePriceTotalAdjustment, 
SellSideTotalPrice = RL.SellSideNetSellPrice,
RateRegistrationInvestorName = M.RateRegistrationInvestorName,
BrokerCompensationRate = bpc.Rate,
LenderCompensationRate = lpc.Rate,
BranchPE = rl.BranchPrice,
CorpPE = rl.CorporatePrice,
RateLockHedging = RL.Hedging,
LE1.LoanProduct,
DocumentNoteDate = CDOC.DocumentPreparationDate,
RL.DateFirstPaymentToInvestor,
PAFirstPmtTo = RL.FirstPaymenTo,
PANextPmtTo = RL.NextPaymentDate,
CorrNoteDate = C.NoteDate,
cp.Warehouse,
lb.Bor1SSN,
lb.Bor2SSN,
p.LotAcres,
cf1.[CX.ExceptionDetails],
cf1.[CX.ExceptionGranted], --Y or N
p.CondotelIndicator,
STRFlag = case when [CX.LP.STR] = 'X' then 'Yes' else 'N' end,
VacantProperty = [CX.VacantProperty]  --values currently
FROM [WIN-T0FCRL091AK].Encompass.elliedb.LOAN L
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LOANMETADATA LM ON LM.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LOANPRODUCTDATA LPD ON LPD.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LOANSUBMISSION LS ON LS.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RATELOCK RL ON RL.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.PROPERTY P ON P.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FUNDING FUND ON FUND.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FEE ON L.ENCOMPASSID = FEE.ENCOMPASSID AND FEE.FeeType = 'PrepaidInterest'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DOWNPAYMENT DP ON DP.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.REGULATIONZ RZ ON RZ.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CLOSINGCOST CC ON CC.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CLOSINGDOCUMENT CDOC ON CDOC.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CLOSINGDISCLOSURE2 CD2 ON CD2.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.HUD1ES ON HUD1ES.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FHAVALOAN FHA ON FHA.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.GFE ON GFE.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.VALOANDATA VLD ON VLD.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.HUDLOANDATA HUD ON HUD.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.UNDERWRITERSUMMARY US ON US.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TSUM ON TSUM.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ATRQMCOMMON ON ATRQMCOMMON.ENCOMPASSID = L.ENCOMPASSID
--LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CONTACT C1 ON L.ENCOMPASSID = C1.ENCOMPASSID AND C1.CONTACTTYPE = 'UNDERWRITER'
left join [WIN-T0FCRL091AK].Encompass.elliedb.HMDA hmda on hmda.EncompassID = L.EncompassID
left join [WIN-T0FCRL091AK].Encompass.elliedb.LoanEstimate1 LE1 on LE1.EncompassID = L.EncompassID
left join [WIN-T0FCRL091AK].Encompass.elliedb.Miscellaneous M on M.EncompassID = L.EncompassID
left join [WIN-T0FCRL091AK].Encompass.elliedb.Correspondent C on C.EncompassID = L.EncompassID
left join [WIN-T0FCRL091AK].Encompass.elliedb.Section32 s32 on s32.EncompassId = L.EncompassId
left join [WIN-T0FCRL091AK].Encompass.elliedb.Gfe2010Fee bpc on bpc.EncompassID = L.EncompassID and bpc.Gfe2010FeeParentType = 'Section800BrokerCompensation'
left join [WIN-T0FCRL091AK].Encompass.elliedb.Gfe2010Fee lpc on lpc.EncompassID = L.EncompassID and lpc.Gfe2010FeeParentType = 'Section800LOCompensation' and lpc.Gfe2010FeeType = 'LenderCompensationCredit' and lpc.Gfe2010FeeIndex = 1
left join [WIN-T0FCRL091AK].Encompass.elliedb.VirtualFields v on v.EncompassID = L.EncompassID and VirtualFieldKey = 'Log.MS.LastCompleted'
left join vwLoanBor lb on lb.EncompassId = L.EncompassId
left join CFNumPivot cf on cf.EncompassID = L.EncompassId
left join CFStringPivot cf1 on cf1.EncompassID = L.EncompassId
left join PPPPivot ppp on ppp.EncompassID = L.EncompassID
left join ContactsPivot cp on cp.EncompassID = L.EncompassID

WHERE LM.LoanFolder IN ('Archive - Employee',
'Completed - Employee',
'My Pipeline',
'(Archive)',
'Funded - Not Purchased',
'Completed Loans')
;
GO


Select TOP 100 * FROM dbo.vwLoan