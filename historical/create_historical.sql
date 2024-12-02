
CREATE TYPE lesson_t AS ENUM ('Individual', 'Group', 'Ensemble');

CREATE TABLE student_lesson_record (
    id SERIAL PRIMARY KEY,
    lesson_type lesson_t NOT NULL,
    genre VARCHAR(100),
    instrument_type_id int,
    price float NOT NULL,
    student_name VARCHAR(100),
    student_email VARCHAR(100),

    FOREIGN KEY (instrument_type_id) REFERENCES lookup_instrument (instrument_type_id)
);

