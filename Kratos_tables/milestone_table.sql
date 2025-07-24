CREATE TABLE dbo.Milestone (

)
SELECT ml.stage,
    ml.tpoconnectstatus,
    l.milestonefilestarteddate,
    l.milestonesubmitteddate,
    l.milestoneapproveddate,
    l.milestonefundeddate,
    --milestonelastcompleted = v.VirtualFieldValue,
    l.milestonecurrentname
FROM [WIN-T0FCRL091AK].Encompass.elliedb.Milestonelog ml
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = ml.encompassid 
--LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.VirtualFields v ON v.encompassid = l.encompassid
WHERE l.LoanNumber = 2503043904;


SELECT Loannumber, ProposedRealEstateTaxesAmount from [WIN-T0FCRL091AK].Encompass.elliedb.Loan WHERE ProposedRealEstateTaxesAmount ='n/a' 


SELECT * --DISTINCT logrecordindex
FROM [WIN-T0FCRL091AK].Encompass.elliedb.loan
WHERE EncompassID = 'bb51f955-82bd-4636-b448-a0879003950c'

