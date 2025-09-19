-- Ma’lumotlar – bu faktlar, qiymatlar yoki yozuvlar bo‘lib, ular raqamlar, matnlar, sanalar, suratlar va hokazo ko‘rinishda bo‘lishi mumkin.

-- SQL nuqtayi nazaridan ma’lumotlar – bu jadval ichida saqlanadigan katakchadagi qiymatlar (masalan: ism = "Ali", yosh = 20).

-- Ma’lumotlar bazasi – bu ma’lumotlarni tartibli saqlash va boshqarish uchun mo‘ljallangan tizim.

-- SQLda ma’lumotlar bazasi – bu jadvallar, ko‘rinishlar (views), funksiyalar va boshqa obyektlarni o‘z ichiga oladigan konteyner.

-- Misol: CREATE DATABASE Maktab; → bu "Maktab" nomli yangi ma’lumotlar bazasini yaratadi.

-- Relyatsion ma’lumotlar bazasi – ma’lumotlarni jadval ko‘rinishida saqlaydigan bazadir.

-- "Relyatsion" atamasi shuni bildiradiki, jadvallar o‘zaro aloqador (relation) bo‘lishi mumkin. Masalan, "Talabalar" jadvali bilan "Fanlar" jadvali orasida bog‘lanish bo‘ladi.

-- SQL – aynan shunday relyatsion bazalarni boshqarish tili (RDBMS: MySQL, PostgreSQL, SQL Server va h.k.).

-- Jadval – bu ma’lumotlar bazasidagi asosiy obyekt bo‘lib, u qatorlar (rows, records) va ustunlardan (columns, fields) iborat.

-- Har bir qator – bitta yozuv (masalan, bitta talabani ifodalaydi).

-- Har bir ustun – ma’lumotning turi (masalan, ism, familiya, yosh).


-- 1. Relyatsion ma’lumotlar bazasini boshqarish tizimi (RDBMS)

-- SQL Server – bu relyatsion ma’lumotlarni jadvallar ko‘rinishida saqlaydi va ular orasida bog‘lanish (relationship) o‘rnatish imkonini beradi.

-- 2. Xavfsizlik va foydalanuvchilarni boshqarish

-- Login va foydalanuvchi darajalarida autentifikatsiya va avtorizatsiya.

-- Rol va ruxsatlar orqali ma’lumotlarga kirishni nazorat qilish.

-- 3. Zaxira nusxa va tiklash (Backup & Restore)

-- Ma’lumotlarni yo‘qolishdan saqlash uchun turli xil backup (to‘liq, differensial, transaction log) mexanizmlari mavjud.

-- Xatolik yuz bersa, ma’lumotlar tiklanadi.

-- 4. Yuqori unumdorlik va tranzaksiyalarni qo‘llab-quvvatlash

-- Bir vaqtning o‘zida ko‘plab foydalanuvchilar ishlay oladi.

-- Tranzaksiyalar orqali ma’lumotlar yaxlitligi (ACID tamoyillari) ta’minlanadi.

-- 5. Qo‘shimcha imkoniyatlar va kengaytiriluvchanlik

-- Stored Procedure, Trigger, View kabi obyektlar bilan murakkab amallarni bajarish.

-- Katta hajmdagi ma’lumotlarni boshqarish, analitik hisob-kitoblar qilish va boshqa tizimlar bilan integratsiya qilish imkoniyati.

-- 1. Windows Authentication

-- SQL Server foydalanuvchini Windows operatsion tizimidagi login ma’lumotlari orqali tanib oladi.

-- Alohida parol kiritish shart emas, foydalanuvchi Windows tizimiga kirgan bo‘lsa, shu login orqali SQL Server’ga ham kira oladi.

-- Afzalligi: xavfsizlik yuqori, parolni alohida saqlash talab qilinmaydi.

-- 2. SQL Server Authentication

-- Foydalanuvchi SQL Server ichida yaratilgan login va parol orqali ulanadi.

-- Masalan: sa (system administrator) loginidan foydalanish mumkin.

-- Afzalligi: har qanday mijoz dasturidan (faqat Windows emas) ulanish mumkin.

CREATE DATABASE SchoolDB;

CREATE TABLE Talabalar (
    StudentID INT PRIMARY KEY,
    Ism VARCHAR(50),
    Age INT
);


-- 1. SQL Server

-- Bu — Relyatsion Ma’lumotlar Bazasi Boshqaruv Tizimi (RDBMS).

-- Microsoft ishlab chiqqan dasturiy ta’minot bo‘lib, ma’lumotlarni saqlash, boshqarish va ularga xizmat ko‘rsatishni amalga oshiradi.

-- Masalan: sizning kompyuteringizda yoki serveringizda ishlaydi va barcha bazalarni o‘zida saqlaydi.

-- Misol: CREATE DATABASE SchoolDB; kodini bajaradigan tizim bu SQL Server.

--  2. SSMS (SQL Server Management Studio)

-- Bu — grafik interfeysli dastur bo‘lib, SQL Server bilan ishlashni osonlashtiradi.

-- Foydalanuvchilar SQL yozmasdan ham ma’lumotlar bazasi yaratishi, jadval qo‘shishi, backup/restore qilishlari mumkin.

-- Shuningdek, query oynasi orqali SQL kodlarini yozish va bajarish ham mumkin.

-- Qisqasi, bu SQL Server bilan ishlash uchun qulay vosita.



-- 1. DQL (Data Query Language)

--  Ma’lumotlarni so‘rash va ko‘rish uchun ishlatiladi.

-- Asosiy buyrug‘i: SELECT

-- 2. DML (Data Manipulation Language)

--  Ma’lumotlarni o‘zgartirish yoki boshqarish uchun ishlatiladi.

-- Asosiy buyruqlar: INSERT, UPDATE, DELETE

-- 3. DDL (Data Definition Language)

--  Ma’lumotlar bazasi tuzilmasini yaratish yoki o‘zgartirish uchun ishlatiladi.

-- Asosiy buyruqlar: CREATE, ALTER, DROP, TRUNCATE

-- 4. DCL (Data Control Language)

--  Foydalanuvchilarga huquq berish yoki olib tashlash uchun ishlatiladi.

-- Asosiy buyruqlar: GRANT, REVOKE
-- 5. TCL (Transaction Control Language)

-- Tranzaksiyalarni boshqarish uchun ishlatiladi. Tranzaksiya — bu bir nechta buyruqlarni bitta operatsiya sifatida bajarish.

-- Asosiy buyruqlar: COMMIT, ROLLBACK, SAVEPOINT

INSERT INTO Talabalar (StudentID, Ism, Age)
VALUES 
(1, 'Ali', 20),
(2, 'Dilshod', 22),
(3, 'Malika', 19);
