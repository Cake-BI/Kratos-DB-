CREATE TABLE dbo.Employment (
    BorrowerID NVARCHAR(100) FOREIGN KEY REFERENCES dbo.borrower(borrowerid),
    EmployerName NVARCHAR(100),
    StreetAddress NVARCHAR(100),
    AddressCity VARCHAR(40),
    AddressState VARCHAR(25),
    AddressZip NVARCHAR(15),
    CuurentEmploymentIndicator INT,
    PositionDescription NVARCHAR(100),
    StartDate Date,
    MonthlyIncomeAmount INT,
    YearsOnJob INT,
    EndDate Date,
    SelfEmploymentIndicator BIT,
    YearsInLineOfWork INT,
    PhoneNumber NVARCHAR(50),
    BasePayAmount INT,
    OvertimeAmount INT,
    BonusAmount INT,
    CommissionsAmount INT,
    OtherAmount INT,
    BusinessOwnedPercent INT,
    BusinessPhone NVARCHAR(50),
    Fax NVARCHAR(50),
    Email NVARCHAR(50),
    BusinessName NVARCHAR(75),
    MonthsOnJob INT,
    ForeigeIncome BIT,
    ForeignAddressIndicator BIT,
    Country NVARCHAR(50),
    EmployerID NVARCHAR(100) PRIMARY KEY
)

INSERT INTO dbo.Employment (
    borrowerid,
    EmployerName,
    StreetAddress,
    AddressCity,
    AddressState,
    AddressZip,
    CuurentEmploymentIndicator,
    PositionDescription,
    StartDate,
    MonthlyIncomeAmount,
    YearsOnJob,
    EndDate,
    SelfEmploymentIndicator,
    YearsInLineOfWork,
    PhoneNumber,
    BasePayAmount,
    OvertimeAmount,
    BonusAmount,
    CommissionsAmount,
    OtherAmount,
    BusinessOwnedPercent,
    BusinessPhone,
    Fax,
    Email,
    BusinessName,
    MonthsOnJob,
    ForeigeIncome,
    ForeignAddressIndicator,
    Country,
    EmployerID 
)

SELECT kb.borrowerid,
e.employername,
e.addressstreetline1,
e.addresscity,
e.addressstate,
e.addresspostalcode,
e.currentemploymentindicator,
e.positiondescription,
e.startdate,
e.monthlyincomeamount,
e.timeonjobtermyears,
e.enddate,
e.selfemployedindicator,
e.timeinlineofworkyears,
e.PhoneNumber,
e.BasePayAmount,
e.OvertimeAmount,
e.BonusAmount,
e.CommissionsAmount,
e.OtherAmount,
e.BusinessOwnedPercent,
e.BusinessPhone,
e.Fax,
e.Email,
e.BusinessName,
e.timeonjobtermmonths,
e.foreignincome,
e.foreignaddressindicator,
e.country,
e.employmentid 

--SELECT l.loannumber, kl.loannum, * 
From [WIN-T0FCRL091AK].Encompass.elliedb.Loan l  
LEFT JOIN Kratos.dbo.Loan kl ON kl.LoanNum = l.LoanNumber
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Borrower b ON l.encompassid = b.encompassid --and fullnamewithsuffix is not null 
LEFT JOIN Kratos.dbo.Borrower kb ON kb.borrowerid = b.borrowerid
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence r ON r.applicationid = b.applicationid and b.applicanttype = r.applicanttype and urla2020streetaddress is not null and mailingaddressindicator = 1 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Employment e ON e.applicationid = r.applicationid AND e.owner = r.applicanttype 
Where b.fullnamewithsuffix is not null and e.employmentid is not null AND l.loannumber = 2405039130


-- DELETE FROM dbo.Employment

-- Drop Table dbo.Employer

-- SELECT TOP 10 * FROM dbo.Employment 





 