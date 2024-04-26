----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
--                     Creating Databank
----------------------------------------------------------------------
USE Formula1;
GO

--- Inserting data into Driver table
INSERT INTO Driver (DriverNumber, FirstName, LastName, BirthDate, Age, Nationality, StartYear, CareerPoints, PointsIn2023, WDC, GPentered, GPwins, CurrentDriver)
VALUES
(1, 'Max', 'Verstappen', '1997-09-30', 26, 'NED', 2015, 2586.5, 575, 3, 185, 54, 1),
(44, 'Lewis', 'Hamilton', '1985-01-07', 38, 'GBR', 2007, 4639.5, 234, 7, 332, 103, 1),
(16, 'Charles', 'Leclerc', '1997-10-16', 26, 'MON', 2018, 1074, 206, 0, 125, 5, 1),
(11, 'Sergio', 'Perez', '1990-01-26', 33, 'MEX', 2011, 1486, 285, 0, 258, 6, 1),
(4, 'Lando', 'Norris', '1999-11-13', 24, 'GBR', 2019, 633, 205, 0, 104, 0, 1),
(55, 'Carlos', 'Sainz', '1994-09-01', 29, 'ESP', 2015, 982.5, 200, 0, 185, 2, 1),
(81, 'Oscar', 'Piastri', '2001-04-06', 22, 'AUS', 2023, 97, 97, 0, 22, 0, 1),
(14, 'Fernando', 'Alonso', '1981-07-29', 42, 'ESP', 2001, 2267, 206, 2, 380, 32, 1),
(63, 'George', 'Russell', '1998-02-15', 25, 'GBR', 2019, 469, 175, 0, 104, 1, 1),
(10, 'Pierre', 'Gasly', '1996-02-07', 27, 'FRA', 2017, 394, 62, 0, 130, 1, 1),
(23, 'Alexander', 'Albon', '1996-03-23', 27, 'THA', 2019, 228, 27, 0, 81, 0, 1),
(31, 'Esteban', 'Ocon', '1996-09-17', 27, 'FRA', 2016, 422, 58, 0, 133, 1, 1),
(22, 'Yuki', 'Tsunoda', '2000-02-11', 23, 'JPN', 2021, 61, 17, 0, 66, 0, 1),
(3, 'Daniel', 'Ricciardo', '1989-07-01', 34, 'AUS', 2011, 1317, 6, 0, 239, 8, 1),
(77, 'Valtteri', 'Bottas', '1989-08-28', 34, 'FIN', 2013, 1797, 10, 0, 222, 10, 1),
(27, 'Nico', 'Hulkenberg', '1987-08-19', 36, 'GER', 2010, 530, 9, 0, 206, 0, 1),
(24, 'Zhou', 'Guanyu', '1999-05-30', 24, 'CHN', 2022, 12, 6, 0, 44, 0, 1),
(20, 'Kevin', 'Magnussen', '1992-10-05', 31, 'DEN', 2014, 186, 3, 0, 164, 0, 1),
(2, 'Logan', 'Sargeant', '2000-12-31', 22, 'USA', 2023, 1, 1, 0, 22, 0, 1),
(18, 'Lance', 'Stroll', '1998-10-29', 25, 'CAN', 2017, 268, 74, 0, 143, 0, 1),
(40, 'Liam', 'Lawson', '2002-02-11', 21, 'NZL', 2023, 2, 2, 0, 5, 0, 0),
(32, 'Michael', 'Schumacher', '1969-02-03', 54, 'GER', 1991, 1566, NULL, 7, 307, 91, 0),
(47, 'Mick', 'Schumacher', '1999-03-22', 24, 'GER', 2021, 12, NULL, 0, 47, 0, 0),
(5, 'Sebastian', 'Vettel', '1987-07-03', 36, 'GER', 2007, 3098, NULL, 4, 299, 53, 0),
(2, 'Alain', 'Prost', '1955-02-24', 68, 'FRA', 1980, 798, NULL, 4, 199, 51, 0),
(12, 'Ayrton', 'Senna', '1960-03-21', NULL, 'BRA', 1984, 614, NULL, 3, 161, 41, 0),
(5, 'Nigel', 'Mansell', '1953-08-08', 70, 'GBR', 1980, 482, NULL, 1, 187, 31, 0),
(20, 'Mark', 'Webber', '1976-08-27', 47, 'AUS', 2002, 1047, NULL, 0, 217, 9, 0),
(12, 'Niki', 'Lauda', '1949-02-22', NULL, 'AUT', 1971, 420, NULL, 3, 177, 25, 0),
(4, 'Jim', 'Clark', '1936-03-04', NULL, 'GBR', 1960, 255, NULL, 2, 73, 25, 0),
(5, 'Nelson', 'Piquet', '1952-08-17', 71, 'BRA', 1978, 481, NULL, 3, 207, 23, 0),
(6, 'Nico', 'Rosberg', '1985-06-27', 38, 'GER', 2006, 1594, NULL, 1, 206, 23, 0),
(0, 'Damon', 'Hill', '1960-09-17', 63, 'GBR', 1992, 360, NULL, 1, 122, 22, 0),
(7, 'Kimi', 'Raikkonen', '1979-10-17', 44, 'FIN', 2002, 1873, NULL, 1, 353, 21, 0),
(11, 'Mika', 'Hakkinen', '1968-09-28', 55, 'FIN', 1991, 420, NULL, 2, 165, 20, 0),
(22, 'Jenson', 'Button', '1980-01-18', 43, 'GBR', 2000, 1235, NULL, 1, 309, 15, 0),
(19, 'Jos', 'Verstappen', '1972-03-04', 51, 'NED', 1994, 17, NULL, 0, 107, 0, 0),
(6, 'Nicholas', 'Latifi', '1995-06-29', 28, 'CAN', 2020, 9, NULL, 0, 61, 0, 0),
(21, 'Nyck', 'De Vries', '1995-02-06', 28, 'NED', 2022, 2, 0, 0, 11, 0, 0),
(8, 'Romain', 'Grosjean', '1986-04-17', 37, 'FRA', 2009, 391, NULL, 0, 181, 0, 0);



--- Inserting data into Team table 
INSERT INTO Team (TeamName, OfficialName, Country, YearOf1GP, TeamPrincipal, Founder, GPentered, ConstructorsCSwin, TeamExists)
VALUES
('Red Bull', 'Oracle Red Bull Racing', 'GBR', 2005, 'Christian Horner', 'Dietrich Mateschitz', 368, 6, 1),
('Ferrari', 'Scuderia Ferrari', 'ITA', 1950, 'Frédéric Vasseur', 'Enzo Ferrari', 1074, 16, 1),
('Mercedes', 'Mercedes-AMG Petronas F1 Team', 'GBR', 1954, 'Toto Wolff', NULL, 291, 8, 1),
('McLaren', 'McLaren F1 Team', 'GBR', 1966, 'Zak Brown', 'Bruce McLaren', 948, 8, 1),
('Aston Martin', 'Aston Martin Aramco Cognizant F1 Team', 'GBR', 1959, 'Lawrence Stroll', NULL, 70, 0, 1),
('Alpine', 'BWT Alpine F1 Team', 'GBR', 2021, 'Bruno Famin', NULL, 64, 0, 1),
('Alpha Tauri', 'Scuderia AlphaTauri', 'ITA', 2020, 'Franz Tost', 'Dietrich Mateschitz', 81, 0, 1),
('Williams', 'Williams Racing', 'GBR', 1977, 'James Vowles', 'Frank Williams', 812, 9, 1),
('Haas', 'MoneyGram Haas F1 Team', 'GBR', 2016, 'Gene Haas', 'Gene Haas', 164, 0, 1),
('Alfa Romeo', 'Alfa Romeo F1 Team Sauber', 'CHE', 1950, 'Alessandro Alunni Bravi', NULL, 212, 0, 1),
('Lotus', 'Lotus F1 Team', 'GBR', 2012, 'Eric Boullier', 'Colin Chapman', 77, 0, 0),
('Minardi', 'Minardi F1 Team', 'ITA', 1985, 'Giancarlo Minardi', 'Giancarlo Minardi', 246, 0, 0),
('Benetton', 'Benetton Formula Ltd.', 'GBR', 1986, 'Flavio Briatore', 'Luciano Benetton', 260, 1, 0),
('Renault', 'Renault Formula 1 Team', 'FRA', 1977, 'Laurent Rossi', NULL, 403, 2, 0),
('Toro Rosso', 'Red Bull Toro Rosso Honda', 'ITA', 2006, 'Franz Tost', 'Dietrich Mateschitz', 268, 0, 0),
('Sauber', 'Sauber F1 Team', 'CHE', 1993, 'Monisha Kaltenborn', 'Peter Sauber', 465, 0, 0);



--- Insert data into DriverInTeam table
INSERT INTO DriverInTeam (fk_DriverID, fk_TeamID)
VALUES
(1, 15),
(1, 1),
(2, 4),
(2, 3),
(3,	16),
(3,	2),
(4,	16),
(4,	4),
(4,	1),
(5,	4),
(6,	15),
(6,	14),
(6,	4),
(6,	2),
(7,	4),
(8,	14),
(8,	4),
(8,	2),
(8,	6),
(8,	5),
(9,	8),
(9,	3),
(10, 15),
(10, 1),
(10, 6),
(11, 15),
(11, 1),
(11, 8),
(12, 14),
(12, 6),
(13, 7),
(14, 14),
(14, 4),
(14, 1),
(14, 7),
(15, 8),
(15, 3),
(15, 10),
(16, 16),
(16, 14),
(16, 5),
(16, 9),
(17, 10),
(18, 4),
(18, 14),
(18, 9),
(19, 8),
(20, 8),
(20, 5),
(21, 7),
(22, 13),
(22, 2),
(22, 3),
(23, 9),
(24, 15),
(24, 1),
(24, 2),
(24, 5),
(25, 4),
(25, 14),
(25, 2),
(25, 8),
(26, 11),
(26, 4),
(26, 8),
(27, 11),
(27, 8),
(27, 2),
(27, 4),
(28, 12),
(28, 8),
(28, 1),
(29, 2),
(29, 4),
(30, 11),
(31, 4),
(31, 8),
(31, 11),
(31, 13),
(32, 8),
(32, 3),
(33, 8),
(34, 16),
(34, 4),
(34, 2),
(34, 11),
(34, 10),
(35, 11),
(35, 4),
(36, 8),
(36, 13),
(36, 14),
(36, 4),
(37, 13),
(37, 12),
(38, 8),
(39, 7),
(40, 14),
(40, 11),
(40, 9);



--- Insert data into FirstPlace table
INSERT INTO FirstPlace (fk_DriverID, Points)
VALUES
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
(NULL, 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 6), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 25);

--- Insert data into SecondPlace table
INSERT INTO SecondPlace (fk_DriverID, Points)
VALUES
((SELECT DriverID FROM Driver WHERE DriverID = 4), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 2), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 1), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 18),
(NULL, 18),
((SELECT DriverID FROM Driver WHERE DriverID = 8), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 2), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 8), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 3), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 5), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 5), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 8), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 5), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 5), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 7), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 5), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 2), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 5), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 3), 18),
((SELECT DriverID FROM Driver WHERE DriverID = 3),18);

--- Insert data into ThirdPlace table
INSERT INTO ThirdPlace (fk_DriverID, Points)
VALUES
((SELECT DriverID FROM Driver WHERE DriverID = 8), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 8), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 8), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 3), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 8), 15),
(NULL, 15),
((SELECT DriverID FROM Driver WHERE DriverID = 12), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 9), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 2), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 2), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 3), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 10), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 6), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 2), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 7), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 5), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 6), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 3), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 8), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 4), 15),
((SELECT DriverID FROM Driver WHERE DriverID = 9), 15);



--- Inserting data into Race table
INSERT INTO Race (RaceName, RaceDate, RaceLocation, Country, CircuitName, CircuitLengthKM, NumberOfLaps, RaceDistanceKM, LapRecord, NumberOfCorners, YearOf1GP)
VALUES

('Formula 1 Gulf Air Bahrain Grand Prix 2023', '2023-03-05', 'Sakhir', 'BHR', 'Bahrain International Circuit', 5.412, 57, 308.238, '1:31.447', 15, 2004),
('Formula 1 STC Saudi Arabian Grand Prix 2023', '2023-03-19', 'Jeddah', 'SAU', 'Jeddah Corniche Circuit', 6.174, 50, 308.45, '1:30.734', 27, 2021),
('Formula 1 Rolex Austrlian Grand Prix 2023', '2023-04-02', 'Melbourne', 'AUS', 'Albert Park Circuit', 5.278, 58, 306.124, '1:20.235', 14, 1996),
('Formula 1 Azerbaijan Grand Prix 2023', '2023-04-30', 'Baku', 'AZE', 'Baku City Circuit', 6.003, 51, 306.049, '1:43.009', 20, 2016),
('Formula 1 Crypto.com Miami Grand Prix 2023', '2023-05-07', 'Miami', 'USA', 'Miami International Circuit', 5.412, 57, 308.326, '1:29.708', 19, 2022),
('Formula 1 Grand Premio E Del Emila-Romagna 2023', '2023-05-21', 'Imola', 'ITA', 'Autodromo Enzo e Dino Ferrari', 4.909, 63, 309.049, '1:15.484', 19, 1980),
('Formula 1 Grand Prix de Monaco 2023', '2023-05-28', 'Monaco', 'MCO', 'Circuit de Monaco', 3.337, 78, 260.286, '1:12.909', 19, 1950),
('Formula 1 AWS Grand Premio de España 2023', '2023-06-04', 'Barcelona', 'ESP', 'Circuit de Barcelona-Catalunya', 4.657, 66, 307.236, '1:16.330', 14, 1991),
('Formula 1 Pirelli Grand Prix du Canada 2023', '2023-06-18', 'Montreal', 'CAN', 'Circuit Gilles-Villeneuve', 4.361, 70, 305.27, '1:13.078', 14, 1978),
('Formula 1 Rolex Grosser Preis von Österreich 2023', '2023-07-02', 'Spielberg', 'AUT', 'Red Bull Ring', 4.318, 71, 306.452, '1:05.619', 10, 1970),
('Formula 1 Aramco British Gran Prix 2023', '2023-07-09', 'Silverstone', 'GBR', 'Silverstone Circuit', 5.891, 52, 306.198, '1:27.097', 18, 1950),
('Formula 1 Quater Airways Hungarian Grand Prix 2023', '2023-07-23', 'Mogyorod', 'HUN', 'Hungaroring', 4.381, 70, 306.63, '1:16.627', 14, 1989),
('Formula 1 MSC Cruises Belgian Grand Prix 2023', '2023-07-30', 'Stavelot', 'BEL', 'Circuit de Spa-Francorchamps', 7.004, 44, 308.052, '1:46.286', 19, 1950),
('Formula 1 Heineken Dutch Grand Prix 2023', '2023-08-27', 'Zandvoort', 'NED', 'Circuit Zandvoort', 4.259, 72, 306.587, '1:11.097', 14, 1952),
('Formula 1 Pirelli Gran Premio D Italia 2023', '2023-09-03', 'Monza', 'ITA', 'Autodromo Nazionale Monza', 5.793, 53, 306.72, '1:21.046', 11, 1950),
('Formula 1 Singapore Airlines Singapore Grand Prix 2023', '2023-09-17', 'Marina Bay', 'SGP', 'Marina Bay Street Circuit', 4.94, 62, 306.143, '1:35.867', 19, 2008),
('Formula 1 Lenovo Japanese Grand Prix 2023', '2023-09-24', 'Suzuka', 'JPN', 'Suzuka International Racing Course', 5.807, 53, 307.471, '1:30.983', 18, 1987),
('Formula 1 Quater Airways Quatar Grand Prix 2023', '2023-10-08', 'Lusail', 'QAT', 'Lusail International Circuit', 5.419, 57, 308.611, '1:24.319', 16, 2021),
('Formula 1 Lenovo United States Grand Prix 2023', '2023-10-22', 'Austin', 'USA', 'Circuit of the Americas', 5.513, 56, 308.405, '1:36.169', 56, 2012),
('Formula 1 Gran Premio de la Ciudad de Mexico 2023', '2023-10-29', 'Mexico', 'MEX', 'Autodromo Hermanos Rodriguez', 4.304, 71, 305.354, '1:17.774', 17, 1963),
('Formula 1 Rolex Grande Premio de São Paulo 2023', '2023-11-05', 'São Paulo', 'BRA', 'Autodromo Jose Carlos Pace', 4.309, 71, 305.879, '1:10.540', 15, 1973),
('Formula 1 Heineken Silver Las Vegas Grand Prix 2023', '2023-11-19', 'Las Vegas', 'USA', 'Las Vegas Strip Circuit', 6.201, 50, 310.05, '1:35.490', 17, 2023),
('Formula 1 Etihad Airways Abu Dhabi Grand Prix 2023', '2023-11-26', 'Yas Marina', 'AUH', 'Yas Marina Circuit', 5.281, 58, 306.183, '1:26.103', 16, 2009);

--- Update FirstPlace to link RaceID
UPDATE FirstPlace
SET fk_RaceID = CASE
    WHEN Result1ID = 1   THEN (SELECT RaceID FROM Race WHERE RaceID = 1 )
    WHEN Result1ID = 2   THEN (SELECT RaceID FROM Race WHERE RaceID = 2 )
    WHEN Result1ID = 3   THEN (SELECT RaceID FROM Race WHERE RaceID = 3 )
    WHEN Result1ID = 4   THEN (SELECT RaceID FROM Race WHERE RaceID = 4 )
	WHEN Result1ID = 5   THEN (SELECT RaceID FROM Race WHERE RaceID = 5 )
    WHEN Result1ID = 6   THEN (SELECT RaceID FROM Race WHERE RaceID = 6 )
	WHEN Result1ID = 7   THEN (SELECT RaceID FROM Race WHERE RaceID = 7 )
    WHEN Result1ID = 8   THEN (SELECT RaceID FROM Race WHERE RaceID = 8 )
    WHEN Result1ID = 9   THEN (SELECT RaceID FROM Race WHERE RaceID = 9 )
    WHEN Result1ID = 10  THEN (SELECT RaceID FROM Race WHERE RaceID = 10)
	WHEN Result1ID = 11  THEN (SELECT RaceID FROM Race WHERE RaceID = 11)
    WHEN Result1ID = 12  THEN (SELECT RaceID FROM Race WHERE RaceID = 12)
	WHEN Result1ID = 13  THEN (SELECT RaceID FROM Race WHERE RaceID = 13)
    WHEN Result1ID = 14  THEN (SELECT RaceID FROM Race WHERE RaceID = 14)
    WHEN Result1ID = 15  THEN (SELECT RaceID FROM Race WHERE RaceID = 15)
    WHEN Result1ID = 16  THEN (SELECT RaceID FROM Race WHERE RaceID = 16)
	WHEN Result1ID = 17  THEN (SELECT RaceID FROM Race WHERE RaceID = 17)
    WHEN Result1ID = 18  THEN (SELECT RaceID FROM Race WHERE RaceID = 18)
	WHEN Result1ID = 19  THEN (SELECT RaceID FROM Race WHERE RaceID = 19)
    WHEN Result1ID = 20  THEN (SELECT RaceID FROM Race WHERE RaceID = 20)
    WHEN Result1ID = 21  THEN (SELECT RaceID FROM Race WHERE RaceID = 21)
    WHEN Result1ID = 22  THEN (SELECT RaceID FROM Race WHERE RaceID = 22)
	WHEN Result1ID = 23  THEN (SELECT RaceID FROM Race WHERE RaceID = 23)
    ELSE NULL
END;

--- Update SecondPlace to link RaceID
UPDATE SecondPlace
SET fk_RaceID = CASE
    WHEN Result2ID = 1   THEN (SELECT RaceID FROM Race WHERE RaceID = 1 )
    WHEN Result2ID = 2   THEN (SELECT RaceID FROM Race WHERE RaceID = 2 )
    WHEN Result2ID = 3   THEN (SELECT RaceID FROM Race WHERE RaceID = 3 )
    WHEN Result2ID = 4   THEN (SELECT RaceID FROM Race WHERE RaceID = 4 )
	WHEN Result2ID = 5   THEN (SELECT RaceID FROM Race WHERE RaceID = 5 )
    WHEN Result2ID = 6   THEN (SELECT RaceID FROM Race WHERE RaceID = 6 )
	WHEN Result2ID = 7   THEN (SELECT RaceID FROM Race WHERE RaceID = 7 )
    WHEN Result2ID = 8   THEN (SELECT RaceID FROM Race WHERE RaceID = 8 )
    WHEN Result2ID = 9   THEN (SELECT RaceID FROM Race WHERE RaceID = 9 )
    WHEN Result2ID = 10  THEN (SELECT RaceID FROM Race WHERE RaceID = 10)
	WHEN Result2ID = 11  THEN (SELECT RaceID FROM Race WHERE RaceID = 11)
    WHEN Result2ID = 12  THEN (SELECT RaceID FROM Race WHERE RaceID = 12)
	WHEN Result2ID = 13  THEN (SELECT RaceID FROM Race WHERE RaceID = 13)
    WHEN Result2ID = 14  THEN (SELECT RaceID FROM Race WHERE RaceID = 14)
    WHEN Result2ID = 15  THEN (SELECT RaceID FROM Race WHERE RaceID = 15)
    WHEN Result2ID = 16  THEN (SELECT RaceID FROM Race WHERE RaceID = 16)
	WHEN Result2ID = 17  THEN (SELECT RaceID FROM Race WHERE RaceID = 17)
    WHEN Result2ID = 18  THEN (SELECT RaceID FROM Race WHERE RaceID = 18)
	WHEN Result2ID = 19  THEN (SELECT RaceID FROM Race WHERE RaceID = 19)
    WHEN Result2ID = 20  THEN (SELECT RaceID FROM Race WHERE RaceID = 20)
    WHEN Result2ID = 21  THEN (SELECT RaceID FROM Race WHERE RaceID = 21)
    WHEN Result2ID = 22  THEN (SELECT RaceID FROM Race WHERE RaceID = 22)
	WHEN Result2ID = 23  THEN (SELECT RaceID FROM Race WHERE RaceID = 23)
    ELSE NULL
END;

--- Update ThirdPlace to link RaceID
UPDATE ThirdPlace
SET fk_RaceID = CASE
    WHEN Result3ID = 1   THEN (SELECT RaceID FROM Race WHERE RaceID = 1 )
    WHEN Result3ID = 2   THEN (SELECT RaceID FROM Race WHERE RaceID = 2 )
    WHEN Result3ID = 3   THEN (SELECT RaceID FROM Race WHERE RaceID = 3 )
    WHEN Result3ID = 4   THEN (SELECT RaceID FROM Race WHERE RaceID = 4 )
	WHEN Result3ID = 5   THEN (SELECT RaceID FROM Race WHERE RaceID = 5 )
    WHEN Result3ID = 6   THEN (SELECT RaceID FROM Race WHERE RaceID = 6 )
	WHEN Result3ID = 7   THEN (SELECT RaceID FROM Race WHERE RaceID = 7 )
    WHEN Result3ID = 8   THEN (SELECT RaceID FROM Race WHERE RaceID = 8 )
    WHEN Result3ID = 9   THEN (SELECT RaceID FROM Race WHERE RaceID = 9 )
    WHEN Result3ID = 10  THEN (SELECT RaceID FROM Race WHERE RaceID = 10)
	WHEN Result3ID = 11  THEN (SELECT RaceID FROM Race WHERE RaceID = 11)
    WHEN Result3ID = 12  THEN (SELECT RaceID FROM Race WHERE RaceID = 12)
	WHEN Result3ID = 13  THEN (SELECT RaceID FROM Race WHERE RaceID = 13)
    WHEN Result3ID = 14  THEN (SELECT RaceID FROM Race WHERE RaceID = 14)
    WHEN Result3ID = 15  THEN (SELECT RaceID FROM Race WHERE RaceID = 15)
    WHEN Result3ID = 16  THEN (SELECT RaceID FROM Race WHERE RaceID = 16)
	WHEN Result3ID = 17  THEN (SELECT RaceID FROM Race WHERE RaceID = 17)
    WHEN Result3ID = 18  THEN (SELECT RaceID FROM Race WHERE RaceID = 18)
	WHEN Result3ID = 19  THEN (SELECT RaceID FROM Race WHERE RaceID = 19)
    WHEN Result3ID = 20  THEN (SELECT RaceID FROM Race WHERE RaceID = 20)
    WHEN Result3ID = 21  THEN (SELECT RaceID FROM Race WHERE RaceID = 21)
    WHEN Result3ID = 22  THEN (SELECT RaceID FROM Race WHERE RaceID = 22)
	WHEN Result3ID = 23  THEN (SELECT RaceID FROM Race WHERE RaceID = 23)
    ELSE NULL
END;