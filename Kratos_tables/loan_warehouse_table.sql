CREATE TABLE LoanWarehouse (
    MtgeeLoanNumber BIGINT,
    MtgeeLoanName NVARCHAR(100),
    NoteAmount INT,
    WarehousePrincipalCurrent DECIMAL(18, 2),
    InterestIncome DECIMAL(18, 2),
    TotalFeesDN INT,
    AgedDays INT,
    DisbEffectiveDate DATE,
    InvestorName NVARCHAR(200),
    NSR_Investor_Address NVARCHAR(200),
    OriginatorProductCode NVARCHAR(50),
    OrigIndex NVARCHAR(20),
    OriginatorParticipationAmt DECIMAL(18, 2)
);


