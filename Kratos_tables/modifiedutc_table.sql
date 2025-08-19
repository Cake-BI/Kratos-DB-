-- Query 1: Core Loan Data (5 tables)
SELECT 
    kl.LoanId,
    MAX(kl.modifiedutc) AS Loan_ModifiedUtc,
    MAX(l.modifiedutc) AS ElliedbLoan_ModifiedUtc,
    MAX(al.modifiedutc) AS AdditionalLoan_ModifiedUtc,
    MAX(ar.modifiedutc) AS AdditionalRequests_ModifiedUtc,
    MAX(app.modifiedutc) AS Application_ModifiedUtc
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.AdditionalLoan al ON al.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.AdditionalRequests ar ON ar.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application app ON app.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 2: Borrower & Asset Data (5 tables)
SELECT 
    kl.LoanId,
    b.modifiedutc AS Borrower_ModifiedUtc,
    asset.modifiedutc AS Asset_ModifiedUtc,
    liability.modifiedutc AS Liability_ModifiedUtc,
    income.modifiedutc AS Income_ModifiedUtc,
    emp.modifiedutc AS Employment_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Asset
) asset ON asset.encompassid = l.encompassid AND asset.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Borrower
    WHERE BorrowerIndex IS NULL
) b ON b.encompassid = l.encompassid AND b.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Liability
) liability ON liability.encompassid = l.encompassid AND liability.rn = 1

LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Income
) income ON income.encompassid = l.encompassid AND income.rn = 1

LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Employment
) emp ON emp.encompassid = l.encompassid AND emp.rn = 1
ORDER BY kl.LoanId;

-- Query 3: Property & Valuation Data (5 tables)
SELECT 
    kl.LoanId,
    MAX(prop.modifiedutc) AS Property_ModifiedUtc,
    MAX(pv.modifiedutc) AS PropertyValuation_ModifiedUtc,
    MAX(val.modifiedutc) AS Valuation_ModifiedUtc,
    MAX(res.modifiedutc) AS Residence_ModifiedUtc,
    MAX(rp.modifiedutc) AS ReoProperty_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Property prop ON prop.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.PropertyValuation pv ON pv.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Valuation val ON val.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence res ON res.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ReoProperty rp ON rp.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 4: Document Management (5 tables)
SELECT 
    kl.LoanId,
    MAX(da.modifiedutc) AS DocumentAudit_ModifiedUtc,
    MAX(dl.modifiedutc) AS DocumentLog_ModifiedUtc,
    MAX(dol.modifiedutc) AS DocumentOrderLog_ModifiedUtc,
    MAX(dtllog.modifiedutc) AS DocumentTrackingLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.DocumentAudit
) da ON da.encompassid = l.encompassid AND da.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.DocumentLog
) dl ON dl.encompassid = l.encompassid AND dl.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.DocumentOrderLog
) dol ON dol.encompassid = l.encompassid AND dol.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.DocumentTrackingLog
) dtllog ON dtllog.encompassid = l.encompassid AND dtllog.rn = 1
GROUP BY kl.LoanId;

-- Query 5: Disclosure & Compliance (5 tables)
SELECT 
    kl.LoanId,
    MAX(disclosure.modifiedutc) AS Disclosure_ModifiedUtc,
    MAX(df.modifiedutc) AS DisclosureForm_ModifiedUtc,
    MAX(dn.modifiedutc) AS DisclosureNotices_ModifiedUtc,
    MAX(dtlog.modifiedutc) AS DisclosureTrackingLog_ModifiedUtc,
    MAX(hmda.modifiedutc) AS Hmda_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Disclosure disclosure ON disclosure.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DisclosureForm df ON df.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DisclosureNotices dn ON dn.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DisclosureTrackingLog dtlog ON dtlog.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Hmda hmda ON hmda.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 6: Closing Documents (5 tables)
SELECT 
    kl.LoanId,
    MAX(cd1.modifiedutc) AS ClosingDisclosure1_ModifiedUtc,
    MAX(cd2.modifiedutc) AS ClosingDisclosure2_ModifiedUtc,
    MAX(cd3.modifiedutc) AS ClosingDisclosure3_ModifiedUtc,
    MAX(cd4.modifiedutc) AS ClosingDisclosure4_ModifiedUtc,
    MAX(cd5.modifiedutc) AS ClosingDisclosure5_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDisclosure1 cd1 ON cd1.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDisclosure2 cd2 ON cd2.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDisclosure3 cd3 ON cd3.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDisclosure4 cd4 ON cd4.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDisclosure5 cd5 ON cd5.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 7: Fees & Costs (5 tables)
SELECT 
    kl.LoanId,
    MAX(fee.modifiedutc) AS Fee_ModifiedUtc,
    MAX(cc.modifiedutc) AS ClosingCost_ModifiedUtc,
    MAX(fv.modifiedutc) AS FeeVariance_ModifiedUtc,
    MAX(fvo.modifiedutc) AS FeeVarianceOther_ModifiedUtc,
    MAX(ff.modifiedutc) AS FundingFee_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Fee
) fee ON fee.encompassid = l.encompassid AND fee.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.ClosingCost
) cc ON cc.encompassid = l.encompassid AND cc.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.FeeVariance
) fv ON fv.encompassid = l.encompassid AND fv.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.FeeVarianceOther
) fvo ON fvo.encompassid = l.encompassid AND fvo.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.FundingFee
) ff ON ff.encompassid = l.encompassid AND ff.rn = 1
GROUP BY kl.LoanId;

-- Query 8: Rate Lock & Pricing (5 tables)
SELECT 
    kl.LoanId,
    MAX(rl.modifiedutc) AS RateLock_ModifiedUtc,
    MAX(rlb.modifiedutc) AS RateLockBuydown_ModifiedUtc,
    MAX(pa.modifiedutc) AS PriceAdjustment_ModifiedUtc,
    MAX(palr.modifiedutc) AS PriceAdjustmentLogRecord_ModifiedUtc,
    MAX(buydown.modifiedutc) AS Buydown_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.RateLock
) rl ON rl.encompassid = l.encompassid AND rl.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.RateLockBuydown
) rlb ON rlb.encompassid = l.encompassid AND rlb.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.PriceAdjustment
) pa ON pa.encompassid = l.encompassid AND pa.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.PriceAdjustmentLogRecord
) palr ON palr.encompassid = l.encompassid AND palr.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Buydown
) buydown ON buydown.encompassid = l.encompassid AND buydown.rn = 1
GROUP BY kl.LoanId;

-- Query 9: GFE & Estimates (5 tables)
SELECT 
    kl.LoanId,
    MAX(gfe.modifiedutc) AS Gfe_ModifiedUtc,
    MAX(le1.modifiedutc) AS LoanEstimate1_ModifiedUtc,
    MAX(le2.modifiedutc) AS LoanEstimate2_ModifiedUtc,
    MAX(le3.modifiedutc) AS LoanEstimate3_ModifiedUtc,
    MAX(gfe2010.modifiedutc) AS Gfe2010_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Gfe gfe ON gfe.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanEstimate1 le1 ON le1.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanEstimate2 le2 ON le2.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanEstimate3 le3 ON le3.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Gfe2010 gfe2010 ON gfe2010.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 10: GSE & Government (5 tables)
SELECT 
    kl.LoanId,
    MAX(fm.modifiedutc) AS FannieMae_ModifiedUtc,
    MAX(frm.modifiedutc) AS FreddieMac_ModifiedUtc,
    MAX(fvl.modifiedutc) AS FhaVaLoan_ModifiedUtc,
    MAX(usda.modifiedutc) AS Usda_ModifiedUtc,
    MAX(vld.modifiedutc) AS VaLoanData_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FannieMae fm ON fm.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FreddieMac frm ON frm.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FhaVaLoan fvl ON fvl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Usda usda ON usda.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.VaLoanData vld ON vld.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 11: Lock Logs (5 tables)
SELECT 
    kl.LoanId,
    MAX(lcl.modifiedutc) AS LockCancellationLog_ModifiedUtc,
    MAX(lconf.modifiedutc) AS LockConfirmLog_ModifiedUtc,
    MAX(ldl.modifiedutc) AS LockDenialLog_ModifiedUtc,
    MAX(lrl.modifiedutc) AS LockRemovedLog_ModifiedUtc,
    MAX(lvl.modifiedutc) AS LockVoidLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LockCancellationLog lcl ON lcl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LockConfirmLog lconf ON lconf.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LockDenialLog ldl ON ldl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LockRemovedLog lrl ON lrl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LockVoidLog lvl ON lvl.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 12: Milestone & Task Logs (5 tables)
SELECT 
    kl.LoanId,
    MAX(ml.modifiedutc) AS MilestoneLog_ModifiedUtc,
    MAX(mhl.modifiedutc) AS MilestoneHistoryLog_ModifiedUtc,
    MAX(mtl.modifiedutc) AS MilestoneTaskLog_ModifiedUtc,
    MAX(mtml.modifiedutc) AS MilestoneTemplateLog_ModifiedUtc,
    MAX(mfrl.modifiedutc) AS MilestoneFreeRoleLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.MilestoneLog ml ON ml.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.MilestoneHistoryLog mhl ON mhl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.MilestoneTaskLog mtl ON mtl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.MilestoneTemplateLog mtml ON mtml.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.MilestoneFreeRoleLog mfrl ON mfrl.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 13: Condition Logs (5 tables)
SELECT 
    kl.LoanId,
    MAX(ecl.modifiedutc) AS EnhancedConditionLog_ModifiedUtc,
    MAX(pcl.modifiedutc) AS PreliminaryConditionLog_ModifiedUtc,
    MAX(pccl.modifiedutc) AS PostClosingConditionLog_ModifiedUtc,
    MAX(purcl.modifiedutc) AS PurchaseConditionLog_ModifiedUtc,
    MAX(scl.modifiedutc) AS SellConditionLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.EnhancedConditionLog ecl ON ecl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.PreliminaryConditionLog pcl ON pcl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.PostClosingConditionLog pccl ON pccl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.PurchaseConditionLog purcl ON purcl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.SellConditionLog scl ON scl.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 14: Service Logs (5 tables)
SELECT 
    kl.LoanId,
    MAX(fsdul.modifiedutc) AS FannieServiceDuLog_ModifiedUtc,
    MAX(fsecl.modifiedutc) AS FannieServiceEcLog_ModifiedUtc,
    MAX(fslpal.modifiedutc) AS FreddieServiceLpaLog_ModifiedUtc,
    MAX(fslqal.modifiedutc) AS FreddieServiceLqaLog_ModifiedUtc,
    MAX(misal.modifiedutc) AS MIServiceArchLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FannieServiceDuLog fsdul ON fsdul.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FannieServiceEcLog fsecl ON fsecl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FreddieServiceLpaLog fslpal ON fslpal.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FreddieServiceLqaLog fslqal ON fslqal.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.MIServiceArchLog misal ON misal.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 15: Tracking & Audit Logs (5 tables)
SELECT 
    kl.LoanId,
    MAX(austl.modifiedutc) AS AUSTrackingLog_ModifiedUtc,
    MAX(dtl.modifiedutc) AS DataTracLog_ModifiedUtc,
    MAX(dt2015.modifiedutc) AS DisclosureTracking2015Log_ModifiedUtc,
    MAX(ttl.modifiedutc) AS TargetTradeLog_ModifiedUtc,
    MAX(tel.modifiedutc) AS TrackingEntryLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.AUSTrackingLog austl ON austl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DataTracLog dtl ON dtl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DisclosureTracking2015Log dt2015 ON dt2015.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TargetTradeLog ttl ON ttl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TrackingEntryLog tel ON tel.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 16: Regulatory & Compliance (5 tables)
SELECT 
    kl.LoanId,
    MAX(rz.modifiedutc) AS RegulationZ_ModifiedUtc,
    MAX(rzirp.modifiedutc) AS RegulationZInterestRatePeriod_ModifiedUtc,
    MAX(rzp.modifiedutc) AS RegulationZPayment_ModifiedUtc,
    MAX(s32.modifiedutc) AS Section32_ModifiedUtc,
    MAX(ctl.modifiedutc) AS ComplianceTestLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RegulationZ rz ON rz.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RegulationZInterestRatePeriod rzirp ON rzirp.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RegulationZPayment rzp ON rzp.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Section32 s32 ON s32.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ComplianceTestLog ctl ON ctl.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 17: TQL & Third Party (5 tables)
SELECT 
    kl.LoanId,
    MAX(tql.modifiedutc) AS TQL_ModifiedUtc,
    MAX(tqlca.modifiedutc) AS TQLComplianceAlert_ModifiedUtc,
    MAX(tqld.modifiedutc) AS TQLDocument_ModifiedUtc,
    MAX(tqlfa.modifiedutc) AS TQLFraudAlert_ModifiedUtc,
    MAX(tqlri.modifiedutc) AS TQLReportInformation_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TQL tql ON tql.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TQLComplianceAlert tqlca ON tqlca.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TQLDocument tqld ON tqld.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TQLFraudAlert tqlfa ON tqlfa.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TQLReportInformation tqlri ON tqlri.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 18: HUD & Settlement (5 tables)
SELECT 
    kl.LoanId,
    MAX(h1es.modifiedutc) AS Hud1Es_ModifiedUtc,
    MAX(h1esd.modifiedutc) AS Hud1EsDate_ModifiedUtc,
    MAX(h1esdd.modifiedutc) AS Hud1EsDueDate_ModifiedUtc,
    MAX(h1esi.modifiedutc) AS Hud1EsItemize_ModifiedUtc,
    MAX(h1espt.modifiedutc) AS Hud1EsPayTo_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Hud1Es
) h1es ON h1es.encompassid = l.encompassid AND h1es.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsDate
) h1esd ON h1esd.encompassid = l.encompassid AND h1esd.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsDueDate
) h1esdd ON h1esdd.encompassid = l.encompassid AND h1esdd.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsItemize
) h1esi ON h1esi.encompassid = l.encompassid AND h1esi.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsPayTo
) h1espt ON h1espt.encompassid = l.encompassid AND h1espt.rn = 1
GROUP BY kl.LoanId;

-- Query 19: More HUD & Settlement (5 tables)
SELECT 
    kl.LoanId,
    MAX(h1ess.modifiedutc) AS Hud1EsSetup_ModifiedUtc,
    MAX(hld.modifiedutc) AS HudLoanData_ModifiedUtc,
    MAX(rhd.modifiedutc) AS RespaHudDetail_ModifiedUtc,
    MAX(ssc.modifiedutc) AS SettlementServiceCharge_ModifiedUtc,
    MAX(cdoc.modifiedutc) AS ClosingDocument_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsSetup
) h1ess ON h1ess.encompassid = l.encompassid AND h1ess.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.HudLoanData
) hld ON hld.encompassid = l.encompassid AND hld.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.RespaHudDetail
) rhd ON rhd.encompassid = l.encompassid AND rhd.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.SettlementServiceCharge
) ssc ON ssc.encompassid = l.encompassid AND ssc.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDocument
) cdoc ON cdoc.encompassid = l.encompassid AND cdoc.rn = 1
GROUP BY kl.LoanId;

-- Query 20: Email & Communication (5 tables)
SELECT 
    kl.LoanId,
    MAX(etl.modifiedutc) AS EmailTriggerLog_ModifiedUtc,
    MAX(hel.modifiedutc) AS HtmlEmailLog_ModifiedUtc,
    MAX(cl.modifiedutc) AS ConversationLog_ModifiedUtc,
    MAX(contact.modifiedutc) AS Contact_ModifiedUtc,
    MAX(mtc.modifiedutc) AS MilestoneTaskContact_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.EmailTriggerLog
) etl ON etl.encompassid = l.encompassid AND etl.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.HtmlEmailLog
) hel ON hel.encompassid = l.encompassid AND hel.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.ConversationLog
) cl ON cl.encompassid = l.encompassid AND cl.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Contact
) contact ON contact.encompassid = l.encompassid AND contact.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.MilestoneTaskContact
) mtc ON mtc.encompassid = l.encompassid AND mtc.rn = 1
GROUP BY kl.LoanId;

-- Query 21: System & Technical (5 tables)
SELECT 
    kl.LoanId,
    MAX(analyzer.modifiedutc) AS Analyzer_ModifiedUtc,
    MAX(vf.modifiedutc) AS VirtualFields_ModifiedUtc,
    MAX(cf.modifiedutc) AS CustomField_ModifiedUtc,
    MAX(cmf.modifiedutc) AS CustomModelFields_ModifiedUtc,
    MAX(str.modifiedutc) AS String_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Analyzer
) analyzer ON analyzer.encompassid = l.encompassid AND analyzer.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.VirtualFields
) vf ON vf.encompassid = l.encompassid AND vf.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.CustomField
) cf ON cf.encompassid = l.encompassid AND cf.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.CustomModelFields
) cmf ON cmf.encompassid = l.encompassid AND cmf.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.string
) str ON str.encompassid = l.encompassid AND str.rn = 1
GROUP BY kl.LoanId;

-- Query 22: Alerts & Warnings (5 tables)
SELECT 
    kl.LoanId,
    MAX(acc.modifiedutc) AS AlertChangeCircumstance_ModifiedUtc,
    MAX(daa.modifiedutc) AS DocumentAuditAlert_ModifiedUtc,
    MAX(loga.modifiedutc) AS LogAlert_ModifiedUtc,
    MAX(gffv.modifiedutc) AS GffVAlertTriggerFieldLog_ModifiedUtc,
    MAX(disaster.modifiedutc) AS Disaster_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.AlertChangeCircumstance
) acc ON acc.encompassid = l.encompassid AND acc.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.DocumentAuditAlert
) daa ON daa.encompassid = l.encompassid AND daa.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.LogAlert
) loga ON loga.encompassid = l.encompassid AND loga.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.GffVAlertTriggerFieldLog
) gffv ON gffv.encompassid = l.encompassid AND gffv.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.Disaster
) disaster ON disaster.encompassid = l.encompassid AND disaster.rn = 1
GROUP BY kl.LoanId;


-- Query 23: Servicing & Transactions (5 tables)
SELECT 
    kl.LoanId,
    MAX(is1.modifiedutc) AS InterimServicing_ModifiedUtc,
    MAX(ist.modifiedutc) AS InterimServicingTransaction_ModifiedUtc,
    MAX(pt.modifiedutc) AS PaymentTransaction_ModifiedUtc,
    MAX(prt.modifiedutc) AS PaymentReversalTransaction_ModifiedUtc,
    MAX(spt.modifiedutc) AS SchedulePaymentTransaction_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.InterimServicing
) is1 ON is1.encompassid = l.encompassid AND is1.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.InterimServicingTransaction
) ist ON ist.encompassid = l.encompassid AND ist.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.PaymentTransaction
) pt ON pt.encompassid = l.encompassid AND pt.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.PaymentReversalTransaction
) prt ON prt.encompassid = l.encompassid AND prt.rn = 1
LEFT JOIN (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY encompassid ORDER BY (SELECT NULL)) as rn
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.SchedulePaymentTransaction
) spt ON spt.encompassid = l.encompassid AND spt.rn = 1
GROUP BY kl.LoanId;

-- Query 24: Escrow & Trust (5 tables)
SELECT 
    kl.LoanId,
    MAX(edt.modifiedutc) AS EscrowDisbursementTransaction_ModifiedUtc,
    MAX(eit.modifiedutc) AS EscrowInterestTransaction_ModifiedUtc,
    MAX(ta.modifiedutc) AS TrustAccount_ModifiedUtc,
    MAX(tai.modifiedutc) AS TrustAccountItem_ModifiedUtc,
    MAX(lpt.modifiedutc) AS LoanPurchaseTransaction_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.EscrowDisbursementTransaction edt ON edt.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.EscrowInterestTransaction eit ON eit.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TrustAccount ta ON ta.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TrustAccountItem tai ON tai.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanPurchaseTransaction lpt ON lpt.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 25: Additional State & Disclosures (5 tables)
SELECT 
    kl.LoanId,
    MAX(asd.modifiedutc) AS AdditionalStateDisclosure_ModifiedUtc,
    MAX(stadisc.modifiedutc) AS StateDisclosure_ModifiedUtc,
    MAX(stalic.modifiedutc) AS StateLicense_ModifiedUtc,
    MAX(nyf.modifiedutc) AS NewYorkFee_ModifiedUtc,
    MAX(nypl.modifiedutc) AS NewYorkPrimaryLender_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.AdditionalStateDisclosure asd ON asd.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.StateDisclosure stadisc ON stadisc.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.StateLicense stalic ON stalic.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.NewYorkFee nyf ON nyf.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.NewYorkPrimaryLender nypl ON nypl.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Continue with remaining tables...

-- Query 26: Energy & Construction (5 tables)
SELECT 
    kl.LoanId,
    MAX(eem.modifiedutc) AS EnergyEfficientMortgage_ModifiedUtc,
    MAX(eemi.modifiedutc) AS EnergyEfficientMortgageItem_ModifiedUtc,
    MAX(cm.modifiedutc) AS ConstructionManagement_ModifiedUtc,
    MAX(ct.modifiedutc) AS CollateralTracking_ModifiedUtc,
    MAX(cmt.modifiedutc) AS CommitmentTerms_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.EnergyEfficientMortgage eem ON eem.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.EnergyEfficientMortgageItem eemi ON eemi.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ConstructionManagement cm ON cm.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CollateralTracking ct ON ct.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CommitmentTerms cmt ON cmt.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 27: Other Assets & Income (5 tables)
SELECT 
    kl.LoanId,
    MAX(oa.modifiedutc) AS OtherAsset_ModifiedUtc,
    MAX(ois.modifiedutc) AS OtherIncomeSource_ModifiedUtc,
    MAX(ol.modifiedutc) AS OtherLiability_ModifiedUtc,
    MAX(ot.modifiedutc) AS OtherTransaction_ModifiedUtc,
    MAX(sei.modifiedutc) AS SelfEmployedIncome_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.OtherAsset oa ON oa.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.OtherIncomeSource ois ON ois.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.OtherLiability ol ON ol.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.OtherTransaction ot ON ot.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.SelfEmployedIncome sei ON sei.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 28: Print & Export (5 tables)
SELECT 
    kl.LoanId,
    MAX(pf.modifiedutc) AS PrintForm_ModifiedUtc,
    MAX(pl.modifiedutc) AS PrintLog_ModifiedUtc,
    MAX(el.modifiedutc) AS ExportLog_ModifiedUtc,
    MAX(elst.modifiedutc) AS ExportLogServiceType_ModifiedUtc,
    MAX(downlog.modifiedutc) AS DownloadLog_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.PrintForm pf ON pf.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.PrintLog pl ON pl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ExportLog el ON el.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ExportLogServiceType elst ON elst.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DownloadLog downlog ON downlog.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 29: Business & Correspondent (5 tables)
SELECT 
    kl.LoanId,
    MAX(aba.modifiedutc) AS AffiliatedBusinessArrangement_ModifiedUtc,
    MAX(corr.modifiedutc) AS Correspondent_ModifiedUtc,
    MAX(tpo.modifiedutc) AS TPO_ModifiedUtc,
    MAX(coi.modifiedutc) AS CorrOtherInsurance_ModifiedUtc,
    MAX(spc.modifiedutc) AS ServiceProviderContact_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.AffiliatedBusinessArrangement aba ON aba.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Correspondent corr ON corr.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TPO tpo ON tpo.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CorrOtherInsurance coi ON coi.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ServiceProviderContact spc ON spc.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Query 30: Remaining System & Admin (5 tables)
SELECT 
    kl.LoanId,
    MAX(hdm.modifiedutc) AS HardDeleteMetadata_ModifiedUtc,
    MAX(lcs.modifiedutc) AS LoanCheckSum_ModifiedUtc,
    MAX(lm.modifiedutc) AS LoanMetadata_ModifiedUtc,
    MAX(oc.modifiedutc) AS OverflowContract_ModifiedUtc,
    MAX(erc.modifiedutc) AS EntityRefContract_ModifiedUtc
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.HardDeleteMetadata hdm ON hdm.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanCheckSum lcs ON lcs.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanMetadata lm ON lm.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.OverflowContract oc ON oc.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.EntityRefContract erc ON erc.encompassid = l.encompassid
GROUP BY kl.LoanId;

-- Final Merge Query (Updated with all queries)
SELECT 
    q1.LoanId,
    -- Query 1 fields
    q1.Loan_ModifiedUtc, q1.ElliedbLoan_ModifiedUtc, q1.AdditionalLoan_ModifiedUtc, q1.AdditionalRequests_ModifiedUtc, q1.Application_ModifiedUtc,
    -- Query 2 fields  
    q2.Borrower_ModifiedUtc, q2.Asset_ModifiedUtc, q2.Liability_ModifiedUtc, q2.Income_ModifiedUtc, q2.Employment_ModifiedUtc,
    -- Query 3 fields
    q3.Property_ModifiedUtc, q3.PropertyValuation_ModifiedUtc, q3.Valuation_ModifiedUtc, q3.Residence_ModifiedUtc, q3.ReoProperty_ModifiedUtc,
    -- Query 4 fields
    q4.DocumentAudit_ModifiedUtc, q4.DocumentLog_ModifiedUtc, q4.DocumentOrderLog_ModifiedUtc, q4.DocumentTrackingLog_ModifiedUtc, q4.ProvidedDocument_ModifiedUtc,
    -- Query 5 fields
    q5.Disclosure_ModifiedUtc, q5.DisclosureForm_ModifiedUtc, q5.DisclosureNotices_ModifiedUtc, q5.DisclosureTrackingLog_ModifiedUtc, q5.Hmda_ModifiedUtc,
    -- Query 6 fields
    q6.ClosingDisclosure1_ModifiedUtc, q6.ClosingDisclosure2_ModifiedUtc, q6.ClosingDisclosure3_ModifiedUtc, q6.ClosingDisclosure4_ModifiedUtc, q6.ClosingDisclosure5_ModifiedUtc,
    -- Query 7 fields
    q7.Fee_ModifiedUtc, q7.ClosingCost_ModifiedUtc, q7.FeeVariance_ModifiedUtc, q7.FeeVarianceOther_ModifiedUtc, q7.FundingFee_ModifiedUtc,
    -- Query 8 fields
    q8.RateLock_ModifiedUtc, q8.RateLockBuydown_ModifiedUtc, q8.PriceAdjustment_ModifiedUtc, q8.PriceAdjustmentLogRecord_ModifiedUtc, q8.Buydown_ModifiedUtc,
    -- Continue adding fields from queries 9-30...
    q9.Gfe_ModifiedUtc, q9.LoanEstimate1_ModifiedUtc, q9.LoanEstimate2_ModifiedUtc, q9.LoanEstimate3_ModifiedUtc, q9.Gfe2010_ModifiedUtc,
    q10.FannieMae_ModifiedUtc, q10.FreddieMac_ModifiedUtc, q10.FhaVaLoan_ModifiedUtc, q10.Usda_ModifiedUtc, q10.VaLoanData_ModifiedUtc
    -- Add remaining fields from queries 11-30...

FROM (Query1) q1
LEFT JOIN (Query2) q2 ON q1.LoanId = q2.LoanId
LEFT JOIN (Query3) q3 ON q1.LoanId = q3.LoanId
LEFT JOIN (Query4) q4 ON q1.LoanId = q4.LoanId
LEFT JOIN (Query5) q5 ON q1.LoanId = q5.LoanId
LEFT JOIN (Query6) q6 ON q1.LoanId = q6.LoanId
LEFT JOIN (Query7) q7 ON q1.LoanId = q7.LoanId
LEFT JOIN (Query8) q8 ON q1.LoanId = q8.LoanId
LEFT JOIN (Query9) q9 ON q1.LoanId = q9.LoanId
LEFT JOIN (Query10) q10 ON q1.LoanId = q10.LoanId
LEFT JOIN (Query11) q11 ON q1.LoanId = q11.LoanId
LEFT JOIN (Query12) q12 ON q1.LoanId = q12.LoanId
LEFT JOIN (Query13) q13 ON q1.LoanId = q13.LoanId
LEFT JOIN (Query14) q14 ON q1.LoanId = q14.LoanId
LEFT JOIN (Query15) q15 ON q1.LoanId = q15.LoanId
LEFT JOIN (Query16) q16 ON q1.LoanId = q16.LoanId
LEFT JOIN (Query17) q17 ON q1.LoanId = q17.LoanId
LEFT JOIN (Query18) q18 ON q1.LoanId = q18.LoanId
LEFT JOIN (Query19) q19 ON q1.LoanId = q19.LoanId
LEFT JOIN (Query20) q20 ON q1.LoanId = q20.LoanId
LEFT JOIN (Query21) q21 ON q1.LoanId = q21.LoanId
LEFT JOIN (Query22) q22 ON q1.LoanId = q22.LoanId
LEFT JOIN (Query23) q23 ON q1.LoanId = q23.LoanId
LEFT JOIN (Query24) q24 ON q1.LoanId = q24.LoanId
LEFT JOIN (Query25) q25 ON q1.LoanId = q25.LoanId
LEFT JOIN (Query26) q26 ON q1.LoanId = q26.LoanId
LEFT JOIN (Query27) q27 ON q1.LoanId = q27.LoanId
LEFT JOIN (Query28) q28 ON q1.LoanId = q28.LoanId
LEFT JOIN (Query29) q29 ON q1.LoanId = q29.LoanId
LEFT JOIN (Query30) q30 ON q1.LoanId = q30.LoanId
ORDER BY q1.LoanId;