-- Create a new database for the project
CREATE DATABASE ecommerce_project;

-- Use the created database
USE ecommerce_project;

-- Create table to store ecommerce data
CREATE TABLE ecommerce_data (
    InvoiceNo VARCHAR(20),        -- Unique invoice number 
    StockCode VARCHAR(20),        -- Product code
    Description TEXT,             -- Product description
    Quantity INT,                 -- Number of items purchased (negative for returns)
    InvoiceDate VARCHAR(60),         -- Date and time of transaction
    UnitPrice DECIMAL(10,2),      -- Price per unit of product
    CustomerID INT,               -- Unique customer ID (can be NULL)
    Country VARCHAR(50)           -- Customer country
);
-- Data is imported using LOAD DATA LOCAL INFILE (external step)
-- Enable local file import
SET GLOBAL local_infile = 1;

-- Load data from CSV file into table
LOAD DATA LOCAL INFILE 'C:/Users/Acer/Downloads/online_retail.csv'
INTO TABLE ecommerce_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Verify number of rows imported
SELECT COUNT(*) FROM ecommerce_data;
