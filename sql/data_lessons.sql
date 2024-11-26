
-- DATA FOR INDIVIDUAL_LESSON
INSERT INTO individual_lesson (level_id, date, state_id, location, pricing_id, instructor_id, instrument_type_id)
VALUES
    (2, '2024-11-30', 1, 'Room J', 4, 33, 9),
    (1, '2024-12-01', 2, 'Room K', 5, 12,  7),
    (2, '2024-12-02', 4, 'Room L', 10, 18,  4),
    (3, '2024-12-03', 3, 'Room M', 7, 5,  6),
    (1, '2024-12-04', 1, 'Room N', 12, 25,  8),
    (3, '2024-12-05', 3, 'Room O', 3, 20,  2),
    (2, '2024-12-06', 4, 'Room P', 9, 30,  10),
    (1, '2024-12-07', 2, 'Room Q', 4, 8,  5),
    (2, '2024-12-08', 1, 'Room R', 8, 35,  1),
    (3, '2024-12-09', 3, 'Room S', 15, 22,  9);
 --   (1, '2024-12-10', 2, 'Room T', 18, 29, 12, 3);

-- DATA FOR GROUP_LESSON
    INSERT INTO group_lesson (level_id, date, state_id, location, pricing_id, instructor_id, instrument_type_id, max_number_of_students, min_number_of_students, registered_number_of_students)
    VALUES
    (1, '2024-11-21', 2, 'Room A', 3, 5,  1, 10, 5, 0),
    (2, '2024-11-22', 4, 'Room B', 12, 8,  4, 15, 7, 0),
    (3, '2024-11-23', 1, 'Room C', 7, 20,  3, 20, 10, 0),
    (1, '2024-11-24', 3, 'Room D', 2, 15,  2, 12, 6, 0),
    (2, '2024-11-25', 4, 'Room E', 9, 25,  6, 18, 8, 0),
    (3, '2024-11-26', 2, 'Room F', 11, 18,  7, 25, 10, 0),
    (1, '2024-11-27', 1, 'Room G', 5, 35,  8, 30, 12, 0),
    (2, '2024-11-28', 3, 'Room H', 14, 29,  5, 20, 8, 0),
    (3, '2024-11-29', 4, 'Room I', 16, 10,  10, 15, 5, 0),
    (3, '2024-11-30', 3, 'Room J', 16, 10,  10, 15, 5, 0);

    --  DATA FOR ENSEMBLE
    INSERT INTO ensemble_lesson (level_id, date, state_id, location, pricing_id, instructor_id, genre, max_number_of_students, min_number_of_students, registered_number_of_students)
    VALUES
    (1, '2024-11-21', 2, 'Room A', 3, 5,  'Jazz', 15, 5, 0),
    (2, '2024-11-22', 4, 'Room B', 12, 8,  'Classical', 20, 8, 0),
    (3, '2024-11-23', 1, 'Room C', 7, 20,  'Pop', 25, 10, 0),
    (1, '2024-11-24', 3, 'Room D', 2, 15,  'Rock', 30, 12, 0),
    (2, '2024-11-25', 4, 'Room E', 9, 25,  'Blues', 18, 6, 0),
    (3, '2024-11-26', 2, 'Room F', 11, 18,  'Folk', 22, 9, 0),
    (1, '2024-11-27', 1, 'Room G', 5, 35,  'Hip-hop', 25, 10, 0),
    (2, '2024-11-28', 3, 'Room H', 14, 29,  'Latin', 18, 7, 0),
    (3, '2024-11-29', 4, 'Room I', 16, 10,  'Reggae', 20, 8, 0),
    (2, '2024-11-30', 1, 'Room J', 4, 33,  'Electronic', 15, 5, 0);



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
