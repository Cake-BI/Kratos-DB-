CREATE TABLE dbo.LoanClosing (
    LoanID INT,
    LenderPaidClosingCostsAmount INT,
    ModifiedUtc BIGINT

    CONSTRAINT FK_LoanClosing_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);

--DROP TABLE LoanClosing

--ALTER TABLE dbo.LoanClosing
--DROP CONSTRAINT [FK_LoanClosing(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanClosing
--ADD CONSTRAINT [FK_LoanClosing(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

INSERT INTO dbo.LoanClosing (
LoanID,
LenderPaidClosingCostsAmount,
ModifiedUtc
)

SELECT kl.LoanID,
l.LenderPaidClosingCostsAmount,
l.ModifiedUtc

FROM dbo.loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum  
