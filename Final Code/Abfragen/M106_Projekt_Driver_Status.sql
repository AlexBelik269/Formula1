----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--             Function - Driver Status - Test
----------------------------------------------------------------------

PRINT dbo.DriverStatus('Fernando', 'Alonso');
-- Normale Informationen für aktuellen Fahrer mit WDC
-- Output: Normale Fahrerinformationen
-- Erklärung: Fernando Alonso ist ein aktueller Fahrer und hat mehrere Welmeisterschaften gewonnen. 
-- Die Ausgabe zeigt seine aktuellen Informationen.
PRINT '';
PRINT '';

PRINT dbo.DriverStatus('Logan', 'Sargeant');
-- Normale Informationen für aktuellen Fahrer - Rookie
-- Output: Normale Fahrerinformationen
-- Erklärung: Logan Sargent ist ein aktueller Fahrer, aber 2023 war sein erstes Jahr in F1, also hat er noch nicht so viele Erfahrungen. 
-- Die Ausgabe zeigt seine aktuellen Informationen.
PRINT '';
PRINT '';

PRINT dbo.DriverStatus('Michael', 'Schumacher');
-- Normale Informationen für nicht aktuellen Fahrer mit WDC
-- Output: Normale Fahrerinformationen, aber kein aktueller Fahrer
-- Erklärung: Michael Schumacher ist nicht mehr aktiv im Fahrerfeld, hat jedoch während seiner Karriere zahlreiche Weltmeisterschaften gewonnen.
-- Die Ausgabe zeigt Informationen zu seinem letzten Status, ohne Angaben für das Jahr 2023.
PRINT '';
PRINT '';

PRINT dbo.DriverStatus('Jos', 'Verstappen');
-- Normale Informationen für nicht aktuellen Fahrer 
-- Output: Normale Fahrerinformationen, aber kein aktueller Fahrer
-- Erklärung: Jos Verstappen ist kein aktueller Fahrer und während seiner Karriere hat er keinen Sieg erziehlt. 
-- Die Ausgabe zeigt Informationen zu seinem letzten Status, ohne Angaben für das Jahr 2023.
PRINT '';
PRINT '';

PRINT dbo.DriverStatus('xyz', 'xyz');
-- Falsche Name 
-- Output: Driver not found.
-- Erklärung: 'xyz' 'xyz' ist kein gültiger Fahrer, daher zeigt das Programm "Driver not found".
PRINT '';

PRINT dbo.DriverStatus('', '');
-- Leere Felder 
-- Output: Invalid input parameters. Please provide valid First Name and Last Name.
-- Erklärung: Beide Felder sind leer, daher wird "Invalid input parameters" angezeigt.
PRINT '';

PRINT dbo.DriverStatus(1, 2);
-- Numerische Eingabe
-- Output: Driver not found.
-- Erklärung: Numerische Eingaben werden nicht akzeptiert, daher wird "Driver not found" angezeigt.
PRINT '';

PRINT dbo.DriverStatus(NULL, NULL);
-- NULL-Werte für Vornamen und Nachnamen 
-- Output: Invalid input parameters. Please provide valid First Name and Last Name.
-- Erklärung: Beide Felder sind NULL, daher wird "Invalid input parameters" angezeigt.
PRINT '';


-- Muss als Comment stehen sonst wird Programm gleich Error zeigen, wenn man alle gleichzeitig aufruft.
-- PRINT dbo.DriverStatus ('xyz');
-- Fehlender Parameter  -  error
-- Output: An insufficient number of arguments were supplied for the procedure or function dbo.DriverStatus.
-- Erklärung: Die Funktion erwartet zwei Parameter, den Vornamen und den Nachnamen eines Rennfahrers. Da ein fehlt, wird ein Fehler angezeigt.




--- select FirstName, LastName from Driver     
---  = um alle Fahrer anzuzeigen, die für diese gespeicherte Prozedur verwendet werden können
