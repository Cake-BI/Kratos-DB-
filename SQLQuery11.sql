SELECT ExistingLiensAndDrawUsed,
 
From [WIN-T0FCRL091AK].Encompass.elliedb.Loan

 
 
 SELECT COUNT(*) AS ColumnCount
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vwRushmore';


 
 SELECT
    [LoanNumber],
    COUNT(*) AS DuplicateCount
FROM 
    [kratos].[dbo].[vwRushmore]
GROUP BY 
    [LoanNumber]
HAVING 
    COUNT(*) > 1
ORDER BY 
    DuplicateCount DESC, [LoanNumber]

SELECT distinct GsePropertyType
 FROM [WIN-T0FCRL091AK].Encompass.elliedb.LOAN L

LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LOANMETADATA LM ON LM.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanProductData LPD ON LPD.ENCOMPASSID = LM.EncompassID



 
 SELECT COLUMN_NAME
FROM [WIN-T0FCRL091AK].Encompass.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'VaLoanData'
  AND COLUMN_NAME LIKE '%loan%'