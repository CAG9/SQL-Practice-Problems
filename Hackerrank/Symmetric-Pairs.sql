SELECT t1.X, t1.Y 
FROM Functions  t1
JOIN Functions t2
ON t1.X = t2.Y AND t2.X = t1.Y
GROUP BY t1.X, t1.Y
HAVING t1.X < t1.Y OR COUNT(t1.X) > 1
ORDER BY t1.X ASC


