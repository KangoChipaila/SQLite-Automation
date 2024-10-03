import pandas as pd
from sqlalchemy import create_engine 

#Extraction

#date_dim_table_data = pd.read_csv("sales_assign3.csv", usecols = ['ORDERDATE'], encoding = 'cp1252')

#product_dim_table_data = pd.read_csv("sales_assign3.csv", usecols = ['PRODUCTCODE', 'PRODUCTLINE', 'MSRP'], encoding = 'cp1252')

sales_fact_table_data = pd.read_csv("sales_assign3.csv", usecols = ['ORDERNUMBER', 'QUANTITYORDERED', 'PRICEEACH', 'SALES', 'DEALSIZE'], encoding = 'cp1252')

#customer_dim_table_data = pd.read_csv("sales_assign3.csv", usecols = ['CUSTOMERNAME', 'PHONE', 'ADDRESSLINE1', 'ADDRESSLINE2', 'CITY', 'STATE', 'POSTALCODE', 'COUNTRY', 'TERRITORY', 'CONTACTLASTNAME', 'CONTACTFIRSTNAME'], encoding = 'cp1252')

#Transformation

#customer_dim_table_data = customer_dim_table_data.fillna('N/A')

#Database Connection
connection = create_engine("sqlite:///C:/Users/Kango Chipaila/Downloads/BIT 3340 Advanced Database Systems/Assignments/Assignment 3/DataMart.db", echo=False)

#Loading

#date_dim_table_data.to_sql('DateDim', con = connection, if_exists='append', index='DateKey')

sales_fact_table_data.to_sql('SalesFact', con = connection, if_exists='append', index='OrderKey')

#product_dim_table_data.to_sql('ProductDim', con = connection, if_exists='append', index='ProductKey')

#customer_dim_table_data.to_sql('CustomerDim', con = connection, if_exists='append', index='CustomerKey')

