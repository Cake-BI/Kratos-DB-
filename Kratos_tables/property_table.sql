SELECT
kl.LoanID,
p.StreetAddress,
p.City,
p.State,
p.PostalCode,
p.County,
p.FinancedNumberOfUnits,
p.StructureBuiltYear,
p.PropertyUsageType,
p.RuralAreaIndicator,
p.LoanPurposeType,
p.PropertyExistingLienAmount,
p.RefinancePropertyExistingLienAmount,
p.GseRefinancePurposeType,
p.RefinanceProposedImprovementsDescription,
p.PropertyRightsType,
p.LotAcres,
p.CondotelIndicator,
p.NonwarrantableProjectIndicator,
p.PropertyId,
p.ModifiedUtc

INTO dbo.LoanProperty
FROM Kratos.dbo.Loan kl
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.LoanNum = l.LoanNumber
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Property p ON p.encompassid = l.encompassid


----------------------------------------- ADD AND ALTAR BELOW ----------------------------------------------------

ALTER TABLE dbo.LoanProperty
ADD StructureBuiltYear INT
    


UPDATE lp
SET 
    lp.StructureBuiltYear = p.StructureBuiltYear
FROM dbo.LoanProperty lp
JOIN Kratos.dbo.Loan kl ON kl.LoanID = lp.LoanID
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.LoanNumber = kl.LoanNum
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Property p ON p.encompassid = l.encompassid;


--DROP TABLE LoanProperty 

--ALTER TABLE dbo.LoanProperty
--ALTER COLUMN PropertyId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.LoanProperty
--ADD CONSTRAINT PK_LoanProperty_PropertyId PRIMARY KEY (PropertyId);

--ALTER TABLE dbo.LoanProperty
--DROP CONSTRAINT [FK_LoanProperty(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.LoanProperty 
--ADD CONSTRAINT [FK_LoanProperty(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH 
FROM [WIN-T0FCRL091AK].Encompass.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Disclosure' 
  AND TABLE_SCHEMA = 'elliedb'

--ALTER TABLE Borrower
--ADD CONSTRAINT FK__Borrower__LoanID;

 SELECT * FROM LoanProperty

