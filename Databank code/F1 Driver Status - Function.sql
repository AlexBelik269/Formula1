----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Function - Driver Status
----------------------------------------------------------------------
USE Formula1;
GO

DROP FUNCTION IF EXISTS DriverStatus;
GO

CREATE FUNCTION DriverStatus (@FirstName VARCHAR(30), @LastName VARCHAR(30))
RETURNS VARCHAR(MAX)
AS 
BEGIN
    DECLARE @Status VARCHAR(MAX);
	    
		IF @FirstName IS NULL OR @LastName IS NULL OR LEN(@FirstName) = 0 OR LEN(@LastName) = 0
    BEGIN
        SET @Status = 'Invalid input parameters. Please provide valid First Name and Last Name.';
        RETURN @Status;
    END

        SELECT @Status = CONCAT(
        'Driver: ', D.FirstName, ' ', D.LastName, CHAR(13) + CHAR(10),
        'Driver Number: ', CAST(D.DriverNumber AS VARCHAR), CHAR(13) + CHAR(10),
        'Age: ' ,
			CASE 
				WHEN D.Age IS NULL THEN 'dead'
				ELSE CAST(D.Age AS VARCHAR)
			END , CHAR(13) + CHAR(10),
        'Nationality: ', D.Nationality, CHAR(13) + CHAR(10),
		'Career start: ', CAST(D.StartYear AS VARCHAR) , CHAR(13) + CHAR(10),
        'Total Wins: ', CAST(D.GPwins AS VARCHAR), CHAR(13) + CHAR(10),
        'Total Races Entered: ', CAST(D.GPentered AS VARCHAR), CHAR(13) + CHAR(10),
        'Percentage of Wins in 2023: ',
        CAST(CASE
                WHEN D.GPentered > 0 THEN
                    CAST(FORMAT((SELECT COUNT(*) FROM FirstPlace WHERE DriverID = fk_DriverID) * 100.0 / 22, '0.00') AS VARCHAR)
                ELSE
                    CAST('N/A' AS VARCHAR)
            END AS VARCHAR) + '%', CHAR(13) + CHAR(10),
        'Career Points: ', CAST(D.CareerPoints AS VARCHAR), CHAR(13) + CHAR(10),
        'Points in 2023: ', CAST(D.PointsIn2023 AS VARCHAR), CHAR(13) + CHAR(10),
        'World Driver Championships: ', CAST(D.WDC AS VARCHAR), CHAR(13) + CHAR(10),
		'Current Driver: ', 
        CASE
            WHEN D.CurrentDriver = 1 THEN 'Yes'
            WHEN D.CurrentDriver = 0 THEN 'No'
            ELSE 'Unknown'
        END, CHAR(13) + CHAR(10),
		'First Team: ', (SELECT TOP 1 T.TeamName
            FROM DriverInTeam DT 
            JOIN Team T ON T.TeamID = DT.fk_TeamID
            WHERE D.DriverID = DT.fk_DriverID
            ORDER BY DT.DriverInTeamID),      CHAR(13) + CHAR(10)+
		CONCAT(CASE
				WHEN D.CurrentDriver = 0 THEN 'Last Team: '
				ELSE 'Current Team: '
			END,
			(SELECT TOP 1 T.TeamName
				FROM DriverInTeam DT 
				JOIN Team T ON T.TeamID = DT.fk_TeamID
				WHERE D.DriverID = DT.fk_DriverID
				ORDER BY DT.DriverInTeamID DESC))
    )

    FROM Driver D
	JOIN DriverInTeam DT on DriverID = fk_DriverID
	JOIN Team T on TeamID = fk_TeamID
    WHERE D.FirstName = @FirstName AND D.LastName = @LastName;

	    IF @@ROWCOUNT = 0
    BEGIN
        SET @Status = 'Driver not found.';
    END

        RETURN @Status;
END;
GO

-- Call the function for any driver: 'First Name', 'Last Name'
PRINT dbo.DriverStatus('Sergio', 'Perez');

