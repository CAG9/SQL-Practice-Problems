
/*
Write a SQL query (or describe the SQL logic) to calculate the average Wait Time to Physician Assessment (in minutes) 
broken down by Facility and CTAS Score for the month of August 2026.
visit_id (VARCHAR)

patient_id (VARCHAR)

arrival_time (DATETIME)

triage_time (DATETIME)

physician_time (DATETIME)

discharge_time (DATETIME)

ctas_score (INT) -- Canadian Triage and Acuity Scale (1 to 5)

facility_code (VARCHAR)
*/


--FIRST APRROACH
SELECT 
    facility_code,
    ctas_score,
    COUNT(visit_id) AS total_visits,
    ROUND(
        AVG(
            DATEDIFF(minute, arrival_time, physician_time)
        ), 2
    ) AS avg_wait_time_minutes
FROM ER_Visits_Flat
WHERE 
    arrival_time >= '2026-08-01' 
    AND arrival_time < '2026-09-01'
    AND physician_time >= arrival_time -- Excludes nulls and data errors
GROUP BY 
    facility_code,
    ctas_score
ORDER BY 
    facility_code ASC, 
    ctas_score ASC;




-- Dim query
SELECT 
    f.facility_code,
    a.ctas_score,
    a.ctas_description,
    COUNT(v.visit_id) AS total_visits,
    ROUND(AVG(DATEDIFF(minute, v.arrival_time, v.physician_time) * 1.0), 2) AS avg_wait_time_minutes
FROM stg_ed_visits v
JOIN Dim_Facility f ON v.facility_code = f.facility_code
JOIN Dim_Acuity a ON v.ctas_score = a.ctas_score
WHERE v.arrival_time >= '2026-08-01' 
  AND v.arrival_time < '2026-09-01'
  AND v.physician_time IS NOT NULL 
  AND v.physician_time >= v.arrival_time
GROUP BY 
    f.facility_code,
    a.ctas_score,
    a.ctas_description
ORDER BY 
    f.facility_code ASC, 
    a.ctas_score ASC;
