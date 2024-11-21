-- This file contains data for our help tables, i.e. those who begin with aternative_


-- DATA FOR ALTERNATIVE_INSTRUMENT
INSERT INTO lookup_instrument (instrument_type) VALUES ('Piano'), ('Violin'), ('Flute'), ('Trumpet'), ('Drums'), ('Saxophone'), ('Guitar'), ('Cello'), ('Clarinet'), ('Accordion');

-- DATA FOR ALTERNATIVE_LEVEL
INSERT INTO lookup_level (level) VALUES ('Beginner'), ('Intermediate'), ('Advanced');

-- DATA FOR ALTERNATIVE_STATE
INSERT INTO lookup_state (state) VALUES ('Booked'), ('Confirmed'), ('Completed'), ('Cancelled');

-- DATA FOR TIMESLOT
INSERT INTO timeslot (start_of_slot, end_of_slot) VALUES
(07:00:00, 08:00:00),
(08:00:00, 09:00:00),
(09:00:00, 10:00:00),
(10:00:00, 11:00:00),
(11:00:00, 12:00:00),
(12:00:00, 13:00:00),
(13:00:00, 14:00:00),
(14:00:00, 15:00:00),
(15:00:00, 16:00:00),
(16:00:00, 17:00:00),
(17:00:00, 18:00:00),
(18:00:00, 19:00:00),
(19:00:00, 20:00:00),
(20:00:00, 21:00:00),
(21:00:00, 22:00:00);

-- DATA FOR TIMESLOT_LESSON ...


-- DATA FOR LOOKUP_LESSON
INSERT INTO lookup_lesson (type) VALUES ('Individual'), ('Group'), ('Ensemble');

-- DATA FOR PRICING.. old prices are false and costs 500kr less
INSERT INTO pricing (lookup_lesson_id, level_id, cost, valid) VALUES
(1, 1, 750, TRUE),
(2, 1, 1000, TRUE),
(3, 1, 1250, TRUE),
(1, 2, 1000, TRUE),
(2, 2, 1250, TRUE),
(3, 2, 1500, TRUE),
(1, 3, 1250, TRUE),
(2, 3, 1500, TRUE),
(3, 3, 1750, TRUE),
(1, 1, 250, FALSE),
(2, 1, 500, FALSE),
(3, 1, 750, FALSE),
(1, 2, 500, FALSE),
(2, 2, 750, FALSE),
(3, 2, 1000, FALSE),
(1, 3, 750, FALSE),
(2, 3, 1000, FALSE),
(3, 3, 1250, FALSE);
