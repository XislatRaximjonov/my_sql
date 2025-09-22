--Katta hajmdagi ma’lumotlarni tezda jadvalga import qilish.

--Qo‘lda INSERT orqali satrma-satr kiritishdan ko‘ra ancha tez ishlaydi.

--Fayllardan (masalan, eksport qilingan loglar, boshqa dasturlardan kelgan CSV ma’lumotlari) to‘g‘ridan-to‘g‘ri SQL jadvaliga yuklash imkonini beradi.

--Afzalliklari:

--Juda katta hajmdagi ma’lumotlarni (millionlab satr) qisqa vaqtda yuklaydi.

--Qo‘shimcha vositalarsiz SQL Server ichida ishlaydi.

--SQL Serverga BULK INSERT, bcp, yoki SQL Server Import/Export Wizard orqali ma’lumot yuklashda ishlatiladigan asosiy fayl formatlari:

--CSV (Comma-Separated Values) – ustunlar vergul bilan ajratilgan matn fayllari.

--TXT (Plain Text / Delimited Text) – ustunlar tab (\t), vergul yoki boshqa belgi bilan ajratilgan oddiy matn fayllari.

--XML (eXtensible Markup Language) – ma’lumotlarni tuzilgan ko‘rinishda import qilish mumkin.

--Native Format (SQL Server bcp format files) – SQL Server’ning o‘ziga xos binary yoki format fayllari, ular yordamida tez va aniq yuklash amalga oshiriladi.

CREATE TABLE Mahsulotlar (
    ProductID INT PRIMARY KEY,        
    ProductName VARCHAR(50) NOT NULL, 
    Narx DECIMAL(10,2) NOT NULL        
);
INSERT INTO Mahsulotlar (ProductID, ProductName, Narx)
VALUES 
(1, 'Olma', 2500.00),
(2, 'Banan', 18000.50),
(3, 'Apelsin', 12000.75);


--NULL

--NULL – qiymat mavjud emasligini bildiradi (bo‘sh).

--Bu "0" yoki "bo‘sh string" ('') emas, balki noma’lum / yo‘q qiymat.

--Agar ustun NULL deb e’lon qilingan bo‘lsa, unga qiymat kiritilmasa ham bo‘ladi.

--NOT NULL

--NOT NULL – qiymat majburiy ekanligini bildiradi.

--Har doim ma’lumot kiritilishi shart. Agar qiymat berilmasa, SQL xatolik qaytaradi.

ALTER TABLE Mahsulotlar
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

--Bir qatorli izoh

-- (--) belgisi bilan yoziladi. Shu qator oxirigacha izoh hisoblanadi.

--Ko‘p qatorli izoh

--/* ... */ orasiga yoziladi. Bir nechta qatorni qamrab olishi mumkin.

ALTER TABLE Mahsulotlar
ADD CategoryID INT NULL;


CREATE TABLE Toifalar (
    CategoryID INT PRIMARY KEY,        
    CategoryName VARCHAR(50) UNIQUE     
);

--SQL Server’da IDENTITY ustuni – bu ustun qiymatlarini avtomatik tarzda ketma-ket raqam bilan to‘ldirish uchun ishlatiladigan maxsus xususiyatdir.

--Asosiy maqsadi:

--Har bir yangi qator qo‘shilganda ustunga yangi unikal son avtomatik beriladi.

--Qo‘lda qiymat kiritish shart emas (odatda PRIMARY KEY sifatida ishlatiladi).

--Afzalliklari:

--Unique ID yaratish oson.

--Har bir yozuvni tezda aniqlash mumkin.

--PRIMARY KEY sifatida juda qulay.

BULK INSERT Mahsulotlar
FROM 'C:\Data\Mahsulotlar.txt'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 1             
);

ALTER TABLE Mahsulotlar
ADD CONSTRAINT FK_Mahsulotlar_Turkumlar
FOREIGN KEY (CategoryID) REFERENCES Toifalar(CategoryID);

--PRIMARY KEY (ASOSIY KALIT):

--Jadvaldagi har bir satrni noyob aniqlash uchun ishlatiladi.

--NULL qiymatlarga ruxsat bermaydi.

--Har bir jadvalda faqat bitta PRIMARY KEY bo‘lishi mumkin (lekin u bir nechta ustunlardan iborat bo‘lishi mumkin – composite key).

--Avtomatik ravishda clustered index yaratadi (agar boshqa clustered index mavjud bo‘lmasa).

--UNIQUE KEY (UNIKAL KALIT):

--Ustun qiymatlarining takrorlanmasligini ta’minlaydi.

--NULL qiymatlarga ruxsat beradi (lekin har bir UNIQUE ustunda odatda bitta NULL bo‘lishi mumkin).

--Jadvalda bir nechta UNIQUE constraint bo‘lishi mumkin.

--Avtomatik ravishda non-clustered index yaratadi.

ALTER TABLE Mahsulotlar
ADD CONSTRAINT CHK_Mahsulotlar_Narx_Plus
CHECK (Narx > 0);
        
ALTER TABLE Mahsulotlar
ADD Birja INT NOT NULL DEFAULT 0;  

UPDATE Mahsulotlar
SET Narx = ISNULL(Narx, 0);


--Xulosa: FOREIGN KEY – jadvallar orasidagi aloqani mustahkamlaydi va ma’lumotlar bazasidagi “xato yozuvlar” paydo bo‘lishini oldini oladi.


CREATE TABLE Mijozlar (
    MijozID INT PRIMARY KEY,            -- Asosiy kalit
    FIO VARCHAR(100) NOT NULL,          -- Mijozning F.I.O
    Yosh INT NOT NULL,                  -- Yosh ustuni
    CONSTRAINT CHK_Mijozlar_Yosh CHECK (Yosh >= 18)  -- Yosh 18 dan katta yoki teng bo‘lishi shart
);

CREATE TABLE MisolJadval (
    ID INT IDENTITY(100,10) PRIMARY KEY,   -- 100 dan boshlanadi, 10 ga oshib boradi
    Nomi VARCHAR(50) NOT NULL
);

INSERT INTO MisolJadval (Nomi) VALUES ('Birinchi');
INSERT INTO MisolJadval (Nomi) VALUES ('Ikkinchi');
INSERT INTO MisolJadval (Nomi) VALUES ('Uchinchi');


CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (1, 101, 2, 2500.00);

--Agar expression NULL bo‘lsa, o‘rniga replacement_value qaytaradi.

--Aks holda, asl qiymatni qaytaradi.
--Berilgan ifodalardan birinchi NULL bo‘lmagan qiymatni qaytaradi.

--Bir nechta alternativa qiymatlarni ketma-ket ko‘rsatishga imkon beradi.


CREATE TABLE Xodimlar (
    EmpID INT PRIMARY KEY,                -- Asosiy kalit
    FIO VARCHAR(100) NOT NULL,            -- Xodimning F.I.O
    Email VARCHAR(100) UNIQUE NOT NULL,   -- UNIQUE kalit (takrorlanmas)
    Lavozim VARCHAR(50) NULL              -- Ixtiyoriy ustun
);

INSERT INTO Xodimlar (EmpID, FIO, Email, Lavozim)
VALUES 
(1, 'Aliyev Anvar', 'anvar.aliyev@example.com', 'Dasturchi'),
(2, 'Karimova Dilnoza', 'dilnoza.karimova@example.com', 'HR');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL
);
CREATE TABLE OrderDetailss (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

select * from OrderDetailss
select * from Xodimlar
select * from OrderDetails
select * from MisolJadval 
select * from Mijozlar
select * from Toifalar
select * from Mahsulotlar
