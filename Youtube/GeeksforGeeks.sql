-- 2nd heihest salaray
SELECT MAX(salary) FROM emp
WHERE sal < (SELECT MAX(salary) FROM emp)

-- Department Wise Highest Salary 
SELECT MAX(salary), dept
FROM emp
GROUP BY dept

-- Dpt amount employees

SELECT COUNT(*), dept
FROM emp
GROUP BY dept

--Display Alternate Records 
SELECT *
FROM
    (SELECT empno,ename,sal, ROW_NUMBER() OVER(ORDER BY empno) AS rn
    FROM emp
    ORDER BY rn)
  WHERE mod(rn,2) != 0;

-- Display Duplicate of a Column and its frequesncy

SELECT ename, COUNT(*)
FROM emp
GROUP BY ename
HAVING COUNT(*) >1

-- Pattern matching
SELECT enmae FROM epm WHERE ename LIKE 'M%'
SELECT enmae FROM epm WHERE ename LIKE '%N'
SELECT enmae FROM epm WHERE ename LIKE '%M%'
SELECT enmae FROM epm WHERE ename NOT LIKE '%M%'

-- Pattern SEarching
SELECT ename from emp where enmae LIKE '____'
SELECT ename from emp where enmae LIKE '_L%' 
SELECT ename from emp where enmae LIKE '___M%'
SELECT hiredate,ename  from emp where hiredat LIKE '%DEC%'
SELECT ename from emp where enmae LIKE  '%L%L%'
SELECT ename from emp where enmae LIKE  'J%S'

-- Disoplay nth row in sql
select * from Customers limit 1 offset 3   
select * from (select ROW_NUMBER OVER() as rn, encam sal) WHERE rn =4

--cros join mxn
CROSS JOIN


-- DIsplay 1st or last Nth rowss 
SELECT * FROM (SELECT ROW_NUMBER OVER() AS RN, ename,sal FROM EMP)
WHERE rn=1 OR rn = (SELECT COUNT(*) FROM emp)
--last two
SELECT * FROM (SELECT ROW_NUMBER OVER() AS RN, ename,sal FROM EMP ORDER BY RN DESC)
LIMIT 2
SELECT * FROM (SELECT ROW_NUMBER OVER() AS RN, ename,sal FROM EMP)
WHERE rn=1 OR rn > (SELECT COUNT(*)-2 FROM emp)

-- NTh highest salary in sql
SELECT salary
    FROM (
      SELECT DISTINCT salary,
             DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
      FROM Employee
    ) ranked
    WHERE rnk = N

--interset 
INTERSECT












