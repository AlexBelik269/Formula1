----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Function - WDC
----------------------------------------------------------------------
USE Formula1;
GO

DROP FUNCTION IF EXISTS WDC;
GO

CREATE FUNCTION WDC()
RETURNS TABLE
AS
RETURN
(SELECT
        CONCAT(D.FirstName, ' ', D.LastName) AS Driver,
        LATEST_TEAM.TeamName AS Team,
        SUM(D.PointsIn2023) AS Points
    FROM Driver D
    JOIN
        (SELECT
                DT.fk_DriverID,
                T.TeamName,
                ROW_NUMBER() OVER (PARTITION BY DT.fk_DriverID ORDER BY DT.DriverInTeamID DESC) AS RowNum
            FROM DriverInTeam DT
            JOIN Team T ON T.TeamID = DT.fk_TeamID
        ) LATEST_TEAM ON D.DriverID = LATEST_TEAM.fk_DriverID AND LATEST_TEAM.RowNum = 1
    WHERE D.CurrentDriver = 1
    GROUP BY D.FirstName, D.LastName, LATEST_TEAM.TeamName
);
GO

SELECT * FROM WDC()
ORDER BY Points DESC


