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

--DELETE FROM LoanMetaData

--DROP TABLE LoanMetaData

--ALTER TABLE dbo.LoanMetaData
--DROP CONSTRAINT [FK_LoanMetaData(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanMetaData
--ADD CONSTRAINT [FK_LoanMetaData(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


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
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.loanguid





