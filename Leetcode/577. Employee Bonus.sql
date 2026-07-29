--Improved
SELECT 
        e.name,
        b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empID
WHERE b.bonus < 1000 OR b.bonus IS NULL


-- OLD
WITH complete  AS (
SELECT e.empId,e.name,e.supervisor,e.salary, b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empid)

SELECT name, bonus
FROM complete
WHERE bonus < 1000 OR bonus IS NULL

