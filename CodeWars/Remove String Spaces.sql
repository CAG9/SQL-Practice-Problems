-- # write your SQL statement here: you are given a table 'nospace' with column 'x', return a table with column 'x' and your result in a column named 'res'.
SELECT  x, REPLACE(x,' ','') AS res
FROM nospace;
