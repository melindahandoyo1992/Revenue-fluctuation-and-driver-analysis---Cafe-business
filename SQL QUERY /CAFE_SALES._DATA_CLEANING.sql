SELECT *
FROM REVENUE.CAFE_SALES

;

-- Data cleaning process

-- Replace empty or unknown value
    
	-- item column



UPDATE REVENUE.CAFE_SALES
SET item = 'Unknown item'
WHERE item IS NULL OR item = '' OR item = 'UNKNOWN' OR item = 'ERROR'
;


	-- Total_spent column

UPDATE REVENUE.CAFE_SALES
SET Total_Spent = Quantity * Price_Per_Unit
WHERE Total_spent IS NULL OR Total_spent = 'ERROR' OR Total_spent = 'UNKNOWN'  OR Total_spent = ''
;

	-- Payment_method column


UPDATE REVENUE.CAFE_SALES
SET Payment_Method = 'Unknown method'
WHERE Payment_Method IS NULL OR Payment_Method = 'ERROR' OR Payment_Method = 'UNKNOWN' OR Payment_Method = ''
;

	-- Location column



UPDATE REVENUE.CAFE_SALES
SET Location = 'Unknown location'
WHERE Location IS NULL OR Location = 'ERROR' OR Location = 'UNKNOWN' OR Location = ''
;


	-- Transaction_date column
    


UPDATE  REVENUE.CAFE_SALES
SET Transaction_Date = null
WHERE Transaction_Date = 'ERROR' OR Transaction_Date = 'UMKNOWN' OR Transaction_Date = '' OR Transaction_Date = 'UNKNOWN'
;






-- Checking duplicate records

SELECT Transaction_id, COUNT(Transaction_id)
FROM REVENUE.CAFE_SALES
GROUP BY Transaction_id
HAVING COUNT(Transaction_id) > 1
;


-- Checking and converting data types

SHOW COLUMNS FROM REVENUE.CAFE_SALES;

ALTER TABLE REVENUE.CAFE_SALES
MODIFY total_spent DECIMAL(10,2);

ALTER TABLE REVENUE.CAFE_SALES
MODIFY transaction_date DATE;




-- Data validation



SELECT 
	COUNT(*) AS total_row,
    SUM(CASE WHEN Item = 'Unknown item' THEN 1 ELSE 0 END) AS unknown_item,
    SUM(CASE WHEN Payment_Method = 'Unknown method' THEN 1 ELSE 0 END) AS unknown_method,
    SUM(CASE WHEN Location = 'Unknown location' THEN 1 ELSE 0 END) AS unknown_location,
    SUM(CASE WHEN Transaction_Date IS NULL THEN 1 ELSE 0 END) AS unknown_transaction_date
FROM REVENUE.CAFE_SALES
;

		-- Checking NULLS
SELECT 
	COUNT(*) AS total_row,
    SUM(CASE WHEN Item IS NULL THEN 1 ELSE 0 END) AS null_item,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS null_method,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_location
FROM REVENUE.CAFE_SALES
;


		-- Checking 'Unknown' consistency
SELECT DISTINCT Item 
FROM REVENUE.CAFE_SALES
;

SELECT DISTINCT Payment_Method 
FROM REVENUE.CAFE_SALES
;

SELECT DISTINCT Location
FROM REVENUE.CAFE_SALES
;

		-- Validate calculation
SELECT *
FROM  REVENUE.CAFE_SALES
WHERE Total_spent != Quantity * Price_Per_Unit;
;


		-- Checking data types
SELECT
	SUM(Total_Spent),
    AVG(Total_Spent)
FROM  REVENUE.CAFE_SALES
;

SELECT
	MONTH(Transaction_Date),
    COUNT(*)
FROM  REVENUE.CAFE_SALES
GROUP BY MONTH(Transaction_Date)
ORDER BY MONTH(Transaction_Date)
;

		-- Checking duplicates
SELECT Transaction_id, COUNT(*)
FROM  REVENUE.CAFE_SALES
GROUP BY Transaction_id
HAVING COUNT(*) > 1
;

		-- Check outliers

SELECT *
FROM  REVENUE.CAFE_SALES
WHERE Quantity < 0 OR Price_Per_Unit < 0 ;


SELECT MIN(Total_Spent), MAX(Total_Spent)
FROM  REVENUE.CAFE_SALES 
;


    

