CREATE TABLE dbo.StageAnnum (
Stage VARCHAR(20),
MilestoneId INT IDENTITY(1,1)
) 


SELECT DISTINCT Stage
INTO #OrderedStages
FROM [WIN-T0FCRL091AK].Encompass.elliedb.Milestonelog;


INSERT INTO dbo.StageAnnum (Stage)
VALUES 
    ('Application'),
    ('Started'),
    ('Initial Disclosures'),
    ('Processing'),
    ('Submittal'),
    ('Cond Approval'),
    ('Resubmittal'),
    ('Approval'),
    ('Clear to Close'),
    ('Docs Ordered'),
    ('Docs Signing'),
    ('Funding'),
    ('Shipping'),
    ('Final Docs'),
    ('Completion'),
    ('Purchasing');

SELECT * FROM StageAnnum

--DROP TABLE StageAnnum

