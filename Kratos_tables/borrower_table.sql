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
    ModifiedUtc
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
b.ModifiedUtc

From [WIN-T0FCRL091AK].Encompass.elliedb.Loan l  
LEFT JOIN Kratos.dbo.Loan kl ON kl.LoanNum = l.LoanNumber
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b ON l.encompassid = b.encompassid --and fullnamewithsuffix is not null 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application a ON a.applicationid = b.applicationid 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence r ON r.applicationid = a.applicationid and b.applicanttype = r.applicanttype and urla2020streetaddress is not null and mailingaddressindicator = 1 
Where fullnamewithsuffix is not null



-- DBCC CHECKIDENT ('dbo.borrower', RESEED, 9999); 

-- DELETE FROM dbo.Borrower

