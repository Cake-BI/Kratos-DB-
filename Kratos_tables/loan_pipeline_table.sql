SELECT kl.LoanId,
kl.LoanNum,
kl.ServiceLoanNumber,
kl.InvestorLoanNumber,
kl.LoanGuId,
lmd.LoanMetaDataId AS LoanPipelineId

INTO dbo.LoanPipeline
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanMetaData lmd ON lmd.encompassid = kl.loanguid AND lmd.LoanFolder = 'My Pipeline'

--DROP TABLE LoanPipeline

--ALTER TABLE dbo.LoanPipeline
--ALTER COLUMN LoanPipelineId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanPipeline
--ADD CONSTRAINT PK_LoanPipeline_LoanPipelineId PRIMARY KEY (LoanPipelineId);

--ALTER TABLE dbo.LoanPipeline
--DROP CONSTRAINT [FK_LoanPipeline(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanPipeline
--ADD CONSTRAINT [FK_LoanPipeline(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;


