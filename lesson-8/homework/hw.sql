
-- 1. Total number of products in each category
SELECT Category, COUNT(*) AS ProductCount
FROM Products
GROUP BY Category;

-- 2. Average price of products in 'Electronics'
SELECT AVG(Price) AS AvgPrice_Electronics
FROM Products
WHERE Category = 'Electronics';

-- 3. Customers from cities that start with 'L'
SELECT *
FROM Customers
WHERE City LIKE 'L%';

-- 4. Product names that end with 'er'
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

-- 5. Customers from countries ending in 'A'
SELECT *
FROM Customers
WHERE Country LIKE '%A';

-- 6. Highest price among all products
SELECT MAX(Price) AS MaxPrice
FROM Products;

-- 7. Label stock status based on StockQuantity
SELECT ProductID, ProductName, StockQuantity,
       CASE WHEN StockQuantity < 30 THEN 'Low Stock'
            ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

-- 8. Total number of customers in each country
SELECT Country, COUNT(*) AS CustomerCount
FROM Customers
GROUP BY Country;

-- 9. Min and Max quantity ordered
SELECT MIN(Quantity) AS MinQty, MAX(Quantity) AS MaxQty
FROM Orders;

---------------------
-- Medium-Level
---------------------

-- 10. Customers who placed orders in Jan 2023 but had NO invoices in Jan 2023
WITH OrdersJan2023 AS (
  SELECT DISTINCT CustomerID
  FROM Orders
  WHERE YEAR(OrderDate) = 2023 AND MONTH(OrderDate) = 1
)
SELECT o.CustomerID
FROM OrdersJan2023 o
WHERE NOT EXISTS (
  SELECT 1
  FROM Invoices i
  WHERE i.CustomerID = o.CustomerID
    AND YEAR(i.InvoiceDate) = 2023
    AND MONTH(i.InvoiceDate) = 1
);

-- 11. Combine all product names (with duplicates) from Products and Products_Discounted
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

-- 12. Combine product names without duplicates
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 13. Average order amount by year
SELECT YEAR(OrderDate) AS OrderYear,
       AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;

-- 14. Group products by price band
SELECT ProductName,
       CASE
         WHEN Price < 100 THEN 'Low'
         WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
         ELSE 'High'
       END AS PriceGroup
FROM Products;

-- 15. Pivot Year values into columns [2012], [2013] and copy to Population_Each_Year
IF OBJECT_ID('dbo.Population_Each_Year', 'U') IS NOT NULL DROP TABLE dbo.Population_Each_Year;
SELECT *
INTO Population_Each_Year
FROM (
  SELECT district_id, district_name, population, [year]
  FROM city_population
) AS src
PIVOT (
  SUM(population) FOR [year] IN ([2012], [2013])
) AS p;

-- 16. Total sales per ProductID
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

-- 17. Products that contain 'oo' in the name
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

-- 18. Pivot City (district_name) columns (Bektemir, Chilonzor, Yakkasaroy) and copy to Population_Each_City
IF OBJECT_ID('dbo.Population_Each_City', 'U') IS NOT NULL DROP TABLE dbo.Population_Each_City;
SELECT *
INTO Population_Each_City
FROM (
  SELECT district_name, population, [year]
  FROM city_population
) AS src
PIVOT (
  SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS p;

---------------------
-- Hard-Level
---------------------

-- 19. Top 3 customers by total invoice amount
SELECT TOP (3) CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- 20. Transform Population_Each_Year back to the original format (like city_population)
--     (We restore district_id and district_name with year/population rows)
IF OBJECT_ID('dbo.City_Population_From_Year', 'U') IS NOT NULL DROP TABLE dbo.City_Population_From_Year;
SELECT
  pey.district_id,
  pey.district_name,
  CAST(val AS DECIMAL(10,2)) AS population,
  y AS [year]
INTO City_Population_From_Year
FROM Population_Each_Year AS pey
UNPIVOT (
  val FOR y IN ([2012], [2013])
) AS up;

-- 21. Product names and number of times sold (join Sales to Products)
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TimesSold DESC, p.ProductName;

-- 22. Transform Population_Each_City back to the original format (like city_population)
IF OBJECT_ID('dbo.City_Population_From_City', 'U') IS NOT NULL DROP TABLE dbo.City_Population_From_City;
WITH Unpvt AS (
  SELECT
    [year],
    CAST(val AS DECIMAL(10,2)) AS population,
    city_name
  FROM Population_Each_City
  UNPIVOT (
    val FOR city_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
  ) AS up
)
SELECT
  CASE city_name
    WHEN 'Chilonzor' THEN 1
    WHEN 'Yakkasaroy' THEN 2
    WHEN 'Mirobod' THEN 3  -- not present in this pivot; kept for mapping completeness
    WHEN 'Yashnobod' THEN 4 -- not present in this pivot; kept for mapping completeness
    WHEN 'Bektemir' THEN 5
    ELSE NULL
  END AS district_id,
  city_name AS district_name,
  population,
  [year]
INTO City_Population_From_City
FROM Unpvt;

-- End of hw_lesson8.sql
