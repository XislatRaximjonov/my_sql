-- 1️⃣ Regionlar ro‘yxatini olamiz
WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
-- 2️⃣ Distributorlar ro‘yxatini olamiz
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
-- 3️⃣ Har bir Region + Distributor kombinatsiyasi yaratamiz
SELECT 
    r.Region,
    d.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales rs
    ON rs.Region = r.Region 
   AND rs.Distributor = d.Distributor
ORDER BY d.Distributor, r.Region;


SELECT e.name
FROM Employee e
JOIN Employee m
    ON e.id = m.managerId
GROUP BY e.id, e.name
HAVING COUNT(m.id) >= 5;

SELECT 
    p.product_name,
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o 
    ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


SELECT CustomerID, Vendor
FROM (
    SELECT 
        CustomerID,
        Vendor,
        SUM([Count]) AS TotalOrders,
        RANK() OVER (PARTITION BY CustomerID ORDER BY SUM([Count]) DESC) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
) AS ranked
WHERE rnk = 1;


SELECT 
    d.Device_id,
    COUNT(DISTINCT d.Locations) AS no_of_location,
    (
        SELECT dd.Locations
        FROM Device dd
        WHERE dd.Device_id = d.Device_id
        GROUP BY dd.Locations
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS max_signal_location,
    COUNT(*) AS no_of_signals
FROM Device d
GROUP BY d.Device_id;


SELECT 
    e.EmpID,
    e.EmpName,
    e.Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);


SELECT 
    SUM(
        CASE 
            WHEN match_count = total_winning THEN 100   -- all numbers matched
            WHEN match_count > 0 THEN 10                -- partial match
            ELSE 0                                      -- no match
        END
    ) AS total_winnings
FROM (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS ticket_numbers,
        COUNT(DISTINCT n.Number) AS total_winning,
        COUNT(DISTINCT CASE WHEN t.Number = n.Number THEN t.Number END) AS match_count
    FROM Tickets t
    CROSS JOIN (SELECT COUNT(*) AS total_winning FROM Numbers) tw
    LEFT JOIN Numbers n 
        ON t.Number = n.Number
    GROUP BY t.TicketID, tw.total_winning
) sub;


SELECT 
    Spend_date,
    User_id,
    SUM(Amount) AS Total_Amount,
    COUNT(DISTINCT Platform) AS Platform_Count,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS Used_Mobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS Used_Desktop
FROM Spending
GROUP BY Spend_date, User_id;


DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);

INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

