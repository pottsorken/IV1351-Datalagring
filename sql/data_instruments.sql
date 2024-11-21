INSERT INTO instrument (instrument_type_id, brand, condition, lease_price, on_lease) VALUES
(1, 'Yamaha', 'Good condition, minor scratches on body', 250.00, FALSE),
(2, 'Stradivarius', 'Excellent condition, like new', 1500.00, FALSE),
(3, 'Moeck', 'Fair condition, some minor cracks', 90.00, FALSE),
(4, 'Bach', 'Good condition, slight dents', 200.00, FALSE),
(5, 'Pearl', 'Very good condition, no visible damage', 120.00, FALSE),
(6, 'Selmer', 'Brand new, no issues', 220.00, FALSE),
(7, 'Fender', 'Excellent condition, well-maintained', 130.00, FALSE),
(8, 'Giovanni', 'Fair condition, minor wear on body', 180.00, FALSE),
(9, 'Buffet Crampon', 'Good condition, well-kept', 110.00, FALSE),
(10, 'Hohner', 'Excellent condition, barely used', 140.00, FALSE),
(1, 'Kawai', 'Brand new, no signs of wear', 300.00, FALSE),
(2, 'Gibson', 'Good condition, light scuffs', 1700.00, FALSE),
(3, 'Gemeinhardt', 'Fair condition, some keypads need replacing', 95.00, FALSE),
(4, 'Jupiter', 'Very good condition, no dents', 210.00, FALSE),
(5, 'Tama', 'Good condition, some surface wear', 130.00, FALSE),
(6, 'Yamaha', 'Very good condition, like new', 230.00, FALSE),
(7, 'Ibanez', 'Good condition, slightly older model', 140.00, FALSE),
(8, 'Cremonese', 'Excellent condition, looks new', 190.00, FALSE),
(9, 'Yanagisawa', 'Good condition, some minor scratches', 125.00, FALSE),
(10, 'Sennheiser', 'Good condition, works perfectly', 150.00, FALSE),
(1, 'Roland', 'Fair condition, keys slightly worn', 270.00, FALSE),
(2, 'Czech', 'Excellent condition, well-maintained', 1600.00, FALSE),
(3, 'Yamaha', 'Fair condition, missing one key', 85.00, FALSE),
(4, 'Conn', 'Very good condition, no issues', 180.00, FALSE),
(5, 'DW', 'Good condition, minor scratches', 125.00, FALSE),
(6, 'Vandoren', 'Brand new, no signs of wear', 210.00, FALSE),
(7, 'Marshall', 'Good condition, minor scuffs', 150.00, FALSE),
(8, 'Boccherini', 'Fair condition, signs of age', 170.00, FALSE),
(9, 'Pearl', 'Very good condition, excellent tone', 130.00, FALSE),
(10, 'Scherzinger', 'Fair condition, slightly damaged', 160.00, FALSE),
(1, 'Yamaha', 'Good condition, minor scratches', 260.00, FALSE),
(2, 'Stradivarius', 'Excellent condition, almost new', 1550.00, FALSE),
(3, 'Moeck', 'Fair condition, slight cracks', 95.00, FALSE),
(4, 'Bach', 'Good condition, minor dents', 210.00, FALSE),
(5, 'Pearl', 'Very good condition, no visible damage', 125.00, FALSE),
(6, 'Selmer', 'Brand new, no issues', 230.00, FALSE),
(7, 'Fender', 'Excellent condition, well-maintained', 135.00, FALSE),
(8, 'Giovanni', 'Fair condition, some wear', 185.00, FALSE),
(9, 'Buffet Crampon', 'Good condition, well-kept', 115.00, FALSE),
(10, 'Hohner', 'Excellent condition, barely used', 145.00, FALSE),
(1, 'Kawai', 'Brand new, perfect condition', 310.00, FALSE),
(2, 'Gibson', 'Good condition, some light scratches', 1750.00, FALSE),
(3, 'Gemeinhardt', 'Fair condition, some keys need tuning', 100.00, FALSE),
(4, 'Jupiter', 'Very good condition, no damage', 215.00, FALSE),
(5, 'Tama', 'Good condition, minor surface wear', 135.00, FALSE),
(6, 'Yamaha', 'Very good condition, lightly used', 240.00, FALSE),
(7, 'Ibanez', 'Good condition, some wear on body', 145.00, FALSE),
(8, 'Cremonese', 'Excellent condition, no visible damage', 195.00, FALSE),
(9, 'Yanagisawa', 'Good condition, minor scratches', 130.00, FALSE),
(10, 'Sennheiser', 'Good condition, works well', 155.00, FALSE),
(1, 'Roland', 'Fair condition, some keys worn out', 280.00, FALSE),
(2, 'Czech', 'Excellent condition, maintained well', 1620.00, FALSE),
(3, 'Yamaha', 'Fair condition, missing a key', 90.00, FALSE),
(4, 'Conn', 'Very good condition, no visible defects', 190.00, FALSE),
(5, 'DW', 'Good condition, minimal scratches', 130.00, FALSE),
(6, 'Vandoren', 'Brand new, never used', 220.00, FALSE),
(7, 'Marshall', 'Good condition, minor wear', 155.00, FALSE),
(8, 'Boccherini', 'Fair condition, signs of aging', 175.00, FALSE),
(9, 'Pearl', 'Very good condition, great tone', 135.00, FALSE),
(10, 'Scherzinger', 'Fair condition, some minor damage', 165.00, FALSE);

-- DATA FOR LEASE
 -- Generated lease data for the lease table
INSERT INTO lease (start_of_lease, end_of_lease, active, done, instrument_id, student_id)
VALUES
('2023-01-15', '2023-07-15', TRUE, FALSE, 12, 1), -- Active lease for student 1
('2023-04-01', '2023-12-01', TRUE, TRUE, 12, 1), -- Done lease for student 1

('2023-06-10', '2024-06-10', TRUE, FALSE, 18, 2), -- Active lease for student 2
('2023-05-20', '2023-11-20', TRUE, TRUE, 18, 2), -- Done lease for student 2

('2023-02-03', '2023-08-03', TRUE, FALSE, 9, 3),  -- Active lease for student 3
('2023-07-22', '2024-07-22', TRUE, TRUE, 9, 3),  -- Done lease for student 3

('2023-03-15', '2023-09-15', TRUE, FALSE, 40, 4), -- Active lease for student 4
('2023-09-01', '2024-09-01', TRUE, TRUE, 40, 4), -- Done lease for student 4

('2023-06-01', '2024-06-01', TRUE, FALSE, 53, 5), -- Active lease for student 5
('2023-05-01', '2023-11-01', TRUE, TRUE, 53, 5), -- Done lease for student 5

('2023-01-05', '2023-07-05', TRUE, TRUE, 15, 6), -- Done lease for student 6
('2023-06-01', '2024-06-01', TRUE, FALSE, 15, 6), -- Active lease for student 6

('2023-06-15', '2024-06-15', TRUE, FALSE, 25, 7), -- Active lease for student 7
('2023-03-01', '2023-09-01', TRUE, TRUE, 25, 7), -- Done lease for student 7

('2023-03-01', '2023-09-01', TRUE, TRUE, 50, 8), -- Done lease for student 8
('2023-07-01', '2024-07-01', TRUE, FALSE, 50, 8), -- Active lease for student 8

('2023-07-10', '2024-07-10', TRUE, FALSE, 22, 9), -- Active lease for student 9
('2023-09-01', '2024-09-01', TRUE, TRUE, 22, 9), -- Done lease for student 9

('2023-06-30', '2024-06-30', TRUE, TRUE, 17, 10), -- Done lease for student 10
('2023-04-15', '2023-10-15', TRUE, FALSE, 17, 10), -- Active lease for student 10

('2023-05-25', '2023-11-25', TRUE, FALSE, 39, 11), -- Active lease for student 11
('2023-06-20', '2024-06-20', TRUE, TRUE, 39, 11), -- Done lease for student 11

('2023-08-01', '2024-08-01', TRUE, TRUE, 35, 12), -- Done lease for student 12
('2023-07-10', '2024-07-10', TRUE, FALSE, 35, 12), -- Active lease for student 12

('2023-06-25', '2024-06-25', TRUE, FALSE, 18, 13), -- Active lease for student 13
('2023-05-01', '2023-11-01', TRUE, TRUE, 18, 13); -- Done lease for student 13



