SELECT kl.LoanId,
a.AccountIdentifier,
a.CashOrMarketValueAmount,
a.Description,
a.LifeInsuranceFaceValueAmount,
a.HolderName,
a.Attention,
a.HolderAddressStreetLine1,
a.HolderAddressCity,
a.HolderAddressState,
a.HolderAddressPostalCode,
a.AssetType,
a.DepositoryAccountName,
a.Owner,
a.HolderPhone,
a.HolderFax,
a.HolderEmail,
a.HolderComments,
a.Total,
a.PrintAttachmentIndicator,
a.Title,
a.TitlePhone,
a.TitleFax,
a.Urla2020CashOrMarketValueAmount,
a.IncludeInAusExport,
a.ForeignAddressIndicator,
a.Country,
a.Id,
a.AssetIndex,
a.IsEmpty,
a.IsVod,
a.NameInAccount,
a.VodIndex,
a.ModifiedUtc,
a.AssetId,
a.ApplicationId,
a.EncompassId

--INTO dbo.Asset 
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.Loannum = l.Loannumber 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Asset a ON a.encompassid = l.encompassid 

--DROP TABLE dbo.Asset

--ALTER TABLE dbo.Asset
--ALTER COLUMN AssetId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.Asset
--ADD CONSTRAINT PK_Asset_AssetId PRIMARY KEY (AssetId);

--ALTER TABLE dbo.Asset
--DROP CONSTRAINT [FK_Asset(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.Asset
--ADD CONSTRAINT [FK_Asset(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;
