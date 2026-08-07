# 1. The Absolute Exclusion Pattern (Anti-Join)
When to use it: When the problem asks you to find entities that have never done something, have no relationship with a certain variable, or are missing a specific record.

How to identify it in the text: Look for keywords like "did not", "never", "not completely", or "none".

The technique: Instead of directly looking for those who do not meet the condition, invert the problem. Look for those who DO meet it using a subquery (inner query), and then exclude them from the main set using NOT IN or NOT EXISTS. In ETL processes and pipeline design, isolating anomalous records this way prevents the data duplication that direct joins generate.

# 2. The Post-Aggregation Filter Pattern (GROUP BY + HAVING)
When to use it: When you need to apply a logical condition over a mathematical calculation or a general count, rather than a single transaction.

How to identify it in the text: Phrases like "more than N times", "total sales greater than", or "only those who bought all products", "find duplicate emails".

The technique: Group by the main entity (GROUP BY id), perform the aggregation function (e.g., COUNT() or SUM()), and use the HAVING clause to filter the final result.

# 3. The Sequential Analysis Pattern (Window Functions)
When to use it: When you need to compare a row with the previous or next one, calculate running totals, or find the "Top N" within different categories without losing the granular detail level of the original table.

How to identify it in the text: Expressions like "Top 3 salaries per department", "consecutive days", "running total", or "difference from previous order".

The technique: Use window functions (ROW_NUMBER(), RANK(), LEAD(), LAG()) combined with PARTITION BY and ORDER BY. Mastering and optimizing these scripts is essential for solving complex architectural challenges.

# 4. The Self-Reference Pattern (Self-Join)
When to use it: When the solution requires comparing different records that live in the exact same table.

How to identify it in the text: Scenarios like "Employees who earn more than their managers", "Delete Duplicate Emails".

The technique: Perform a JOIN of the table with itself (FROM table t1 JOIN table t2), usually implementing inequality conditions (t1.salary > t2.salary) or linking internal foreign keys (t1.manager_id = t2.id).
# 5. Bonus
When facing a new requirement, your first mental filter should be asking: "Am I evaluating properties of a single row (WHERE), properties of a group (HAVING), exclusive absences (NOT IN), or relative positions (Window Functions)?"
