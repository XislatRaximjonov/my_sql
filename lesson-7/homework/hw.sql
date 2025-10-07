
SELECT MIN(Price) AS MinimalNarx
FROM Mahsulotlar;

SELECT MAX(Salary) AS MaksimalIshHaqi
FROM Xodimlar;

SELECT COUNT(*) AS QatorlarSoni
FROM Mijozlar;

SELECT COUNT(DISTINCT Category) AS NoyobToifalarSoni
FROM Mahsulotlar;

SELECT SUM(Quantity) AS UmumiySotilganMiqdor
FROM Savdo
WHERE ProductID = 7;

SELECT AVG(Age) AS OrtachaYosh
FROM Xodimlar;

SELECT Department, COUNT(*) AS XodimlarSoni
FROM Xodimlar
GROUP BY Department;

SELECT 
    Category,
    MIN(Price) AS MinimalNarx,
    MAX(Price) AS MaksimalNarx
FROM Mahsulotlar
GROUP BY Category;

SELECT CustomerID, SUM(Amount) AS JamiSotuv
FROM Savdo
GROUP BY CustomerID;

SELECT DeptID, COUNT(*) AS XodimlarSoni
FROM Xodimlar
GROUP BY DeptID
HAVING COUNT(*) > 5;

SELECT 
    Category,
    SUM(Quantity * Price) AS JamiSotuv,
    AVG(Quantity * Price) AS OrtachaSotuv
FROM Savdo
GROUP BY Category;

SELECT COUNT(*) AS KadrlarXodimlariSoni
FROM Xodimlar
WHERE Department = 'Kadrlar';

SELECT 
    DeptName,
    MAX(Salary) AS EngYuqoriIshHaqi,
    MIN(Salary) AS EngPastIshHaqi
FROM Xodimlar
GROUP BY DeptName;

SELECT 
    DeptName,
    AVG(Salary) AS OrtachaIshHaqi
FROM Xodimlar
GROUP BY DeptName;

SELECT 
    DeptName,
    AVG(Salary) AS OrtachaMaosh,
    COUNT(*)   AS XodimlarSoni
FROM Xodimlar
GROUP BY DeptName;

SELECT 
    Category,
    AVG(Price) AS OrtachaNarx
FROM Mahsulotlar
GROUP BY Category
HAVING AVG(Price) > 400;

SELECT 
    YEAR(SaleDate) AS Yil,
    SUM(Amount)    AS JamiSotuv
FROM Savdolar
GROUP BY YEAR(SaleDate)
ORDER BY Yil;

SELECT 
    CustomerID,
    COUNT(*) AS BuyurtmalarSoni
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

SELECT 
    DeptName,
    AVG(Salary) AS OrtachaMaosh
FROM Xodimlar
GROUP BY DeptName
HAVING AVG(Salary) > 60000;

SELECT 
    Category,
    AVG(Price) AS OrtachaNarx
FROM Mahsulotlar
GROUP BY Category
HAVING AVG(Price) > 150;

SELECT 
    CustomerID,
    SUM(Amount) AS JamiSotuv
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > 1500;


SELECT 
    DeptName,
    SUM(Salary) AS UmumiyIshHaqi,
    AVG(Salary) AS OrtachaIshHaqi
FROM Xodimlar
GROUP BY DeptName
HAVING AVG(Salary) > 65000;

SELECT 
    CustomerID,
    MIN(Amount) AS EngKamXarid,
    SUM(CASE WHEN Weight > 50 THEN Amount ELSE 0 END) AS Ogirligi50danOrtiqUmumiy
FROM Orders
GROUP BY CustomerID;

SELECT 
    YEAR(OrderDate)  AS Yil,
    MONTH(OrderDate) AS Oy,
    SUM(Amount)      AS JamiSotuv,
    COUNT(DISTINCT ProductID) AS NoyobMahsulotlar
FROM Buyurtmalar
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
ORDER BY Yil, Oy;

SELECT 
    YEAR(OrderDate) AS Yil,
    MIN(Quantity)   AS EngKamBuyurtma,
    MAX(Quantity)   AS EngKattaBuyurtma
FROM Buyurtmalar
GROUP BY YEAR(OrderDate)
ORDER BY Yil;


















