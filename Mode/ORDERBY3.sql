SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE '%T-Pain%'
 ORDER BY year_rank DESC;
