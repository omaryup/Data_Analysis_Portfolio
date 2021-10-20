import pandas as pd
import numpy as np
import yfinance as yf
from matplotlib import pyplot as plt
from datetime import datetime
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

ticker = get_ticker(input)
start_date = get_start_date(input)
end_date = get_end_date(input)

#yfinance variables
yf_ticker = yf.Ticker(ticker)
data = yf.download(tickers = ticker, start = start_date,end = end_date, group_by = 'ticker', progress=False)

major_holders = yf_ticker.major_holders
inst_holders = yf_ticker.institutional_holders
recommendation = yf_ticker.recommendations

#Turn data into DataFrame using Pandas
df = pd.DataFrame(data)
df.rename(columns={'Adj Close':'adj_close'}, inplace=True)
new_col = ['Open', 'High', 'Low', 'Close', 'Volume', 'adj_close', 'simple_rtn', 'log_rtn'] #change position of adj_close
df = df.reindex(columns=new_col)
df.index.names = ['Dates'] #renames the index

#Calculations added to DataFrame
df['simple_rtn'] = df.adj_close.pct_change()
df['log_rtn'] = np.log(df.adj_close/df.adj_close.shift(1))


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


#Daily Yield curve
plt.figure(figsize=(12, 10))
us_dept_treas_2021 = pd.read_html("https://www.treasury.gov/resource-center/data-chart-center/interest-rates/pages/TextView.aspx?data=yieldYear&year=2021")
us_dept_treas_month = pd.read_html("https://www.treasury.gov/resource-center/data-chart-center/interest-rates/pages/TextView.aspx?data=yield")
us_dept_treas_2021[1].plot()
us_dept_treas_month[1].plot()
plt.legend()
plt.show()

#Printing
print("\n")
print(df.head(10))

print("\n")
print(inst_holders)
print("\n")
print(recommendation)
print("\n")
print(recommendation['To Grade'].value_counts())

print("\n")
print(df.columns)
print("\n")
print(df.index)
print("\n")
print(us_dept_treas_2021[1])
print("\n")
print(us_dept_treas_month[1])
