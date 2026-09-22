# Leetcode Problem 

Below is a table ..... 
## Problems

| The Absolute Exclusion Pattern | The Post-Aggregation Filter Pattern | The Sequential Analysis Pattern  | The Self-Reference Pattern| Other |
| :--- | :--- | :--- | :--- | :--- |
| Anti-Join | GROUP BY +/or HAVING | Window Functions| Self-Join | Other |
| 183. Customers Who Never Order | 182. Duplicate Emails | 1484. Group Sold Products By The Date (COUNT, GROUP_CONCATdistinct )| 181. Employees Earning More Than Their Managers | 175. Combine Two Tables (Join) |
| 607. Sales Person |511. Game Play Analysis I | :--- | 196. Delete Duplicate Emails  | 197. Rising Temperature (Join on Diff(dates))|
| 619. Biggest Single Number MAX(FROM inner query) | 586. Customer Placing the Largest Number of Orders (GROUP BY, ORDER LIMIT) | :--- | :--- | 577. Employee Bonus (Left join OR WHERE)|
| 1581. Customer Who Visited but Did Not Make Any Transactions (WHERE NOT IN visitid from transactions) | 596. Classes With at Least 5 Students | :--- | :--- | 584. Find Customer Referee (WHERE != 2 OR IS NULL) |
| 1633. Percentage of Users Attended a Contest(COUNT()/(SELECT COUNT()) | 1068. Product Sales Analysis I( HAVING)| :--- | :--- | 595. Big Countries (WHERE OR) |
| :--- | 1084. Sales Analysis III HAVING(MIN(date)>=,MAX(date)<= | :--- | :--- | 610. Triangle Judgement (Case x+y>z...) |
| :--- | 1327. List the Products Ordered in a Period(JOIN id and dates HAVING >100) | :--- | :--- | 620. Not Boring Movies (WHERE id%2=1 and !+) |
| :--- | 1587. Bank Account Summary II (SUM(amount) group by name,account | :--- | :--- |627. Swap Sex of Employees (Update tbl set sex = (Case) |
| :--- | 1693. Daily Leads and Partners GROUPBY date_id,make_name, COUNT(distict) | :--- | 1661. Average Time of Process per Machine( self join on machineid,process, a1activity start , a2.activity start ) then just avg a2-a1) | 1075. Project Employees I(Join and ROUND(AVG()) |
| :--- | 1729. Find Followers Count GROUP BY user_id,COUNT(*) | :--- | :--- | 1141. User Activity for the Past 30 Days I(COUNT(distinctid) WHERE date , GROUPBYdate|
| :--- | 1741. Find Total Time Spent by Each Employee (GROUPBY empid,day,sum(out-in) | :--- | 1731. The Number of Employees Which Report to Each Employee(JOIN on emplo=reports, Groupby emplo,name ,COUNT,round e2) | 1148. Article Views I (WHEre author =viewer)|
| :--- | 1789. Primary Department for Each Employee (GROUPBY empid,having count(empid) UNION WHERE Y) | :--- | :--- | 1179. Reformat Department Table(SUM(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) As Jan_Revenue),Groupby|
| :--- | 1890. The Latest Login in 2020(GROUP BY user_id, MAX(time))| :--- | :--- | 1211. Queries Quality and Percentage(AVG(rat/pos| SUM(CASE)/COUNT(*)x100|
| :--- | :--- | :--- | :--- | 1251. Average Selling Price(JOIN id and dates, IFNULL(ROUND(SUM(price*units)/SUM(u.units),2),0) |
| :--- | :--- | :--- | :--- | 1280. Students and Examinations(CROSS JOIN LEFT JOIN, COUNT(examinationsubjects)GROUPBY idnamesub |
| :--- | :--- | :--- | :--- | 1378. Replace Employee ID With The Unique Identifier (LeftJOin)|
| :--- | :--- | :--- | :--- | 1407. Top Travellers(IFNULL(SUM)), LEFT JOIN groupby id|
| :--- | :--- | :--- | :--- | 1517. Find Users With Valid E-Mails REGEXP'^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$' AND LIKE BINARY '%@leetcode.com' |
| :--- | :--- | :--- | :--- | 1527. Patients With a Condition REGEXP '(^| )DIAB1' |
| :--- | :--- | :--- | :--- | 1667. Fix Names in a Table(CONCAT(LEFT(UPPER)),LOWER(SUBSTRING2)|
| :--- | :--- | :--- | :--- | 1683. Invalid Tweets WHERE LENGTH()>15|
| :--- | :--- | :--- | :--- | 1757. Recyclable and Low Fat Products WHERE|
| :--- | :--- | :--- | :--- | 1795. Rearrange Products Table(SELECT id,'store1'',where st1 is not null, UNION  |
| :--- | :--- | :--- | :--- | 1873. Calculate Special Bonus CASE WHEN id%2=1 And  NOT LIKE 'M%'|
| :--- | :--- | :--- | :--- | :--- |
| :--- | :--- | :--- | :--- | :--- |

---
Next:  1965
