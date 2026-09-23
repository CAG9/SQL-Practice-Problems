SELECT user_id,
        COUNT(prompt) AS prompt_count ,
        ROUND(AVG(tokens),2) AS avg_tokens
FROM prompts
GROUP BY user_id
HAVING COUNT(prompt) >= 3 AND MAX(tokens) > avg_tokens 
ORDER BY avg_tokens  DESC, user_id ASC

--------------------------------

WITH sub AS (SELECT user_id,
        COUNT(prompt) AS prompt_count ,
        ROUND(AVG(tokens),2) AS avg_tokens
FROM prompts
GROUP BY user_id
HAVING COUNT(prompt) >= 3 )

SELECT DISTINCT s.user_id,
        s.prompt_count,
        s.avg_tokens
FROM sub s
JOIN prompts p
ON s.user_id = p.user_id
WHERE p.tokens > s.avg_tokens 
ORDER BY s.avg_tokens  DESC, s.user_id ASC
