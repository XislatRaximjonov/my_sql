SELECT 
  CONCAT(emp_id, '-', first_name, ' ', last_name) AS EmployeeInfo
FROM employees;

UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999');

SELECT 
  first_name AS 'First Name',
  LENGTH(first_name) AS 'Name Length'
FROM employees
WHERE first_name LIKE 'A%' 
   OR first_name LIKE 'J%' 
   OR first_name LIKE 'M%'
ORDER BY first_name;

SELECT 
  manager_id,
  SUM(salary) AS total_salary
FROM employees
GROUP BY manager_id;


SELECT
  year,
  GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;


SELECT *
FROM cinema
WHERE id % 2 = 1
  AND description != 'boring'
ORDER BY rating DESC;

SELECT *
FROM SingleOrder
ORDER BY (Id = 0), Id;


SELECT 
  COALESCE(column1, column2, column3, column4) AS FirstNonNull
FROM person;


SELECT 
  FullName,
  SUBSTRING_INDEX(FullName, ' ', 1) AS FirstName,
  SUBSTRING_INDEX(SUBSTRING_INDEX(FullName, ' ', 2), ' ', -1) AS MiddleName,
  SUBSTRING_INDEX(FullName, ' ', -1) AS LastName
FROM Students;


SELECT *
FROM Orders
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders
    WHERE DeliveryState = 'California'
)
AND DeliveryState = 'Texas';


SELECT 
  SomeGroupColumn,
  GROUP_CONCAT(ValueColumn ORDER BY ValueColumn SEPARATOR ', ') AS CombinedValues
FROM DMLTable
GROUP BY SomeGroupColumn;


SELECT 
  first_name,
  last_name,
  CONCAT(first_name, ' ', last_name) AS FullName
FROM Employees
WHERE LENGTH(LOWER(CONCAT(first_name, last_name))) 
      - LENGTH(REPLACE(LOWER(CONCAT(first_name, last_name)), 'a', '')) >= 3;


SELECT 
  department_id,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 3 THEN 1 ELSE 0 END) AS employees_over_3_years,
  ROUND(
    SUM(CASE WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 3 THEN 1 ELSE 0 END) 
    / COUNT(*) * 100, 2
  ) AS percentage_over_3_years
FROM Employees
GROUP BY department_id;


SELECT 
  id,
  value,
  SUM(value) OVER (ORDER BY id) AS cumulative_sum
FROM Students;


SELECT 
  birth_date,
  GROUP_CONCAT(student_name SEPARATOR ', ') AS students_with_same_birthday
FROM Student
GROUP BY birth_date
HAVING COUNT(*) > 1;


SELECT 
  LEAST(PlayerA, PlayerB) AS Player1,
  GREATEST(PlayerA, PlayerB) AS Player2,
  SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
  LEAST(PlayerA, PlayerB),
  GREATEST(PlayerA, PlayerB);


SELECT
  'tf56sd#%OqH' AS OriginalString,
  REGEXP_REPLACE('tf56sd#%OqH', '[^A-Z]', '') AS UppercaseLetters,
  REGEXP_REPLACE('tf56sd#%OqH', '[^a-z]', '') AS LowercaseLetters,
  REGEXP_REPLACE('tf56sd#%OqH', '[^0-9]', '') AS Numbers,
  REGEXP_REPLACE('tf56sd#%OqH', '[A-Za-z0-9]', '') AS OtherCharacters;
