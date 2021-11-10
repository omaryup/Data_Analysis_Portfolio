👋 Hi, and welcome! 👋

(*) I am a Finance major with over 3 years of experience in Asset Management and trade settlement Operations. I have experience supporting different businesses such as Fixed Income, Real Estate, and Retirement. 

(*) I am highly interested in pursuing a career in Data and passionate about technology, and its applications to finance. 

(*) I graduated Cum Laude in 2018 and I am super interested in Data Analytics roles focused on the Financial Industry. 

(*) Fun fact about myself: I love stargazing, and I am a self-taught drummer.

:dart: This is a portfolio created to display my technical and visualization skills on Python, SQL and Tableau.

# "Financial_Data_Info.py" 

**This is a program I wrote to obtain financial data from Yahoo Finance using Python, pandas, matplotlib, numpy and more.**

- :point_right: The intention is for user to enter a valid ticker (verified by a function that only accepts alphabetical characters)
- :point_right: Followed by user input for both start and end date (user must follow the Y-M-D format)
- :green_book: Additionally, the program will create a DataFrame for the first 10 rows of data obtained and perform two quick calculations based on adjusted return
  - :dart: Simple return is then calculated using numpy (as percentage change)
  - :dart: Then, log return is calculated using numpy as the division between adj_close and prior adj_close values
- :page_facing_up: The program will then continue output major institutional holders and recommendations for the ticker/stock provided, followed by line charts for all values in DataFrame created
- :chart_with_upwards_trend: The program will also create plots for the new columns created (simple return and log return)

- Additional:
  - :chart_with_upwards_trend: At the end, the program will also display a visualization of daily YIELD CURVE RATES for 2021 and for current Month. This information is obtained by doing webscraping on the U.S. Departmen of Treasury using Pandas.

https://user-images.githubusercontent.com/23235947/139759192-da1bb3d6-2093-47ff-967f-5fde5a34c0e1.mp4

# "Semiconductor_financials_compare.sql" 

**In this section, the SQL script will be used to manipulate data previously loaded into SQL Server using excel files.**

### Visualizing all tables in Database

- We can see this Database contains the main Financial Statements for a total of 6 public companies in the Semiconductor industry.
- The intention of the query is to consolidate the data by year and construct a new table using fundamental analysis to obtain key stats in the industry.

![Ssms_qKzSFNmDjs](https://user-images.githubusercontent.com/23235947/140806980-1d792476-d7c0-44d8-a61b-757dd0b5ac86.png)

### Visualizing all tables in Database

- In this next section, we can see that we are only selecting the latest reports. For this comapny in particular, we see the most recent annual report (before 2021) was released in Oct 2020.

![Ssms_1xf6VGDH7b](https://user-images.githubusercontent.com/23235947/140814154-bdbd9284-5e57-4a07-97bd-a5ce498c4303.png)


# "BRD 1947 - PRESENT (TABLEAU)" 

**The intention of this analysis is for investors to have a clear understanding of how the investment in debt securities has changed over time since 1947. The data source for this project was imported from an excel file with over 12k rows of data obtained from the World Bank Database.**

![tabpublic_wJaXu5dqS6](https://user-images.githubusercontent.com/23235947/141040871-0853367d-6592-47d8-88b5-22864f149b41.png)
