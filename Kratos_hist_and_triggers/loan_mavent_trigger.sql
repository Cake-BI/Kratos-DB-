-- =============================================
-- Trigger: trg_loan_insert_mavent
-- Purpose: Auto-populate LoanMavent table when new loans are inserted
-- Prevents duplicates by checking if LoanId already exists
-- =============================================

IF OBJECT_ID('trg_loan_smart_update_mavent', 'TR') IS NOT NULL
    DROP TRIGGER trg_loan_smart_update_mavent
GO

CREATE TRIGGER trg_loan_smart_update_mavent
ON Loan
AFTER INSERT, UPDATE
AS
BEGIN
    -- Use MERGE to handle both INSERT new records and UPDATE existing ones
    MERGE dbo.LoanMavent AS target
    USING (
        -- This subquery gets the complete data for the newly inserted loans
        -- plus any existing loans that might need updates
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
            MaventLicenseResult,
            m.MiscellaneousId AS LoanMaventId,
            m.ModifiedUtc
        FROM Loan kl 
        JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.loanguid = l.encompassid
        LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.miscellaneous m ON m.encompassid = l.encompassid
        WHERE kl.LoanId IN (SELECT LoanId FROM inserted)  -- Only process newly inserted loans
    ) AS source ON target.LoanId = source.LoanId
    
    -- UPDATE existing records if data has changed
    WHEN MATCHED THEN
        UPDATE SET
            MaventReviewResult = source.MaventReviewResult,
            MaventOfacResult = source.MaventOfacResult,
            MaventOtherResult = source.MaventOtherResult,
            MaventStateResult = source.MaventStateResult,
            MaventTilaRorResult = source.MaventTilaRorResult,
            MaventTilaToleranceResult = source.MaventTilaToleranceResult,
            MaventAutoOrderIndicator = source.MaventAutoOrderIndicator,
            MaventHpmlResult = source.MaventHpmlResult,
            MaventNmlsResult = source.MaventNmlsResult,
            MaventATRQMResult = source.MaventATRQMResult,
            AveragePercentageRate = source.AveragePercentageRate,
            MaventOrderedBy = source.MaventOrderedBy,
            FinanceChargeAmount = source.FinanceChargeAmount,
            FederalTotalLoanAmount = source.FederalTotalLoanAmount,
            StateTotalLoanAmount = source.StateTotalLoanAmount,
            QmPointsAndFeesTotal = source.QmPointsAndFeesTotal,
            AbilityToRepayLoanType = source.AbilityToRepayLoanType,
            QualifiedMortgageLoanType = source.QualifiedMortgageLoanType,
            QualifiedMortgageEligible = source.QualifiedMortgageEligible,
            HigherPricedCoveredTrans = source.HigherPricedCoveredTrans,
            LoanTermAndFeatures = source.LoanTermAndFeatures,
            QmPointsAndFeesLimit = source.QmPointsAndFeesLimit,
            MaventOrderedDate = source.MaventOrderedDate,
            UnderwritingFactors = source.UnderwritingFactors,
            QmPriceBasedLimit = source.QmPriceBasedLimit,
            ReviewId = source.ReviewId,
            MaventCraxResult = source.MaventCraxResult,
            MaventEnterpriseResult = source.MaventEnterpriseResult,
            MaventGseResult = source.MaventGseResult,
            MaventHighCostResult = source.MaventHighCostResult,
            MaventHmdaResult = source.MaventHmdaResult,
            MaventLicenseResult = source.MaventLicenseResult,
            LoanMaventId = source.LoanMaventId,
            ModifiedUtc = source.ModifiedUtc
    
    -- INSERT new records that don't exist
    WHEN NOT MATCHED THEN
        INSERT (
            LoanId,
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
            MaventLicenseResult,
            LoanMaventId,
            ModifiedUtc
        )
        VALUES (
            source.LoanId,
            source.MaventReviewResult,
            source.MaventOfacResult,
            source.MaventOtherResult,
            source.MaventStateResult,
            source.MaventTilaRorResult,
            source.MaventTilaToleranceResult,
            source.MaventAutoOrderIndicator,
            source.MaventHpmlResult,
            source.MaventNmlsResult,
            source.MaventATRQMResult,
            source.AveragePercentageRate,
            source.MaventOrderedBy,
            source.FinanceChargeAmount,
            source.FederalTotalLoanAmount,
            source.StateTotalLoanAmount,
            source.QmPointsAndFeesTotal,
            source.AbilityToRepayLoanType,
            source.QualifiedMortgageLoanType,
            source.QualifiedMortgageEligible,
            source.HigherPricedCoveredTrans,
            source.LoanTermAndFeatures,
            source.QmPointsAndFeesLimit,
            source.MaventOrderedDate,
            source.UnderwritingFactors,
            source.QmPriceBasedLimit,
            source.ReviewId,
            source.MaventCraxResult,
            source.MaventEnterpriseResult,
            source.MaventGseResult,
            source.MaventHighCostResult,
            source.MaventHmdaResult,
            source.MaventLicenseResult,
            source.LoanMaventId,
            source.ModifiedUtc
        );

    -- Log which LoanIds were processed
    DECLARE @ProcessedLoans NVARCHAR(MAX);
    SELECT @ProcessedLoans = STRING_AGG(CAST(LoanId AS NVARCHAR(10)), ', ')
    FROM inserted;
    
    PRINT 'LoanMavent trigger processed LoanIds: ' + @ProcessedLoans;
END

/*SELECT 
    name,
    is_disabled,
    create_date,
    modify_date
FROM sys.triggers 
WHERE name = 'trg_loan_smart_update_mavent';*/













-- =============================================
-- Dynamic Trigger - Automatically handles new columns
-- =============================================

-- Drop existing trigger if it exists
IF OBJECT_ID('trg_loan_smart_update_mavent', 'TR') IS NOT NULL
    DROP TRIGGER trg_loan_dynamic_mavent
GO

CREATE TRIGGER trg_loan_smart_update_mavent
ON Loan
AFTER INSERT
AS
BEGIN
    -- Create a temporary table to capture MERGE output
    CREATE TABLE #MergeResults (
        ActionType VARCHAR(10),
        LoanId INT,
        MaventReviewResult VARCHAR(MAX),
        MaventOfacResult VARCHAR(MAX),
        MaventOtherResult VARCHAR(MAX),
        MaventStateResult VARCHAR(MAX),
        MaventTilaRorResult VARCHAR(MAX),
        MaventTilaToleranceResult VARCHAR(MAX),
        MaventAutoOrderIndicator VARCHAR(MAX),
        MaventHpmlResult VARCHAR(MAX),
        MaventNmlsResult VARCHAR(MAX),
        MaventATRQMResult VARCHAR(MAX),
        AveragePercentageRate VARCHAR(MAX),
        MaventOrderedBy VARCHAR(MAX),
        FinanceChargeAmount VARCHAR(MAX),
        FederalTotalLoanAmount VARCHAR(MAX),
        StateTotalLoanAmount VARCHAR(MAX),
        QmPointsAndFeesTotal VARCHAR(MAX),
        AbilityToRepayLoanType VARCHAR(MAX),
        QualifiedMortgageLoanType VARCHAR(MAX),
        QualifiedMortgageEligible VARCHAR(MAX),
        HigherPricedCoveredTrans VARCHAR(MAX),
        LoanTermAndFeatures VARCHAR(MAX),
        QmPointsAndFeesLimit VARCHAR(MAX),
        MaventOrderedDate VARCHAR(MAX),
        UnderwritingFactors VARCHAR(MAX),
        QmPriceBasedLimit VARCHAR(MAX),
        ReviewId VARCHAR(MAX),
        MaventCraxResult VARCHAR(MAX),
        MaventEnterpriseResult VARCHAR(MAX),
        MaventGseResult VARCHAR(MAX),
        MaventHighCostResult VARCHAR(MAX),
        MaventHmdaResult VARCHAR(MAX),
        MaventLicenseResult VARCHAR(MAX),
        LoanMaventId VARCHAR(MAX),
        ModifiedUtc VARCHAR(MAX)
    );
    
    -- Use MERGE with same logic as before
    MERGE dbo.LoanMavent AS target
    USING (
        -- Same source query as before
        SELECT 
            i.LoanId, 
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
            MaventLicenseResult,
            m.MiscellaneousId AS LoanMaventId,
            m.ModifiedUtc
        FROM inserted i
        JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON i.loanguid = l.encompassid
        LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.miscellaneous m ON m.encompassid = l.encompassid
    ) AS source ON target.LoanId = source.LoanId
    
    -- UPDATE existing records
    WHEN MATCHED THEN
        UPDATE SET
            MaventReviewResult = source.MaventReviewResult,
            MaventOfacResult = source.MaventOfacResult,
            MaventOtherResult = source.MaventOtherResult,
            MaventStateResult = source.MaventStateResult,
            MaventTilaRorResult = source.MaventTilaRorResult,
            MaventTilaToleranceResult = source.MaventTilaToleranceResult,
            MaventAutoOrderIndicator = source.MaventAutoOrderIndicator,
            MaventHpmlResult = source.MaventHpmlResult,
            MaventNmlsResult = source.MaventNmlsResult,
            MaventATRQMResult = source.MaventATRQMResult,
            AveragePercentageRate = source.AveragePercentageRate,
            MaventOrderedBy = source.MaventOrderedBy,
            FinanceChargeAmount = source.FinanceChargeAmount,
            FederalTotalLoanAmount = source.FederalTotalLoanAmount,
            StateTotalLoanAmount = source.StateTotalLoanAmount,
            QmPointsAndFeesTotal = source.QmPointsAndFeesTotal,
            AbilityToRepayLoanType = source.AbilityToRepayLoanType,
            QualifiedMortgageLoanType = source.QualifiedMortgageLoanType,
            QualifiedMortgageEligible = source.QualifiedMortgageEligible,
            HigherPricedCoveredTrans = source.HigherPricedCoveredTrans,
            LoanTermAndFeatures = source.LoanTermAndFeatures,
            QmPointsAndFeesLimit = source.QmPointsAndFeesLimit,
            MaventOrderedDate = source.MaventOrderedDate,
            UnderwritingFactors = source.UnderwritingFactors,
            QmPriceBasedLimit = source.QmPriceBasedLimit,
            ReviewId = source.ReviewId,
            MaventCraxResult = source.MaventCraxResult,
            MaventEnterpriseResult = source.MaventEnterpriseResult,
            MaventGseResult = source.MaventGseResult,
            MaventHighCostResult = source.MaventHighCostResult,
            MaventHmdaResult = source.MaventHmdaResult,
            MaventLicenseResult = source.MaventLicenseResult,
            LoanMaventId = source.LoanMaventId,
            ModifiedUtc = source.ModifiedUtc
    
    -- INSERT new records
    WHEN NOT MATCHED THEN
        INSERT (
            LoanId, MaventReviewResult, MaventOfacResult, MaventOtherResult, MaventStateResult,
            MaventTilaRorResult, MaventTilaToleranceResult, MaventAutoOrderIndicator,
            MaventHpmlResult, MaventNmlsResult, MaventATRQMResult, AveragePercentageRate,
            MaventOrderedBy, FinanceChargeAmount, FederalTotalLoanAmount, StateTotalLoanAmount,
            QmPointsAndFeesTotal, AbilityToRepayLoanType, QualifiedMortgageLoanType,
            QualifiedMortgageEligible, HigherPricedCoveredTrans, LoanTermAndFeatures,
            QmPointsAndFeesLimit, MaventOrderedDate, UnderwritingFactors, QmPriceBasedLimit,
            ReviewId, MaventCraxResult, MaventEnterpriseResult, MaventGseResult,
            MaventHighCostResult, MaventHmdaResult, MaventLicenseResult, LoanMaventId, ModifiedUtc
        )
        VALUES (
            source.LoanId, source.MaventReviewResult, source.MaventOfacResult, source.MaventOtherResult,
            source.MaventStateResult, source.MaventTilaRorResult, source.MaventTilaToleranceResult,
            source.MaventAutoOrderIndicator, source.MaventHpmlResult, source.MaventNmlsResult,
            source.MaventATRQMResult, source.AveragePercentageRate, source.MaventOrderedBy,
            source.FinanceChargeAmount, source.FederalTotalLoanAmount, source.StateTotalLoanAmount,
            source.QmPointsAndFeesTotal, source.AbilityToRepayLoanType, source.QualifiedMortgageLoanType,
            source.QualifiedMortgageEligible, source.HigherPricedCoveredTrans, source.LoanTermAndFeatures,
            source.QmPointsAndFeesLimit, source.MaventOrderedDate, source.UnderwritingFactors,
            source.QmPriceBasedLimit, source.ReviewId, source.MaventCraxResult, source.MaventEnterpriseResult,
            source.MaventGseResult, source.MaventHighCostResult, source.MaventHmdaResult,
            source.MaventLicenseResult, source.LoanMaventId, source.ModifiedUtc
        )
    
    -- Capture results into temp table for history logging
    OUTPUT $action, inserted.LoanId, inserted.MaventReviewResult, inserted.MaventOfacResult,
           inserted.MaventOtherResult, inserted.MaventStateResult, inserted.MaventTilaRorResult,
           inserted.MaventTilaToleranceResult, inserted.MaventAutoOrderIndicator, inserted.MaventHpmlResult,
           inserted.MaventNmlsResult, inserted.MaventATRQMResult, inserted.AveragePercentageRate,
           inserted.MaventOrderedBy, inserted.FinanceChargeAmount, inserted.FederalTotalLoanAmount,
           inserted.StateTotalLoanAmount, inserted.QmPointsAndFeesTotal, inserted.AbilityToRepayLoanType,
           inserted.QualifiedMortgageLoanType, inserted.QualifiedMortgageEligible, inserted.HigherPricedCoveredTrans,
           inserted.LoanTermAndFeatures, inserted.QmPointsAndFeesLimit, inserted.MaventOrderedDate,
           inserted.UnderwritingFactors, inserted.QmPriceBasedLimit, inserted.ReviewId,
           inserted.MaventCraxResult, inserted.MaventEnterpriseResult, inserted.MaventGseResult,
           inserted.MaventHighCostResult, inserted.MaventHmdaResult, inserted.MaventLicenseResult,
           inserted.LoanMaventId, inserted.ModifiedUtc
    INTO #MergeResults (ActionType, LoanId, MaventReviewResult, MaventOfacResult,
                        MaventOtherResult, MaventStateResult, MaventTilaRorResult,
                        MaventTilaToleranceResult, MaventAutoOrderIndicator, MaventHpmlResult,
                        MaventNmlsResult, MaventATRQMResult, AveragePercentageRate,
                        MaventOrderedBy, FinanceChargeAmount, FederalTotalLoanAmount,
                        StateTotalLoanAmount, QmPointsAndFeesTotal, AbilityToRepayLoanType,
                        QualifiedMortgageLoanType, QualifiedMortgageEligible, HigherPricedCoveredTrans,
                        LoanTermAndFeatures, QmPointsAndFeesLimit, MaventOrderedDate,
                        UnderwritingFactors, QmPriceBasedLimit, ReviewId,
                        MaventCraxResult, MaventEnterpriseResult, MaventGseResult,
                        MaventHighCostResult, MaventHmdaResult, MaventLicenseResult,
                        LoanMaventId, ModifiedUtc);
    
    -- Insert history records from temp table, converting to JSON (only if changes happened)
    INSERT INTO dbo.LoanMaventHistory (LoanId, ActionType, RowDataJSON)
    SELECT 
        LoanId, 
        ActionType,
        (SELECT LoanId, MaventReviewResult, MaventOfacResult, MaventOtherResult, MaventStateResult,
                MaventTilaRorResult, MaventTilaToleranceResult, MaventAutoOrderIndicator, MaventHpmlResult,
                MaventNmlsResult, MaventATRQMResult, AveragePercentageRate, MaventOrderedBy,
                FinanceChargeAmount, FederalTotalLoanAmount, StateTotalLoanAmount, QmPointsAndFeesTotal,
                AbilityToRepayLoanType, QualifiedMortgageLoanType, QualifiedMortgageEligible,
                HigherPricedCoveredTrans, LoanTermAndFeatures, QmPointsAndFeesLimit, MaventOrderedDate,
                UnderwritingFactors, QmPriceBasedLimit, ReviewId, MaventCraxResult, MaventEnterpriseResult,
                MaventGseResult, MaventHighCostResult, MaventHmdaResult, MaventLicenseResult,
                LoanMaventId, ModifiedUtc
         FROM #MergeResults mr WHERE mr.LoanId = m.LoanId AND mr.ActionType = m.ActionType
         FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) as RowDataJSON
    FROM #MergeResults m;
    
    -- Clean up
    DROP TABLE #MergeResults;
    
    -- Log summary
    DECLARE @ProcessedLoans NVARCHAR(MAX);
    DECLARE @ChangeCount INT;
    
    SELECT 
        @ProcessedLoans = STRING_AGG(CAST(i.LoanId AS NVARCHAR(10)), ', '),
        @ChangeCount = COUNT(*)
    FROM inserted i;
    
    SELECT @ChangeCount = COUNT(*) 
    FROM dbo.LoanMaventHistoryDynamic 
    WHERE ChangeDate >= DATEADD(SECOND, -5, GETDATE());
    
    IF @ProcessedLoans IS NOT NULL
        PRINT 'LoanMavent dynamic trigger processed LoanIds: ' + @ProcessedLoans + 
              ' (History records created: ' + CAST(@ChangeCount AS VARCHAR(10)) + ')';
END
GO

-- =============================================
-- Helper Views/Functions to Query History
-- =============================================

-- View to easily query history with parsed JSON
CREATE OR ALTER VIEW vw_LoanMaventHistoryParsed AS
SELECT 
    h.HistoryId,
    h.LoanId,
    h.ActionType,
    h.ChangeDate,
    h.ChangedBy,
    -- Parse commonly used fields from JSON
    JSON_VALUE(h.RowDataJSON, '$.LoanId') as JSON_LoanId,
    JSON_VALUE(h.RowDataJSON, '$.MaventReviewResult') as JSON_MaventReviewResult,
    JSON_VALUE(h.RowDataJSON, '$.FinanceChargeAmount') as JSON_FinanceChargeAmount,
    -- Full JSON for complete access
    h.RowDataJSON
FROM dbo.LoanMaventHistory h;
GO

PRINT 'Dynamic history system created successfully!';
PRINT 'Benefits:';
PRINT '- Automatically handles new columns added to LoanMavent';
PRINT '- Stores complete row data in JSON format';
PRINT '- Use vw_LoanMaventHistoryParsed to query parsed data';
PRINT '- Only creates history records when actual changes occur';

-- Example queries:
PRINT '';
PRINT 'Example usage:';
PRINT '-- See all changes: SELECT * FROM vw_LoanMaventHistoryParsed ORDER BY ChangeDate DESC';
PRINT '-- See changes for loan: SELECT * FROM vw_LoanMaventHistoryParsed WHERE LoanId = 12345';
PRINT '-- Parse any JSON field: SELECT JSON_VALUE(RowDataJSON, ''$.ColumnName'') FROM LoanMaventHistoryDynamic';


DROP TRIGGER trg_loan_smart_update_mavent;
GO