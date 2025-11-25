SELECT h.hacker_id,
        h.name, 
        COUNT(c.challenge_id) as counted_challenges
        FROM hackers h
        JOIN challenges c
        ON h.hacker_id = c.hacker_id
        GROUP BY h.hacker_id, h.name
        HAVING counted_challenges = (SELECT COUNT(challenge_id) as count1
                                    FROM challenges
                                    GROUP BY hacker_id
                                    ORDER BY count1 DESC 
                                    LIMIT 1)
        OR counted_challenges IN (
                                    SELECT  DISTINCT sub1.counted_c
                                    FROM (
                                            SELECT h.hacker_id , h.name, COUNT(c.challenge_id) as counted_c
                                                FROM hackers h
                                                JOIN challenges c
                                                ON h.hacker_id = c.hacker_id
                                                GROUP BY h.hacker_id, h.name ) sub1
                                    GROUP BY sub1.counted_c
                                    HAVING COUNT(counted_c) = 1)
        ORDER BY counted_challenges DESC, h.hacker_id;
----------------
SELECT 
    h.hacker_id,
    h.name,
    c.challenge_count
FROM hackers h
JOIN (
    SELECT 
        hacker_id,
        COUNT(*) AS challenge_count,
        COUNT(*) OVER () AS total_rows,
        MAX(COUNT(*)) OVER () AS max_challenges,
        COUNT(*) OVER (PARTITION BY COUNT(*)) AS freq
    FROM challenges
    GROUP BY hacker_id
) AS c
    ON h.hacker_id = c.hacker_id
WHERE 
        c.challenge_count = c.max_challenges   -- keep all max
     OR  c.freq = 1                            -- keep unique counts
ORDER BY 
    c.challenge_count DESC,
    h.hacker_id;
