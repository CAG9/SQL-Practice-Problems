SELECT
        CASE WHEN g.grade < 8 THEN null ELSE s.name END,
        g.grade,
        s.marks
FROM Students s
JOIN Grades g 
ON   s.marks BETWEEN g.min_mark AND g.max_mark 
ORDER BY g.grade DESC, s.name ASC

