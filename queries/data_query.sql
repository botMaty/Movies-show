INSERT INTO Directors (dname, photo_path) VALUES
('Christopher Nolan', '/photo/directors/christopher_nolan.jpg'),
('Steven Spielberg', '/photo/directors/steven_spielberg.jpg'),
('Quentin Tarantino', '/photo/directors/quentin_tarantino.jpg'),
('Jeff Fowler', '/photo/directors/jeff_fowler.jpg'),
('John McTiernan', '/photo/directors/john_mctiernan.jpg'),
('Renny Harlin', '/photo/directors/renny_harlin.jpg'),
('Matt Reeves', '/photo/directors/matt_reeves.jpg'),
('Chad Stahelski', '/photo/directors/chad_stahelski.jpg');

INSERT INTO Movies (mname, title, initial_release, rate, did, poster_path) VALUES
('Inception', 'A mind-bending thriller', '2010-07-16', 8.8, 1, '/photo/posters/inception.jpg'),
('Jurassic Park', 'Dinosaurs come to life', '1993-06-11', 8.1, 2, '/photo/posters/jurassic_park.jpg'),
('Pulp Fiction', 'Crime stories intertwined', '1994-10-14', 8.9, 3, '/photo/posters/pulp_fiction.jpg'),
('The Dark Knight', 'Batman battles Joker in Gotham', '2008-07-18', 9.0, 1, '/photo/posters/dark_knight.jpg'),
('Sonic the Hedgehog', 'Fast blue hedgehog vs. Robotnik', '2020-02-14', 6.5, 4, '/photo/posters/sonic1.jpg'),
('Sonic the Hedgehog 2', 'Sonic returns with Tails and Knuckles', '2022-04-08', 6.6, 4, '/photo/posters/sonic2.jpg'),
('Sonic the Hedgehog 3', 'Sonic faces new threat', '2024-12-20', 0.0, 4, '/photo/posters/sonic3.jpg'),
('Die Hard', 'NYPD officer battles terrorists in LA skyscraper', '1988-07-15', 8.2, 5, '/photo/posters/diehard1.jpg'),
('Die Hard 2', 'Terrorists take over an airport', '1990-07-04', 7.1, 6, '/photo/posters/diehard2.jpg'),
('Die Hard with a Vengeance', 'McClane teams with a Harlem store owner vs. bomber', '1995-05-19', 7.6, 5, '/photo/posters/diehard3.jpg'),
('John Wick', 'An ex-hitman seeks vengeance for his dog', '2014-10-24', 7.4, 8, '/photo/posters/john_wick1.jpg'),
('John Wick: Chapter 2', 'John returns to the underworld', '2017-02-10', 7.5, 8, '/photo/posters/john_wick2.jpg'),
('John Wick: Chapter 3 – Parabellum', 'John is on the run with a bounty on his head', '2019-05-17', 7.4, 8, '/photo/posters/john_wick3.jpg'),
('John Wick: Chapter 4', 'John takes the fight to the High Table', '2023-03-24', 7.8, 8, '/photo/posters/john_wick4.jpg');

INSERT INTO Genres (gname) VALUES
('Sci-Fi'),
('Action'),
('Adventure'),
('Drama'),
('Crime'),
('Thriller'),
('Animation'),
('Biography'),
('Comedy'),
('Documentary'),
('Family'),
('Fantasy'),
('Film-Noir'),
('History'),
('Horror'),
('Music'),
('Musical'),
('Mystery'),
('Romance'),
('Sport'),
('War'),
('Western');

INSERT INTO Actors (aname, photo_path) VALUES
('Leonardo DiCaprio', '/photo/actors/leo.jpg'),
('Sam Neill', '/photo/actors/sam_neill.jpg'),
('John Travolta', '/photo/actors/travolta.jpg'),
('Samuel L. Jackson', '/photo/actors/samuel.jpg'),
('Uma Thurman', '/photo/actors/uma.jpg'),
('Christian Bale', '/photo/actors/christian_bale.jpg'),
('Heath Ledger', '/photo/actors/heath_ledger.jpg'),
('Ben Schwartz', '/photo/actors/ben_schwartz.jpg'),
('Jim Carrey', '/photo/actors/jim_carrey.jpg'),
('Idris Elba', '/photo/actors/idris_elba.jpg'),
('Bruce Willis', '/photo/actors/bruce_willis.jpg'),
('Keanu Reeves', '/photo/actors/keanu.jpg'),
('Aaron Eckhart', '/photo/actors/aaron_eckhart.jpg'),
('Michael Caine', '/photo/actors/michael_caine.jpg'),
('Maggie Gyllenhaal', '/photo/actors/maggie_gyllenhaal.jpg'),
('Gary Oldman', '/photo/actors/gary_oldman.jpg'),
('Morgan Freeman', '/photo/actors/morgan_freeman.jpg');

-- Inception
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(1, 1, 'Dom Cobb');

-- Jurassic Park
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(2, 2, 'Dr. Alan Grant');

-- Pulp Fiction
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(3, 3, 'Vincent Vega'),
(3, 4, 'Jules Winnfield'),
(3, 5, 'Mia Wallace');

-- The Dark Knight
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(4, 6, 'Bruce Wayne / Batman'),
(4, 7, 'Joker'),
(4, 13, 'Harvey Dent'),
(4, 14, 'Alfred Pennyworth'),
(4, 15, 'Rachel Dawes'),
(4, 16, 'James Gordon'),
(4, 17, 'Lucius Fox');

-- Sonic 1
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(5, 8, 'Sonic'),
(5, 9, 'Dr. Robotnik');

-- Sonic 2
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(6, 8, 'Sonic'),
(6, 9, 'Dr. Robotnik'),
(6, 10, 'Knuckles');

-- Sonic 3
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(7, 8, 'Sonic'),
(7, 10, 'Knuckles'),
(7, 12, 'Shadow');

-- Die Hard 1–3
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(8, 11, 'John McClane'),
(9, 11, 'John McClane'),
(10, 11, 'John McClane'),
(10, 4, 'Zeus Carver');  -- Samuel L. Jackson

-- John Wick 1–4
INSERT INTO Movies_cast (mid, aid, role_in_movie) VALUES
(11, 12, 'John Wick'),
(12, 12, 'John Wick'),
(13, 12, 'John Wick'),
(14, 12, 'John Wick');

-- Inception
INSERT INTO Movies_genres (mid, gid) VALUES (1, 1), (1, 2), (1, 6);

-- Jurassic Park
INSERT INTO Movies_genres (mid, gid) VALUES (2, 1), (2, 3);

-- Pulp Fiction
INSERT INTO Movies_genres (mid, gid) VALUES (3, 4), (3, 5);

-- The Dark Knight
INSERT INTO Movies_genres (mid, gid) VALUES (4, 2), (4, 5), (4, 6);

-- Sonic
INSERT INTO Movies_genres (mid, gid) VALUES
(5, 1), (5, 3),
(6, 1), (6, 2), (6, 3),
(7, 1), (7, 2), (7, 3);

-- Die Hard
INSERT INTO Movies_genres (mid, gid) VALUES
(8, 2), (8, 6),
(9, 2), (9, 6),
(10, 2), (10, 6);

-- John Wick
INSERT INTO Movies_genres (mid, gid) VALUES
(11, 2), (11, 6),
(12, 2), (12, 6),
(13, 2), (13, 6),
(14, 2), (14, 6);