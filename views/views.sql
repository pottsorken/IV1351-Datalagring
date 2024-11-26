
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


-- 2. Show how many students there are with no sibling, with one sibling, with two siblings, etc.
-- NOTE: Complete!

CREATE VIEW student_sibling AS
WITH group_siblings AS (
    SELECT COUNT(s.*) AS nSiblings
    FROM student AS s
    GROUP BY sibling_id
    HAVING s.sibling_id IS NOT NULL
    )
(SELECT 0 AS nsiblings, COUNT(*) AS nStudents -- Insert one tuple that count those without siblings
FROM student
WHERE student.sibling_id IS NULL)
UNION ALL
(SELECT gs.nsiblings, SUM(gs.nsiblings) AS nStudents
FROM group_siblings AS gs
GROUP BY gs.nSiblings
ORDER BY gs.nSiblings ASC);


-- TODO: 
-- 3. List ids and names of all instructors who has given more than a specific number of lessons during the current month.



-- TODO: 
-- 4. List all ensembles held during the next week




