import pandas as pd
import numpy as np
import yfinance as yf
from matplotlib import pyplot as plt
from datetime import datetime
from matplotlib.dates import MonthLocator
import seaborn as sns

#Set-up environment

pd.set_option('display.width', 500)
pd.set_option('display.max_columns', 55)
pd.set_option('display.max_rows', 500)

#Set-up data needed for analysis

def get_ticker(input):
    while True:
        ticker = input("Please enter Ticker Symbol: ")
        if ticker.isalpha():
            return ticker
            break
        else:
            print("Please input correct Ticker symbol")

def get_start_date(input):
    format = "%Y-%m-%d"
    while True:
        start_date = input("Please enter Start Date (YYYY-mm-dd): ")
        try:
            datetime.strptime(start_date, format)
            return start_date
            break
        except ValueError:
            print("This is the incorrect date format. It should be YYYY-mm-dd")

def get_end_date(input):
    format = "%Y-%m-%d"
    while True:
        end_date = input("Please enter End Date (YYYY-mm-dd): ")
        try:
            datetime.strptime(end_date, format)
            return end_date
            break
        except ValueError:
            print("This is the incorrect date format. It should be YYYY-mm-dd")

#Calling functions defined above
ticker = get_ticker(input)
start_date = get_start_date(input)
end_date = get_end_date(input)

#yfinance variables
yf_ticker = yf.Ticker(ticker)
data = yf.download(tickers = ticker, start = start_date,end = end_date, group_by = 'ticker', progress=False)

major_holders = yf_ticker.major_holders
inst_holders = yf_ticker.institutional_holders
recommendation = yf_ticker.recommendations

#Converting downloaded data to DataFrame using Pandas
df = pd.DataFrame(data)
df.rename(columns={'Adj Close':'adj_close'}, inplace=True)
new_col = ['Open', 'High', 'Low', 'Close', 'Volume', 'adj_close', 'simple_rtn', 'log_rtn'] #change position of adj_close
df = df.reindex(columns=new_col)
df.index.names = ['Dates'] #renames the index

#Calculations added to DataFrame
df['simple_rtn'] = df.adj_close.pct_change()
df['log_rtn'] = np.log(df.adj_close/df.adj_close.shift(1))

recom_count = recommendation['To Grade'].value_counts()


#Plots and Graphs
df.plot(figsize = (24, 12), subplots = True)
plt.legend()
plt.show()

plt.figure(figsize=(12, 10))
ax = plt.subplot(1,1,1)
df['adj_close'].plot()
ax.set(title = ticker + ' time series', xlabel = 'Date', ylabel = 'Stock price ($)')
plt.legend()
plt.show()

plt.figure(figsize=(12, 10))
df['simple_rtn'].plot(figsize = (12, 10))
plt.legend()
plt.show()

plt.figure(figsize=(12, 10))
df['log_rtn'].plot(figsize = (12, 10))
plt.legend()
plt.show()


#Daily Treasury Yield curverates

#creating dataframe from US Treas urls
treas_2021 = pd.read_html("https://www.treasury.gov/resource-center/data-chart-center/interest-rates/pages/TextView.aspx?data=yieldYear&year=2021", header=0, index_col=0)[1] #we use header and index col to crate Date and col index for dataframe
treas_month = pd.read_html("https://www.treasury.gov/resource-center/data-chart-center/interest-rates/pages/TextView.aspx?data=yield", header=0, index_col=0)[1] #we use header and index col to crate Date and col index for dataframe

#plotting for 2021
fig, ax1 = plt.subplots(figsize=(25, 15))
ax1.plot(treas_2021)
ax1.set_title('Daily Treasury Yield Curves Rates for 2021')
ax1.xaxis.set_major_locator(MonthLocator())
plt.xticks(rotation=30)
plt.legend(treas_2021.columns, bbox_to_anchor=(1.06, 1), loc = 'upper right')
ax1.set_ylabel('Yield rates')
ax1.set_xlabel('Date')
plt.show()

#plotting for month
fig, ax2 = plt.subplots(figsize=(25, 15))
ax2.plot(treas_month)
ax2.set_title('Daily Treasury Yield Curves Rates for October')
plt.xticks(rotation=30)
plt.legend(treas_month.columns, bbox_to_anchor=(1.06, 1), loc = 'upper right')
ax2.set_ylabel('Yield rates')
ax2.set_xlabel('Date')
plt.show()

#Printing
print("\n")
print(df.head(10))

print("\n")
print(inst_holders)
print("\n")
print(recommendation.head())
print("\n")
print(recom_count)

print(treas_2021.head())
print("\n")
print(treas_month)

print("\n")
print(df.columns)
print("\n")
print(df.index)
print("\n")
