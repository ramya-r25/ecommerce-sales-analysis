-- ___________________REVENUE ANALYSIS_____________________________

-- TOTAL REVENUE
SELECT SUM( UnitPrice * Quantity ) AS TOTAL_REVENUE FROM cleaned_data; 

-- COUNTRY REVENUE
SELECT Country, 
   SUM( UnitPrice * Quantity ) AS COUNTRY_REVENUE FROM cleaned_data
GROUP BY Country  
ORDER BY COUNTRY_REVENUE DESC ; 

-- MONTHLY TREND 
SELECT 
    DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'), '%Y-%m') AS month,
    SUM(UnitPrice * Quantity) AS monthly_revenue
FROM cleaned_data
GROUP BY month
ORDER BY month;

-- _________________PRODUCT ANALYSIS_____________________

-- TOP SELLING PRODUCTS(BY QUANTITY)

SELECT Description,
SUM(Quantity) AS total_sold FROM cleaned_data
GROUP BY Description
ORDER BY total_sold DESC ; 

-- TOP REVENUE GENERATING PRODUCTS
SELECT Description,
SUM(Quantity*UnitPrice) AS Revenue FROM cleaned_data
GROUP BY Description
ORDER BY Revenue DESC;

-- LOW PERFORMING PRODUCTS

SELECT 
    Description,
    SUM(Quantity) AS total_sold
FROM cleaned_data
GROUP BY Description
ORDER BY total_sold ASC
LIMIT 10;

-- _______________________CUSTOMER ANALYSIS______________________________

-- TOP CUSTOMERS (WHO SPENDS THE MOST)

SELECT CustomerID,
SUM(Quantity*Unitprice) AS Total_spent FROM cleaned_data
GROUP BY CustomerID
ORDER BY Total_spent DESC;

-- AVERAGE CUSTOMER SPENDING 

SELECT AVG(total_spent) AS avg_cust_spent
FROM(
SELECT CustomerID,
SUM(Quantity*Unitprice) AS total_spent FROM cleaned_data
GROUP BY CustomerID) t;

-- NUMBER OF UNIQUE CUSTOMERS 

SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM cleaned_data;

-- REPEAT CUSTOMERS
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_data
GROUP BY CustomerID
HAVING total_orders > 1
ORDER BY total_orders DESC;

-- CUSTOMER SEGMENTATION
SELECT 
    CustomerID,
    SUM(Quantity * UnitPrice) AS total_spent,
    CASE 
        WHEN SUM(Quantity * UnitPrice) > 10000 THEN 'High Value'
        WHEN SUM(Quantity * UnitPrice) BETWEEN 5000 AND 10000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM cleaned_data
GROUP BY CustomerID;

-- AVERAGE ORDERS PER CUSTOMER
SELECT 
    AVG(total_orders) AS avg_orders_per_customer
FROM (
    SELECT 
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS total_orders
    FROM cleaned_data
    GROUP BY CustomerID
) t;

-- ___________________REGIONAL ANALYSIS_____________________

-- REVENUE BY COUNTRY

SELECT 
    Country,
    SUM(Quantity * UnitPrice) AS revenue
FROM cleaned_data
GROUP BY Country
ORDER BY revenue DESC;

-- NUMBER OF CUSOTOMERS PER COUNTRY
SELECT 
    Country,
    COUNT(DISTINCT CustomerID) AS total_customers
FROM cleaned_data
GROUP BY Country
ORDER BY total_customers DESC;

-- AVERAGE SPENDING PER COUNTRY

SELECT 
    Country,
    AVG(total_spent) AS avg_spending
FROM (
    SELECT 
        Country,
        CustomerID,
        SUM(Quantity * UnitPrice) AS total_spent
    FROM cleaned_data
    GROUP BY Country, CustomerID
) t
GROUP BY Country
ORDER BY avg_spending DESC;

-- TOP COUNTRIES BY ORDER VALUE

SELECT 
    Country,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_data
GROUP BY Country
ORDER BY total_orders DESC;

-- FINAL DATA EXPORT FOR EXCEL / POWER BI
SELECT * FROM cleaned_data
;