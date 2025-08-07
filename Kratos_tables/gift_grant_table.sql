SELECT kl.LoanId, 
gf.* 

INTO GiftGrant
FROM Loan kl 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Loan l ON l.loannumber = kl.loannum 
JOIN [WIN-T0FCRL091AK].Encompass.elliedb.giftgrant gf ON gf.encompassid = l.encompassid

--ALTER TABLE GiftGrant 
--DROP COLUMN encompassid, dcmodifiedutc, createdutc, id, altid 

--DROP TABLE dbo.GiftGrant

--ALTER TABLE dbo.GiftGrant
--ALTER COLUMN GiftGrantId NVARCHAR(100) NOT NULL;

--ALTER TABLE dbo.GiftGrant
--ADD CONSTRAINT PK_GiftGrant_GiftGrantId PRIMARY KEY (GiftGrantId);

--ALTER TABLE dbo.GiftGrant
--DROP CONSTRAINT [FK_GiftGrant(LoanID)_Loan(LoanID)];

--ALTER TABLE dbo.GiftGrant
--ADD CONSTRAINT [FK_GiftGrant(LoanID)_Loan(LoanID)]
--FOREIGN KEY (LoanID)
--REFERENCES dbo.Loan(LoanID)
--ON DELETE CASCADE;