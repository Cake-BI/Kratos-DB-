CREATE TABLE BorrowerCredit (
    ExperianCreditScore INT,
    EquifaxScore INT,
    TransUnionScore INT,
    MinFicoScore INT,
    CreditRecievedDate DATE,
    PriorForeclosure BIT,
    DateOfBankruptcy DATE,
    DateOfForeclosure DATE,
    TaxIdentificationIdentifier NVARCHAR(50),
    TotalMonthlyIncomeAmount DECIMAL(18, 2),
    TotalPresentHousingExpenseAmount DECIMAL(18, 2),
    TotalMonthlyIncomeMinusNetRentalAmount DECIMAL(18, 2),

    ExperianDatePulled DATE,
    ExperianKeyFactor1 NVARCHAR(200),
    ExperianKeyFactor2 NVARCHAR(200),
    ExperianKeyFactor3 NVARCHAR(200),
    ExperianKeyFactor4 NVARCHAR(200),
    ExperianKeyFactor5 NVARCHAR(200),
    ExperianFactorCode1 NVARCHAR(50),
    ExperianFactorCode2 NVARCHAR(50),
    ExperianFactorCode3 NVARCHAR(50),
    ExperianFactorCode4 NVARCHAR(50),
    ExperianFactorCode5 NVARCHAR(50),

    TransUnionDatePulled DATE,
    TransUnionKeyFactor1 NVARCHAR(200),
    TransUnionKeyFactor2 NVARCHAR(200),
    TransUnionKeyFactor3 NVARCHAR(200),
    TransUnionKeyFactor4 NVARCHAR(200),
    TransUnionKeyFactor5 NVARCHAR(200),
    TransUnionFactorCode1 NVARCHAR(50),
    TransUnionFactorCode2 NVARCHAR(50),
    TransUnionFactorCode3 NVARCHAR(50),
    TransUnionFactorCode4 NVARCHAR(50),
    TransUnionFactorCode5 NVARCHAR(50),

    EquifaxDatePulled DATE,
    EquifaxKeyFactor1 NVARCHAR(200),
    EquifaxKeyFactor2 NVARCHAR(200),
    EquifaxKeyFactor3 NVARCHAR(200),
    EquifaxKeyFactor4 NVARCHAR(200),
    EquifaxKeyFactor5 NVARCHAR(200),
    EquifaxFactorCode1 NVARCHAR(50),
    EquifaxFactorCode2 NVARCHAR(50),
    EquifaxFactorCode3 NVARCHAR(50),
    EquifaxFactorCode4 NVARCHAR(50),
    EquifaxFactorCode5 NVARCHAR(50),
    BorrowerId NVARCHAR(100) PRIMARY KEY,
    ModifiedUtc BIGINT
        
    CONSTRAINT FK_BorrowerCredit_Borrower FOREIGN KEY (BorrowerId)
    REFERENCES dbo.Borrower(BorrowerId)
); 

--DROP TABLE BorrowerCredit

--ALTER TABLE dbo.BorrowerCredit
--DROP CONSTRAINT [FK_BorrowerCredit(BorrowerID_Borrower(BorrowerID)];

--ALTER TABLE dbo.BorrowerCredit
--ADD CONSTRAINT [FK_BorrowerCredit(BorrowerID_Borrower(BorrowerID)]
--FOREIGN KEY (BorrowerID)
--REFERENCES dbo.Borrower(BorrowerID)
--ON DELETE CASCADE;


INSERT INTO dbo.BorrowerCredit (
ExperianCreditScore,
EquifaxScore,
TransUnionScore,
MinFicoScore,
CreditRecievedDate,
PriorForeclosure,
DateOfBankruptcy,
DateOfForeclosure,
TaxIdentificationIdentifier,
TotalMonthlyIncomeAmount,
TotalPresentHousingExpenseAmount,
TotalMonthlyIncomeMinusNetRentalAmount,

ExperianDatePulled,
ExperianKeyFactor1,
ExperianKeyFactor2,
ExperianKeyFactor3,
ExperianKeyFactor4,
ExperianKeyFactor5,
ExperianFactorCode1,
ExperianFactorCode2,
ExperianFactorCode3,
ExperianFactorCode4,
ExperianFactorCode5,

TransUnionDatePulled,
TransUnionKeyFactor1,
TransUnionKeyFactor2,
TransUnionKeyFactor3,
TransUnionKeyFactor4,
TransUnionKeyFactor5,
TransUnionFactorCode1,
TransUnionFactorCode2,
TransUnionFactorCode3,
TransUnionFactorCode4,
TransUnionFactorCode5,

EquifaxDatePulled,
EquifaxKeyFactor1,
EquifaxKeyFactor2,
EquifaxKeyFactor3,
EquifaxKeyFactor4,
EquifaxKeyFactor5,
EquifaxFactorCode1,
EquifaxFactorCode2,
EquifaxFactorCode3,
EquifaxFactorCode4,
EquifaxFactorCode5,
BorrowerId,
ModifiedUtc
)

SELECT b.ExperianCreditScore,
b.EquifaxScore,
b.TransUnionScore,
b.MinFicoScore,
b.CreditReceivedDate,
b.PriorForeclosure,
b.DateOfBankruptcy,
b.DateOfForeclosure,
b.TaxIdentificationIdentifier,
b.TotalMonthlyIncomeAmount,
b.TotalPresentHousingExpenseAmount,
b.TotalMonthlyIncomeMinusNetRentalAmount,

b.ExperianDatePulled,
b.ExperianKeyFactor1,
b.ExperianKeyFactor2,
b.ExperianKeyFactor3,
b.ExperianKeyFactor4,
b.ExperianKeyFactor5,
b.ExperianFactorCode1,
b.ExperianFactorCode2,
b.ExperianFactorCode3,
b.ExperianFactorCode4,
b.ExperianFactorCode5,

b.TransUnionDatePulled,
b.TransUnionKeyFactor1,
b.TransUnionKeyFactor2,
b.TransUnionKeyFactor3,
b.TransUnionKeyFactor4,
b.TransUnionKeyFactor5,
b.TransUnionFactorCode1,
b.TransUnionFactorCode2,
b.TransUnionFactorCode3,
b.TransUnionFactorCode4,
b.TransUnionFactorCode5,

b.EquifaxDatePulled,
b.EquifaxKeyFactor1,
b.EquifaxKeyFactor2,
b.EquifaxKeyFactor3,
b.EquifaxKeyFactor4,
b.EquifaxKeyFactor5,
b.EquifaxFactorCode1,
b.EquifaxFactorCode2,
b.EquifaxFactorCode3,
b.EquifaxFactorCode4,
b.EquifaxFactorCode5,
b.borrowerid,
b.modifiedutc

SELECT  * 
FROM dbo.Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b ON b.encompassid = l.encompassid AND b.applicanttype IN ('borrower', 'coborrower') AND b.fullname is not null
--LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b1 ON b1.encompassid = l.encompassid AND b1.applicanttype = 'coborrower' AND b1.fullname is not null
WHERE b.borrowerid is null




/*DELETE FROM dbo.Loan
WHERE loanid IN (
    1034778,
    1026980,
    1027155,
    1027889,
    1028161,
    1028796,
    1028797,
    1029512,
    1029515
);*/


