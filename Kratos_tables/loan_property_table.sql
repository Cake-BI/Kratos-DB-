CREATE TABLE dbo.LoanProperty (
    LoanID INT,
    GsePropertyType NVARCHAR(30),
    ModifiedUtc BIGINT

    CONSTRAINT FK_LoanProperty_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);

--DROP TABLE LoanProperty

--ALTER TABLE dbo.LoanProperty
--DROP CONSTRAINT [FK_LoanProperty(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanProperty
--ADD CONSTRAINT [FK_LoanProperty(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

INSERT INTO dbo.LoanProperty(
    LoanID,
    GsePropertyType,
    ModifiedUtc
)

SELECT kl.loanID,
lpd.GsePropertyType,
lpd.ModifiedUtc

FROM dbo.loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanProductData lpd ON lpd.encompassid = l.encompassid