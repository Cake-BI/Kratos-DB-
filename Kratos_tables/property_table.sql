CREATE TABLE dbo.Property (
LoanID INT,
StreetAddress NVARCHAR(100),
City NVARCHAR(40),
State VARCHAR(25),
PostalCode NVARCHAR(15),
County VARCHAR(60),
FinancedNumberOfUnits INT,
StructureBuiltYear VARCHAR(10),
PropertyUsageType NVARCHAR(40),
RuralAreaIndicator INT,
LoanPurposeType NVARCHAR(40),
PropertyExistingLienAmount INT,
RefinancePropertyExistingLienAmount INT,
GseRefinancePurposeType NVARCHAR(40),
RefinanceProposedImprovementsDescription NVARCHAR(100),
PropertyRightsType VARCHAR(40),
PropertyID NVARCHAR(100) PRIMARY KEY
)

INSERT INTO dbo.Property (
LoanID,
StreetAddress,
City,
State,
PostalCode,
County,
FinancedNumberOfUnits,
StructureBuiltYear,
PropertyUsageType,
RuralAreaIndicator,
LoanPurposeType,
PropertyExistingLienAmount,
RefinancePropertyExistingLienAmount,
GseRefinancePurposeType,
RefinanceProposedImprovementsDescription,
PropertyRightsType,
PropertyID
)

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
p.PropertyId

FROM [WIN-T0FCRL091AK].Encompass.elliedb.Loan l
LEFT JOIN Kratos.dbo.Loan kl ON kl.LoanNum = l.LoanNumber
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Property p ON p.encompassid = l.encompassid


/*DROP TABLE Property

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH 
FROM Kratos.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Borrower' 
  AND TABLE_SCHEMA = 'dbo';*/ 
