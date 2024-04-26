----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--           Function 1., 2. & 3. Platz - Test
----------------------------------------------------------------------

select * from GetSecondAndThirdPlaceDrivers();
-- Zeigt all fahrer die auf dem 2. oder 3. Platz waren


SELECT * FROM GetSecondAndThirdPlaceDrivers()
WHERE DriverName = 'Max Verstappen' AND RacePosition = 'Second Place';
-- Zeigt alle Rennen wo Max Verstappen auf dem 2. Platz war


SELECT * FROM GetSecondAndThirdPlaceDrivers()
WHERE RaceID = 10 AND RacePosition = 'Second Place';
-- Zeigt den Fahrer der auf dem 2. Platz war im 10. Rennen
