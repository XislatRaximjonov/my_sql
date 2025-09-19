CREATE TABLE Xodimlar (
    EmpID INT PRIMARY KEY,
    Ism VARCHAR(50),
    IshHaqi DECIMAL(10,2)
);

INSERT INTO Xodimlar (EmpID, Ism, IshHaqi)
VALUES (1, 'Ali', 2500.00);

INSERT INTO Xodimlar (EmpID, Ism, IshHaqi)
VALUES (2, 'Dilshod', 3200.50);

INSERT INTO Xodimlar (EmpID, Ism, IshHaqi)
VALUES (3, 'Malika', 4100.75);

INSERT INTO Xodimlar (EmpID, Ism, IshHaqi)
VALUES 
(4, 'Javohir', 2800.00),
(5, 'Sevinch', 3500.25),
(6, 'Rustam', 4000.00);

UPDATE Xodimlar
SET IshHaqi = 7000.00
WHERE EmpID = 1;

DELETE FROM Xodimlar
WHERE EmpID = 2;

--DELETE

--Vazifasi: Jadvaldagi ma’lumotlarni o‘chirish.

--Xususiyatlari:

--WHERE sharti bilan faqat kerakli qatorlarni o‘chirsa bo‘ladi.

--Tranzaksiya qo‘llab-quvvatlanadi (ya’ni ROLLBACK qilish mumkin).

--Jadvalning tuzilishi va ustunlari o‘zgarishsiz qoladi.


--TRUNCATE

--Vazifasi: Jadvaldagi barcha ma’lumotlarni tezda o‘chirish.

--Xususiyatlari:

--WHERE ishlatib bo‘lmaydi → faqat hamma qatorni o‘chiradi.

--IDENTITY ustunlari qayta 1 dan boshlanadi.

--Jadvalning tuzilishi saqlanib qoladi.

--DROP

--Vazifasi: Butunlay jadvalni (yoki bazani) o‘chiradi.

--Xususiyatlari:

--Na faqat ma’lumotlar, balki jadvalning o‘zi ham yo‘q bo‘ladi.

--Qayta ishlatish uchun jadvalni boshidan CREATE TABLE bilan yaratish kerak bo‘ladi.

ALTER TABLE Xodimlar
ALTER COLUMN Ism VARCHAR(100);

ALTER TABLE Xodimlar
ADD Bolim VARCHAR(50);

ALTER TABLE Xodimlar
ALTER COLUMN IshHaqi float;

CREATE TABLE Bolimlar (
    DepartamentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
    );

DELETE FROM Xodimlar;

INSERT INTO Bolimlar (DepartamentID, DepartmentName)
SELECT 1, 'IT'
UNION ALL
SELECT 2, 'HR'
UNION ALL
SELECT 3, 'Marketing'
UNION ALL
SELECT 4, 'Sales'
UNION ALL
SELECT 5, 'Finance';

ALTER TABLE Xodimlar
DROP COLUMN Bolim;

EXEC sp_rename 'Xodimlar', 'StaffMembers';

DROP TABLE Bolimlar;

CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(100),
    Kategoriya VARCHAR(50),
    Narx DECIMAL(10,2),
    Soni INT
);

ALTER TABLE Mahsulotlar
ADD CONSTRAINT chk_Narx_Plus CHECK (Narx > 0);

ALTER TABLE Mahsulotlar
ADD StockQuantity INT DEFAULT 50;


EXEC sp_rename 'Mahsulotlar.Kategoriya', 'ProductCategory', 'COLUMN';

INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, Soni, StockQuantity)
VALUES (1, 'Noutbuk', 'Elektronika', 8500.00, 10, 50);

INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, Soni, StockQuantity)
VALUES (2, 'Smartfon', 'Elektronika', 4500.00, 25, 50);

INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, Soni, StockQuantity)
VALUES (3, 'Stol', 'Mebel', 1200.00, 15, 50);

INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, Soni, StockQuantity)
VALUES (4, 'Kreslo', 'Mebel', 2200.00, 8, 50);

INSERT INTO Mahsulotlar (ProductID, MahsulotNomi, ProductCategory, Narx, Soni, StockQuantity)
VALUES (5, 'Sovutkich', 'Maishiy texnika', 9800.00, 5, 50);

SELECT *
INTO Products_Backup
FROM Mahsulotlar;

EXEC sp_rename 'Mahsulotlar', 'Inventar';

ALTER TABLE Inventar
ALTER COLUMN Narx FLOAT;

select * from Inventar
select * from StaffMembers
