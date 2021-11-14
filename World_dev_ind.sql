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

/*
CREATE TABLE world_dev_ind_20yrs(
Unique_ID varchar(250) PRIMARY KEY NOT NULL,
Country_Name varchar(255),
Country_Code varchar(255),
Series_Name varchar(255)
)*/

SELECT *
FROM World_Dev_ind.dbo.world_dev_ind_20yrs

INSERT INTO 
		World_Dev_ind.dbo.world_dev_ind_20yrs (Unique_ID)
SELECT 
		Unique_ID
FROM 
		World_Dev_ind.dbo.[2001_2005_world_dev_ind]

------------------------------------------------------------------------------------------------

/*Combining all tables into 1 new (master) table*/

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

--Updating Table with columns from the 2001-2005 based on a JOIN

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
