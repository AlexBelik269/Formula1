----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--            Stored Procedure - Race Info - Test
----------------------------------------------------------------------

EXEC RaceInfo 19;
-- Normalfall 
-- Output: Normale Rennen Beschreibung
-- Erklärung: Die Prozedur wird mit der Rennen-ID 19 aufgerufen. Die Ausgabe zeigt die normale Beschreibung des Rennens.        
PRINT '';
PRINT '';

EXEC RaceInfo 6;
-- Normalfall aber das Rennen hat nicht stattgefunden
-- Output: Normale Rennen Beschreibung, aber ohne Gewinner, 2. und 3. Platz beschreibung.
-- Erklärung: Die Prozedur wird mit der Rennen-ID 6 aufgerufen, das Rennen hat jedoch nicht stattgefunden. Daher fehlen Informationen zu den ersten drei Plätzen.     
PRINT '';
PRINT '';

EXEC RaceInfo 99;
-- Rennen nicht gefunden
-- Output: Race not found.
-- Erklärung: Die Prozedur wird mit einer ungültigen Rennen-ID (99) aufgerufen. Die Ausgabe zeigt "Race not found".       
PRINT '';
PRINT '';

EXEC RaceInfo 'xyz';
-- Parameter als varchar nicht akzeptiert
-- Output: Error converting data type varchar to int.
-- Erklärung: Die Prozedur wird mit einem ungültigen Rennen-ID-Format ('xyz') aufgerufen, was zu einem Konvertierungsfehler führt.    
PRINT '';
PRINT '';

EXEC RaceInfo '';
-- Leere Parameter
-- Output: Race not found.
-- Erklärung: Die Prozedur wird ohne eine Rennen-ID aufgerufen (leeres Feld). Die Ausgabe zeigt "Race not found".       
PRINT '';
PRINT '';

EXEC RaceInfo NULL;
-- NULL-Wert
-- Output: Race not found.
-- Erklärung: Die Prozedur wird mit einem NULL-Wert als Rennen-ID aufgerufen. Die Ausgabe zeigt "Race not found".      
PRINT '';
PRINT '';

EXEC RaceInfo;
-- Fehlende Parameter 
-- Output: Procedure or function 'RaceInfo' expects parameter '@TeamName', which was not supplied.
-- Erklärung: Die Prozedur erwartet ein Parameter.


