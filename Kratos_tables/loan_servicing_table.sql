CREATE TABLE dbo.LoanServicing (
    LoanID INT,
    InvestorName VARCHAR(100),
    InvestorCommitment VARCHAR(100),
    Hedging VARCHAR(100),
    DateFirstPaymentToInvestor DATE,
    FirstPaymenTo VARCHAR(50),
    NextPaymentDate DATE,
    CorrespondentPaymentHistoryNoteDate DATE,
    ScheduledFirstPaymentDate DATE,
    EscrowWaiverIndicator BIT,
    BalloonIndicator BIT,
    LienPriorityType VARCHAR(50),
    LoanProductDataID NVARCHAR(100) PRIMARY KEY,
    ModifiedUtc BIGINT

    CONSTRAINT FK_LoanServicing_Loan FOREIGN KEY (LoanId)
    REFERENCES dbo.Loan(LoanId)
);

-- DROP TABLE LoanServicing

--ALTER TABLE dbo.LoanServicing 
--DROP CONSTRAINT [FK_LoanServicing(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanServicing
--ADD CONSTRAINT [FK_LoanServicing(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

INSERT INTO dbo.LoanServicing (
    LoanID,
    InvestorName,
    InvestorCommitment,
    Hedging,
    DateFirstPaymentToInvestor,
    FirstPaymenTo,
    NextPaymentDate,
    CorrespondentPaymentHistoryNoteDate,
    ScheduledFirstPaymentDate,
    EscrowWaiverIndicator,
    BalloonIndicator,
    LienPriorityType,
    LoanProductDataID,
    ModifiedUtc
)

SELECT kl.LoanID,
rl.InvestorName,
rl.InvestorCommitment,
rl.Hedging,
rl.DateFirstPaymentToInvestor,
rl.FirstPaymenTo,
rl.NextPaymentDate,
rl.CorrespondentPaymentHistoryNoteDate,
lpd.ScheduledFirstPaymentDate,
lpd.EscrowWaiverIndicator,
lpd.BalloonIndicator,
lpd.LienPriorityType,
lpd.LoanProductDataID,
lpd.ModifiedUtc

FROM dbo.loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RateLock rl ON rl.encompassid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanProductData lpd ON lpd.encompassid = rl.encompassid



