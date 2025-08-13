SELECT kl.LoanId,
tpo.CompanyID ,
tpo.CompanyName,
tpo.CompanyLegalName,
tpo.CompanyDBAName,
tpo.CompanyAddress,
tpo.CompanyCity,
tpo.CompanyState,
tpo.CompanyZip,
tpo.CompanyPhone,
tpo.CompanyFax,
tpo.CompanyManagerName,
tpo.CompanyManagerEmail,
tpo.CompanyAEName,
tpo.CompanyAEUserName,
tpo.CompanyRating,
tpo.InitialApplicationDate,
tpo.InitialSubmitDate,
tpo.LOID,
tpo.LOName,
tpo.LOEmail,
tpo.LOBusinessPhone,
tpo.LOCellPhone,
tpo.LOAddress,
tpo.LOCity,
tpo.LOState,
tpo.LOZip,
tpo.LOAEName,
tpo.LOAEUserName,
tpo.LOStatus,
tpo.LONotes,
tpo.LPID,
tpo.LPName,
tpo.LPEmail,
tpo.LPBusinessPhone,
tpo.LPCellPhone,
tpo.LPAddress,
tpo.LPCity,
tpo.LPState,
tpo.LPZip,
tpo.LPAEName,
tpo.LPStatus,
tpo.LPNotes,
tpo.TPOId,
tpo.ModifiedUtc

INTO LoanBroker
FROM Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = kl.LoanGuID 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TPO tpo ON tpo.encompassid = l.encompassid AND CompanyId is not null


--DROP TABLE LoanBroker

--ALTER TABLE dbo.LoanBroker
--ALTER COLUMN TPOId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanBroker
--ADD CONSTRAINT PK_LoanBroker_TPOId PRIMARY KEY (TPOId);

--ALTER TABLE dbo.LoanBroker
--DROP CONSTRAINT [FK_LoanBroker(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanBroker
--ADD CONSTRAINT [FK_LoanBroker(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

SELECT * FROM LoanBroker


-- Find LoanId in Table1 but not in Table2
SELECT t1.tpoid,
t1.organizationLegalName,
t1.organizationName,
nmlsId
FROM Brokers t1
WHERE NOT EXISTS (
    SELECT 1 
    FROM LoanTPO t2 
    WHERE t2.CompanyId = t1.TPOId
);
