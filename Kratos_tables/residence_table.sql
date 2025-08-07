SELECT 
    kl.LoanId, 
    m.AddressStreetLine1 AS MailingAddress,
    m.AddressCity AS MailingAddressCity,
    m.AddressState AS MailingAddressState, 
    m.AddressPostalCode AS MailingPostalCode,
    r.AddressStreetLine1 AS CurrentAddress,
    r.AddressCity AS CurrentAddressCity,
    r.AddressState AS CurrentAddressState,
    r.AddressPostalCode CurrentPostalCode,
    r.LandlordName,
    r.LandlordAttention,
    r.LandlordStreet,
    r.LandlordCity,
    r.LandlordState,
    r.LandlordPostalCode,
    r.DurationTermYears,
    r.ApplicantType,
    r.AccountName,
    r.ResidencyBasisType,
    r.Rent,
    r.LandlordPhone,
    r.LandlordFax,
    r.LandlordEmail,
    r.LandlordComments,
    r.County,
    r.DurationTermMonths,
    r.AddressUnitDesignatorType,
    r.AddressUnitIdentifier,
    r.CountryCode,
    r.PrintAttachmentIndicator,
    r.Title,
    r.AddressCounty,
    r.DoesNotApplyIndicator,
    r.ForeignAddressIndicator,
    r.Country,
    r.LandlordForeignAddressIndicator,
    r.LandlordCountry,
    r.ModifiedUtc,
    r.ResidenceId,
    r.ApplicationId, 
    b.BorrowerId

--INTO dbo.Residence    
FROM dbo.Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.LoanNumber = kl.LoanNum 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence r ON r.EncompassId = l.EncompassId AND r.ResidencyType = 'Current'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b ON b.ApplicationId = r.ApplicationId AND b.ApplicantType = r.ApplicantType
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence m ON m.ApplicationId = r.ApplicationId AND m.ApplicantType = r.ApplicantType AND m.MailingAddressIndicator = 1
WHERE r.ResidenceId IS NOT NULL AND r.AddressStreetLine1 IS NOT NULL;
 
 
--DROP TABLE dbo.Residence

--ALTER TABLE dbo.Residence
--ALTER COLUMN ResidenceId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.Residence
--ADD CONSTRAINT PK_Residence_ResidenceId PRIMARY KEY (ResidenceId);

--ALTER TABLE dbo.Residence
--DROP CONSTRAINT [FK_Residence(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.Residence 
--ADD CONSTRAINT [FK_Residence(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

SELECT * FROM Residence
WHERE mailingpostalcode != currentpostalcode

SELECT Column_name 
FROM [WIN-T0FCRL091AK].Encompass.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Residence'


