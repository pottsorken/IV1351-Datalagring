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
    TO_CHAR(a.date, 'Mon')
ORDER BY TO_CHAR(a.date, 'Mon') ASC;








-- 2. Show how many students there are with no sibling, with one sibling, with two siblings, etc.

from students
first column: num of siblings
second column: elect all with sibling id





-- 3. List ids and names of all instructors who has given more than a specific number of lessons during the current month.



