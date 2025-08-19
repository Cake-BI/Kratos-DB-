-- Option 1: Generic History Table with JSON storage
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoanMaventHistory]') AND type in (N'U'))
BEGIN
    CREATE TABLE dbo.LoanMaventHistory (
        HistoryId INT IDENTITY(1,1) PRIMARY KEY,
        LoanId INT,
        ActionType VARCHAR(20), -- 'INSERT', 'UPDATE', 'DELETE'
        ChangeDate DATETIME2 DEFAULT GETDATE(),
        ChangedBy VARCHAR(100) DEFAULT SYSTEM_USER,
        TableName VARCHAR(100) DEFAULT 'LoanMavent',
        -- Store all column data as JSON - automatically handles any number of columns
        RowDataJSON NVARCHAR(MAX), -- All column values in JSON format
        -- Optional: Store what specifically changed
        ChangedColumns VARCHAR(MAX) -- Comma-separated list of changed column names
    );
    
    CREATE INDEX IX_LoanMaventHistoryDynamic_LoanId ON dbo.LoanMaventHistoryDynamic(LoanId);
    CREATE INDEX IX_LoanMaventHistoryDynamic_ChangeDate ON dbo.LoanMaventHistoryDynamic(ChangeDate);
    
    PRINT 'Dynamic LoanMaventHistory table created successfully';
END
GO


SELECT * FROM LoanMaventHistory

--DROP TABLE LoanMaventHistory