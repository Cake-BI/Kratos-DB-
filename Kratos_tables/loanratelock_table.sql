CREATE TABLE dbo.LoanRateLock(
    LoanId INT,
    BuySidePriceRate DECIMAL(10, 4),
    BuySidePriceNetBuyPrice DECIMAL(10, 4),
    SellSidePriceRate DECIMAL(10, 4),
    SellSidePriceTotalAdjustment DECIMAL(10, 4),
    SellSideNetSellPrice DECIMAL(10, 4),
    SellSideCommitmentDate DATETIME,
    CompSideTradeNumber VARCHAR(50),
    BranchPrice DECIMAL(10, 4),
    CorporatePrice DECIMAL(10, 4),
    PlanCode VARCHAR(50),
    RequestImpoundWaived VARCHAR(20),
    Impounds BIT,
    Interest DECIMAL(10, 4),
    RequestedInterestRatePercent DECIMAL(5, 3),
    RateLockId NVARCHAR(100) PRIMARY KEY,
    ModifiedUtc BIGINT 

    CONSTRAINT FK_LoanRateLock_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);

--DROP TABLE LoanRateLock

INSERT INTO dbo.LoanRateLock(
    LoanId,
    BuySidePriceRate,
    BuySidePriceNetBuyPrice,
    SellSidePriceRate,
    SellSidePriceTotalAdjustment,
    SellSideNetSellPrice,
    SellSideCommitmentDate,
    CompSideTradeNumber,
    BranchPrice,
    CorporatePrice,
    PlanCode,
    RequestImpoundWaived,
    Impounds,
    Interest,
    RequestedInterestRatePercent,
    RateLockId,
    ModifiedUtc 
)

SELECT kl.LoanId,
rl.BuySidePriceRate,
rl.BuySidePriceNetBuyPrice,
rl.SellSidePriceRate,
rl.SellSidePriceTotalAdjustment,
rl.SellSideNetSellPrice,
rl.SellSideCommitmentDate,
rl.CompSideTradeNumber,
rl.BranchPrice,
rl.CorporatePrice,
rl.PlanCode,
rl.RequestImpoundWaived,
rl.Impounds,
rl.Interest,
l.RequestedInterestRatePercent,
rl.ratelockid,
rl.modifiedutc

FROM dbo.loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RateLock rl ON rl.encompassid = l.encompassid

-- SELECT top 5 * from [WIN-T0FCRL091AK].Encompass.elliedb.RateLock





