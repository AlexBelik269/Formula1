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
-- Erkl�rung: Die Prozedur wird mit der Rennen-ID 19 aufgerufen. Die Ausgabe zeigt die normale Beschreibung des Rennens.        
PRINT '';
PRINT '';

EXEC RaceInfo 6;
-- Normalfall aber das Rennen hat nicht stattgefunden
-- Output: Normale Rennen Beschreibung, aber ohne Gewinner, 2. und 3. Platz beschreibung.
-- Erkl�rung: Die Prozedur wird mit der Rennen-ID 6 aufgerufen, das Rennen hat jedoch nicht stattgefunden. Daher fehlen Informationen zu den ersten drei Pl�tzen.     
PRINT '';
PRINT '';

EXEC RaceInfo 99;
-- Rennen nicht gefunden
-- Output: Race not found.
-- Erkl�rung: Die Prozedur wird mit einer ung�ltigen Rennen-ID (99) aufgerufen. Die Ausgabe zeigt "Race not found".       
PRINT '';
PRINT '';

EXEC RaceInfo 'xyz';
-- Parameter als varchar nicht akzeptiert
-- Output: Error converting data type varchar to int.
-- Erkl�rung: Die Prozedur wird mit einem ung�ltigen Rennen-ID-Format ('xyz') aufgerufen, was zu einem Konvertierungsfehler f�hrt.    
PRINT '';
PRINT '';

EXEC RaceInfo '';
-- Leere Parameter
-- Output: Race not found.
-- Erkl�rung: Die Prozedur wird ohne eine Rennen-ID aufgerufen (leeres Feld). Die Ausgabe zeigt "Race not found".       
PRINT '';
PRINT '';

EXEC RaceInfo NULL;
-- NULL-Wert
-- Output: Race not found.
-- Erkl�rung: Die Prozedur wird mit einem NULL-Wert als Rennen-ID aufgerufen. Die Ausgabe zeigt "Race not found".      
PRINT '';
PRINT '';

EXEC RaceInfo;
-- Fehlende Parameter 
-- Output: Procedure or function 'RaceInfo' expects parameter '@TeamName', which was not supplied.
-- Erkl�rung: Die Prozedur erwartet ein Parameter.


