SELECT u.user_id as buyer_id, u.join_date AS join_date, COUNT(o.buyer_id) as orders_in_2019
FROM users u
 LEFT JOIN orders o
ON u.user_id = o.buyer_id AND Year(order_date) = '2019'
group by user_id;
