WITH RECURSIVE Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 1000
)
SELECT * FROM Numbers;


SELECT e.name, s.total_sales
FROM employees e
JOIN (
    SELECT employee_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY employee_id
) s ON e.employee_id = s.employee_id;


WITH AvgSalary AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT * FROM AvgSalary;


SELECT p.product_name, s.max_sale
FROM products p
JOIN (
    SELECT product_id, MAX(sale_amount) AS max_sale
    FROM sales
    GROUP BY product_id
) s ON p.product_id = s.product_id;


WITH RECURSIVE Doubles AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM Doubles
    WHERE num * 2 < 1000000
)
SELECT * FROM Doubles;


WITH EmployeeSales AS (
    SELECT employee_id, COUNT(*) AS total_sales
    FROM sales
    GROUP BY employee_id
)
SELECT e.name, es.total_sales
FROM employees e
JOIN EmployeeSales es ON e.employee_id = es.employee_id
WHERE es.total_sales > 5;


WITH ProductSales AS (
    SELECT product_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY product_id
)
SELECT p.product_name, ps.total_sales
FROM products p
JOIN ProductSales ps ON p.product_id = ps.product_id
WHERE ps.total_sales > 500;


WITH AvgSalary AS (
    SELECT AVG(salary) AS avg_salary FROM employees
)
SELECT e.*
FROM employees e, AvgSalary a
WHERE e.salary > a.avg_salary;


SELECT e.name, s.order_count
FROM employees e
JOIN (
    SELECT employee_id, COUNT(*) AS order_count
    FROM sales
    GROUP BY employee_id
    ORDER BY order_count DESC
    LIMIT 5
) s ON e.employee_id = s.employee_id;


SELECT p.category_id, s.total_sales
FROM (
    SELECT product_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY product_id
) s
JOIN products p ON p.product_id = s.product_id
GROUP BY p.category_id;


WITH RECURSIVE Factorial AS (
    SELECT n AS original_n, n AS current_n, 1 AS fact
    FROM numbers1
    UNION ALL
    SELECT f.original_n, f.current_n - 1, f.fact * (f.current_n - 1)
    FROM Factorial f
    WHERE f.current_n > 1
)
SELECT original_n AS number, MAX(fact) AS factorial
FROM Factorial
GROUP BY original_n
ORDER BY number;


WITH RECURSIVE SplitString AS (
    SELECT 1 AS pos, SUBSTRING('HELLO', 1, 1) AS ch
    UNION ALL
    SELECT pos + 1, SUBSTRING('HELLO', pos + 1, 1)
    FROM SplitString
    WHERE pos < LENGTH('HELLO')
)
SELECT ch AS character
FROM SplitString;


WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(sale_month, '%Y-%m') AS month,
        SUM(total_sales) AS total_sales
    FROM sales
    GROUP BY DATE_FORMAT(sale_month, '%Y-%m')
)
SELECT 
    month,
    total_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY month) AS sales_difference
FROM MonthlySales;


SELECT e.name, s.quarter, s.total_sales
FROM employees e
JOIN (
    SELECT 
        employee_id,
        CONCAT(YEAR(sale_date), '-Q', QUARTER(sale_date)) AS quarter,
        SUM(amount) AS total_sales
    FROM sales
    GROUP BY employee_id, YEAR(sale_date), QUARTER(sale_date)
    HAVING SUM(amount) > 45000
) s ON e.employee_id = s.employee_id;


WITH RECURSIVE Fibonacci AS (
    SELECT 1 AS n, 0 AS a, 1 AS b
    UNION ALL
    SELECT n + 1, b, a + b
    FROM Fibonacci
    WHERE n < 10  -- limit sequence length
)
SELECT n AS position, a AS fibonacci_number
FROM Fibonacci;


SELECT value
FROM FindSameCharacters
WHERE LENGTH(value) > 1
  AND value REGEXP CONCAT('^', SUBSTRING(value, 1, 1), '+$');


WITH RECURSIVE NumSeq AS (
    SELECT 1 AS n, CAST('1' AS CHAR(10)) AS seq
    UNION ALL
    SELECT n + 1, CONCAT(seq, n + 1)
    FROM NumSeq
    WHERE n < 5
)
SELECT seq FROM NumSeq;


SELECT e.name, s.total_sales
FROM employees e
JOIN (
    SELECT employee_id, SUM(amount) AS total_sales
    FROM sales
    WHERE sale_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY employee_id
    ORDER BY total_sales DESC
    LIMIT 5
) s ON e.employee_id = s.employee_id;


-- T-SQL version (SQL Server)
;WITH Split AS (
    SELECT 
        value,
        ROW_NUMBER() OVER (PARTITION BY value ORDER BY (SELECT NULL)) AS rn
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(name, ' ')
    WHERE ISNUMERIC(value) = 1
)
SELECT STRING_AGG(value, ' ') AS cleaned_string
FROM Split
WHERE rn = 1  -- remove duplicates
  AND LEN(value) > 1;  -- remove single-digit numbers
