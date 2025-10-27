SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);


SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

SELECT e.id, e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.department_name = 'Sales';

SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


SELECT p.*
FROM products p
WHERE p.price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);

SELECT e.*
FROM employees e
WHERE e.department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);


SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);


SELECT s.student_id, s.name, g.course_id, g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);


SELECT p.id, p.product_name, p.price, p.category_id
FROM products p
WHERE (
    SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
      AND p2.price > p.price
) = 2;


SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
)
AND e.salary < (
    SELECT MAX(salary)
    FROM employees d
    WHERE d.department_id = e.department_id
);
