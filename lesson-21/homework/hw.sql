SELECT *, 
       ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

SELECT ProductName, SUM(Quantity) AS TotalQuantity,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS RankByQuantity
FROM ProductSales
GROUP BY ProductName;

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS t
WHERE rn = 1;

SELECT *,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

SELECT *,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales;

SELECT *,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (ORDER BY SaleDate);

SELECT *,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;

SELECT *,
       (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) / SaleAmount * 100 AS NextSalePctChange
FROM ProductSales;

SELECT *,
       SaleAmount / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS RatioToPrev
FROM ProductSales;

SELECT *,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;

SELECT *
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS t
WHERE SaleAmount > PrevAmount;

SELECT *,
       SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM ProductSales;

SELECT *,
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales;

SELECT *,
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;

SELECT *,
       DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
ORDER BY Department, Salary DESC;

SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
) AS t
WHERE SalaryRank <= 2
ORDER BY Department, Salary DESC;

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees1
) AS t
WHERE rn = 1;

SELECT *,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS UNBOUNDED PRECEDING) AS RunningTotalSalary
FROM Employees1
ORDER BY Department, HireDate;

SELECT *,
       SUM(Salary) OVER (PARTITION BY Department) AS TotalSalaryByDept
FROM Employees1;

SELECT *,
       AVG(Salary) OVER (PARTITION BY Department) AS AvgSalaryByDept
FROM Employees1;

SELECT *,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;

SELECT *,
       AVG(Salary) OVER (
           ORDER BY HireDate
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS MovingAvg3
FROM Employees1
ORDER BY HireDate;

SELECT SUM(Salary) AS SumLast3Hired
FROM (
    SELECT Salary
    FROM Employees1
    ORDER BY HireDate DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) AS t;
