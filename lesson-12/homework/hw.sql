SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a 
    ON p.personId = a.personId;

SELECT 
    e.name AS Employee
FROM Employee e
JOIN Employee m 
    ON e.managerId = m.id
WHERE e.salary > m.salary;

SELECT 
    email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;

DELETE p1
FROM Person p1
JOIN Person p2
  ON p1.email = p2.email
 AND p1.id > p2.id;


SELECT ParentName FROM boys
UNION
SELECT ParentName FROM girls;

SELECT TOP 1 *
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT 
    c1.Item AS `Item Cart 1`,
    c2.Item AS `Item Cart 2`
FROM Cart1 c1
LEFT JOIN Cart2 c2 ON c1.Item = c2.Item

UNION

SELECT 
    c1.Item AS `Item Cart 1`,
    c2.Item AS `Item Cart 2`
FROM Cart1 c1
RIGHT JOIN Cart2 c2 ON c1.Item = c2.Item;


SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
  ON c.id = o.customerId
WHERE o.id IS NULL;


SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id 
   AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
