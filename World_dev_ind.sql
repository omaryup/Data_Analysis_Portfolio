------------------------------------------------------------------------------------------------

/* View all tables in database */

SELECT *
FROM World_Dev_ind.INFORMATION_SCHEMA.TABLES
GO

------------------------------------------------------------------------------------------------

/*Cleaning Data*/

--Deleting Country Name fields that are NULL in 2001 - 2005 table

SELECT *
FROM World_Dev_ind.dbo.[2001_2005_world_dev_ind]
--WHERE [Country Name] IS NULL
ORDER BY [Country Name] ASC

DELETE FROM 
		World_Dev_ind.dbo.[2001_2005_world_dev_ind]
WHERE 
		[Country Name] IS NULL

--Deleting Country Name fields that are NULL in 2006 - 2010 table
SELECT *
FROM World_Dev_ind.dbo.[2006_2010_world_dev_ind]
--WHERE [Country Name] IS NULL
ORDER BY [Country Name] ASC

DELETE FROM 
		World_Dev_ind.dbo.[2006_2010_world_dev_ind]
WHERE 
		[Country Name] IS NULL

--Deleting Country Name fields that are NULL in 2011 - 2015 table
SELECT *
FROM World_Dev_ind.dbo.[2011_2015_world_dev_ind]
--WHERE [Country Name] IS NULL
ORDER BY [Country Name] ASC

DELETE FROM 
		World_Dev_ind.dbo.[2011_2015_world_dev_ind]
WHERE 
		[Country Name] IS NULL

--Deleting Country Name fields that are NULL in 2016 - 2020 table
SELECT *
FROM World_Dev_ind.dbo.[2016_2020_world_dev_ind]
--WHERE [Country Name] IS NULL
ORDER BY [Country Name] ASC

DELETE FROM 
		World_Dev_ind.dbo.[2016_2020_world_dev_ind]
WHERE 
		[Country Name] IS NULL

------------------------------------------------------------------------------------------------

--Additional Cleaning of Null Values on Unique_ID field

DELETE FROM 
		World_Dev_ind.dbo.[2001_2005_world_dev_ind]
WHERE 
		Unique_ID IS NULL

DELETE FROM 
		World_Dev_ind.dbo.[2006_2010_world_dev_ind]
WHERE 
		Unique_ID IS NULL

DELETE FROM 
		World_Dev_ind.dbo.[2011_2015_world_dev_ind]
WHERE 
		Unique_ID IS NULL

DELETE FROM 
		World_Dev_ind.dbo.[2016_2020_world_dev_ind]
WHERE 
		Unique_ID IS NULL


------------------------------------------------------------------------------------------------

/*Altering database tables to create a new (master) table*/

SELECT [Country Code] + [Series Code]
FROM World_Dev_ind.dbo.[2006_2010_world_dev_ind]

--Adding a unique id column to each table

/*
ALTER TABLE World_Dev_ind.dbo.[2001_2005_world_dev_ind] ADD [Unique_ID] AS [Country Code] + [Series Code]

ALTER TABLE World_Dev_ind.dbo.[2006_2010_world_dev_ind] ADD [Unique_ID] AS [Country Code] + [Series Code]

ALTER TABLE World_Dev_ind.dbo.[2011_2015_world_dev_ind] ADD [Unique_ID] AS [Country Code] + [Series Code]

ALTER TABLE World_Dev_ind.dbo.[2016_2020_world_dev_ind] ADD [Unique_ID] AS [Country Code] + [Series Code]
*/


SELECT *
FROM World_Dev_ind.dbo.[2001_2005_world_dev_ind]
ORDER BY [Country Name] ASC

SELECT [Unique_ID],[2006],[2007],[2008],[2009],[2010]
FROM World_Dev_ind.dbo.[2006_2010_world_dev_ind]

------------------------------------------------------------------------------------------------

/*Creating new (master) table*/


CREATE TABLE 
		world_dev_ind_20yrs
		(
		Unique_ID varchar(250) PRIMARY KEY NOT NULL,
		Country_Name varchar(255),
		Country_Code varchar(255),
		Series_Name varchar(255)
		)

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs

--Inserting Unique_ID from reference table (2001-2005)

INSERT INTO 
		World_Dev_ind.dbo.world_dev_ind_20yrs (Unique_ID)
SELECT 
		Unique_ID
FROM 
		World_Dev_ind.dbo.[2001_2005_world_dev_ind]

------------------------------------------------------------------------------------------------

/*Combining all tables into 1 new (master) table*/

-- Visualizing all tables to plan how JOIN functions will be used
SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs
ORDER BY Unique_ID ASC

SELECT *
FROM World_Dev_ind.dbo.[2001_2005_world_dev_ind]
ORDER BY Unique_ID ASC

SELECT *
FROM World_Dev_ind.dbo.[2006_2010_world_dev_ind]
ORDER BY Unique_ID ASC

SELECT *
FROM World_Dev_ind.dbo.[2011_2015_world_dev_ind]
ORDER BY Unique_ID ASC

SELECT *
FROM World_Dev_ind.dbo.[2016_2020_world_dev_ind]
ORDER BY Unique_ID ASC

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs
JOIN World_Dev_ind.dbo.[2001_2005_world_dev_ind]
ON World_Dev_ind.dbo.world_dev_ind_20yrs.Unique_ID = World_Dev_ind.dbo.[2001_2005_world_dev_ind].Unique_ID


--Visualizing what the table will look like

SELECT	
		World_Dev_ind.dbo.world_dev_ind_20yrs.Country_Name, 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Country_Code, 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Series_Name

FROM	
		World_Dev_ind.dbo.world_dev_ind_20yrs

JOIN
		World_Dev_ind.dbo.[2001_2005_world_dev_ind]
ON
		World_Dev_ind.dbo.world_dev_ind_20yrs.Unique_ID = World_Dev_ind.dbo.[2001_2005_world_dev_ind].Unique_ID

--Updating Table with Country, Code and Series from the 2001-2005 based on a JOIN

UPDATE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
SET 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Country_Name = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[Country Name],
		World_Dev_ind.dbo.world_dev_ind_20yrs.Country_Code = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[Country Code],
		World_Dev_ind.dbo.world_dev_ind_20yrs.Series_Name = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[Series Name]
FROM 
		World_Dev_ind.dbo.world_dev_ind_20yrs
JOIN 
		World_Dev_ind.dbo.[2001_2005_world_dev_ind]
ON 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Unique_ID = World_Dev_ind.dbo.[2001_2005_world_dev_ind].Unique_ID

--Confirming updates

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs
ORDER BY Unique_ID ASC


--Adding YEAR columns to 'master' table

ALTER TABLE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
ADD
		"2001" float,
		"2002" float,
		"2003" float,
		"2004" float,
		"2005" float

--Updating new columns with data from the 2001-2005 based on a JOIN

UPDATE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
SET 
		World_Dev_ind.dbo.world_dev_ind_20yrs."2001" = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[2001],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2002" = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[2002],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2003" = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[2003],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2004" = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[2004],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2005" = World_Dev_ind.dbo.[2001_2005_world_dev_ind].[2005]
FROM 
		World_Dev_ind.dbo.world_dev_ind_20yrs
JOIN 
		World_Dev_ind.dbo.[2001_2005_world_dev_ind]
ON 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Unique_ID = World_Dev_ind.dbo.[2001_2005_world_dev_ind].Unique_ID

--Confirming updates

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs
ORDER BY Unique_ID ASC


--Adding YEAR columns to 'master' table

ALTER TABLE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
ADD
		"2006" float,
		"2007" float,
		"2008" float,
		"2009" float,
		"2010" float

--Updating new columns with data from the 2006-2010 based on a JOIN

UPDATE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
SET 
		World_Dev_ind.dbo.world_dev_ind_20yrs."2006" = World_Dev_ind.dbo.[2006_2010_world_dev_ind].[2006],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2007" = World_Dev_ind.dbo.[2006_2010_world_dev_ind].[2007],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2008" = World_Dev_ind.dbo.[2006_2010_world_dev_ind].[2008],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2009" = World_Dev_ind.dbo.[2006_2010_world_dev_ind].[2009],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2010" = World_Dev_ind.dbo.[2006_2010_world_dev_ind].[2010]
FROM 
		World_Dev_ind.dbo.world_dev_ind_20yrs
JOIN 
		World_Dev_ind.dbo.[2006_2010_world_dev_ind]
ON 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Unique_ID = World_Dev_ind.dbo.[2006_2010_world_dev_ind].Unique_ID

--Confirming updates

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs
ORDER BY Unique_ID ASC


--Adding YEAR columns to 'master' table

ALTER TABLE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
ADD
		"2011" float,
		"2012" float,
		"2013" float,
		"2014" float,
		"2015" float

--Updating new columns with data from the 2011-2015 based on a JOIN

UPDATE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
SET 
		World_Dev_ind.dbo.world_dev_ind_20yrs."2011" = World_Dev_ind.dbo.[2011_2015_world_dev_ind].[2011],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2012" = World_Dev_ind.dbo.[2011_2015_world_dev_ind].[2012],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2013" = World_Dev_ind.dbo.[2011_2015_world_dev_ind].[2013],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2014" = World_Dev_ind.dbo.[2011_2015_world_dev_ind].[2014],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2015" = World_Dev_ind.dbo.[2011_2015_world_dev_ind].[2015]
FROM 
		World_Dev_ind.dbo.world_dev_ind_20yrs
JOIN 
		World_Dev_ind.dbo.[2011_2015_world_dev_ind]
ON 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Unique_ID = World_Dev_ind.dbo.[2011_2015_world_dev_ind].Unique_ID


--Confirming updates

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs
ORDER BY Unique_ID ASC


--Adding YEAR columns to 'master' table

ALTER TABLE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
ADD
		"2016" float,
		"2017" float,
		"2018" float,
		"2019" float,
		"2020" float

--Updating new columns with data from the 2016-2020 based on a JOIN

UPDATE 
		World_Dev_ind.dbo.world_dev_ind_20yrs
SET 
		World_Dev_ind.dbo.world_dev_ind_20yrs."2016" = World_Dev_ind.dbo.[2016_2020_world_dev_ind].[2016],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2017" = World_Dev_ind.dbo.[2016_2020_world_dev_ind].[2017],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2018" = World_Dev_ind.dbo.[2016_2020_world_dev_ind].[2018],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2019" = World_Dev_ind.dbo.[2016_2020_world_dev_ind].[2019],
		World_Dev_ind.dbo.world_dev_ind_20yrs."2020" = World_Dev_ind.dbo.[2016_2020_world_dev_ind].[2020]
FROM 
		World_Dev_ind.dbo.world_dev_ind_20yrs
JOIN 
		World_Dev_ind.dbo.[2016_2020_world_dev_ind]
ON 
		World_Dev_ind.dbo.world_dev_ind_20yrs.Unique_ID = World_Dev_ind.dbo.[2016_2020_world_dev_ind].Unique_ID


--Confirming updates

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs
ORDER BY Unique_ID ASC
