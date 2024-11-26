
-- TODO: Limit scope to a specific year
-- Can be a static implementation
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
    a.state_id = 3
GROUP BY 
    TO_CHAR(a.date, 'Mon'),
    EXTRACT(MONTH FROM a.date)
ORDER BY EXTRACT(MONTH FROM a.date) ASC;


-- NOTE: Complete!
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
WHERE student.sibling_id IS NULL)
UNION ALL
-- Sum the sibling groupings
(SELECT gs.nsiblings, SUM(gs.nsiblings) AS nStudents
FROM group_siblings AS gs
GROUP BY gs.nSiblings
ORDER BY gs.nSiblings ASC);


-- NOTE: Complete! 
-- 3. List ids and names of all instructors who has given more than a specific number of lessons during the current month.

CREATE VIEW instructor_lessons AS
WITH group_lessons AS (
    SELECT l.instructor_id AS instructor_id, COUNT(l.*) AS nLessons
    FROM lesson AS l
    WHERE EXTRACT(MONTH FROM l.date) = EXTRACT(MONTH FROM CURRENT_DATE)
    GROUP BY l.instructor_id
)
SELECT
    i.instructor_id,
    i.name,
    group_lessons.nLessons
FROM
    instructor AS i
INNER JOIN 
    group_lessons
    ON i.instructor_id = group_lessons.instructor_id
WHERE group_lessons.nLessons > 1 -- Hardcoded
ORDER BY 
    group_lessons.nLessons DESC;


-- TODO: 
-- 4. List all ensembles held during the next week




