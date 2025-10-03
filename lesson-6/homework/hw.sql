SELECT DISTINCT
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM mytable;

SELECT DISTINCT 
       LEAST(col1, col2) AS col1,
       GREATEST(col1, col2) AS col2
FROM mytable;

SELECT *
FROM TestMultipleZero
WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0;

SELECT *
FROM TestMultipleZero
WHERE (A + B + C + D) <> 0;

SELECT *
FROM section1
WHERE id % 2 = 1;

SELECT *
FROM section1
WHERE MOD(id, 2) = 1;

SELECT *
FROM section1
ORDER BY id ASC
LIMIT 1;

SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);


SELECT *
FROM section1
WHERE name LIKE 'B%';

SELECT *
FROM your_table
WHERE code LIKE '%\_%' ESCAPE '\';


SELECT *
FROM ProductCodes
WHERE CHARINDEX('_', Code) > 0;


SELECT *
FROM ProductCodes
WHERE INSTR(Code, '_') > 0;

