SELECT h.hacker_id,
         h.name,
          SUM(s.max_score) as sum_max_score
FROM Hackers as h
JOIN (
    SELECT  hacker_id,
             challenge_id,
              MAX(score) As max_score
    FROM Submissions
    GROUP BY 1,2 
) as s ON h.hacker_id = s.hacker_id
GROUP BY h.hacker_id, h.name
HAVING sum_max_score > 0
ORDER BY sum_max_score DESC, h.hacker_id ASC
