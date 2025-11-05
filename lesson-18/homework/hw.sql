-- Create a temporary table
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(10,2)
);

-- Insert data for the current month
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE MONTH(s.SaleDate) = MONTH(GETDATE())
  AND YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID;

-- Return the result
SELECT ProductID, TotalQuantity, TotalRevenue
FROM #MonthlySales;


CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;


CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;

SELECT dbo.fn_GetTotalRevenueForProduct(1) AS TotalRevenue;


CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);

SELECT * FROM dbo.fn_GetSalesByCategory('Electronics');


CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;  -- Assume prime until proven otherwise

    -- Numbers less than 2 are not prime
    IF @Number < 2
        SET @IsPrime = 0;
    ELSE
    BEGIN
        WHILE @i <= SQRT(@Number)
        BEGIN
            IF @Number % @i = 0
            BEGIN
                SET @IsPrime = 0;
                BREAK;
            END
            SET @i = @i + 1;
        END
    END

    IF @IsPrime = 1
        RETURN 'Yes';
    ELSE
        RETURN 'No';
END;

SELECT dbo.fn_IsPrime(2) AS Result;   -- Yes
SELECT dbo.fn_IsPrime(4) AS Result;   -- No
SELECT dbo.fn_IsPrime(17) AS Result;  -- Yes
SELECT dbo.fn_IsPrime(20) AS Result;  -- No


CREATE FUNCTION dbo.fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers (Number)
        VALUES (@i);
        SET @i = @i + 1;
    END

    RETURN;
END;

SELECT * FROM dbo.fn_GetNumbersBetween(5, 10);


CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        OFFSET @N - 1 ROWS FETCH NEXT 1 ROWS ONLY
    );
END;

SELECT dbo.getNthHighestSalary(2) AS HighestNSalary;


SELECT TOP 1
    id,
    COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY COUNT(*) DESC;


CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

SELECT * FROM vw_CustomerOrderSummary;


SELECT 
    g.RowNumber,
    COALESCE(g.TestCase, (
        SELECT TOP 1 g2.TestCase
        FROM Gaps g2
        WHERE g2.RowNumber < g.RowNumber
          AND g2.TestCase IS NOT NULL
        ORDER BY g2.RowNumber DESC
    )) AS Workflow
FROM Gaps g
ORDER BY g.RowNumber;






