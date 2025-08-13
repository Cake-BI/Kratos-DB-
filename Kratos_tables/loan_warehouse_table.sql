CREATE TABLE LoanWarehouse (
    LoanNum BIGINT,
    BorrowerName NVARCHAR(100),
    NoteAmount INT,
    WarehousePrincipalCurrent DECIMAL(18, 2),
    InterestIncome DECIMAL(18, 2),
    TotalFeesDN INT,
    AgedDays INT,
    DisbEffectiveDate DATE,
    InvestorName NVARCHAR(200),
    OriginatorProductCode NVARCHAR(50),
    AsOfDate DATE
);


