-- second highest salary 
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

--Duplicate Emails
SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;

-- Employees Earning More Than Their Managers
SELECT e1.name AS Employee
FROM Employee e1
JOIN Employee e2 ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;

-- Rising Temperature
SELECT w2.id
FROM Weather w1
JOIN Weather w2 ON DATEDIFF(w2.recordDate, w1.recordDate) = 1
WHERE w2.temperature > w1.temperature;

-- Department Top Three Salaries

WITH ranked AS (
  SELECT e.name AS Employee, d.name AS Department, e.salary,
         DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS rnk
  FROM Employee e
  JOIN Department d ON e.departmentId = d.id
)
SELECT Department, Employee, salary AS Salary
FROM ranked
WHERE rnk <= 3;


 --Consecutive Numbers — using LAG()
WITH numbered AS (
  SELECT
    num,
    LAG(num, 1) OVER (ORDER BY id) AS prev1,
    LAG(num, 2) OVER (ORDER BY id) AS prev2
  FROM Logs
)
SELECT DISTINCT num AS ConsecutiveNums
FROM numbered
WHERE num = prev1 AND num = prev2;





--Nth Highest Salary — using DENSE_RANK()
SELECT salary
FROM (
  SELECT salary,
         DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM Employee
) ranked
WHERE rnk = N;


-- 8. Trips and Users (Cancellation Rate)

SELECT t.request_at AS Day,
       ROUND(
         SUM(CASE WHEN t.status LIKE 'cancelled%' THEN 1 ELSE 0 END) / COUNT(*), 2
       ) AS 'Cancellation Rate'
FROM Trips t
JOIN Users u1 ON t.client_id = u1.users_id AND u1.banned = 'No'
JOIN Users u2 ON t.driver_id = u2.users_id AND u2.banned = 'No'
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;

--9. Exchange Seats
--Question: Swap adjacent student seat IDs (1↔2, 3↔4, …); if the count is odd, the last student keeps their seat.
sqlSELECT
  CASE
    WHEN id % 2 = 1 AND id = (SELECT MAX(id) FROM Seat) THEN id
    WHEN id % 2 = 1 THEN id + 1
    ELSE id - 1
  END AS id,
  student
FROM Seat
ORDER BY id;


--10. Running/Cumulative Total (Window Functions) Question: Given daily sales, compute a running total per product.
SELECT product_id, sale_date, amount,
       SUM(amount) OVER (
         PARTITION BY product_id ORDER BY sale_date
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM Sales;


