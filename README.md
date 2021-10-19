- 👋 Hi, and welcome!
- :dart: This is a portfolio created to display my technical and visualization skills on Python, SQL and more.
# "Financial_Data.py" 

**The file shows a quick program I wrote to obtain financial data from yahoo finance using Python, pandas, matplotlib, numpy and more.**

- The intention is for user to enter a valid ticker (verified by a function that only accepts alphabetical characters)
- Followed by user input for both start and end date (user must follow the Y-M-D format)
- Additionally, the program will create a DataFrame for the first 10 rows of data obtained and perform two quick calculations based on adjusted return
  - Simple return is then calculated using numpy (as percentage change)
  - Then, log return is calculated using numpy as the division between adj_close and prior adj_close values
- The program will then continue output major institutional holders and recommendations for the ticker/stock provided, followed by line charts for all values in DataFrame created
- The program will also create plots for the new columns created (simple return and log return)
- For visualization purposes, some additional items are printed at the end

**As of 10/19/21 this program is still in progress.**
