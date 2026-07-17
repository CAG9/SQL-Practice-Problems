WITH RECURSIVE asterisk AS (
    SELECT 20 as i, REPEAT('* ', 20) AS pattern
    UNION ALL
    SELECT i - 1, REPEAT('* ', i - 1)
    FROM asterisk 
    WHERE i > 1
)

SELECT pattern FROM asterisk;
