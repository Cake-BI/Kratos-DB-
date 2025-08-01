
CREATE TABLE dbo.LoanMilestone (
    LoanNumber            VARCHAR(50),

    -- Milestone Dates + Durations
    StartedDate    DATETIME,
    DaysAtStarted  INT,

    InitialDisclosuresDate   DATETIME,
    DaysAtInitialDisclosures INT,

    ProcessingDate   DATETIME,
    DaysAtProcessing INT,

    SubmittalDate     DATETIME,
    DaysAtSubmittal   INT,

    CondApprovalDate     DATETIME,
    DaysAtCondApproval   INT,

    ResubmittalDate    DATETIME,
    DaysAtResubmittal  INT,

    ShippingDate     DATETIME,
    DaysAtShipping   INT,

    ApprovalDate      DATETIME,
    DaysAtApproval    INT,

    ClearToCloseDate    DATETIME,
    DaysAtClearToClose  INT,

    DocsOrderedDate    DATETIME,
    DaysAtDocsOrdered  INT,

    DocsSigningDate     DATETIME,
    DaysAtDocsSigning   INT,

    FundingDate    DATETIME,
    DaysAtFunding  INT,

    FinalDocsDate    DATETIME,
    DaysAtFinalDocs  INT,

    CompletionDate    DATETIME,
    DaysAtCompletion  INT,

    -- Final column
    LastModifiedUtc  DATETIME
);


--ALTER TABLE dbo.Loanmilestone
--DROP CONSTRAINT [FK_LoanMilestone(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.Loanmilestone
--ADD CONSTRAINT [FK_LoanMilestone(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


-- Pivot 1: Completion Dates
WITH DatePivot AS (
    SELECT *
    FROM (
        SELECT 
            l.loannumber, 
            Stage = REPLACE(mtl.Stage, ' ', ''),  -- Remove spaces
            DateComplete = CASE WHEN mtl.DoneIndicator > 0 THEN mtl.DateUtc ELSE NULL END
        FROM elliedb.milestonelog mtl 
        JOIN elliedb.Loan l ON mtl.EncompassId = l.EncompassId
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

-- Pivot 2: Durations
DurationPivot AS (
    SELECT *
    FROM (
        SELECT 
            l.loannumber,
            Stage = REPLACE(mtl.Stage, ' ', ''),
            DaysSpent = CASE WHEN mtl.Duration < 0 THEN NULL ELSE mtl.Duration END
        FROM elliedb.milestonelog mtl 
        JOIN elliedb.Loan l ON mtl.EncompassId = l.EncompassId
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

-- Latest ModifiedUtc per loan
LatestModified AS (
    SELECT 
        l.loannumber,
        MAX(mtl.ModifiedUtc) AS LastModifiedUtc
    FROM elliedb.milestonelog mtl
    JOIN elliedb.Loan l ON mtl.EncompassId = l.EncompassId
    GROUP BY l.loannumber
)

-- Final result
SELECT 
    d.loannumber,

    -- StageDate and DaysAtStage pairs
    d.Started               AS StartedDate,             dur.Started              AS DaysAtStarted,
    d.InitialDisclosures    AS InitialDisclosuresDate,  dur.InitialDisclosures   AS DaysAtInitialDisclosures,
    d.Processing            AS ProcessingDate,          dur.Processing           AS DaysAtProcessing,
    d.Submittal             AS SubmittalDate,           dur.Submittal            AS DaysAtSubmittal,
    d.CondApproval          AS CondApprovalDate,        dur.CondApproval         AS DaysAtCondApproval,
    d.Resubmittal           AS ResubmittalDate,         dur.Resubmittal          AS DaysAtResubmittal,
    d.Shipping              AS ShippingDate,            dur.Shipping             AS DaysAtShipping,
    d.Approval              AS ApprovalDate,            dur.Approval             AS DaysAtApproval,
    d.ClearToClose          AS ClearToCloseDate,        dur.ClearToClose         AS DaysAtClearToClose,
    d.DocsOrdered           AS DocsOrderedDate,         dur.DocsOrdered          AS DaysAtDocsOrdered,
    d.DocsSigning           AS DocsSigningDate,         dur.DocsSigning          AS DaysAtDocsSigning,
    d.Funding               AS FundingDate,             dur.Funding              AS DaysAtFunding,
    d.FinalDocs             AS FinalDocsDate,           dur.FinalDocs            AS DaysAtFinalDocs,
    d.Completion            AS CompletionDate,          dur.Completion           AS DaysAtCompletion,

    -- Final column: last modified
    lm.LastModifiedUtc

FROM DatePivot d
JOIN DurationPivot dur ON d.loannumber = dur.loannumber
JOIN LatestModified lm ON d.loannumber = lm.loannumber;




