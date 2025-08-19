-- Create the history table with the same structure as the main table
CREATE TABLE dbo.LoanHist (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    LoanID INT NOT NULL,
    LoanNum BIGINT,
    ServiceLoanNumber NVARCHAR(100),
    InvestorLoanNumber NVARCHAR(100),
    LoanGuID VARCHAR(40),
    ChangedDate DATETIME2 DEFAULT GETUTCDATE(),
    ChangeType INT NOT NULL -- 'I' for Insert, 'U' for Update, 'D' for Delete
);

--DROP TABLE LoanHist

--DROP TRIGGER IF EXISTS tr_Loan_Audit


--DROP INDEX IX_LoanHistory_LoanID ON dbo.LoanHist;
--DROP INDEX IX_LoanHistory_ChangedDate ON dbo.LoanHist;

-- Create index on LoanID for better performance when querying history
CREATE INDEX IX_LoanHistory_LoanID ON dbo.LoanHist (LoanID);
CREATE INDEX IX_LoanHistory_ChangedDate ON dbo.LoanHist (ChangedDate);

--DROP TRIGGER tr_Loan_Audit

--Trigger for INSERT operations
CREATE TRIGGER tr_Loan_Audit
ON dbo.Loan
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Handle INSERT operations
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO dbo.LoanHist (
            LoanID, LoanNum, ServiceLoanNumber, InvestorLoanNumber, 
            LoanGuID, ChangedDate, ChangeType
        )
        SELECT 
            i.LoanID, i.LoanNum, i.ServiceLoanNumber, i.InvestorLoanNumber,
            i.LoanGuID, GETUTCDATE(), 1
        FROM inserted i;
    END
    
    -- Handle UPDATE operations
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO dbo.LoanHist (
            LoanID, LoanNum, ServiceLoanNumber, InvestorLoanNumber, 
            LoanGuID, ChangedDate, ChangeType
        )
        SELECT 
            i.LoanID, i.LoanNum, i.ServiceLoanNumber, i.InvestorLoanNumber,
            i.LoanGuID, GETUTCDATE(), 2
        FROM inserted i;
    END
    
    -- Handle DELETE operations
    IF NOT EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO dbo.LoanHist (
            LoanID, LoanNum, ServiceLoanNumber, InvestorLoanNumber, 
            LoanGuID, ChangedDate, ChangeType
        )
        SELECT 
            d.LoanID, d.LoanNum, d.ServiceLoanNumber, d.InvestorLoanNumber,
            d.LoanGuID, GETUTCDATE(), 3
        FROM deleted d;
    END
END;
-- Optional: Query to view history for a specific loan
/*
-- Example query to see history for a specific loan
SELECT 
    h.HistoryID,
    h.LoanID,
    h.LoanNum,
    h.ServiceLoanNumber,
    h.InvestorLoanNumber,
    h.LoanGuID,
    h.ModifiedUtc,
    h.Ohtani,
    h.ChangedBy,
    h.ChangedDate,
    CASE h.ChangeType 
        WHEN 'I' THEN 'Insert'
        WHEN 'U' THEN 'Update' 
        WHEN 'D' THEN 'Delete'
    END as ChangeDescription
FROM dbo.LoanHistory h
WHERE h.LoanID = 1000000  -- Replace with actual LoanID
ORDER BY h.ChangedDate DESC;
*/


SELECT * FROM LoanHist

