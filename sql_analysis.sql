CREATE DATABASE supply_chain_db;
use supply_chain_db;

CREATE TABLE supply_chain (
    Type VARCHAR(50),
    Days_for_shipping_real INT,
    Days_for_shipment_scheduled INT,
    Benefit_per_order FLOAT,
    Sales_per_customer FLOAT,
    Delivery_Status VARCHAR(50),
    Late_delivery_risk INT,
    Category_Id INT,
    Category_Name VARCHAR(255),
    Customer_City VARCHAR(100),
    Customer_Country VARCHAR(100),
    Customer_Fname VARCHAR(100),
    Customer_Id INT,
    Customer_Lname VARCHAR(100),
    Customer_Segment VARCHAR(100),
    Customer_State VARCHAR(100),
    Customer_Street VARCHAR(255),
    Customer_Zipcode VARCHAR(20),
    Department_Id INT,
    Department_Name VARCHAR(255),
    Latitude FLOAT,
    Longitude FLOAT,
    Market VARCHAR(50),
    Order_City VARCHAR(100),
    Order_Country VARCHAR(100),
    Order_Customer_Id INT,
    Order_Date DATETIME,
    Order_Id INT,
    Order_Item_Cardprod_Id INT,
    Order_Item_Discount FLOAT,
    Order_Item_Discount_Rate FLOAT,
    Order_Item_Id INT,
    Order_Item_Product_Price FLOAT,
    Order_Item_Profit_Ratio FLOAT,
    Order_Item_Quantity INT,
    Sales FLOAT,
    Order_Item_Total FLOAT,
    Order_Profit_Per_Order FLOAT,
    Order_Region VARCHAR(100),
    Order_State VARCHAR(100),
    Order_Status VARCHAR(100),
    Product_Card_Id INT,
    Product_Category_Id INT,
    Product_Image TEXT,
    Product_Name VARCHAR(255),
    Product_Price FLOAT,
    Product_Status INT,
    Shipping_Date DATETIME,
    Shipping_Mode VARCHAR(100),
    delivery_days INT,
    delay INT
);
select * from supply_chain;

-- Creating views for better analysis
CREATE VIEW customer_view AS
SELECT 
    Customer_Id,
    Customer_Fname,
    Customer_Lname,
    Customer_Segment,
    Customer_City,
    Customer_Country
FROM supply_chain;

CREATE VIEW product_view AS
SELECT 
    Product_Card_Id,
    Product_Name,
    Category_Id,
    Category_Name,
    Product_Price
FROM supply_chain;

CREATE VIEW order_view AS
SELECT 
    Order_Id,
    Customer_Id,
    Product_Card_Id,
    Sales,
    Order_Profit_Per_Order,
    Order_Date,
    Order_Region,
    Market
FROM supply_chain;

CREATE VIEW shipping_view AS
SELECT 
    Order_Id,
    Shipping_Mode,
    delivery_days,
    delay,
    Late_delivery_risk
FROM supply_chain;


select sum(sales) as 'Total_Sales'
from supply_chain;


-- Q. Count sales by regarding Region?
SELECT Order_Region, SUM(Sales) AS total_sales
FROM supply_chain
GROUP BY Order_Region
ORDER BY total_sales DESC;

SELECT Shipping_Mode, AVG(delivery_days) AS avg_delivery
FROM supply_chain
GROUP BY Shipping_Mode;

SELECT Category_Name, SUM(Order_Profit_Per_Order) AS total_profit
FROM supply_chain
GROUP BY Category_Name
ORDER BY total_profit DESC;

-- Q. Which products generate high sales but low profit?

SELECT Product_Name,
       SUM(Sales) AS total_sales,
       SUM(Order_Profit_Per_Order) AS total_profit
FROM supply_chain
GROUP BY Product_Name
HAVING total_sales > 1000
ORDER BY total_profit ASC
LIMIT 10;

-- Q. Which region has the highest late delivery risk?

SELECT Order_Region,
       COUNT(*) AS total_orders,
       SUM(Late_delivery_risk) AS late_orders
FROM supply_chain
GROUP BY Order_Region
ORDER BY late_orders DESC;

-- Q. Which products have sales higher than the average product sales?

SELECT Product_Name,
       SUM(Sales) AS total_sales
FROM supply_chain
GROUP BY Product_Name
HAVING total_sales > (
    SELECT AVG(product_sales)
    FROM (
        SELECT SUM(Sales) AS product_sales
        FROM supply_chain
        GROUP BY Product_Name
    ) AS avg_sales
);

-- Q. Which regions generate profit above overall average?

SELECT Order_Region,
       SUM(Order_Profit_Per_Order) AS total_profit
FROM supply_chain
GROUP BY Order_Region
HAVING total_profit > (
    SELECT AVG(region_profit)
    FROM (
        SELECT SUM(Order_Profit_Per_Order) AS region_profit
        FROM supply_chain
        GROUP BY Order_Region
    ) AS profit_avg
);

-- Q. Which orders have delay higher than average delay?

SELECT Order_Id,
       delay
FROM supply_chain
WHERE delay > (
    SELECT AVG(delay)
    FROM supply_chain
);

-- Q. Which customers spend more than average?

SELECT Customer_Id,
       SUM(Sales) AS total_spending
FROM supply_chain
GROUP BY Customer_Id
HAVING total_spending > (
    SELECT AVG(customer_spending)
    FROM (
        SELECT SUM(Sales) AS customer_spending
        FROM supply_chain
        GROUP BY Customer_Id
    ) avg_table
);

-- Q. Which customers generate highest sales and profit?

SELECT 
    c.Customer_Id,
    c.Customer_Fname,
    SUM(o.Sales) AS total_sales,
    SUM(o.Order_Profit_Per_Order) AS total_profit
FROM customer_view c
JOIN order_view o
ON c.Customer_Id = o.Customer_Id
GROUP BY c.Customer_Id, c.Customer_Fname
ORDER BY total_sales DESC
LIMIT 10;

-- Q. Which products perform best in each category?

SELECT 
    p.Category_Name,
    p.Product_Name,
    SUM(o.Sales) AS total_sales
FROM product_view p
JOIN order_view o
ON p.Product_Card_Id = o.Product_Card_Id
GROUP BY p.Category_Name, p.Product_Name
ORDER BY total_sales DESC;

-- Q. How shipping performance affects regional sales?

SELECT 
    o.Order_Region,
    s.Shipping_Mode,
    AVG(s.delivery_days) AS avg_delivery,
    SUM(o.Sales) AS total_sales
FROM order_view o
JOIN shipping_view s
ON o.Order_Id = s.Order_Id
GROUP BY o.Order_Region, s.Shipping_Mode
ORDER BY total_sales DESC;

-- Q. Which customer segment performs best in each market?

SELECT 
    o.Market,
    c.Customer_Segment,
    SUM(o.Sales) AS total_sales,
    SUM(o.Order_Profit_Per_Order) AS total_profit
FROM order_view o
JOIN customer_view c
ON o.Customer_Id = c.Customer_Id
GROUP BY o.Market, c.Customer_Segment
ORDER BY total_sales DESC;

-- Q. How frequently customers place orders?

SELECT 
    Customer_Id,
    COUNT(Order_Id) AS total_orders,
    ROW_NUMBER() OVER (ORDER BY COUNT(Order_Id) DESC) AS customer_rank
FROM supply_chain
GROUP BY Customer_Id;



-- Q. Rank products based on total sales.

SELECT 
    Product_Name,
    SUM(Sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS product_rank
FROM supply_chain
GROUP BY Product_Name;


-- Q. Which product is top in each category?

SELECT * FROM (
    SELECT 
        Category_Name,
        Product_Name,
        SUM(Sales) AS total_sales,
        RANK() OVER (PARTITION BY Category_Name ORDER BY SUM(Sales) DESC) AS rank_in_category
    FROM supply_chain
    GROUP BY Category_Name, Product_Name
) ranked
WHERE rank_in_category = 1;


-- Q. How does cumulative sales grow month by month?

SELECT 
    MONTH(Order_Date) AS month,
    SUM(Sales) AS monthly_sales,
    SUM(SUM(Sales)) OVER (ORDER BY MONTH(Order_Date)) AS cumulative_sales
FROM supply_chain
GROUP BY MONTH(Order_Date);

-- Top 3 products in each region

-- Q. Which are top 3 products in every region?
SELECT *
FROM (
    SELECT 
        Order_Region,
        Product_Name,
        SUM(Sales) AS total_sales,
        RANK() OVER ( 
            PARTITION BY Order_Region
            ORDER BY SUM(Sales) DESC
        ) AS rank_in_region
    FROM supply_chain
    GROUP BY Order_Region, Product_Name
) ranked
WHERE rank_in_region <= 3;