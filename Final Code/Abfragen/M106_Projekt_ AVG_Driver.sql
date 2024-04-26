----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--            Function - AVG Driver - Test
----------------------------------------------------------------------

DECLARE @DriverID1 INT = 1;
SELECT dbo.GetDriverAveragePoints(@DriverID1) AS AveragePoints;
-- Driver ID ist 1


DECLARE @DriverID1 INT = 2;
SELECT dbo.GetDriverAveragePoints(@DriverID1) AS AveragePoints;
-- Driver ID ist 2


DECLARE @DriverID1 INT = 18;
SELECT dbo.GetDriverAveragePoints(@DriverID1) AS AveragePoints;
-- Driver ID ist 18


DECLARE @DriverID1 INT = NULL;
SELECT dbo.GetDriverAveragePoints(@DriverID1) AS AveragePoints;
-- Driver ID ist NULL