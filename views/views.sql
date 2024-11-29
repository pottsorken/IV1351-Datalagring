
-- 1. Show the number of lessons given per month during a specified year.
CREATE VIEW lessons_per_month AS
SELECT 
    TO_CHAR(a.date, 'Mon') AS Month,
    COUNT(a.lesson_id) AS Total, 
    SUM(CASE WHEN i.lesson_id IS NOT NULL THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN g.lesson_id IS NOT NULL THEN 1 ELSE 0 END) AS Group,
    SUM(CASE WHEN e.lesson_id IS NOT NULL THEN 1 ELSE 0 END) AS Ensemble
FROM 
    lesson AS a
LEFT JOIN individual_lesson AS i ON a.lesson_id = i.lesson_id
LEFT JOIN group_lesson AS g ON a.lesson_id = g.lesson_id
LEFT JOIN ensemble_lesson AS e ON a.lesson_id = e.lesson_id
WHERE 
    a.state_id = 3 AND
    EXTRACT(YEAR FROM a.date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 
    TO_CHAR(a.date, 'Mon'),
    EXTRACT(MONTH FROM a.date)
ORDER BY EXTRACT(MONTH FROM a.date) ASC;


-- 2. Show how many students there are with no sibling, with one sibling, with two siblings, etc.

CREATE VIEW student_sibling AS
WITH group_siblings AS (
    SELECT COUNT(s.*) AS nSiblings
    FROM student AS s
    GROUP BY sibling_id
    HAVING s.sibling_id IS NOT NULL
)
-- Insert one tuple that count those without siblings
(SELECT 0 AS nsiblings, COUNT(*) AS nStudents 
FROM student
WHERE student.sibling_id IS NULL OR student.sibling_id = 1)
UNION ALL
-- Sum the sibling groupings
(SELECT (gs.nsiblings - 1) AS n_siblings, SUM(gs.nsiblings) AS n_students
FROM group_siblings AS gs
WHERE gs.nSiblings <> 1 -- Non-1 values
GROUP BY gs.nSiblings
ORDER BY gs.nSiblings ASC);



-- 3. List ids and names of all instructors who has given more than a specific number of lessons during the current month.

CREATE VIEW instructor_lessons AS
WITH group_of_lessons AS (
    SELECT l.instructor_id AS instructor_id, COUNT(l.*) AS nLessons
    FROM lesson AS l
    WHERE EXTRACT(MONTH FROM l.date) = EXTRACT(MONTH FROM CURRENT_DATE)
    GROUP BY l.instructor_id
)
SELECT
    i.instructor_id,
    i.name,
    group_of_lessons.nLessons
FROM
    instructor AS i
INNER JOIN 
    group_of_lessons
    ON i.instructor_id = group_of_lessons.instructor_id
WHERE group_of_lessons.nLessons > 1 -- Hardcoded
ORDER BY 
    group_of_lessons.nLessons DESC;



-- 4. List all ensembles held during the next week
CREATE VIEW ensembles AS 
SELECT 
    TO_CHAR(e.date, 'Day') AS Day,
    e.genre AS Genre,
    CASE 
        WHEN (e.max_number_of_students - e.registered_number_of_students) <= 0 THEN 'No Seats'
        WHEN (e.max_number_of_students - e.registered_number_of_students) >= 1 AND 
             (e.max_number_of_students - e.registered_number_of_students) <= 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS no_of_free_seats
FROM 
    ensemble_lesson AS e
WHERE 
    EXTRACT(WEEK FROM e.date) = EXTRACT(WEEK FROM CURRENT_DATE) + 1
ORDER BY
    e.genre ASC, 
    Day ASC;


