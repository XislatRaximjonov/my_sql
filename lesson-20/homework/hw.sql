SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s.CustomerName
      AND MONTH(s2.SaleDate) = 3
      AND YEAR(s2.SaleDate) = 2024
);


SELECT Product
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS Sub
);


SELECT MAX(Price) AS SecondHighestSale
FROM #Sales
WHERE Price < (
    SELECT MAX(Price) FROM #Sales
);

SELECT 
    MONTH(SaleDate) AS SaleMonth,
    (SELECT SUM(Quantity) 
     FROM #Sales s2 
     WHERE MONTH(s2.SaleDate) = MONTH(s1.SaleDate)
       AND YEAR(s2.SaleDate) = YEAR(s1.SaleDate)
    ) AS TotalQuantity
FROM #Sales s1
GROUP BY MONTH(SaleDate), YEAR(SaleDate)
ORDER BY SaleMonth;

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);

SELECT
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name
ORDER BY Name;

WITH FamilyHierarchy AS (
    -- Anchor: immediate parent-child relationships
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family
    UNION ALL
    -- Recursive: find children of children
    SELECT f.PID, fh.CHID
    FROM FamilyHierarchy fh
    JOIN Family f ON fh.CHID = f.ParentId
)
SELECT PID, CHID
FROM FamilyHierarchy
ORDER BY PID, CHID;


SELECT o1.CustomerID, o1.OrderID, o1.DeliveryState, o1.Amount
FROM #Orders o1
WHERE o1.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o2.CustomerID = o1.CustomerID
        AND o2.DeliveryState = 'CA'
  )
ORDER BY o1.CustomerID, o1.OrderID;


UPDATE #residents
SET address = address + ' name=' + fullname
WHERE address NOT LIKE '%name=%';


WITH RoutesCTE AS (
    -- Anchor member: start from Tashkent
    SELECT 
        DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS RoutePath,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    -- Recursive member: extend routes
    SELECT 
        r.DepartureCity,
        r.ArrivalCity,
        CAST(rc.RoutePath + ' - ' + r.ArrivalCity AS VARCHAR(MAX)) AS RoutePath,
        rc.Cost + r.Cost AS Cost
    FROM RoutesCTE rc
    JOIN #Routes r ON rc.ArrivalCity = r.DepartureCity
    WHERE CHARINDEX(r.ArrivalCity, rc.RoutePath) = 0 -- avoid cycles
)
SELECT RoutePath AS Route, Cost
FROM RoutesCTE
WHERE ArrivalCity = 'Khorezm'
AND Cost = (SELECT MIN(Cost) FROM RoutesCTE WHERE ArrivalCity = 'Khorezm')
   OR Cost = (SELECT MAX(Cost) FROM RoutesCTE WHERE ArrivalCity = 'Khorezm')
ORDER BY Cost;


WITH Changes AS (
    SELECT *,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
            OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS GroupRank
    FROM #RankingPuzzle
)
SELECT ID, Vals, GroupRank
FROM Changes
ORDER BY ID;


SELECT e.EmployeeID, e.EmployeeName, e.Department, e.SalesAmount, e.SalesMonth, e.SalesYear
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);


SELECT e1.EmployeeID, e1.EmployeeName, e1.Department, e1.SalesAmount, e1.SalesMonth, e1.SalesYear
FROM #EmployeeSales e1
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e1.SalesMonth
      AND e2.SalesYear = e1.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING MAX(e2.SalesAmount) = e1.SalesAmount
);


SELECT e1.EmployeeID, e1.EmployeeName
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth, SalesYear FROM #EmployeeSales) AS m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales e2
        WHERE e2.EmployeeID = e1.EmployeeID
          AND e2.SalesMonth = m.SalesMonth
          AND e2.SalesYear = m.SalesYear
    )
);

SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);



SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);

SELECT p1.Name, p1.Category, p1.Price
FROM Products p1
WHERE Price > (
    SELECT AVG(Price)
    FROM Products p2
    WHERE p2.Category = p1.Category
);

SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;


SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);


SELECT Name
FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM Orders);

SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQuantity DESC;

