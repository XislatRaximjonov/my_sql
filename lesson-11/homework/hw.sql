SELECT 
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderDate
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022;

SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');


SELECT 
    d.DepartmentName,
    MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees e 
    ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND YEAR(o.OrderDate) = 2023;


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;


SELECT 
    p.ProductName,
    s.SaleDate,
    s.Amount AS SaleAmount
FROM Sales s
JOIN Products p 
    ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022
   OR s.Amount > 400;


SELECT 
    p.ProductName,
    SUM(s.Amount) AS TotalSalesAmount
FROM Products p
JOIN Sales s 
    ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName;


SELECT 
    e.EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR'
  AND e.Salary > 60000;


SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p 
    ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023
  AND p.StockQuantity > 100;

SELECT 
    e.EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales'
   OR YEAR(e.HireDate) > 2020;


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND c.Address REGEXP '^[0-9]{4}';


SELECT 
    p.ProductName,
    p.Category,
    s.Amount AS SaleAmount
FROM Products p
JOIN Sales s 
    ON p.ProductID = s.ProductID
WHERE p.Category = 'Electronics'
   OR s.Amount > 350;


SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p 
    ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;


SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.City,
    o.OrderID,
    o.Amount
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles'
  AND o.Amount > 300;


SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('HR', 'Finance')
   OR LENGTH(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(e.EmployeeName),'a',''),'e',''),'i',''),'o',''),'u','')) 
      <= LENGTH(e.EmployeeName) - 4;


SELECT 
    e.EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
  AND e.Salary > 60000;
