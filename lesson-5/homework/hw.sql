

-- 1) Alias: rename ProductName as Name (Products)
SELECT ProductID, ProductName AS Name, Price, Category, StockQuantity
FROM Products;

-- 2) Alias: rename Customers table to Client (example usage)
SELECT c.CustomerID, c.FirstName, c.LastName, c.Country
FROM Customers AS c;  -- alias "Client" requested; typical alias usage shown as "c" (short form)
-- If you strictly want "Client" as alias name:
-- SELECT Client.CustomerID, Client.FirstName, Client.LastName, Client.Country FROM Customers AS Client;

-- 3) UNION ProductName from Products and Products_Discounted (distinct combined list)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4) INTERSECT: common ProductName in both Products and Products_Discounted
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

-- 5) DISTINCT customer full name and Country
SELECT DISTINCT
       CONCAT(ISNULL(FirstName, ''),
              CASE WHEN FirstName IS NOT NULL AND LastName IS NOT NULL THEN ' ' ELSE '' END,
              ISNULL(LastName, '')) AS CustomerName,
       Country
FROM Customers;

-- 6) CASE: Price level ('High' if > 1000 else 'Low') from Products
SELECT ProductID, ProductName,
       CASE WHEN Price > 1000 THEN 'High' ELSE 'Low' END AS PriceLevel
FROM Products;

-- 7) IIF: 'Yes' if StockQuantity > 100, else 'No' (Products_Discounted)
SELECT ProductID, ProductName,
       IIF(StockQuantity > 100, 'Yes', 'No') AS StockOver100
FROM Products_Discounted;




-- 8) UNION again (same as #3, included per task)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 9) EXCEPT: ProductName present in Products but not in Products_Discounted
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

-- 10) IIF: 'Expensive' if Price > 1000 else 'Affordable' (Products)
SELECT ProductID, ProductName,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceTag
FROM Products;

-- 11) Employees with (Age < 25) OR (Salary > 60000)
SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 60000;

-- 12) Update salary: +10% for HR department OR EmployeeID = 5
-- (DML — irreversible in a live DB; run only once if desired)
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentName = 'HR' OR EmployeeID = 5;




-- 13) CASE tiers on Sales.SaleAmount
SELECT SaleID, ProductID, CustomerID, SaleAmount,
       CASE
         WHEN SaleAmount > 500 THEN 'Top Tier'
         WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
         ELSE 'Low Tier'
       END AS SaleTier
FROM Sales;

-- 14) Customers who placed orders but have NO record in Sales (by CustomerID) using EXCEPT
SELECT DISTINCT o.CustomerID
FROM Orders AS o
EXCEPT
SELECT DISTINCT s.CustomerID
FROM Sales  AS s;

-- 15) Orders: discount percentage by quantity
--   1 item       -> 3%
--   2 to 3 items -> 5%
--   Otherwise    -> 7%
SELECT
    CustomerID,
    Quantity,
    CASE
        WHEN Quantity = 1 THEN 0.03
        WHEN Quantity BETWEEN 2 AND 3 THEN 0.05
        ELSE 0.07
    END AS DiscountPercent
FROM Orders;




-- IF example: quick check for HR employees
IF EXISTS (SELECT 1 FROM Employees WHERE DepartmentName = 'HR')
    SELECT 'HR department has employees' AS Info;
ELSE
    SELECT 'No employees in HR' AS Info;

-- WHILE example: simple counter (prints 1..3)
DECLARE @i INT = 1;
WHILE @i <= 3
BEGIN
    PRINT CONCAT('Loop iteration = ', @i);
    SET @i += 1;
END;
