SELECT kl.LoanId,
a.SofDBorrowerAddressType,
a.SofDBorrowerAddress,
a.SofDBorrowerAddressCity,
a.SofDBorrowerAddressState,
a.SofDBorrowerAddressZipcode,
a.SofDCoBorrowerAddressType,
a.SofDCoBorrowerAddress,
a.SofDCoBorrowerAddressCity,
a.SofDCoBorrowerAddressState,
a.SofDCoBorrowerAddressZipcode,
a.SofDBorrForeignAddressIndicator,
a.SofDBorrCountry,
a.SofDCoBorrForeignAddressIndicator,
a.SofDCoBorrCountry,
a.PrequalCreditReportIndicator,
a.ApplicationId,
a.ModifiedUtc,
a.applicationindex,
a.rescissiondate

--INTO dbo.LoanAdverseAction
FROM dbo.Loan kl
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.Loannumber = kl.LoanNum
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application a ON a.encompassid = l.encompassid
WHERE a.SofDBorrowerAddress is not null
--WHERE kl.Loannum = '2501042333'


