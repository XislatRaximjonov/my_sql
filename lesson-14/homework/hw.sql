CREATE TABLE TestMultipleColumns (FullName VARCHAR(50));

INSERT INTO TestMultipleColumns VALUES
('Ali Karimov'),
('Nodira Ismoilova'),
('Jasur Mirzaev');


SELECT
  FullName,
  SUBSTRING_INDEX(FullName, ' ', 1) AS Name,
  SUBSTRING_INDEX(FullName, ' ', -1) AS Surname
FROM TestMultipleColumns;


SELECT *
FROM TestPercent
WHERE yourColumn LIKE '%\%%';


SELECT
  str,
  SUBSTRING_INDEX(str, '.', 1) AS Part1,
  SUBSTRING_INDEX(SUBSTRING_INDEX(str, '.', 2), '.', -1) AS Part2,
  SUBSTRING_INDEX(str, '.', -1) AS Part3
FROM Splitter;


SELECT *
FROM testDots
WHERE (LENGTH(Vals) - LENGTH(REPLACE(Vals, '.', ''))) > 2;


SELECT
  str,
  (LENGTH(str) - LENGTH(REPLACE(str, ' ', ''))) AS SpaceCount
FROM CountSpaces;


CREATE TABLE Employee (
  EmployeeID INT,
  Name VARCHAR(50),
  ManagerID INT,
  Salary DECIMAL(10,2)
);

INSERT INTO Employee VALUES
(1, 'Ali', NULL, 8000),
(2, 'Nodira', 1, 6000),
(3, 'Jasur', 1, 9000);


SELECT 
  e.EmployeeID,
  e.Name AS EmployeeName,
  e.Salary AS EmployeeSalary,
  m.Name AS ManagerName,
  m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;


SELECT
  EmployeeID,
  FirstName,
  LastName,
  HireDate,
  TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsOfService
FROM Employees
WHERE TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) BETWEEN 10 AND 15;



CREATE TABLE Weather (
  Id INT,
  RecordDate DATE,
  Temperature INT
);

INSERT INTO Weather VALUES
(1, '2025-10-10', 25),
(2, '2025-10-11', 27),
(3, '2025-10-12', 23),
(4, '2025-10-13', 30);


SELECT
  w1.Id,
  w1.RecordDate,
  w1.Temperature
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(w1.RecordDate, w2.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;

CREATE TABLE Activity (
  player_id INT,
  login_date DATE
);

INSERT INTO Activity VALUES
(1, '2024-01-10'),
(1, '2024-02-14'),
(2, '2024-03-20'),
(2, '2024-03-18');


SELECT
  player_id,
  MIN(login_date) AS first_login
FROM Activity
GROUP BY player_id;


CREATE TABLE Fruits (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fruit_name VARCHAR(30)
);

INSERT INTO Fruits (fruit_name) VALUES
('Apple'), ('Banana'), ('Cherry'), ('Grape'), ('Mango');


SELECT fruit_name
FROM Fruits
ORDER BY id
LIMIT 1 OFFSET 2;


CREATE TABLE Employees (
  EmployeeID INT,
  Name VARCHAR(50),
  HireDate DATE
);

INSERT INTO Employees VALUES
(1, 'Ali', '2024-05-01'),
(2, 'Malika', '2020-01-15'),
(3, 'Jasur', '2015-03-22'),
(4, 'Dilnoza', '2008-11-10'),
(5, 'Sardor', '1999-07-07');


SELECT
  EmployeeID,
  Name,
  HireDate,
  TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsWorked,
  CASE
    WHEN TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) < 1 THEN 'New Hire'
    WHEN TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) BETWEEN 1 AND 5 THEN 'Junior'
    WHEN TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
    WHEN TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) BETWEEN 11 AND 20 THEN 'Senior'
    ELSE 'Veteran'
  END AS EmploymentStage
FROM Employees;


CREATE TABLE GetIntegers (Vals VARCHAR(50));

INSERT INTO GetIntegers VALUES
('123abc'),
('45test'),
('007bond'),
('NoNumberHere');


SELECT
  Vals,
  CAST(REGEXP_SUBSTR(Vals, '^[0-9]+') AS UNSIGNED) AS StartingNumber
FROM GetIntegers;


CREATE TABLE MultipleVals (Vals VARCHAR(100));
INSERT INTO MultipleVals VALUES ('apple,banana,cherry');


SELECT
  Vals,
  CONCAT(
    SUBSTRING(Vals, 2, 1),
    SUBSTRING(Vals, 1, 1),
    SUBSTRING(Vals, 3)
  ) AS Swapped_First_Two
FROM MultipleVals;


-- Swap first two letters for each comma-separated word
WITH split AS (
  SELECT 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Vals, ',', n.n), ',', -1)) AS word
  FROM MultipleVals
  JOIN (
    SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
  ) AS n
  ON n.n <= 1 + LENGTH(Vals) - LENGTH(REPLACE(Vals, ',', ''))
)
SELECT 
  GROUP_CONCAT(
    CONCAT(SUBSTRING(word,2,1), SUBSTRING(word,1,1), SUBSTRING(word,3))
    ORDER BY word SEPARATOR ','
  ) AS Swapped_Words
FROM split;


WITH RECURSIVE chars AS (
  SELECT 1 AS pos,
         SUBSTRING('sdgfhsdgfhs@121313131', 1, 1) AS ch
  UNION ALL
  SELECT pos + 1,
         SUBSTRING('sdgfhsdgfhs@121313131', pos + 1, 1)
  FROM chars
  WHERE pos < LENGTH('sdgfhsdgfhs@121313131')
)
SELECT pos, ch
FROM chars;



CREATE TABLE Activity (
  player_id INT,
  device VARCHAR(50),
  login_date DATE
);

INSERT INTO Activity VALUES
(1, 'iPhone', '2024-01-05'),
(1, 'Android', '2024-01-10'),
(2, 'PC', '2024-01-02'),
(2, 'Tablet', '2024-01-06');

SELECT 
  player_id,
  device AS first_device
FROM Activity a
WHERE login_date = (
  SELECT MIN(login_date)
  FROM Activity
  WHERE player_id = a.player_id
);


SELECT
  'rtcfvty34redt' AS InputString,
  REGEXP_REPLACE('rtcfvty34redt', '[0-9]', '') AS CharactersOnly,
  REGEXP_REPLACE('rtcfvty34redt', '[^0-9]', '') AS NumbersOnly;
