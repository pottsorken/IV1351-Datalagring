-- This file contains data for our help tables, i.e. those who begin with aternative_


-- DATA FOR ALTERNATIVE_INSTRUMENT
INSERT INTO alternative_instrument (instrument_type) VALUES ('Piano');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Violin');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Flute');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Trumpet');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Drums');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Saxophone');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Guitar');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Cello');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Clarinet');
INSERT INTO alternative_instrument (instrument_type) VALUES ('Accordion');

-- DATA FOR ALTERNATIVE_LEVEL
INSERT INTO alternative_level (level) VALUES ('Beginner');
INSERT INTO alternative_level (level) VALUES ('Intermediate');
INSERT INTO alternative_level (level) VALUES ('Advanced');

-- DATA FOR ALTERNATIVE_STATE
INSERT INTO alternative_state (state) VALUES ('Booked');
INSERT INTO alternative_state (state) VALUES ('Confirmed');
INSERT INTO alternative_state (state) VALUES ('Completed');
INSERT INTO alternative_state (state) VALUES ('Cancelled');