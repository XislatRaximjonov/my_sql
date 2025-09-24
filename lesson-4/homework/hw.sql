CREATE TABLE Xodimlar (
    XodimID INT PRIMARY KEY IDENTITY(1,1),  -- SQL Server uchun (MySQLda AUTO_INCREMENT)
    FIO NVARCHAR(100) NOT NULL,
    Lavozim NVARCHAR(50),
    IshHaqqi DECIMAL(10,2)
);

INSERT INTO Xodimlar (FIO, Lavozim, IshHaqqi) VALUES
('Ali Karimov', 'Dasturchi', 5000),
('Dilshod Umarov', 'Muhandis', 4500),
('Malika Yusupova', 'Boshqaruvchi', 7000),
('Javlon Shodmonov', 'Dizayner', 4000),
('Shahnoza Rahimova', 'Analitik', 4800),
('Bobur Qodirov', 'Arxitektor', 6500),
('Gulbahor Ismoilova', 'HR', 3500),
('Rustam Eshmatov', 'DevOps', 6000);

SELECT TOP 5 XodimID, FIO, Lavozim, IshHaqqi
FROM Xodimlar
ORDER BY IshHaqqi DESC;

DROP TABLE Mahsulotlar
CREATE TABLE Mahsulotlar (
    MahsulotID INT PRIMARY KEY IDENTITY(1,1), 
    Nomi NVARCHAR(100) NOT NULL,
    Turkum NVARCHAR(50),
    Narx DECIMAL(10,2)
);
INSERT INTO Mahsulotlar (Nomi, Turkum, Narx) VALUES
('iPhone 13', 'Telefon', 900),
('Galaxy S21', 'Telefon', 850),
('MacBook Pro', 'Laptop', 2000),
('ThinkPad X1', 'Laptop', 1800),
('Dell XPS 13', 'Laptop', 1500),
('Sony Bravia 55', 'Televizor', 1100),
('LG OLED 65', 'Televizor', 1300),
('Canon EOS 90D', 'Kamera', 1200);
SELECT DISTINCT Turkum
FROM Mahsulotlar;

SELECT MahsulotID, Nomi, Turkum, Narx
FROM Mahsulotlar
WHERE Narx > 100;


DROP TABLE Mijozlar

CREATE TABLE Mijozlar (
    MijozID INT PRIMARY KEY IDENTITY(1,1), 
    Ismi NVARCHAR(50) NOT NULL,
    Familiya NVARCHAR(50),
    Telefon NVARCHAR(20)
);
INSERT INTO Mijozlar (Ismi, Familiya, Telefon) VALUES
('Ali', 'Karimov', '+998901112233'),
('Aziz', 'Raximov', '+998907778899'),
('Anvar', 'Qodirov', '+998935556677'),
('Behruz', 'Usmonov', '+998994445566'),
('Dilshod', 'Abdullayev', '+998935551122'),
('Akmal', 'Xolmatov', '+998907771122');

SELECT MijozID, Ismi, Familiya, Telefon
FROM Mijozlar
WHERE Ismi LIKE 'A%';

SELECT MahsulotID, Nomi, Turkum, Narx
FROM Mahsulotlar
ORDER BY Narx ASC;
DROP TABLE Xodimlar

CREATE TABLE Xodimlar (
    XodimID INT PRIMARY KEY IDENTITY(1,1), 
    Ismi NVARCHAR(50) NOT NULL,
    Familiya NVARCHAR(50),
    IshHaqi DECIMAL(10,2),
    DepartamentName NVARCHAR(50)
);

INSERT INTO Xodimlar (Ismi, Familiya, IshHaqi, DepartamentName) VALUES
('Ali', 'Karimov', 75000, 'HR'),
('Aziz', 'Raximov', 55000, 'IT'),
('Anvar', 'Qodirov', 62000, 'HR'),
('Dilshod', 'Abdullayev', 80000, 'Marketing'),
('Madina', 'Islomova', 65000, 'HR'),
('Sardor', 'Xolmatov', 45000, 'HR');


SELECT XodimID, Ismi, Familiya, IshHaqi, DepartamentName
FROM Xodimlar
WHERE IshHaqi >= 60000
  AND DepartamentName = 'HR';

  CREATE TABLE hodimlar (
    XodimID INT PRIMARY KEY IDENTITY(1,1), 
    Ismi NVARCHAR(50) NOT NULL,
    Familiya NVARCHAR(50),
    IshHaqi DECIMAL(10,2),
    DepartamentName NVARCHAR(50),
    Email NVARCHAR(100) NULL
);

INSERT INTO hodimlar (Ismi, Familiya, IshHaqi, DepartamentName, Email) VALUES
('Ali', 'Karimov', 75000, 'HR', 'ali.karimov@example.com'),
('Aziz', 'Raximov', 55000, 'IT', NULL),
('Anvar', 'Qodirov', 62000, 'HR', 'anvar.qodirov@example.com'),
('Dilshod', 'Abdullayev', 80000, 'Marketing', NULL),
('Madina', 'Islomova', 65000, 'HR', NULL);

SELECT XodimID, Ismi, Familiya, 
       ISNULL(Email, 'noemail@example.com') AS Email,
       IshHaqi, DepartamentName
FROM hodimlar;

SELECT MahsulotID, Nomi, Turkum, Narx
FROM Mahsulotlar
WHERE Narx BETWEEN 50 AND 100;

SELECT DISTINCT Category, ProductName
FROM Mahsulotlar;

SELECT DISTINCT Category, ProductName
FROM Mahsulotlar
ORDER BY ProductName DESC;

SELECT TOP 10 *
FROM Mahsulotlar
ORDER BY Price DESC;

SELECT XodimID,
       COALESCE(FirstName, Familiya) AS Toqimalar
FROM Xodimlar;

SELECT DISTINCT Turkum, Narx
FROM Mahsulotlar;



CREATE TABLE Xodimlarr (
    XodimID INT PRIMARY KEY ,  
    Ismi VARCHAR(50),
    Familiya VARCHAR(50),
    Yoshi INT,
    DepartamentName VARCHAR(50),
    IshHaqi DECIMAL(10,2)
);

INSERT INTO Xodimlarr ( Ismi, Familiya, Yoshi, DepartamentName, IshHaqi) VALUES
('Ali',    'Karimov', 28, 'IT',        55000),
('Aziza',  'Saidova', 32, 'HR',        60000),
('Bekzod', 'Rustamov', 35, 'Finance',  70000),
('Dilshod','Niyazov', 41, 'Marketing', 65000),
('Madina', 'Tursunova', 38, 'IT',      72000),
('Javlon', 'Shukurov', 45, 'Marketing',80000),
('Anvar',  'Abdullaev',30, 'Sales',    50000);


SELECT XodimID, Ismi, Familiya, Yoshi, DepartamentName, IshHaqi
FROM Xodimlarr
WHERE (Yoshi BETWEEN 30 AND 40)
   OR (DepartamentName = 'Marketing');


   SELECT XodimID, Ismi, Familiya, IshHaqi, DepartamentName
FROM Xodimlarr
ORDER BY IshHaqi DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;


CREATE TABLE Mahsulotlarr (
    MahsulotID INT IDENTITY(1,1) PRIMARY KEY,
    Nomi NVARCHAR(100),
    Turkum NVARCHAR(50),
    Narx DECIMAL(10,2),
    StokMiqdori INT
);
INSERT INTO Mahsulotlarr (Nomi, Turkum, Narx, StokMiqdori) VALUES
('iPhone 13',     'Telefon', 900, 30),
('Galaxy S21',    'Telefon', 850, 70),
('MacBook Pro',   'Laptop', 2000, 15),
('ThinkPad X1',   'Laptop', 1800, 20),
('Dell Inspiron', 'Laptop', 950, 80),
('Sony TV 55"',   'TV', 1100, 60),
('LG Monitor',    'Monitor', 300, 120),
('Canon Camera',  'Camera', 750, 55),
('AirPods Pro',   'Aksesuar', 250, 200),
('Logitech Mouse','Aksesuar', 40, 500);


SELECT MahsulotID, Nomi, Turkum, Narx, StokMiqdori
FROM Mahsulotlarr
WHERE Narx <= 1000
  AND StokMiqdori > 50
ORDER BY StokMiqdori ASC;

CREATE TABLE Mahsulotlarrr (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Mahsulotlarrr (ProductID, ProductName, Category, Price) VALUES
(1, 'iPhone 13', 'Phone', 900),
(2, 'Galaxy S21', 'Phone', 850),
(3, 'MacBook Pro', 'Laptop', 2000),
(4, 'ThinkPad X1', 'Laptop', 1800),
(5, 'Dell Inspiron', 'Laptop', 1200),
(6, 'Sony TV', 'TV', 1100),
(7, 'LG Monitor', 'Monitor', 400),
(8, 'Headset Pro', 'Accessory', 150);

SELECT ProductID, ProductName, Category, Price
FROM Mahsulotlarrr
WHERE ProductName LIKE '%e%';

SELECT XodimID, Ismi, Familiya, DepartamentName, IshHaqi
FROM Xodimlar
WHERE DepartamentName IN ('HR', 'IT', 'Moliya');

CREATE TABLE Mijozlarr (
    MijozID INT PRIMARY KEY,
    Ismi VARCHAR(50),
    Shahar VARCHAR(50),
    PochtaIndeksi VARCHAR(10)
);

INSERT INTO Mijozlarr (MijozID, Ismi, Shahar, PochtaIndeksi) VALUES
(1, 'Ali',     'Toshkent', '100011'),
(2, 'Aziza',   'Samarqand','140100'),
(3, 'Bekzod',  'Buxoro',   '200120'),
(4, 'Dilnoza', 'Toshkent', '100200'),
(5, 'Javlon',  'Andijon',  '170110'),
(6, 'Malika',  'Samarqand','140050');


SELECT MijozID, Ismi, Shahar, PochtaIndeksi
FROM Mijozlarr
ORDER BY Shahar ASC, PochtaIndeksi DESC;

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SaleAmount INT
);


INSERT INTO Sales (SaleID, ProductName, SaleAmount) VALUES
(1, 'iPhone 13', 120),
(2, 'Galaxy S21', 95),
(3, 'MacBook Pro', 60),
(4, 'Dell Inspiron', 85),
(5, 'Sony TV', 150),
(6, 'Headset Pro', 70),
(7, 'ThinkPad X1', 55),
(8, 'LG Monitor', 90);

SELECT TOP (5) ProductName, SaleAmount
FROM Sales
ORDER BY SaleAmount DESC;


CREATE TABLE Xodimlarrr (
    XodimID INT PRIMARY KEY,
    Ism VARCHAR(50),
    Familiya VARCHAR(50),
    BoLim VARCHAR(50)
);

INSERT INTO Xodimlarrr (XodimID, Ism, Familiya, BoLim) VALUES
(1, 'Ali', 'Karimov', 'IT'),
(2, 'Dilnoza', 'Xolmatova', 'HR'),
(3, 'Javlon', 'Rahimov', 'Moliya');

SELECT 
    Ism + ' ' + Familiya AS ToliqIsm,
    BoLim
FROM Xodimlarrr;


CREATE TABLE Mahsulotlarrrr (
    MahsulotID INT PRIMARY KEY,
    MahsulotNomi VARCHAR(100),
    Turkum VARCHAR(50),
    Narx DECIMAL(10,2)
);

INSERT INTO Mahsulotlarrrr (MahsulotID, MahsulotNomi, Turkum, Narx) VALUES
(1, 'iPhone 13', 'Telefon', 900),
(2, 'Galaxy S21', 'Telefon', 850),
(3, 'MacBook Pro', 'Laptop', 2000),
(4, 'ThinkPad X1', 'Laptop', 1800),
(5, 'Dell Inspiron', 'Laptop', 1200),
(6, 'Sony TV 55"', 'TV', 1100),
(7, 'LG Monitor', 'Monitor', 300),
(8, 'Headset Pro', 'Aksessuar', 70),
(9, 'Headset Pro', 'Aksessuar', 70); -- takroriy yozuv


SELECT DISTINCT 
    Turkum, 
    MahsulotNomi, 
    Narx
FROM Mahsulotlarrrr
WHERE Narx > 50;

SELECT MahsulotID, Nomi, Turkum, Narx
FROM Mahsulotlar
WHERE Narx < (
    SELECT AVG(Narx) * 0.10
    FROM Mahsulotlar
);

SELECT XodimID, Ism, Familiya, Yosh, Bolim
FROM Xodimlar
WHERE Yosh < 30
  AND Bolim IN ('HR', 'IT');

  CREATE TABLE Mijozlarrr (
    MijozID INT PRIMARY KEY,
    Ism VARCHAR(50),
    Familiya VARCHAR(50),
    Email VARCHAR(100)
);

INSERT INTO Mijozlarrr (MijozID, Ism, Familiya, Email) VALUES
(1, 'Ali', 'Karimov', 'ali.karimov@gmail.com'),
(2, 'Dilshod', 'Rasulov', 'dilshod_r@mail.ru'),
(3, 'Malika', 'Sharipova', 'malika.sharipova@gmail.com'),
(4, 'Aziza', 'Saidova', 'aziza123@yahoo.com'),
(5, 'Javohir', 'Usmonov', 'javohir.it@gmail.com');

SELECT MijozID, Ism, Familiya, Email
FROM Mijozlarrr
WHERE Email LIKE '%@gmail.com';

