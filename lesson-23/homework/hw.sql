SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

SELECT 
    Id, 
    rID, 
    MAX(Vals) AS MaxVal
FROM MyTabel
GROUP BY Id, rID;


SELECT 
    Id,
    Vals
FROM TestFixLengths
WHERE Vals IS NOT NULL
  AND LENGTH(Vals) BETWEEN 6 AND 10;


SELECT t.ID, t.Item, t.Vals
FROM TestMaximum t
INNER JOIN (
    SELECT ID, MAX(Vals) AS MaxVal
    FROM TestMaximum
    GROUP BY ID
) AS m
ON t.ID = m.ID AND t.Vals = m.MaxVal
ORDER BY t.ID;


SELECT 
    Id,
    SUM(MaxVal) AS SumofMax
FROM (
    SELECT 
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS sub
GROUP BY Id
ORDER BY Id;


SELECT 
    Id,
    a,
    b,
    CASE 
        WHEN a - b = 0 THEN '' 
        ELSE CAST(a - b AS VARCHAR)
    END AS OUTPUT
FROM TheZeroPuzzle
ORDER BY Id;

SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;

SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;

SELECT COUNT(*) AS TotalTransactions
FROM Sales;

SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;

SELECT Category, SUM(QuantitySold) AS TotalUnitsSold
FROM Sales
GROUP BY Category;

SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;

SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Product
ORDER BY Revenue DESC;

SELECT SaleID, SaleDate, Product,
       QuantitySold * UnitPrice AS Revenue,
       SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningTotalRevenue
FROM Sales
ORDER BY SaleDate;

SELECT Category,
       SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
       ROUND(100.0 * SUM(QuantitySold * UnitPrice) / 
             (SELECT SUM(QuantitySold * UnitPrice) FROM Sales), 2) AS RevenuePercentage
FROM Sales
GROUP BY Category;


SELECT s.SaleID, s.Product, s.Category, s.QuantitySold, s.UnitPrice, s.SaleDate,
       s.Region, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
ORDER BY s.SaleID;


SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL;


SELECT c.CustomerID, c.CustomerName,
       SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRevenue DESC;


SELECT TOP 1 c.CustomerID, c.CustomerName,
       SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRevenue DESC;

SELECT c.CustomerID, c.CustomerName,
       COUNT(s.SaleID) AS TotalSalesTransactions,
       SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRevenue DESC;


SELECT DISTINCT p.ProductID, p.ProductName, p.Category
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;

SELECT TOP 1 ProductID, ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;

SELECT p.ProductID, p.ProductName, p.Category, p.SellingPrice
FROM Products p
JOIN (
    SELECT Category, AVG(SellingPrice) AS AvgSellingPrice
    FROM Products
    GROUP BY Category
) AS cat_avg ON p.Category = cat_avg.Category
WHERE p.SellingPrice > cat_avg.AvgSellingPrice
ORDER BY p.Category, p.SellingPrice DESC;
