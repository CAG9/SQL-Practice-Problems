SELECT name FROM Customer
WHERE referee_id != 2 or referee_id IS NULL;
-- Faster
SELECT name
FROM customer
WHERE COALESCE(referee_id, 0) != 2;
