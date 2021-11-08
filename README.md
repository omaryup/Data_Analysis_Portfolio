- 👋 Hi, and welcome!
- :dart: This is a portfolio created to display my technical and visualization skills on Python, SQL and more.
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

## "Visualizing all tables in Database" 
