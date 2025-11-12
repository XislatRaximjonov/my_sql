SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS running_total
FROM sales_data
ORDER BY customer_id, order_date;

SELECT 
    product_category,
    COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

SELECT 
    product_category,
    MAX(total_amount) AS max_total
FROM sales_data
GROUP BY product_category;

SELECT 
    product_category,
    MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;


SELECT 
    order_date,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3days
FROM sales_data
ORDER BY order_date;


SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;


SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_purchase,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS customer_rank
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY customer_rank;


SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS diff_from_prev
FROM sales_data
ORDER BY customer_id, order_date;


SELECT 
    product_category,
    product_name,
    unit_price,
    RANK() OVER (
        PARTITION BY product_category 
        ORDER BY unit_price DESC
    ) AS price_rank
FROM sales_data
WHERE RANK() OVER (
        PARTITION BY product_category 
        ORDER BY unit_price DESC
    ) <= 3;


SELECT 
    product_category,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY product_category 
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeRevenue
FROM sales_data
ORDER BY product_category, order_date;


SELECT 
    Value,
    SUM(Value) OVER (
        ORDER BY Value
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS [Sum of Previous]
FROM OneColumn;


SELECT 
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS category_count
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;


SELECT 
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS total_spending
FROM sales_data
GROUP BY customer_id, customer_name, region
HAVING SUM(total_amount) > (
    SELECT AVG(SUM(total_amount))
    FROM sales_data AS s2
    WHERE s2.region = sales_data.region
    GROUP BY s2.customer_id
);


SELECT 
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS total_spending,
    RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM sales_data
GROUP BY customer_id, customer_name, region;


SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;


SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS monthly_sales,
    LAG(SUM(total_amount)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS prev_month_sales,
    ROUND(
        (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m'))) 
        / LAG(SUM(total_amount)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) * 100, 2
    ) AS growth_rate
FROM sales_data
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_total_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date);


SELECT 
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM sales_data
);


SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN Id = MIN(Id) OVER (PARTITION BY Grp) 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Tot
FROM MyData
ORDER BY Grp, Id;


SELECT 
    ID,
    SUM(Cost) AS Cost,
    SUM(DISTINCT Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID
ORDER BY ID;


WITH SeatCTE AS (
    SELECT 
        SeatNumber,
        LAG(SeatNumber) OVER (ORDER BY SeatNumber) AS PrevSeat
    FROM Seats
)
SELECT 
    COALESCE(PrevSeat + 1, 1) AS GapStart,
    SeatNumber - 1 AS GapEnd
FROM SeatCTE
WHERE SeatNumber - PrevSeat > 1
UNION ALL
-- Tugashdagi oxirgi bo'sh joy (eng katta raqamdan keyin ham bo'lishi mumkin)
SELECT 
    MAX(SeatNumber) + 1,
    NULL
FROM Seats
ORDER BY GapStart;
