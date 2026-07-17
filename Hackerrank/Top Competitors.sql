SELECT h.hacker_id, h.name
FROM submissions s
    JOIN challenges c 
    ON s.challenge_id = c.challenge_id
    JOIN difficulty d  
    ON c.difficulty_level = d.difficulty_level
    JOIN hackers h
    ON s.hacker_id = h.hacker_id AND s.score = d.score
GROUP BY h.hacker_id,h.name
HAVING COUNT(s.hacker_id) > 1
ORDER BY COUNT(s.hacker_id) DESC, h.hacker_id ASC;


WITH completescore AS (
    SELECT s.submission_id,
           s.hacker_id,
           s.challenge_id,
           s.score AS attempt_score,
           c.difficulty_level,
           d.score AS total_points
    FROM Submissions s
    JOIN challenges c ON s.challenge_id = c.challenge_id
    JOIN Difficulty d ON c.difficulty_level = d.difficulty_level AND s.score = d.score
)

SELECT h.hacker_id,
       h.name
FROM Hackers h
JOIN completescore ON h.hacker_id = completescore.hacker_id
GROUP BY h.hacker_id, h.name
HAVING COUNT(completescore.challenge_id) > 1 -- Changed from > 2 to > 1
ORDER BY COUNT(completescore.challenge_id) DESC, h.hacker_id ASC; -- Sorting stays on the main query

