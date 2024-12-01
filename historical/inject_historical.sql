

INSERT INTO student_lesson_record(lesson_type, genre, instrument_type_id, price, student_name, student_email)
SELECT
    'Individual' AS lesson_type,
    NULL AS genre,
    l.instrument_type_id,
    p.cost,
    s.name AS student_name,
    s.email AS student_email
FROM
    individual_lesson AS l
INNER JOIN student_lesson AS c ON l.lesson_id = c.lesson_id
INNER JOIN student AS s ON s.student_id = c.student_id
INNER JOIN pricing AS p ON l.pricing_id = p.pricing_id;
 


INSERT INTO student_lesson_record(lesson_type, genre, instrument_type_id, price, student_name, student_email)
SELECT
    'Group' AS lesson_type,
    NULL AS genre,
    l.instrument_type_id,
    p.cost,
    s.name AS student_name,
    s.email AS student_email
FROM
    group_lesson AS l
INNER JOIN student_lesson AS c ON l.lesson_id = c.lesson_id
INNER JOIN student AS s ON s.student_id = c.student_id
INNER JOIN pricing AS p ON l.pricing_id = p.pricing_id;
 


INSERT INTO student_lesson_record(lesson_type, genre, instrument_type_id, price, student_name, student_email)
SELECT
    'Ensemble' AS lesson_type,
    l.genre AS genre,
    NULL AS instrument_type_id,
    p.cost,
    s.name AS student_name,
    s.email AS student_email
FROM
    ensemble_lesson AS l
INNER JOIN student_lesson AS c ON l.lesson_id = c.lesson_id
INNER JOIN student AS s ON s.student_id = c.student_id
INNER JOIN pricing AS p ON l.pricing_id = p.pricing_id;

