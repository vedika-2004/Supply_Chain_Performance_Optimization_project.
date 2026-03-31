# 🚚 Supply Chain Performance Optimization
   A complete supply chain data analysis project built using Python, MySQL, and Power BI to understand sales performance, shipping efficiency, delivery delays, and overall supply chain operations.

## 🧩 Project Overview
   This project analyzes the **DataCo Global Supply Chain dataset** to understand how different components of the supply chain are performing and how businesses can improve operational efficiency using data. 

   The main purpose of this project is to convert raw supply chain data into meaningful insights that help organizations improve delivery performance, increase profitability, and make better business decisions. 
  
   The project follows a complete data analysis workflow, starting from **data cleaning in Python**, performing **SQL-based analysis in MySQL**, and finally building an **interactive Power BI dashboard** for business insights.



## 📊 Dashboard Preview

![Dashboard Screenshot](./Screenshot%202026-03-26%20203434.png) 

![Dashboard Screenshot](./Screenshot%202026-03-26%20203748.png) 

![Dashboard Screenshot](./Screenshot%202026-03-26%20203839.png)


## 🎯 Objectives

• Perform data cleaning and preprocessing for better analysis.

• Analyze sales and profit distribution across regions and markets.

• Identify top-performing products and customer segments.

• Study shipping performance and delivery delays.

• Build interactive Power BI dashboards for business insights.

• Generate actionable recommendations for supply chain improvement.


## 🗂️ Dataset Details

This project uses the original **DatacoSupplyChainDataset** and a cleaned version prepared for analysis.

➢ DatacoSupplyChainDataset.csv – Original raw dataset containing:

• Order details  
• Customer information  
• Product and category data  
• Market and region details  
• Shipping and delivery information  
• Sales and profit data  

➢ cleaned_supply_chain_data.csv – Processed dataset created using Python:

• Removed missing values  
• Fixed column names  
• Converted date formats  
• Created delivery_days column  
• Created delay column  
• Prepared data for SQL and Power BI analysis  

The cleaned dataset is used for SQL analysis and Power BI dashboard creation.

## ⚙️ Tools & Technologies Used

### Tools / Libraries

» Programming: Python  
» Database: MySQL  
» Libraries & Technologies: Pandas, NumPy  
» Visualization: Matplotlib, Seaborn, Power BI  
» Documentation: Jupyter Notebook, GitHub, Markdown  


## 🔄 Project Workflow

Python → MySQL → Power BI

### 1️⃣ Python

The original **DatacoSupplyChainDataset** was cleaned and transformed into **cleaned_supply_chain_data.csv** using Python.  
Missing values were handled, columns were formatted, and new features like delivery_days and delay were created.

### 2️⃣ Python (Data Analysis)

File: Supply_chain_data_analysis.ipynb
Exploratory Data Analysis (EDA) was performed to understand:

• Sales distribution
• Profit trends
• Market performance
• Product performance
• Shipping analysis
• Delivery behavior

Charts were created using Matplotlib and Seaborn.


### 3️⃣ MySQL

File: sql_analysis.sql
The cleaned dataset was imported into MySQL for structured analysis.  
SQL queries were written to analyze sales, profit, customers, products, and shipping performance.

### 4️⃣ Power BI

Power BI was used to build interactive dashboards and visualize key supply chain insights.


## 📊 Power BI Dashboard

Dashboard Name: supply_chain_dashboard.pbix

### 🔹 Dashboard Features

» 1. Overview Dashboard :
• Total Sales  
• Total Profit  
• Average Delivery Days  
• Sales by Market and Region  
• Shipping Mode Distribution  
• Sales by Category  

» 2. Product & Customer Dashboard :
• Top Products  
• Category Performance  
• Customer Segments  
• Market-wise Sales  
• Profit Analysis  

» 3. Shipping & Delivery Dashboard :
• Delivery Days  
• Late Delivery Risk  
• Shipping Mode Performance  
• Region-wise Delivery  
• Delay Distribution

## 🔍 Key Insights

• Some regions generate higher sales but lower profit margins

• Shipping mode has a strong impact on delivery time

• Certain products show high sales with low profitability

• Late delivery risk affects logistics performance

• Market and customer segments contribute differently to revenue

• Delivery delays impact overall supply chain efficiency


## 📈 Business Recommendations

• Improve shipping operations in high-delay regions

• Focus on high-profit product categories

• Optimize low-profit products and pricing strategies

• Reduce late delivery risk through better logistics planning

• Monitor market and customer performance regularly


## 📌 Conclusion

This project demonstrates how supply chain data can be analyzed using Python, MySQL, and Power BI to generate meaningful business insights.
It showcases a complete end-to-end data analyst workflow and highlights how data-driven decisions can improve supply chain performance and business operations.



