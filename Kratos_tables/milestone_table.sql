CREATE TABLE dbo.LoanMilestone (
    LoanID VARCHAR(50),

    -- Milestone Dates + Durations
    StartedDate DATETIME,
    DaysAtStarted INT,

    InitialDisclosuresDate DATETIME,
    DaysAtInitialDisclosures INT,

    ProcessingDate DATETIME,
    DaysAtProcessing INT,

    SubmittalDate DATETIME,
    DaysAtSubmittal INT,

    CondApprovalDate DATETIME,
    DaysAtCondApproval INT,

    ResubmittalDate DATETIME,
    DaysAtResubmittal INT,

    ShippingDate DATETIME,
    DaysAtShipping INT,

    ApprovalDate DATETIME,
    DaysAtApproval INT,

    ClearToCloseDate DATETIME,
    DaysAtClearToClose INT,

    DocsOrderedDate DATETIME,
    DaysAtDocsOrdered INT,

    DocsSigningDate DATETIME,
    DaysAtDocsSigning INT,

    FundingDate DATETIME,
    DaysAtFunding INT,

    FinalDocsDate DATETIME,
    DaysAtFinalDocs INT,

    CompletionDate DATETIME,
    DaysAtCompletion INT,

    -- Final column
    LastModifiedUtc BIGINT
);

--ALTER TABLE dbo.LoanMilestone
--DROP CONSTRAINT [FK_LoanMilestone(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanMilestone
--ADD CONSTRAINT [FK_LoanLoanMilestone(LoanId)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


-- CTEs First
WITH DatePivot AS (
    SELECT *
    FROM (
        SELECT 
            kl.loanID, 
            Stage = REPLACE(mtl.Stage, ' ', ''),  
            DateComplete = CASE WHEN mtl.DoneIndicator > 0 THEN mtl.DateUtc ELSE NULL END
        FROM [WIN-T0FCRL091AK].Encompass.elliedb.milestonelog mtl 
        JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON mtl.EncompassId = l.EncompassId
        JOIN dbo.Loan kl ON l.LoanNumber = kl.LoanNum
    ) AS src
    PIVOT (
        MAX(DateComplete)
        FOR Stage IN (
            [Started], [InitialDisclosures], [Processing], [Submittal], [CondApproval],
            [Resubmittal], [Shipping], [Approval], [ClearToClose], [DocsOrdered],
            [DocsSigning], [Funding], [FinalDocs], [Completion]
        )
    ) AS pvt
),
DurationPivot AS (
    SELECT *
    FROM (
        SELECT 
            kl.loanID,
            Stage = REPLACE(mtl.Stage, ' ', ''),
            DaysSpent = CASE WHEN mtl.Duration < 0 THEN NULL ELSE mtl.Duration END
        FROM [WIN-T0FCRL091AK].Encompass.elliedb.milestonelog mtl 
        JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON mtl.EncompassId = l.EncompassId
        JOIN dbo.Loan kl ON l.LoanNumber = kl.LoanNum
    ) AS src
    PIVOT (
        MAX(DaysSpent)
        FOR Stage IN (
            [Started], [InitialDisclosures], [Processing], [Submittal], [CondApproval],
            [Resubmittal], [Shipping], [Approval], [ClearToClose], [DocsOrdered],
            [DocsSigning], [Funding], [FinalDocs], [Completion]
        )
    ) AS pvt
),
LatestModified AS (
    SELECT 
        kl.loanID,
        MAX(mtl.ModifiedUtc) AS LastModifiedUtc
    FROM [WIN-T0FCRL091AK].Encompass.elliedb.milestonelog mtl
    JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON mtl.EncompassId = l.EncompassId
    JOIN dbo.Loan kl ON l.LoanNumber = kl.LoanNum
    GROUP BY kl.loanID
)

-- Now do the insert
INSERT INTO dbo.LoanMilestone (
    LoanID,

    StartedDate,            DaysAtStarted,
    InitialDisclosuresDate, DaysAtInitialDisclosures,
    ProcessingDate,         DaysAtProcessing,
    SubmittalDate,          DaysAtSubmittal,
    CondApprovalDate,       DaysAtCondApproval,
    ResubmittalDate,        DaysAtResubmittal,
    ShippingDate,           DaysAtShipping,
    ApprovalDate,           DaysAtApproval,
    ClearToCloseDate,       DaysAtClearToClose,
    DocsOrderedDate,        DaysAtDocsOrdered,
    DocsSigningDate,        DaysAtDocsSigning,
    FundingDate,            DaysAtFunding,
    FinalDocsDate,          DaysAtFinalDocs,
    CompletionDate,         DaysAtCompletion,

    LastModifiedUtc
)
SELECT 
    d.loanID,

    d.Started               AS StartedDate,              dur.Started              AS DaysAtStarted,
    d.InitialDisclosures    AS InitialDisclosuresDate,   dur.InitialDisclosures   AS DaysAtInitialDisclosures,
    d.Processing            AS ProcessingDate,           dur.Processing           AS DaysAtProcessing,
    d.Submittal             AS SubmittalDate,            dur.Submittal            AS DaysAtSubmittal,
    d.CondApproval          AS CondApprovalDate,         dur.CondApproval         AS DaysAtCondApproval,
    d.Resubmittal           AS ResubmittalDate,          dur.Resubmittal          AS DaysAtResubmittal,
    d.Shipping              AS ShippingDate,             dur.Shipping             AS DaysAtShipping,
    d.Approval              AS ApprovalDate,             dur.Approval             AS DaysAtApproval,
    d.ClearToClose          AS ClearToCloseDate,         dur.ClearToClose         AS DaysAtClearToClose,
    d.DocsOrdered           AS DocsOrderedDate,          dur.DocsOrdered          AS DaysAtDocsOrdered,
    d.DocsSigning           AS DocsSigningDate,          dur.DocsSigning          AS DaysAtDocsSigning,
    d.Funding               AS FundingDate,              dur.Funding              AS DaysAtFunding,
    d.FinalDocs             AS FinalDocsDate,            dur.FinalDocs            AS DaysAtFinalDocs,
    d.Completion            AS CompletionDate,           dur.Completion           AS DaysAtCompletion,

    lm.LastModifiedUtc

FROM DatePivot d
JOIN DurationPivot dur ON d.loanID = dur.loanID
JOIN LatestModified lm ON d.loanID = lm.loanID;


-- DROP TABLE LoanMilestone


--Select * from loanmilestone