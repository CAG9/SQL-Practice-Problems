# SQL CTE (Common Table Expression) Cheat Sheet

A practical guide to identifying when, why, and how to use Common Table Expressions (`WITH` clauses) in SQL queries. Ideal for GitHub documentation, study notes, or quick reference.

---

## 📌 Table of Contents
- [1. Quick Decision Tree](#1-quick-decision-tree)
- [2. Trigger Checklist](#2-trigger-checklist)
- [3. Key Patterns & Code Examples](#3-key-patterns--code-examples)
  - [Pattern 1: Filtering Window Functions](#pattern-1-filtering-window-functions-top-n--deduplication)
  - [Pattern 2: Multi-Step Data Pipeline](#pattern-2-multi-step-data-pipeline)
  - [Pattern 3: Reused Subqueries](#pattern-3-reused-subqueries)
  - [Pattern 4: Recursive / Hierarchical Queries](#pattern-4-recursive--hierarchical-queries)
- [4. CTE vs Subquery vs Temp Table](#4-cte-vs-subquery-vs-temp-table)

---

## 1. Quick Decision Tree

Ask yourself these four questions in order:

```
                  Do you need to filter or aggregate 
                  by a Window Function result?
                             /        \
                           YES         NO
                           /            \
                   [USE CTE]          Is the query recursive 
                                      or hierarchical?
                                        /        \
                                      YES         NO
                                      /            \
                              [USE CTE]          Are you referencing the exact 
                                                 same subquery multiple times?
                                                   /        \
                                                 YES         NO
                                                 /            \
                                         [USE CTE]          Does the query have >1 nested 
                                                            subquery level (hard to read)?
                                                              /        \
                                                            YES         NO
                                                            /            \
                                                    [USE CTE]          [Standard Query / 
                                                                        Subquery fine]
```

---

## 2. Trigger Checklist

| Scenario | CTE Needed? | Reason |
| :--- | :---: | :--- |
| **Filtering Window Functions** (`ROW_NUMBER()`, `RANK()`, `SUM() OVER()`) | **MUST** | `WHERE` executes before Window Functions in SQL execution order. |
| **Recursive Data** (Org charts, folder trees, bill of materials) | **MUST** | Standard SQL cannot loop across parent-child relationships dynamically without `WITH RECURSIVE`. |
| **Subquery Reuse** (Self-joins on aggregated data) | **RECOMMENDED** | Prevents repeating the exact same subquery block multiple times. |
| **Multi-Stage Pipelines** (Filter $\rightarrow$ Aggregate $\rightarrow$ Join $\rightarrow$ Re-aggregate) | **RECOMMENDED** | Replaces nested "subquery inception" with clean, top-to-bottom pipeline blocks. |
| **Debugging / Testing Logic** | **RECOMMENDED** | Allows testing individual stages independently by running `SELECT * FROM CTE_Name`. |

---

## 3. Key Patterns & Code Examples

### Pattern 1: Filtering Window Functions (Top-N / Deduplication)

> **Symptom:** You want to filter by `ROW_NUMBER() = 1` or `RANK() <= 3`.

```sql
WITH RankedOrders AS (
    SELECT 
        customer_id,
        order_id,
        order_date,
        amount,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
)
SELECT customer_id, order_id, order_date, amount
FROM RankedOrders
WHERE rn = 1; -- Returns only the latest order per customer
```

---

### Pattern 2: Multi-Step Data Pipeline

> **Symptom:** Deeply nested subqueries in `FROM` or `JOIN` clauses that obscure business logic.

```sql
-- Step 1: Filter raw orders
WITH CleanOrders AS (
    SELECT customer_id, amount
    FROM orders
    WHERE status = 'completed' AND order_date >= '2026-01-01'
),

-- Step 2: Aggregate by customer
CustomerTotals AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM CleanOrders
    GROUP BY customer_id
)

-- Step 3: Combine with customer details for final output
SELECT 
    c.customer_name, 
    ct.total_spent
FROM CustomerTotals ct
JOIN customers c ON ct.customer_id = c.customer_id
WHERE ct.total_spent > 1000;
```

---

### Pattern 3: Reused Subqueries

> **Symptom:** Duplicate subquery logic written across `JOIN`, `UNION`, or comparison steps.

```sql
WITH RegionalSales AS (
    SELECT region_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY region_id
)
SELECT 
    curr.region_id,
    curr.total_sales AS current_region_sales,
    prev.total_sales AS adjacent_region_sales
FROM RegionalSales curr
JOIN RegionalSales prev ON curr.region_id = prev.region_id + 1;
```

---

### Pattern 4: Recursive / Hierarchical Queries

> **Symptom:** Querying org charts, parent-child trees, or threaded comments.

```sql
WITH RECURSIVE OrgChart AS (
    -- Anchor: Find top management
    SELECT employee_id, manager_id, name, 1 AS depth
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive Step: Join employees with their managers
    SELECT e.employee_id, e.manager_id, e.name, o.depth + 1
    FROM employees e
    JOIN OrgChart o ON e.manager_id = o.employee_id
)
SELECT * FROM OrgChart ORDER BY depth;
```

---

## 4. CTE vs Subquery vs Temp Table

| Feature | CTE (`WITH`) | Subquery | Temp Table (`#temp`) |
| :--- | :--- | :--- | :--- |
| **Scope** | Single query | Single query | Entire session/procedure |
| **Readability** | High (Top-Down) | Low when nested | Medium |
| **Reusability** | Multiple times in *one* query | Defined inline each time | Across *multiple* queries |
| **Indexing** | Not indexable | Not indexable | Indexable (Best for massive data) |
| **Recursion** | Supported (`RECURSIVE`) | Not supported | Not direct |

---

*Feel free to star or bookmark this reference for quick query optimization and structuring.*