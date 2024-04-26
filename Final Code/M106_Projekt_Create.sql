----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
--                     Creating Databank
----------------------------------------------------------------------
USE master;
GO

DROP DATABASE IF EXISTS Formula1;
GO

CREATE DATABASE Formula1;
GO

USE Formula1;
GO

----------------------------------------------------------------------
--                       Creating tables
----------------------------------------------------------------------

CREATE TABLE Driver (
    DriverID INT IDENTITY(1,1) NOT NULL,
    DriverNumber INT NOT NULL,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate DATE  NOT NULL,
    Age INT,
    Nationality VARCHAR(3) NOT NULL,
    StartYear INT NOT NULL,
    CareerPoints decimal(6, 1) NOT NULL,
    PointsIn2023 INT,
    WDC INT NOT NULL,
    GPentered INT NOT NULL,
    GPwins INT NOT NULL,
	CurrentDriver BIT NOT NULL,
    PRIMARY KEY (DriverID),
);

CREATE TABLE Team (
    TeamID INT IDENTITY(1,1) NOT NULL,
    TeamName VARCHAR(30) NOT NULL,
    OfficialName VARCHAR(60) NOT NULL,
    Country VARCHAR(3) NOT NULL,
    YearOf1GP INT NOT NULL,
    TeamPrincipal VARCHAR(30) NOT NULL,
    Founder VARCHAR(30),
    GPentered INT NOT NULL,
    ConstructorsCSwin INT NOT NULL,
	TeamExists BIT NOT NULL,
    PRIMARY KEY (TeamID)
);

CREATE TABLE DriverInTeam (
	DriverInTeamID INT IDENTITY(1,1) NOT NULL,
	fk_DriverID INT NOT NULL,
	fk_TeamID INT NOT NULL,
	PRIMARY KEY (DriverInTeamID)
);


CREATE TABLE FirstPlace (
    Result1ID INT IDENTITY(1,1) NOT NULL,
    fk_RaceID INT,
    fk_DriverID INT,
    Points INT NOT NULL,
    PRIMARY KEY (Result1ID)
);

CREATE TABLE SecondPlace (
    Result2ID INT IDENTITY(1,1) NOT NULL,
    fk_RaceID INT,
    fk_DriverID INT,
    Points INT NOT NULL,
    PRIMARY KEY (Result2ID)
);

CREATE TABLE ThirdPlace (
    Result3ID INT IDENTITY(1,1) NOT NULL,
    fk_RaceID INT,
    fk_DriverID INT,
    Points INT NOT NULL,
    PRIMARY KEY (Result3ID)
);

CREATE TABLE Race (
    RaceID INT IDENTITY(1,1) NOT NULL,
    RaceName VARCHAR(90) NOT NULL,
    RaceDate DATE NOT NULL,
    RaceLocation VARCHAR(30) NOT NULL,
    Country VARCHAR(3) NOT NULL,
    CircuitName VARCHAR(50) NOT NULL,
    CircuitLengthKM decimal(9, 3) NOT NULL,
    NumberOfLaps INT NOT NULL,
    RaceDistanceKM decimal(9, 3) NOT NULL,
    LapRecord VARCHAR(30) NOT NULL,
    NumberOfCorners INT NOT NULL,
    YearOf1GP INT NOT NULL,
    PRIMARY KEY (RaceID),
);

GO

----------------------------------------------------------------------
--                       Adding conections
----------------------------------------------------------------------


ALTER TABLE DriverInTeam ADD
	FOREIGN KEY (fk_DriverID) REFERENCES Driver(DriverID),
	FOREIGN KEY (fk_TeamID) REFERENCES Team(TeamID);

ALTER TABLE FirstPlace ADD
    FOREIGN KEY (fk_RaceID) REFERENCES Race(RaceID),
    FOREIGN KEY (fk_DriverID) REFERENCES Driver(DriverID);

ALTER TABLE SecondPlace ADD
    FOREIGN KEY (fk_RaceID) REFERENCES Race(RaceID),
    FOREIGN KEY (fk_DriverID) REFERENCES Driver(DriverID);

ALTER TABLE ThirdPlace ADD
    FOREIGN KEY (fk_RaceID) REFERENCES Race(RaceID),
    FOREIGN KEY (fk_DriverID) REFERENCES Driver(DriverID);

GO