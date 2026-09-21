SELECT contest_id,
    ROUND((( COUNT(*)/ (SELECT COUNT(*) AS total_users FROM USERS ))*100),2) AS 'percentage'
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC
