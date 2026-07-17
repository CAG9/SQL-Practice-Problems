-- DELETE DUPLCIATE DATA
DELETE from cars 
WHERE model_id not in (SELECT MIN(model_id)
                      FROM cars
                      GROUP BY model_name,brand)

DELETE from cars 
WHERE ctd not in (SELECT MAX(ctd)
                      FROM cars
                      GROUP BY model_name,brand
                      HAVING COUNT(1)>1)

--DIsplay HIGHEST AND LOWEST SALARY
SELECT *,
MAX(salary) OVER(PARTITION BY dept ORDER BY salary DESC) AS highest salary,
MIN(salary) OVER(PARTITION BY dept ORDER BY salary DESC
                  RANGE BETWEEN UNBOUNDED PRECEDING AND UBOUNDED FOLLOWING ) AS los_salaary


--Find Actual Distance substract from cumularive
SELECT *,
CUMULATIVE_DISTANCE -LAG(cumulative_distance,1,0) OVER(PARTITION BY cars ORER BY DAYS) AS dist
FROM car_travels

--Input to output a table wwith cities with distance all the same 
with cte as
(select *
, row_number() over() as rn
from src_dest_distance)
select t1.source, t1.destination, t1.distance
from cte t1
join cte t2
on t1.rn < t2.rn
and t1.source = t2.destination
and t1.destination = t2.source;

--UNGROUP the given input data

with recursive cte as
(select id, item_name, total_count, 1 as level
from travel_items
union all
select cte.id, cte.item_name, cte.total_count - 1, level+1 as level
from cte
join travel_items t on t.item_name = cte.item_name and t.id = cte.id
where cte.total_count > 1
)
select id, item_name, level
from cte


-- DErive irl maches
--each teams need to play with evrey one just once
-- each team play with every other team twice

-- Solution for 1: Each team plays with every other team JUST ONCE.
WITH matches AS
(SELECT row_number() over(order by team_name) AS id, t.*
FROM teams t)
SELECT team.team_name AS team, opponent.team_name AS opponent
FROM matches team
JOIN matches opponent ON team.id < opponent.id
ORDER BY team;
-- Solution for 2: Each team plays with every other team TWO ONCE.
WITH matches AS
(SELECT row_number() over(order by team_name) AS id, t.*
FROM teams t)
SELECT team.team_name AS team, opponent.team_name AS opponent
FROM matches team
JOIN matches opponent ON team.id <> opponent.id
ORDER BY team;



-- Find the hierarchy in same able, under a given manager asha
WITH RECURSIVE cte AS 
  (
  select * from emp_details
  WHERE name = 'Asha'
  UNION
  SELECT e.*
  FROM cte 
  join emp_details e on e.manager_id = cte.id
  )
SELECT *
  FROM cte


  --find the diffrence in average sales for each mpnth 2003-2004

--- Q9: Find difference in average sales ---
select * from Sales_order;

with cte as
(select year_id, month_id, to_char(order_date, 'MON') as mon, avg(sales) as avg_sales_per_month
from sales_order s
where year_id in (2003, 2004)
group by year_id, month_id, to_char(order_date, 'MON'))
select y03.mon, round(abs(y03.avg_sales_per_month - y04.avg_sales_per_month)::decimal,2) as diff
from cte y03
join cte y04 on y03.mon = y04.mon
where y03.year_id = 2003
and y04.year_id = 2004
  order by y03.month_id;


-- pizza delivery status.cust_name/order_id/status

--- Q10: Pizza Delivery Status ---
select * from cust_orders;

select distinct cust_name as customer_name, 'COMPLETED' as status
from cust_orders D
where D.status = 'DELIVERED'
and not exists (select 1 from cust_orders d2
where d2.cust_name=d.cust_name
and d2.status in ('SUBMITTED','CREATED'))
union
  
select distinct cust_name as customer_name, 'IN PROGRESS' as status
from cust_orders D
where D.status = 'DELIVERED'
and not exists (select 1 from cust_orders d2
where d2.cust_name=d.cust_name
and d2.status in ('SUBMITTED','CREATED'))

  union
  
select distinct cust_name as customer_name, 'AWAITING PROGRESS' as status
from cust_orders D
where D.status = 'SUBMITTED'
and not exists (select 1 from cust_orders d2
where d2.cust_name=d.cust_name
and d2.status in ('DELIVERED'))
  union
  
select distinct cust_name as customer_name, 'AWAITING SUBMISSION' as status
from cust_orders D
where D.status = 'CRETED'
and not exists (select 1 from cust_orders d2
where d2.cust_name=d.cust_name
and d2.status in ('DELIVERED','SUBMITTED'))






-- CHange table orientation form vertidal to wide, colimn monts

SELECT
CustomerID AS Customer,

-- Jan
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) || '$'
END AS "Jan-21",

-- Feb
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END) || '$'
END AS "Feb-21",

-- Mar
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END) || '$'
END AS "Mar-21",

-- Repeat for all other months...

-- Apr
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END) || '$'
END AS "Apr-21",

-- Continue for May through Dec...

-- Total
CASE
WHEN SUM(Amount) < 0 THEN '(' || ABS(SUM(Amount)) || ')$'
WHEN SUM(Amount) = 0 THEN '0$'
ELSE SUM(Amount) || '$'
END AS "Total"

FROM Sales
GROUP BY CustomerID

UNION ALL

-- Total Row
SELECT
'Total',

-- Jan Total
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) || '$'
END,

-- Repeat same structure for Feb to Dec...

-- Total Column
CASE
WHEN SUM(Amount) < 0 THEN '(' || ABS(SUM(Amount)) || ')$'
WHEN SUM(Amount) = 0 THEN '0$'
ELSE SUM(Amount) || '$'
END

FROM Sales;

CustomerID AS Customer,

-- Jan
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) || '$'
END AS "Jan-21",

-- Feb
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Feb-21' THEN Amount ELSE 0 END) || '$'
END AS "Feb-21",

-- Mar
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Mar-21' THEN Amount ELSE 0 END) || '$'
END AS "Mar-21",

-- Repeat for all other months...

-- Apr
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Apr-21' THEN Amount ELSE 0 END) || '$'
END AS "Apr-21",

-- Continue for May through Dec...

-- Total
CASE
WHEN SUM(Amount) < 0 THEN '(' || ABS(SUM(Amount)) || ')$'
WHEN SUM(Amount) = 0 THEN '0$'
ELSE SUM(Amount) || '$'
END AS "Total"

FROM Sales
GROUP BY CustomerID

UNION ALL

-- Total Row
SELECT
'Total',

-- Jan Total
CASE
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) < 0
THEN '(' || ABS(SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END)) || ')$'
WHEN SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) = 0
THEN '0$'
ELSE SUM(CASE WHEN TO_CHAR(SalesDate, 'Mon-YY') = 'Jan-21' THEN Amount ELSE 0 END) || '$'
END,

-- Repeat same structure for Feb to Dec...

-- Total Column
CASE
WHEN SUM(Amount) < 0 THEN '(' || ABS(SUM(Amount)) || ')$'
WHEN SUM(Amount) = 0 THEN '0$'
ELSE SUM(Amount) || '$'
END

FROM Sales;


















