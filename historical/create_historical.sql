
CREATE DATABASE historical_soundgood;

\c historical_soundgood

CREATE TYPE lesson_t AS ENUM ('Individual', 'Group', 'Ensemble');

-- Create help table
CREATE TABLE lookup_instrument (
    instrument_type_id SERIAL PRIMARY KEY,
    instrument_type VARCHAR(100) UNIQUE NOT NULL
);

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


INSERT INTO lookup_instrument (instrument_type) 
VALUES  ('Piano'), ('Violin'), ('Flute'), 
        ('Trumpet'), ('Drums'), ('Saxophone'), 
        ('Guitar'), ('Cello'), ('Clarinet'), 
        ('Accordion');



