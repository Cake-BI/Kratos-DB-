CREATE TABLE dbo.LoanMetaData (
    LoanID INT,
    CreatedUtc DATETIME,
    OrganizationCode VARCHAR(50),
    ReferralSource VARCHAR(100),
    Channel VARCHAR(50),
    ModifiedUtc BIGINT

    CONSTRAINT FK_LoanMetaData_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);

--DROP TABLE LoanMetaData

INSERT INTO dbo.LoanMetaData (
    LoanID,
    CreatedUtc,
    OrganizationCode,
    ReferralSource,
    Channel,
    ModifiedUtc
)

SELECT kl.LoanID,
l.CreatedUtc,
l.OrganizationCode,
l.ReferralSource,
l.Channel,
l.modifiedUtc

FROM dbo.loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum 





