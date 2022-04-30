SELECT s.name as name
FROM salesperson s
WHERE s.sales_id NOT IN (SELECT o.sales_id
             FROM orders o
             JOIN company AS c
             ON o.com_id = c.com_id
             WHERE c.name = 'RED');
