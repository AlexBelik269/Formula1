----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Function - WCC
----------------------------------------------------------------------
USE Formula1;
GO

DROP FUNCTION IF EXISTS WCC;
GO

CREATE FUNCTION WCC()
RETURNS TABLE
AS RETURN
(SELECT
        T.TeamName AS Team,
        SUM(CDP.PointsIn2023) AS Points
    FROM Team T
    JOIN (SELECT  
            DIT.fk_TeamID,
            D.PointsIn2023,
            ROW_NUMBER() OVER (PARTITION BY DIT.fk_DriverID ORDER BY DIT.DriverInTeamID DESC) AS RowNum
        FROM DriverInTeam DIT
        JOIN Driver D ON DIT.fk_DriverID = D.DriverID
        WHERE D.CurrentDriver = 1
     ) AS CDP ON T.TeamID = CDP.fk_TeamID
    WHERE T.TeamExists = 1
          AND CDP.RowNum = 1  -- Only consider the latest team for each driver
	GROUP BY T.TeamName
);
GO

SELECT * FROM WCC()
ORDER BY Points DESC;
