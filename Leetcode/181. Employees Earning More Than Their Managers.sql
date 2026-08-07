SELECT employee1.name AS Employee
FROM employee employee1
JOIN employee employee2
ON employee1.managerId = employee2.id
WHERE employee1.salary > employee2.salary


--
SELECT e1.name AS employee
FROM employee e1
JOIN employee e2
ON e1.managerId = e2.id and e1.salary > e2.salary
