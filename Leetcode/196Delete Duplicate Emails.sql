DELETE  p2 
FROM Person AS p1 
JOIN Person AS p2
WHERE p1.email = p2.email AND p1.id < p2.id;
