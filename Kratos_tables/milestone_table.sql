SELECT ml.days,
ml.logrecordindex,
ml.stage,
CASE WHEN ml.stage is 'Started' THEN 1 
	 WHEN ml.stage is 'Initial Disclosures' THEN 2
	 WHEN ml.stage is 'Processing' THEN 3
	 WHEN ml.stage is 'Submittal' THEN 4
	 WHEN ml.stage is 'Cond Approval' THEN 5
	 WHEN ml.stage is 'Resubmittal' THEN 6
	 WHEN ml.stage is 'Approval' THEN 7
	 WHEN ml.stage is 'Completion' THEN 8
	 WHEN ml.stage is 'Clear to Close' THEN 9
	 WHEN ml.stage is 'Docs Ordered' THEN 10
	 WHEN ml.stage is 'Docs Signing' THEN 11
	 WHEN ml.stage is 'Funding' THEN 12
	 WHEN ml.stage is 'Shipping' THEN 13
	 WHEN ml.stage is 'Final Docs' THEN 14
ml.tpoconnectstatus,
l.milestonefilestarteddate,
l.milestonesubmitteddate,
l.milestoneapproveddate,
l.milestonefundeddate,
--l.milestonelastcompleted,
l.milestonecurrentname

FROM [WIN-T0FCRL091AK].Encompass.elliedb.Milestonelog ml
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.encompassid = ml.encompassid
WHERE l.LoanNumber = 2503043904  

