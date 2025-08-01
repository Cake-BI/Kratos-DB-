SELECT kl.LoanId,
c.ContactType,
c.ContactIndex,
c.ReferenceNumber,
c.Name,
c.ContactName,
c.ContactTitle,
c.Address,
c.City,
c.State,
c.PostalCode,
c.Phone,
c.Phone2,
c.Email,
c.Fax,
c.Fax2,
c.PersonalLicenseNumber,
c.LicenseType,
c.LicenseExempt,
c.NmlsLicense,
c.License,
c.ContactId,
c.ModifiedUtc

INTO dbo.Contact 
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.LoanNumber = kl.LoanNum 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Contact c ON c.encompassid = l.encompassid

--DROP TABLE dbo.Contact 

--ALTER TABLE dbo.Contact
--ALTER COLUMN ContactId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.Contact
--ADD CONSTRAINT PK_Contact_ContactId PRIMARY KEY (ContactId);

--ALTER TABLE dbo.Contact
--DROP CONSTRAINT [FK_Contact(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.Contact 
--ADD CONSTRAINT [FK_Contact(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;

