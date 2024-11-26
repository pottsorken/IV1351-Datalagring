-- Create the database for the Soundgood music school
CREATE DATABASE soundgoodmusic;

-- Navigate in to the new database
\c soundgoodmusic;


--FOREIGN KEYS FIRST
-- Create help tables
CREATE TABLE lookup_instrument (
    instrument_type_id SERIAL PRIMARY KEY,
    instrument_type VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE lookup_level (
    level_id SERIAL PRIMARY KEY,
    level VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE lookup_state (
    state_id SERIAL PRIMARY KEY,
    state VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE lookup_lesson (
    lookup_lesson_id SERIAL PRIMARY KEY,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE pricing (
    pricing_id  SERIAL PRIMARY KEY,
    lookup_lesson_id INT NOT NULL,
    level_id INT NOT NULL,
    cost FLOAT NOT NULL,
    valid BOOLEAN NOT NULL,
--    valid_from DATE NOT NULL,
--    valid_to DATE,

    FOREIGN KEY (lookup_lesson_id) REFERENCES lookup_lesson (lookup_lesson_id),
    FOREIGN KEY (level_id) REFERENCES lookup_level (level_id)
);

CREATE TABLE contact_person (
    contactperson_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL, 
    phone_number VARCHAR(18) NOT NULL, 
    email VARCHAR(100) NOT NULL,
    relation VARCHAR(100)
);


CREATE TABLE sibling (
    sibling_id SERIAL PRIMARY KEY
);
-- Create tables
CREATE TABLE student (
    student_id SERIAL PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    personal_number VARCHAR(13) UNIQUE NOT NULL, 
    sibling_id INT, 
    instrument_quota INT, 
    phone_number VARCHAR(18) NOT NULL, 
    email VARCHAR(100) NOT NULL, 
    contactperson_id INT, 
    street_name_and_number VARCHAR(100) NOT NULL, 
    postal_code VARCHAR(6) NOT NULL, 
    city VARCHAR(100) NOT NULL, 

    FOREIGN KEY (contactperson_id) REFERENCES contact_person (contactperson_id),
    FOREIGN KEY (sibling_id) REFERENCES sibling (sibling_id)
    );



CREATE TABLE instructor (
    instructor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    personal_number VARCHAR(13) UNIQUE NOT NULL,
    phone_number VARCHAR(18) NOT NULL, 
    email VARCHAR(100) NOT NULL,
    street_name_and_number VARCHAR(100) NOT NULL, 
    postal_code VARCHAR(6) NOT NULL, 
    city VARCHAR(100) NOT NULL
);

CREATE TABLE instrument_knowledge (
    instructor_id INT NOT NULL, 
    instrument_type_id INT NOT NULL, 
    level_id INT NOT NULL, 

    FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id), 
    FOREIGN KEY (instrument_type_id) REFERENCES lookup_instrument (instrument_type_id), 
    FOREIGN KEY (level_id) REFERENCES lookup_level (level_id), 
    PRIMARY KEY (instructor_id, instrument_type_id) 
);

CREATE TABLE timeslot(
    slot_id SERIAL PRIMARY KEY,
    start_of_slot TIME(0),
    end_of_slot TIME(0)
);
-- LESSONS
CREATE TABLE lesson (
    lesson_id SERIAL PRIMARY KEY, 
    level_id INT NOT NULL,
    date DATE,
    state_id INT NOT NULL,
    location VARCHAR(100),
    pricing_id INT NOT NULL,
    instructor_id INT NOT NULL,

    FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id),
    FOREIGN KEY (pricing_id) REFERENCES pricing (pricing_id),
    FOREIGN KEY (level_id) REFERENCES lookup_level (level_id), 
    FOREIGN KEY (state_id) REFERENCES lookup_state (state_id)

);

-- LEASES AND PAYMENT
CREATE TABLE individual_lesson (
    instrument_type_id INT NOT NULL

) INHERITS (lesson);

CREATE TABLE group_lesson (
    instrument_type_id INT NOT NULL,
    max_number_of_students INT, 
    min_number_of_students INT NOT NULL,
    registered_number_of_students INT NOT NULL,


    FOREIGN KEY (instrument_type_id) REFERENCES lookup_instrument (instrument_type_id)
) INHERITS (lesson);

CREATE TABLE ensemble_lesson (
    genre VARCHAR(100) NOT NULL,
    max_number_of_students INT, 
    min_number_of_students INT NOT NULL,
    registered_number_of_students INT NOT NULL

) INHERITS (lesson);

CREATE TABLE timeslot_lesson (
    lesson_id INT NOT NULL,
    slot_id INT NOT NULL,

    --FOREIGN KEY (slot_id) REFERENCES timeslot (slot_id),
    --FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id),
    PRIMARY KEY (slot_id, lesson_id)
);


CREATE TABLE instrument (
    instrument_id SERIAL PRIMARY KEY,
    instrument_type_id INT NOT NULL, 
    brand VARCHAR(100),
    condition VARCHAR(200),
    lease_price FLOAT NOT NULL,
    on_lease BOOLEAN NOT NULL,

    FOREIGN KEY (instrument_type_id) REFERENCES lookup_instrument (instrument_type_id)
);

CREATE TABLE lease (
    lease_id SERIAL PRIMARY KEY,
    start_of_lease DATE NOT NULL,
    end_of_lease DATE,
    active BOOLEAN NOT NULL,
    done BOOLEAN NOT NULL,
    instrument_id INT NOT NULL,
    student_id INT,

    FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id),
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);



--create relation tables
CREATE TABLE student_lesson (
    student_id INT NOT NULL, 
    lesson_id INT NOT NULL,

    --FOREIGN KEY (student_id) REFERENCES student (student_id),
    --FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id),
    PRIMARY KEY (student_id, lesson_id)
);

