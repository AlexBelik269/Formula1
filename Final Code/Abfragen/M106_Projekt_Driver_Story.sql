----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--         Stored Procedure - Driver Story - Test
----------------------------------------------------------------------

EXEC DriverStory 'Max', 'Verstappen';
-- Normalfall mit aktuellem Fahrer 
-- Output: Normale Fahrergeschichte
-- Erklärung: Max Verstappen ist ein aktueller Fahrer und hat die meisten Rennen in 2023 gewonnen. 
--            Daher zeigt seine Geschichte alle verfügbaren Abschnitte dieses Programms.
PRINT '';
PRINT '';

EXEC DriverStory 'Oscar', 'Piastri';
-- Normalfall mit aktuellem Fahrer 
-- Output:  Normale Fahrergeschichte
-- Erklärung: Oscar Piastri ist ein aktueller Fahrer, hat jedoch noch kein Rennen gewonnen. 
--            Die Geschichte zeigt seine bisherigen Ereignisse und Leistungen.
PRINT '';
PRINT '';

EXEC DriverStory 'Mick', 'Schumacher';
-- Normalfall mit nicht aktuellem Fahrer
-- Output: Normale Fahrergeschichte, kein aktueller Fahrer
-- Erklärung: Mick Schumacher ist kein aktueller Fahrer. Die Geschichte zeigt, wie das Programm in diesem Fall funktioniert.
PRINT '';
PRINT '';

EXEC DriverStory 'Ayrton', 'Senna';
-- Normalfall mit nicht aktuellem, verstorbenem Fahrer
-- Output: Normale Fahrergeschichte, kein aktueller Fahrer, tot
-- Erklärung: Ayrton Senna ist kein aktueller Fahrer und ist leider gestorben. Die Geschichte zeigt nur seine Lebensereignisse.
PRINT '';
PRINT '';

EXEC DriverStory 'xyz', 'xyz';
-- Fahrer nicht gefunden
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erklärung: 'xyz' 'xyz' ist kein gültiger Fahrer, daher zeigt das Programm "Driver NOT found,...".
PRINT '';

EXEC DriverStory '', '';
-- Leere Felder
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erklärung: Beide Felder sind leer, daher wird "Driver NOT found,..." angezeigt.
PRINT '';

EXEC DriverStory '' ;
-- Fehlender Parameter
-- Output: Procedure or function 'DriverStory' expects parameter '@LastName', which was not supplied.
-- Erklärung: Die Prozedur erwartet zwei Parameter, den Vornamen und den Nachnamen eines Rennfahrers. Da ein fehlt, wird eine Fehlermeldung angezeigt.
PRINT '';

EXEC DriverStory NULL, NULL;
-- NULL-Werte für Vornamen und Nachnamen 
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erklärung: Beide Felder sind NULL, daher wird "Driver NOT found,..." angezeigt.
PRINT '';

EXEC DriverStory 2, 6;
-- Numerische Eingabe
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erklärung: Numerische Eingaben werden nicht akzeptiert, daher wird "Driver NOT found,..." angezeigt.


--- select FirstName, LastName from Driver     
---  = um alle Fahrer anzuzeigen, die für diese gespeicherte Prozedur verwendet werden können
