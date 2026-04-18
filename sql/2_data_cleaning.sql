-- Create cleaned dataset from raw data

CREATE TABLE cleaned_data AS
SELECT *
FROM ecommerce_data
WHERE InvoiceNo NOT LIKE 'C%'        -- remove cancelled orders
  AND Quantity > 0                  -- remove returns
  AND UnitPrice > 0                 -- remove invalid price
  AND CustomerID IS NOT NULL
  AND CustomerID != 0               -- remove empty IDs
  AND StockCode REGEXP '^[0-9]+$';  -- keep only real products

-- Check number of rows before cleaning
SELECT COUNT(*) AS original_rows FROM ecommerce_data;
-- Check number of rows after cleaning
SELECT COUNT(*) AS cleaned_rows FROM cleaned_data;
