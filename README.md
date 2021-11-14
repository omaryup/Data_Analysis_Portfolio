## 👋 Hi, and welcome! 👋  

(*) I am a Finance major with over 3 years of experience in Asset Management and trade settlement Operations. I have experience supporting different businesses such as Fixed Income, Real Estate, and Retirement. 

(*) I am highly interested in pursuing a career in Data and passionate about technology, and its applications to finance. 

(*) I graduated Cum Laude in 2018 and I am super interested in Data Analytics roles focused on the Financial Industry. 

(*) Fun fact about myself: I love stargazing, and I am a self-taught drummer.

:dart: This is a portfolio created to display my technical and visualization skills on Python, SQL and Tableau.

# "Financial_Data_Info.py" 

**This is a program I wrote to obtain financial data from Yahoo Finance using Python, pandas, matplotlib, numpy and more.**

- :point_right: The objective is for users to enter a valid ticker (verified by a function that only accepts alphabetical characters)
- :point_right: Followed by user inputs for both start and end date (user must follow the Y-M-D format)
- :green_book: Additionally, the program will create a DataFrame for the first 10 rows of data obtained and perform two quick calculations based on adjusted return
  - :dart: Simple return is then calculated using numpy (as percentage change)
  - :dart: Then, log return is calculated using numpy as the division between adj_close and prior adj_close values
- :page_facing_up: The program will then proceed to output major institutional holders and historical recommendations for the ticker/stock provided, followed by line charts for all values in DataFrame created
- :chart_with_upwards_trend: The program will also create plots for the new columns created (simple return and log return)

- Additional Feature:
  - :chart_with_upwards_trend: At the end, the program will also display a visualization of daily YIELD CURVE RATES for 2021 and for current Month. This information is obtained by performing webscraping using Pandas library on the U.S. Department of Treasury.

<p align="center">
  >>> Hit play below to see the program in action! <<<
</p>

<p align="center">
  (maximize window for a better view)
</p>

https://user-images.githubusercontent.com/23235947/141530341-7854c2ed-b488-457c-8db8-9f6840fc7ae8.mp4

### 📊 "BRD 1947 - PRESENT (TABLEAU)" 

**The intention of this analysis is for investors to have a clear understanding of how the investment in debt securities has changed over time since 1947. The data source for this project was imported from an excel file with over 12k rows of data obtained from the World Bank Database.**

The full Tableau workbook can be found [here](https://public.tableau.com/views/World_Bank_Bonds/Cover?:language=en-US&:display_count=n&:origin=viz_share_link)

![tabpublic_nTouzZ5gRy](https://user-images.githubusercontent.com/23235947/141209034-3cf3cc84-bbf7-441d-95ae-7305f5f76a47.png)


# "World_Dev_ind (383k ROWS)" 

### A brief description of data used (from World Bank Data site):
>World Development Indicators (WDI) is the primary World Bank collection of development indicators, compiled from officially recognized international sources. It presents the most current and accurate global development data available, and includes national, regional and global estimates. [Note: Even though Global Development Finance (GDF) is no longer listed in the WDI database name, all external debt and financial flows data continue to be included in WDI. The GDF publication has been renamed International Debt Statistics (IDS), and has its own separate database, as well.

**In this section, the SQL script will be used to clean data previously loaded into SQL Server using excel files (4 csv files total added to this repository).**


### :bulb: Cleaning & Joining of Data

- Before cleaning data in SQL, the csv files had to be formatted in excel individually. This was needed to avoid the SQL server import wizard from creating errors. The formatting on csv files included the following actions:
    - Replacing ',' in the "Series Name" cells (due to delimiter functionality on SQL server import wizard).
    - Changing the table name on YEAR columns e.g. from **2001[YR2001]** to **2001** (not changing the column names, would also cause errors while importing data).
- Once the csv files were imported in SQL server, and DATABASE was created, the first step that took place was to visualize all tables imported and loaded in the new World_Dev_ind database using the **INFORMATION_SCHEMA.TABLES**.
- The next step in the cleaning process was to delete any **NULL** values from the dataset. Given this is a large dataset, it was important that **NULL** values were discarded from the **Country Name** column, as this column will be later be used to create a **UNIQUE_ID** (Primary Key).
- Next, additional functions were queried on the dataset to ensure all **NULL** values from the characteristics columns were discarded. That is, NULL values were deleted from the Country, Code, and Series columns.
- Once these fields were cleaned. the **UNIQUE_ID** column was created. This was needed to later be used to JOIN all other tables to a master table.
- Next, the master table is created. Given that the World Bank Data site only allows users to download a limited number of rows per report, 4 different files (csv) were downloaded. Each file contained 5 years worth of data for over 200 Countries.
- After creating the master table, the **UNIQUE_ID** column is added. This will be used as a reference to add all other tables, particularly the YEAR columns from other tables.
- Then, the YEAR columns are added based on the **JOIN** criteria matching the **UNIQUE_ID** from each of the tables. This ensured accuracy when joining all YEAR columns to the master table.

UNIQUE_ID is created
![Ssms_FUKU1wPu90](https://user-images.githubusercontent.com/23235947/141686714-25d3d5f5-0f4f-48c0-8f1f-27d344b07b07.png)

Country, Code, and Series are added to master table
![Ssms_4XE0k5y6TO](https://user-images.githubusercontent.com/23235947/141686741-86ccf745-13cd-4819-906f-fc408652938c.png)

### 🔍 Final Result
- The intention of the query is to consolidate the data found on the World Bank Data based on specific criteria such as the UNIQUE_ID. 
- The UNIQUE_ID is a concatenation of both Country Codes and Series Codes. These datafields were identified as unique for each series and country, however when placed together, they would serve as unique identifier for each country and series.
- Main Functions used on query:
   - **CREATE, SELECT, ORDER BY, JOIN, INSERT INTO, ADD, UPDATE, and SET**.

![Ssms_m0saBT1aVM](https://user-images.githubusercontent.com/23235947/141686700-dae25629-a66e-4005-9d3d-5aca64669d29.png)

# "Semiconductor_financials_compare.sql" 

**In this section, the SQL script will be used to manipulate data previously loaded into SQL Server using excel files.**

### 🔍 Visualizing all tables in Database

- We can see this Database contains the main Financial Statements for a total of 6 public companies in the Semiconductor industry.
- The intention of the query is to consolidate the data by Ticker and Year and construct a common size Income Statement for each Company.
- Using the **CREATE**, **INSERT**, **INTO**, **UPDATE** AND **WHERE** functions the SQL script performs the following actions:
    - Pulls all Schemas available in Database.
    - Followed by a selection of tables being used.
    - The script then proceeds to Create the common size Income Statement table by defining Primary Key, Columns and data types.
    - Following lines of code add values pulled from other tables.
    - Finally, calculations are made and added to the newly created table showing in percentage form with only two decimals.

![Ssms_d2S0MxcjII](https://user-images.githubusercontent.com/23235947/141656219-4d051758-4dbd-40c6-99db-8e7f689bbc00.png)
