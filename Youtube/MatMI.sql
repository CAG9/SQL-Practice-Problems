--Identify the job titles of the highest paid employees
SELECT
t.worker_title AS best_paid_title
FROM title t 
JOIN worker w
ON
t.worker_red_id = w.worker_id
WHERE w.salary = (SELECT MAX(salary) FROM worker)
