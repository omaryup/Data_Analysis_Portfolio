/* Visualizing all tables in Database */

SELECT *
FROM Semiconductors_financials.INFORMATION_SCHEMA.TABLES
GO

/* Visualizing all financial statements in Database for AMAT */

SELECT *
FROM Semiconductors_financials.dbo.common_size_IS

SELECT *
FROM Semiconductors_financials.dbo.LRCX_IS

SELECT *
FROM Semiconductors_financials.dbo.AMAT_BS

SELECT *
FROM Semiconductors_financials.dbo.AMAT_CF


/*Creating Common Size table for AMAT stock*/

USE Semiconductors_financials
GO

/*CREATE TABLE Common_size_IS(
Ticker varchar(50) PRIMARY KEY,
Company varchar(50),
Year int,
Revenue int,
COGS int,
Marketing_Selling_Exp int,
Administrative_Exp int,
Research_and_Development_Exp int,
Other_Exp int,
Restructuring_Charges int)*/

/*ALTER TABLE dbo.Common_size_IS
ALTER COLUMN Revenue INT NULL*/

/*INSERT INTO Common_size_IS (Ticker, Company, Year)
VALUES ('AMAT', 'Applied Materials', 2020)*/

/*delete from Semiconductors_financials.dbo.Common_size_IS
where Ticker is Null*/

INSERT INTO Semiconductors_financials.dbo.Common_size_IS (Ticker)
VALUES ('AMAT')

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET Company = 'Applied Materials'
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Year = 2020
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Revenue = [Oct. 25, 2020] FROM Semiconductors_financials.dbo.AMAT_IS WHERE Items = 'Net sales'
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	COGS = [Oct. 25, 2020] FROM dbo.AMAT_IS WHERE Items = 'Cost of products sold'
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Marketing_Selling_Exp = [Oct. 25, 2020] FROM Semiconductors_financials.dbo.AMAT_IS WHERE Items = 'Marketing and selling'
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Administrative_Exp = [Oct. 25, 2020] FROM dbo.AMAT_IS WHERE Items = 'General and administrative'
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Research_and_Development_Exp = [Oct. 25, 2020] FROM Semiconductors_financials.dbo.AMAT_IS WHERE Items = 'Research, development and engineering'
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Other_Exp = 0
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Restructuring_Charges = 0

/*INSERT INTO Semiconductors_financials.dbo.Common_size_IS (Ticker)
VALUES ('LRCX')*/

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET Company = 'Lam Research'
WHERE Ticker = 'LRCX'
UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Year = 2020
WHERE Ticker = 'LRCX'

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Revenue = [Jun. 28, 2020] FROM Semiconductors_financials.dbo.LRCX_IS WHERE Items = 'Revenue'
AND Ticker = 'LRCX'

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	COGS = [Jun. 28, 2020] FROM Semiconductors_financials.dbo.LRCX_IS WHERE Items = 'Cost of goods sold'
AND Ticker = 'LRCX'

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Marketing_Selling_Exp = 0
WHERE Ticker = 'LRCX'

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Administrative_Exp = [Jun. 28, 2020] FROM Semiconductors_financials.dbo.LRCX_IS WHERE Items = 'Selling, general, and administrative'
AND Ticker = 'LRCX'

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Research_and_Development_Exp = [Jun. 28, 2020] FROM Semiconductors_financials.dbo.LRCX_IS WHERE Items = 'Research and development'
AND Ticker = 'LRCX'

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Other_Exp = [Jun. 28, 2020] FROM Semiconductors_financials.dbo.LRCX_IS WHERE Items = 'Other expense, net'
AND Ticker = 'LRCX'

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET	Restructuring_Charges = 0
WHERE Ticker = 'LRCX'

ALTER TABLE Semiconductors_financials.dbo.Common_size_IS
ADD COGS_percent VARCHAR(50)

USE Semiconductors_financials
GO

UPDATE Semiconductors_financials.dbo.Common_size_IS
SET COGS_percent = CAST(ROUND(COGS * 100.0 / Revenue, 2) as decimal(10,2))

