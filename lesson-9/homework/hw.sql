SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;

SELECT 
    d.DepartmentName,
    e.EmpName
FROM Departments d
CROSS JOIN Employees e;

SELECT 
    s.SupplierName,
    p.ProductName
FROM Products p
INNER JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID;

SELECT 
    c.CustomerName,
    o.OrderID
FROM Orders o
INNER JOIN Customers c 
    ON o.CustomerID = c.CustomerID;

SELECT 
    c.CourseName,
    s.StudentName
FROM Courses c
CROSS JOIN Students s;

SELECT 
    p.ProductName,
    o.OrderID
FROM Products p
INNER JOIN Orders o 
    ON p.ProductID = o.ProductID;


SELECT 
    e.EmpName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID;

SELECT 
    s.StudentName,
    e.CourseID
FROM Students s
INNER JOIN Enrollments e 
    ON s.StudentID = e.StudentID;

SELECT 
    o.OrderID,
    p.PaymentID,
    p.Amount
FROM Orders o
INNER JOIN Payments p 
    ON o.OrderID = p.OrderID;

SELECT 
    o.OrderID,
    p.ProductName,
    p.Price
FROM Orders o
INNER JOIN Products p 
    ON o.ProductID = p.ProductID
WHERE p.Price > 100;

SELECT 
    e.EmpName,
    d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID;

SELECT 
    o.OrderID,
    p.ProductName,
    o.Quantity,
    p.Stock
FROM Orders o
INNER JOIN Products p 
    ON o.ProductID = p.ProductID
WHERE o.Quantity > p.Stock;

SELECT 
    c.CustomerName,
    s.ProductID,
    s.Amount
FROM Sales s
INNER JOIN Customers c 
    ON s.CustomerID = c.CustomerID
WHERE s.Amount >= 500;

SELECT 
    st.StudentName,
    c.CourseName
FROM Enrollments e
INNER JOIN Students st 
    ON e.StudentID = st.StudentID
INNER JOIN Courses c 
    ON e.CourseID = c.CourseID;

SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
INNER JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';

SELECT 
    o.OrderID,
    o.TotalAmount,
    p.Amount AS PaymentAmount
FROM Orders o
INNER JOIN Payments p 
    ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount;

SELECT 
    e.EmpName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID;

SELECT 
    p.ProductName,
    c.CategoryName
FROM Products p
INNER JOIN Categories c 
    ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

SELECT 
    s.SaleID,
    c.CustomerName,
    c.Country,
    s.ProductID,
    s.Amount
FROM Sales s
INNER JOIN Customers c 
    ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';


SELECT 
    o.OrderID,
    c.CustomerName,
    c.Country,
    o.TotalAmount
FROM Orders o
INNER JOIN Customers c 
    ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany'
  AND o.TotalAmount > 100;


SELECT 
    e1.EmpName AS Employee1,
    e2.EmpName AS Employee2
FROM Employees e1
JOIN Employees e2 
    ON e1.EmpID < e2.EmpID   -- o‘zini o‘zi juftlamaslik va dublikatni oldini olish uchun
   AND e1.DepartmentID <> e2.DepartmentID;


SELECT 
    p.PaymentID,
    o.OrderID,
    pr.ProductName,
    o.Quantity,
    pr.Price,
    p.Amount AS PaidAmount
FROM Payments p
JOIN Orders o 
    ON p.OrderID = o.OrderID
JOIN Products pr 
    ON o.ProductID = pr.ProductID
WHERE p.Amount <> (o.Quantity * pr.Price);


SELECT 
    s.StudentID,
    s.StudentName
FROM Students s
LEFT JOIN Enrollments e 
    ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL;


SELECT 
    m.EmpName AS Manager,
    m.Salary AS ManagerSalary,
    e.EmpName AS Employee,
    e.Salary AS EmployeeSalary
FROM Employees m
JOIN Employees e 
    ON m.EmpID = e.ManagerID
WHERE m.Salary <= e.Salary;


SELECT DISTINCT
    c.CustomerID,
    c.CustomerName,
    o.OrderID
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID
LEFT JOIN Payments p 
    ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

