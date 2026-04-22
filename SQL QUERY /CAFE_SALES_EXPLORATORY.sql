
SELECT *
FROM REVENUE.CAFE_SALES2
;

SELECT SUM(Total_Spent)
FROM REVENUE.CAFE_SALES2
;

SELECT COUNT(Transaction_id) * AVG(Total_spent)
FROM REVENUE.CAFE_SALES2
;

SELECT COUNT(Transaction_id)*
;
-- INCREASING REVENUE FROM FEBRUARY TO JUNE
-- We will check in which month shows the lowest and the highest revenue

SELECT DATE_FORMAT(Transaction_Date, '%Y-%m') AS month, SUM(Total_spent) AS revenue
FROM REVENUE.CAFE_SALES2
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY DATE_FORMAT(Transaction_Date, '%Y-%m')
;

 -- Comparing transaction volume in Feb vs June
SELECT DATE_FORMAT(Transaction_date, '%Y-%m') AS month,
COUNT(Transaction_id) AS total_order
FROM REVENUE.CAFE_SALES2
WHERE DATE_FORMAT(Transaction_Date, '%Y-%m') IN ('2023-02','2023-06')
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY DATE_FORMAT(Transaction_Date, '%Y-%m')
;



-- Comparing average quantity in Feb vs June
SELECT DATE_FORMAT(Transaction_date, '%Y-%m') AS month,
SUM(Quantity) AS avg_quantity
FROM REVENUE.CAFE_SALES2
WHERE DATE_FORMAT(Transaction_Date, '%Y-%m') IN ('2023-02','2023-06')
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY DATE_FORMAT(Transaction_Date, '%Y-%m')
;



-- amount of price per unit comparison between both months
SELECT Price_Per_Unit,

  COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Item END) AS feb_count,
	
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Item END) AS june_count,

    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Item END)
    -
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Item END) AS difference
        
	
        
FROM REVENUE.CAFE_SALES2
GROUP BY Price_Per_Unit
ORDER BY Price_Per_Unit
;

SELECT DATE_FORMAT(Transaction_date, '%Y-%m'), COUNT(Item)
FROM REVENUE.CAFE_SALES2
WHERE Price_Per_Unit = 5
GROUP BY DATE_FORMAT(Transaction_date, '%Y-%m')
ORDER BY DATE_FORMAT(Transaction_date, '%Y-%m')

;

-- it is shows that total order/volume, quantity, and sales on higher price item has been increasing over the time, 
-- We will analyze deep dive by seeing it through item, pricing, payment method, location.

		-- item dimension
    SELECT 
    item,

    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN item END) AS feb_count_order,

    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN item END) AS june_count_order,

    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN item END)
    -
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN item END) AS difference,
        
SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS feb_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS june_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END)
    -
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS difference
        


FROM REVENUE.CAFE_SALES2
GROUP BY item
ORDER BY difference DESC;

;

-- From the total order it is high likely generate from $4 item, but from quantiy generate from $5 item 

-- Payment method dimension

SELECT 
	Payment_Method,

	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-02'
        THEN Payment_Method END) AS feb_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Payment_Method END) AS june_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Payment_Method END)
	-
    
    COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-02'
        THEN Payment_Method END) AS difference,
	
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS feb_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS june_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END)
    -
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS difference
        
	FROM REVENUE.CAFE_SALES2
	GROUP BY Payment_Method
	ORDER BY difference DESC;


-- Location dimension

SELECT 
	Location,

	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-02'
        THEN Location END) AS feb_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Location END) AS june_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Location END)
	-
    
    COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-02'
        THEN Location END) AS difference,
	
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS feb_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS june_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END)
    -
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS difference
        
	FROM REVENUE.CAFE_SALES2
	GROUP BY Location
	ORDER BY difference DESC;

-- Price dimension

SELECT Price_Per_Unit,

  COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Price_Per_Unit END) AS feb_count,
	
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Price_Per_Unit END) AS june_count,

    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Price_Per_Unit END)
    -
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Price_Per_Unit END) AS difference,
	
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS feb_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS june_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END)
    -
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-02' 
        THEN Quantity END) AS difference
        
	
        
FROM REVENUE.CAFE_SALES2
GROUP BY Price_Per_Unit
ORDER BY Price_Per_Unit
;




-- DECREASING REVENUE FROM JUNE TO JULY
-- We will compare revenue from June to July

SELECT DATE_FORMAT(Transaction_Date, '%Y-%m') AS month, SUM(Total_spent) AS revenue
FROM REVENUE.CAFE_SALES2
WHERE DATE_FORMAT(Transaction_Date, '%Y-%m') IN ('2023-06','2023-07')
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY DATE_FORMAT(Transaction_Date, '%Y-%m')
;

 -- Comparing transaction volume in Feb vs June
SELECT DATE_FORMAT(Transaction_date, '%Y-%m') AS month,
COUNT(Transaction_id) AS total_order
FROM REVENUE.CAFE_SALES2
WHERE DATE_FORMAT(Transaction_Date, '%Y-%m') IN ('2023-06','2023-07')
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY DATE_FORMAT(Transaction_Date, '%Y-%m')
;



-- Comparing average quantity in Feb vs June
SELECT DATE_FORMAT(Transaction_date, '%Y-%m') AS month,
SUM(Quantity) AS avg_quantity
FROM REVENUE.CAFE_SALES2
WHERE DATE_FORMAT(Transaction_Date, '%Y-%m') IN ('2023-06','2023-07')
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY DATE_FORMAT(Transaction_Date, '%Y-%m')
;



-- amount of price per unit comparison between both months
SELECT Price_Per_Unit,

  COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Item END) AS feb_count,
	
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Item END) AS june_count,

    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Item END)
    -
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Item END) AS difference
        

        
FROM REVENUE.CAFE_SALES2
GROUP BY Price_Per_Unit
ORDER BY difference ASC
;


-- it is shows that total order/volume, quantity, and sales on higher price item has been decresing over the time, 
-- We will analyze deep dive by seeing it through item, pricing, payment method, location.


-- item dimension
SELECT 
	Item,
    
    COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Item END) AS June_count,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date,'%Y-%m') = '2023-07'
        THEN Item END) AS July_count,
	
    COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date,'%Y-%m') = '2023-07'
        THEN Item END) 
	-
    COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Item END) AS difference,
        
	SUM(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Quantity END) AS June_count,
	
    SUM(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-07'
        THEN Quantity END) AS July_count,
        
	 SUM(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-07'
        THEN Quantity END)
	-
    SUM(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Quantity END) AS difference

FROM REVENUE.CAFE_SALES2
GROUP BY Item
ORDER BY difference ASC
;

-- Payment method dimension

SELECT 
	Payment_Method,

	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Payment_Method END) AS feb_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-07'
        THEN Payment_Method END) AS june_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-07'
        THEN Payment_Method END)
	-
    
    COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Payment_Method END) AS difference,
	
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS feb_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Quantity END) AS june_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Quantity END)
    -
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS difference
        
	FROM REVENUE.CAFE_SALES2
	GROUP BY Payment_Method
	ORDER BY difference ASC;


-- Location dimension

SELECT 
	Location,

	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Location END) AS feb_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-07'
        THEN Location END) AS june_payment_method_quantity,
        
	COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-07'
        THEN Location END)
	-
    
    COUNT(CASE
		WHEN DATE_FORMAT(Transaction_Date, '%Y-%m') = '2023-06'
        THEN Location END) AS difference,
	
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS feb_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Quantity END) AS june_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Quantity END)
    -
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS difference
        
	FROM REVENUE.CAFE_SALES2
	GROUP BY Location
	ORDER BY difference ASC;

-- Price dimension

SELECT Price_Per_Unit,

  COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Price_Per_Unit END) AS feb_count,
	
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Price_Per_Unit END) AS june_count,

    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Price_Per_Unit END)
    -
    COUNT(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Price_Per_Unit END) AS difference,
	
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS feb_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Quantity END) AS june_count_quanity,

    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-07' 
        THEN Quantity END)
    -
    SUM(CASE 
        WHEN DATE_FORMAT(transaction_date, '%Y-%m') = '2023-06' 
        THEN Quantity END) AS difference
        
	
        
FROM REVENUE.CAFE_SALES2
GROUP BY Price_Per_Unit
ORDER BY difference ASC
;


SELECT Item, Price_Per_Unit
FROM REVENUE.CAFE_SALES2
WHERE Price_Per_Unit = 5
GROUP BY item
;


        
        
