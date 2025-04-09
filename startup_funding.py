import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px

df = pd.read_csv('startup_funding.csv')

#Remark has more than 50% value so drop the entire column
df.drop('Remarks', axis=1, inplace=True)

df.rename(columns={
    'Sr No': 'sr_no',
    'Date dd/mm/yyyy': 'date',
    'Startup Name': 'startup_name',
    'Industry Vertical': 'industry_vertical',
    'SubVertical': 'sub_vertical',
    'City  Location': 'city_location',
    'Investors Name': 'investors_name',
    'InvestmentnType': 'investment_type',
    'Amount in USD': 'amount_usd'
}, inplace=True)

#fix data time
df['date'] = pd.to_datetime(df['date'], format='%d/%m/%Y', errors='coerce')

#Replace commas
df['amount_usd'] = df['amount_usd'].astype(str).str.replace(',', '', regex=False)
df['amount_usd'] = pd.to_numeric(df['amount_usd'], errors='coerce')
df['amount_usd'].fillna(df['amount_usd'].mean(), inplace=True)

# drop null from investment type
df.dropna(subset=['investment_type'], inplace=True)
df.dropna(subset=['investors_name'], inplace=True)

#Random fill 
non_null_cities = df['city_location'].dropna().values
df['city_location'] = df['city_location'].apply(lambda x: np.random.choice(non_null_cities) if pd.isna(x) else x)
non_null_sub_vertical = df['sub_vertical'].dropna().values
df['sub_vertical'] = df['sub_vertical'].apply(lambda x: np.random.choice(non_null_sub_vertical) if pd.isna(x) else x)
non_null_industry_vertical = df['industry_vertical'].dropna().values
df['industry_vertical'] = df['industry_vertical'].apply(lambda x: np.random.choice(non_null_industry_vertical) if pd.isna(x) else x)

# forward fill data column 
df['date'] = df['date'].fillna(method='ffill')

#save a new cleaned file into csv 
df.to_csv("startup_funding_cln.csv", index=False)

# ---------------------save file to MySQL database------------------------------- 
import pymysql
import pandas as pd
connection = pymysql.connect(host='localhost', user='root', password="GKB@mysql_ds07", database='codeit') 
cursor = connection.cursor()

df = pd.read_csv('startup_funding_cln.csv')
#insert into MySQL table
for _, row in df.iterrows():
    cursor.execute("""INSERT INTO startup_funding_cln (sr_no,date,startup_name,industry_vertical,city_location,investors_name,investment_type,amount_usd)
         VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """, (row["sr_no"], row["date"], row["startup_name"], row["industry_vertical"],row["city_location"],row["investors_name"],row["investment_type"],row["amount_usd"]))

connection.commit()
print("Data inserted successfully")

querry = "SELECT * FROM startup_funding_cln"
cursor.execute(querry)
rows = cursor.fetchall()
for row in rows:
    print(row)

cursor.close()
connection.close()

