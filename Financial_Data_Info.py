import pandas as pd  # version 1.3.4
import numpy as np
import yfinance as yf  # version 0.1.65
from matplotlib import pyplot as plt
from datetime import datetime
from matplotlib.dates import MonthLocator
import seaborn as sns

# Set-up environment
pd.set_option('display.float_format', '{:,.2f}'.format)
pd.set_option('display.width', 500)
pd.set_option('display.max_columns', 55)
pd.set_option('display.max_rows', 500)


# Set-up data needed for analysis


def get_ticker(user_input):
    while True:
        ticker_input = user_input('Please enter Ticker Symbol: ')
        if not ticker_input.isnumeric():
            return ticker_input
            break
        else:
            print("Please input correct Ticker symbol")


def get_start_date(start_date_input):
    start_date_format = "%Y-%m-%d"
    while True:
        start_date = start_date_input("Please enter Start Date (YYYY-mm-dd): ")
        try:
            datetime.strptime(start_date, start_date_format)
            return start_date
            break
        except ValueError:
            print("This is the incorrect date format. It should be YYYY-mm-dd")


def get_end_date(end_date_input):
    end_date_format = "%Y-%m-%d"
    while True:
        end_date = end_date_input("Please enter End Date (YYYY-mm-dd): ")
        try:
            datetime.strptime(end_date, end_date_format)
            return end_date
            break
        except ValueError:
            print("This is the incorrect date format. It should be YYYY-mm-dd")


# Calling functions defined above
ticker = get_ticker(input)
start_date = get_start_date(input)
end_date = get_end_date(input)

# Yahoo Finance variables
yf_ticker = yf.Ticker(ticker)
data = yf.download(tickers=ticker, start=start_date, end=end_date, group_by='ticker', actions=True, progress=False)

major_holders = yf_ticker.major_holders
inst_holders = yf_ticker.institutional_holders
recommendation = yf_ticker.recommendations

# Calling recommendations ONLY for date rage entered by user

recommendation = recommendation.loc[str(start_date):str(end_date)]

# Converting downloaded data to DataFrame using Pandas package
df = pd.DataFrame(data)
df.rename(columns={'Adj Close': 'adj_close'}, inplace=True)
new_col = ['Open', 'High', 'Low', 'Close', 'Volume', 'adj_close', 'simple_rtn',
           'log_rtn']  # change position of adj_close
df = df.reindex(columns=new_col)
df.index.names = ['Dates']  # renames the index

stock_info = yf_ticker.info
df_stock_info = pd.DataFrame(stock_info.items(), columns=['Description', 'Details'])  # all stock info

income_statement_a = yf_ticker.financials.round(decimals=3)
balance_sheet_a = yf_ticker.balance_sheet.round(decimals=3)
cash_flow_a = yf_ticker.cashflow.round(decimals=3)

# Calculations added to DataFrame
df['simple_rtn'] = df.adj_close.pct_change()
df['log_rtn'] = np.log(df.adj_close / df.adj_close.shift(1))

# Counting recommendations
recommendation_count = recommendation['To Grade'].value_counts()

# Daily Treasury Yield curve rates

# creating dataframe from US Treas urls

treas_2022 = pd.read_html(
    "https://home.treasury.gov/resource-center/data-chart-center/interest-rates/TextView?type=daily_treasury_yield_curve&field_tdr_date_value=2022",
    header=0, index_col=0)[0] # no change from 2021, however, pandas is now picking up additional columns from HTML so I had to add the below to use the correct columns

# below code excludes unnecessary columns between index 0 - 6 and only shows the 1mo - 30yr yields
cols = [0,1,2,3,4,5,6]
treas_2022.drop(treas_2022.columns[cols],axis=1, inplace=True)

# treas_2021 = pd.read_html(
#     "https://home.treasury.gov/resource-center/data-chart-center/interest-rates/TextView?type=daily_treasury_yield_curve&field_tdr_date_value=2022",
#     header=0, index_col=0)[1]  # Header and index col are used to crate Date and col index for dataframe [updated with above on 2.6.22]

treas_month = \
    pd.read_html(
        "https://home.treasury.gov/resource-center/data-chart-center/interest-rates/TextView?type=daily_treasury_yield_curve&field_tdr_date_value=2022",
        header=0, index_col=0)[0]  # Header and index col are used to crate Date and col index for dataframe [no changes on 2.6.22, other than df name and below for month]

#below code was added on 2.6.22 to print only treasury rate columns
cols = [0,1,2,3,4,5,6]
treas_month.drop(treas_month.columns[cols],axis=1, inplace=True)


# selecting the last business day rates
treas_month_dates = treas_month.iloc[-1:]

# Plotting Stock Data
df.plot(figsize=(24, 12), subplots=True, sharex=True, sharey=False, grid=True)
plt.suptitle('Historical Prices', fontsize=20)
plt.xlabel('Date', fontsize=20)
plt.legend()
plt.show()

plt.figure(figsize=(12, 10))
ax = plt.subplot(1, 1, 1)
df['adj_close'].plot()
ax.set_title(ticker + ' time series', fontsize=30)
ax.set(xlabel='Date', ylabel='Stock price ($)')
ax.xaxis.label.set_size(18)
ax.yaxis.label.set_size(18)
plt.legend()
plt.show()

plt.figure(figsize=(12, 10))
df['simple_rtn'].plot(figsize=(12, 10))
plt.legend()
plt.show()

plt.figure(figsize=(12, 10))
df['log_rtn'].plot(figsize=(12, 10))
plt.legend()
plt.show()

# Plotting Treasury Data
fig1, ax1 = plt.subplots(figsize=(25, 15))
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
ax1.plot(treas_2022)
ax1.set_title('Daily Treasury Yield Curves Rates for 2021', fontsize=30)
ax1.xaxis.set_major_locator(MonthLocator())
plt.xticks(rotation=30)
plt.legend(treas_2022.columns, bbox_to_anchor=(1.06, 1), loc='upper right')
ax1.set_ylabel('Yield rates', fontsize=30)
ax1.set_xlabel('Date', fontsize=30)
plt.show()

# plotting for month
fig2, ax2 = plt.subplots(figsize=(25, 15))
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
ax2.plot(treas_month)
ax2.set_title('Daily Treasury Yield Curves Rates for Current Month', fontsize=30)
plt.xticks(rotation=30)
plt.legend(treas_month.columns, bbox_to_anchor=(1.06, 1), loc='upper right')
ax2.set_ylabel('Yield rates', fontsize=30)
ax2.set_xlabel('Date', fontsize=30)
plt.show()

# plotting the yield curve for last business date
fig3, ax3 = plt.subplots(figsize=(25, 15))
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
ax3.set_title('Last Business Day - Yield Curve', fontsize=30)
ax3.plot(treas_month_dates.T)
ax3.set_ylabel('Rates', fontsize=30)
ax3.set_xlabel('Maturity', fontsize=30)
plt.show()

# Printing
print("\n")
print(df.head(10))  # dataset
print("\n")
print(inst_holders)  # dataset
print("\n")
print(recommendation.head(20))  # dataset
print("\n")
print(recommendation_count)  # dataset
print("\n")
print(treas_2022.head())  # dataset
print("\n")
print(treas_month)  # dataset
print("\n")
print(df_stock_info)  # dataset
print("\n")
print(income_statement_a)  # dataset
print("\n")
print(balance_sheet_a)  # dataset
print("\n")
print(cash_flow_a)  # dataset
