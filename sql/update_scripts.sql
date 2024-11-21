
-- UPDATE REGISTERED NUMBER OF STUDENTS
--GROUP LESSON
UPDATE group_lesson gl
SET registered_number_of_students = (
    SELECT COUNT(sl.student_id)
    FROM student_lesson sl
    WHERE sl.lesson_id = gl.lesson_id
);
--WHERE gl.lesson_id BETWEEN 11 AND 20;

--ENSAMBLE LESSON
UPDATE ensemble_lesson el
SET registered_number_of_students = (
    SELECT COUNT(sl.student_id)
    FROM student_lesson sl
    WHERE sl.lesson_id = el.lesson_id
);
--WHERE el.lesson_id BETWEEN 21 AND 26;


-- UPDATE INSTRUMENT_QUOTA IN STUDENT
UPDATE student s
SET instrument_quota = GREATEST(
    s.instrument_quota - (
        -- Subquery to count active leases for the student
        SELECT COUNT(*)
        FROM lease l
        WHERE l.student_id = s.student_id AND l.active = TRUE
    ), 
    0
);






