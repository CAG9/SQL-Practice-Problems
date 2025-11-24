WITH RECURSIVE nums AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM nums WHERE n < 1000
),
primes AS (
    SELECT n
    FROM nums
    WHERE NOT EXISTS (
        SELECT 1
        FROM nums AS d
        WHERE d.n <= SQRT(nums.n)
          AND nums.n % d.n = 0
          AND d.n > 1
    )
)
SELECT GROUP_CONCAT(n SEPARATOR '&')
FROM primes;
