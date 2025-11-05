CREATE PROCEDURE usp_CalculateEmployeeBonus
AS
BEGIN
    -- Create temporary table
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Insert calculated data into temp table
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * b.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus b ON e.Department = b.Department;

    -- Select all data from the temp table
    SELECT * FROM #EmployeeBonus;
END;

EXEC usp_CalculateEmployeeBonus;

CREATE PROCEDURE usp_UpdateDepartmentSalary
    @DeptName NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- Update salaries
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @DeptName;

    -- Return updated employees
    SELECT EmployeeID, FirstName, LastName, Department, Salary
    FROM Employees
    WHERE Department = @DeptName;
END;

EXEC usp_UpdateDepartmentSalary 'Sales', 10;

MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

-- Update existing products if data has changed
WHEN MATCHED AND 
     (target.ProductName <> source.ProductName OR target.Price <> source.Price)
THEN
    UPDATE SET
        target.ProductName = source.ProductName,
        target.Price = source.Price

-- Insert new products if they do not exist
WHEN NOT MATCHED BY TARGET
THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

-- Delete products from current if missing in new
WHEN NOT MATCHED BY SOURCE
THEN
    DELETE;

-- Optional: output the changes (not required)
-- OUTPUT $action, inserted.*, deleted.*;
;


SELECT * FROM Products_Current ORDER BY ProductID;


SELECT 
    t.id,
    CASE 
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN c.id IS NULL THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t
LEFT JOIN Tree c ON t.id = c.p_id
GROUP BY t.id, t.p_id, c.id
ORDER BY t.id;


SELECT 
    s.user_id,
    COALESCE(
        SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) / NULLIF(COUNT(c.user_id), 0),
        0
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;

SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

SELECT MIN(salary) FROM employees


CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;

EXEC GetProductSalesSummary @ProductID = 1;


