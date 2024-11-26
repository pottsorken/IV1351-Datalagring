
-- Insert into lesson table for individual_lesson
INSERT INTO lesson (level_id, date, state_id, location, pricing_id, instructor_id)
VALUES
(1, '2024-11-21', 2, 'Room M', 5, 12),
(2, '2024-11-22', 1, 'Room N', 10, 18),
(3, '2024-11-23', 3, 'Room O', 7, 24),
(1, '2024-11-24', 4, 'Room P', 3, 9),
(2, '2024-11-25', 2, 'Room Q', 12, 15),
(3, '2024-11-26', 1, 'Room R', 8, 30),
(1, '2024-11-27', 3, 'Room S', 6, 5),
(2, '2024-11-28', 4, 'Room T', 11, 20),
(3, '2024-11-29', 2, 'Room U', 14, 27),
(1, '2024-11-30', 1, 'Room V', 4, 33);

-- Insert into individual_lesson, inheriting from lesson
INSERT INTO individual_lesson (lesson_id, instrument_type_id)
VALUES
(1, 3),
(2, 7),
(3, 5),
(4, 9),
(5, 1),
(6, 8),
(7, 10),
(8, 4),
(9, 6),
(10, 2);

-- Insert into lesson table for group_lesson
INSERT INTO lesson (level_id, date, state_id, location, pricing_id, instructor_id)
VALUES
(3, '2024-12-01', 1, 'Room E', 5, 11),
(2, '2024-12-02', 2, 'Room F', 9, 25),
(1, '2024-12-03', 3, 'Room H', 12, 19),
(3, '2024-12-04', 4, 'Room I', 6, 8),
(2, '2024-12-05', 1, 'Room A', 7, 26),
(1, '2024-12-06', 2, 'Room F', 14, 13),
(3, '2024-12-07', 3, 'Room E', 3, 37),
(2, '2024-12-08', 4, 'Room B', 10, 21),
(1, '2024-12-09', 1, 'Room C', 11, 4),
(3, '2024-12-10', 2, 'Room D', 8, 36);

-- Insert into group_lesson, inheriting from lesson
INSERT INTO group_lesson (lesson_id, instrument_type_id, max_number_of_students, min_number_of_students, registered_number_of_students)
VALUES
(11, 2, 15, 5, 10),
(12, 7, 20, 6, 12),
(13, 5, 18, 4, 14),
(14, 9, 25, 8, 20),
(15, 1, 12, 6, 8),
(16, 8, 22, 5, 19),
(17, 4, 16, 7, 14),
(18, 10, 19, 6, 18),
(19, 3, 17, 5, 13),
(20, 6, 23, 9, 21);

-- Insert into lesson table for ensemble_lesson
INSERT INTO lesson (level_id, date, state_id, location, pricing_id, instructor_id)
VALUES
(1, '2024-12-11', 3, 'Room A', 8, 14),
(2, '2024-12-12', 4, 'Room B', 11, 34),
(3, '2024-12-13', 1, 'Room C', 5, 22),
(1, '2024-12-14', 2, 'Room D', 9, 29),
(2, '2024-12-15', 3, 'Room E', 4, 16),
(3, '2024-12-16', 4, 'Room F', 13, 28),
(1, '2024-12-17', 1, 'Room A', 6, 32),
(2, '2024-12-18', 2, 'Room B', 7, 6),
(3, '2024-12-19', 3, 'Room C', 10, 17),
(1, '2024-12-20', 4, 'Room D', 12, 35);

-- Insert into ensemble_lesson, inheriting from lesson
INSERT INTO ensemble_lesson (lesson_id, genre, max_number_of_students, min_number_of_students, registered_number_of_students)
VALUES
(21, 'Classical', 10, 5, 7),
(22, 'Jazz', 15, 7, 12),
(23, 'Rock', 12, 6, 8),
(24, 'Pop', 18, 5, 14),
(25, 'Blues', 20, 8, 16),
(26, 'Hip-hop', 25, 9, 22),
(27, 'Folk', 14, 6, 11),
(28, 'Country', 19, 7, 15),
(29, 'Electronic', 13, 5, 10),
(30, 'Reggae', 22, 8, 18);



-- DATA FOR STUDENT_LESSON --
-- INDIVDUAL LESSONS
INSERT INTO student_lesson (student_id, lesson_id)
VALUES
    (1, 1),  -- Student 1 attends Individual Lesson 1
    (2, 2),  -- Student 2 attends Individual Lesson 2
    (3, 3),  -- Student 3 attends Individual Lesson 3
    (4, 4),  -- Student 4 attends Individual Lesson 4
    (5, 5),  -- Student 5 attends Individual Lesson 5
    (6, 6),  -- Student 6 attends Individual Lesson 6
    (7, 7),  -- Student 7 attends Individual Lesson 7
    (8, 8),  -- Student 8 attends Individual Lesson 8
    (9, 9),  -- Student 9 attends Individual Lesson 9
    (10, 10); -- Student 10 attends Individual Lesson 10

-- GROUP LESSONS
INSERT INTO student_lesson (student_id, lesson_id)
VALUES
    (11, 11), (12, 11), (13, 11), (14, 11), (15, 11),  -- 5 students for Group Lesson 1
    (16, 12), (17, 12), (18, 12), (19, 12), (20, 12), (21, 12), (22, 12), -- 7 students for Group Lesson 2
    (23, 13), (24, 13), (25, 13), (26, 13), (27, 13), (28, 13), (29, 13), (30, 13), (31, 13), -- 9 students for Group Lesson 3
    (32, 14), (33, 14), (34, 14), -- 3 students for Group Lesson 4
    (35, 15), (36, 15), (37, 15), (38, 15), (39, 15), (40, 15), (41, 15), (42, 15), (43, 15), (44, 15), -- 10 students for Group Lesson 5
    (45, 16), (46, 16), (47, 16), (48, 16), (49, 16), (50, 16), (51, 16), (52, 16), (53, 16), (54, 16), (55, 16), -- 11 students for Group Lesson 6
    (56, 17), (57, 17), (58, 17), (59, 17), -- 4 students for Group Lesson 7
    (60, 18), (61, 18), (62, 18), (63, 18), (64, 18), -- 5 students for Group Lesson 8
    (65, 19), (66, 19), (67, 19), (68, 19), (69, 19), (70, 19), -- 6 students for Group Lesson 9
    (71, 20), (72, 20), (73, 20), (74, 20), (75, 20), (76, 20), (77, 20), (78, 20); -- 8 students for Group Lesson 10

--ENSAMBLE LESSON
INSERT INTO student_lesson (student_id, lesson_id)
VALUES
    (79, 21), (80, 21), (81, 21), -- 3 students for Ensamble Lesson 1
    (82, 22), (83, 22), (84, 22), (85, 22), (86, 22), -- 5 students for Ensamble Lesson 2
    (87, 23), (88, 23), (89, 23), (90, 23), (91, 23), (92, 23), (93, 23), -- 7 students for Ensamble Lesson 3
    (94, 24), (95, 24), (96, 24), -- 3 students for Ensamble Lesson 4
    (97, 25), (98, 25), (99, 25), (100, 25), -- 4 students for Ensamble Lesson 5
    (101, 26), (102, 26), (103, 26), (104, 26); -- 4 students for Ensamble Lesson 6


-- DATA FOR TIMESLOT_LESSON
-- INDIVIDUAL LESSON
INSERT INTO timeslot_lesson (lesson_id, slot_id)
VALUES
    (1, 3), -- Lesson 1 at 09:00-10:00
    (2, 5), -- Lesson 2 at 11:00-12:00
    (3, 7), -- Lesson 3 at 13:00-14:00
    (4, 9), -- Lesson 4 at 15:00-16:00
    (5, 11), -- Lesson 5 at 17:00-18:00
    (6, 13), -- Lesson 6 at 19:00-20:00
    (7, 2), -- Lesson 7 at 08:00-09:00
    (8, 4), -- Lesson 8 at 10:00-11:00
    (9, 6), -- Lesson 9 at 12:00-13:00
    (10, 8); -- Lesson 10 at 14:00-15:00


-- GROUP LESSON
INSERT INTO timeslot_lesson (lesson_id, slot_id)
VALUES
    (11, 2), -- Group Lesson 1 at 08:00-09:00
    (12, 4), -- Group Lesson 2 at 10:00-11:00
    (13, 6), -- Group Lesson 3 at 12:00-13:00
    (14, 8), -- Group Lesson 4 at 14:00-15:00
    (15, 10), -- Group Lesson 5 at 16:00-17:00
    (16, 12), -- Group Lesson 6 at 18:00-19:00
    (17, 14), -- Group Lesson 7 at 20:00-21:00
    (18, 3), -- Group Lesson 8 at 09:00-10:00
    (19, 5), -- Group Lesson 9 at 11:00-12:00
    (20, 7); -- Group Lesson 10 at 13:00-14:00

-- ENSEMBLE LESSON
INSERT INTO timeslot_lesson (lesson_id, slot_id)
VALUES
    (21, 1), -- Ensamble Lesson 1 at 07:00-08:00
    (22, 3), -- Ensamble Lesson 2 at 09:00-10:00
    (23, 5), -- Ensamble Lesson 3 at 11:00-12:00
    (24, 7), -- Ensamble Lesson 4 at 13:00-14:00
    (25, 9), -- Ensamble Lesson 5 at 15:00-16:00
    (26, 11), -- Ensamble Lesson 6 at 17:00-18:00
    (27, 13), -- Ensamble Lesson 7 at 19:00-20:00
    (28, 2), -- Ensamble Lesson 8 at 08:00-09:00
    (29, 4), -- Ensamble Lesson 9 at 10:00-11:00
    (30, 6); -- Ensamble Lesson 10 at 12:00-13:00
