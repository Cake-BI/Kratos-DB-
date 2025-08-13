CREATE TABLE dbo.Borrower (
    LoanId INT FOREIGN KEY REFERENCES dbo.Loan(loanid),
    ApplicationIndex INT,
    BorrowerIndex INT,
    isBorrower BIT,
    FirstName NVARCHAR(100),
    MiddleName NVARCHAR(100),
    LastName NVARCHAR(100),
    AgeAtApplicationYearsCount INT,
    FullNameWithSuffix NVARCHAR(200),
    AddressCity NVARCHAR(100),
    HomePhoneNumber NVARCHAR(50),
    MobilePhone NVARCHAR(50),
    MaritalStatusType VARCHAR(50),
    BorrowerId NVARCHAR(100) PRIMARY KEY,
    ModifiedUtc BIGINT NULL
);

--DROP TABLE Borrower

--ALTER TABLE dbo.Borrower
--ADD ApplicantType VARCHAR(30);


--ALTER TABLE dbo.Borrower
--DROP CONSTRAINT [FK_Borrower(LoanID)_LoanID(LoanID)];


--ALTER TABLE dbo.Borrower
--ADD CONSTRAINT [FK_Borrower(LoanID)_LoanID(LoanID)]
--FOREIGN KEY (LoanId)
--REFERENCES dbo.Loan(loanid)
--ON DELETE CASCADE;



INSERT INTO dbo.Borrower (
    loanid,
    applicationindex,
    borrowerindex,
    isborrower,
    firstname,
    middlename,
    lastname,
    ageatapplicationyearscount,
    fullnamewithsuffix,
    addresscity,
    homephonenumber,
    mobilephone,
    maritalstatustype,
    borrowerid,
    ModifiedUtc,
    ApplicantType
)
Select kl.loanid,
a.applicationindex,
b.borrowerindex,
b.isborrower,
b.firstname,
b.middlename,
b.lastname,
b.ageatapplicationyearscount,
b.fullnamewithsuffix,
r.addresscity,
b.homephonenumber,
b.mobilephone,
b.maritalstatustype,
b.borrowerid,
b.ModifiedUtc,
b.ApplicantType

From [WIN-T0FCRL091AK].Encompass.elliedb.Loan l  
JOIN Kratos.dbo.Loan kl ON kl.Loanguid = l.encompassid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b ON l.encompassid = b.encompassid --and fullnamewithsuffix is not null 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application a ON a.applicationid = b.applicationid 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence r ON r.applicationid = a.applicationid and b.applicanttype = r.applicanttype and urla2020streetaddress is not null and mailingaddressindicator = 1 
Where fullnamewithsuffix is not null


-- DBCC CHECKIDENT ('dbo.borrower', RESEED, 9999); 

DELETE FROM dbo.Borrower

/*UPDATE b_new
SET b_new.ApplicantType = b_orig.ApplicantType
FROM dbo.Borrower b_new
JOIN Kratos.dbo.Loan kl ON b_new.loanid = kl.loanid
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON kl.LoanNum = l.LoanNumber
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b_orig ON l.encompassid = b_orig.encompassid
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application a ON a.applicationid = b_orig.applicationid
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence r 
    ON r.applicationid = a.applicationid 
    AND b_orig.applicanttype = r.applicanttype 
    AND urla2020streetaddress IS NOT NULL 
    AND mailingaddressindicator = 1
WHERE b_orig.fullnamewithsuffix IS NOT NULL
  AND b_new.fullnamewithsuffix = b_orig.fullnamewithsuffix;*/ 



SELECT TOP 10 * FROM Borrower


