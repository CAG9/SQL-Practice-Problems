-- write a query that list subject and the number of the situdents taking the course only if 
--the course has three or more students enrolled
SELECT s1.subject_name, COUNT(*) AS 'students_counts'
FROM table1 as s1
JOIN table2 as s2
ON s1.subject_id = s23.subject_id
GROUP BY s1.subject_names
HAVING COUNT(*) >=3 ;


-- write the cities taht have students with max score above 80 OR cities taht have more than on estudents enrolled
-- aldpabetic 
SELECT s1.cities
FROM table1 as s1
JOIN table2 as s2
ON s1.students_id = s2.students.id
WHERE s2.grades > 80;

UNION 

SELECT s1.cities
FROM table1 as s1
GROUP BY s1.cities
having COUNT(*) > 1

ORDER BY city ASC;

--query list all the students and subjects, with the status , date last assignmets
-- 1- if there no score pending
--   5.0 or more approved
--   less tan 5. exam


WITH ranked_assignments AS (
    SELECT 
        student_id,
        subject_id,
        score,
        submission_date,
        ROW_NUMBER() OVER(
            PARTITION BY student_id, subject_id 
            ORDER BY submission_date DESC
        ) as rn
    FROM kissolutionsllc_ts4x4_assignments
)
SELECT 
    st.student_name,
    sub.subject_name,
    CASE 
        WHEN ra.score IS NULL THEN 'Pending'
        WHEN ra.score >= 5.0 THEN 'Approved'
        ELSE 'Exam'
    END AS status,
    ra.submission_date AS last_submission_date
FROM kissolutionsllc_ts4x4_students st
JOIN kissolutionsllc_ts4x4_subjects sub 
    ON st.subject_id = sub.subject_id
LEFT JOIN ranked_assignments ra 
    ON st.student_id = ra.student_id 
    AND st.subject_id = ra.subject_id
    AND ra.rn = 1
ORDER BY st.student_name ASC;














--Get the Most Recent Assignment per Student and Subject

WITH ranked_assignments AS (
    SELECT 
        student_id,
        subject_id,
        score,
        submission_date,
        ROW_NUMBER() OVER(
            PARTITION BY student_id, subject_id 
            ORDER BY submission_date DESC
        ) as rn
    FROM kissolutionsllc_ts4x4_assignments
)
-- Step 2: Join Students, Subjects, and the Filtered Assignments
-- Note: Use LEFT JOIN so students or subjects without assignments aren't dropped!
    
SELECT 
    st.student_name,
    sub.subject_name,

-- Step 3: Map the Score to the Required Status using CASE    
    CASE 
        WHEN ra.score IS NULL THEN 'Pending'
        WHEN ra.score >= 5.0 THEN 'Approved'
        ELSE 'Exam'
    END AS status,
    ra.submission_date AS last_submission_date
FROM kissolutionsllc_ts4x4_students st
JOIN kissolutionsllc_ts4x4_subjects sub 
    ON st.subject_id = sub.subject_id
LEFT JOIN ranked_assignments ra 
    ON st.student_id = ra.student_id 
    AND st.subject_id = ra.subject_id
    AND ra.rn = 1
ORDER BY st.student_name ASC;
