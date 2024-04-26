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
-- Erkl�rung: Max Verstappen ist ein aktueller Fahrer und hat die meisten Rennen in 2023 gewonnen. 
--            Daher zeigt seine Geschichte alle verf�gbaren Abschnitte dieses Programms.
PRINT '';
PRINT '';

EXEC DriverStory 'Oscar', 'Piastri';
-- Normalfall mit aktuellem Fahrer 
-- Output:  Normale Fahrergeschichte
-- Erkl�rung: Oscar Piastri ist ein aktueller Fahrer, hat jedoch noch kein Rennen gewonnen. 
--            Die Geschichte zeigt seine bisherigen Ereignisse und Leistungen.
PRINT '';
PRINT '';

EXEC DriverStory 'Mick', 'Schumacher';
-- Normalfall mit nicht aktuellem Fahrer
-- Output: Normale Fahrergeschichte, kein aktueller Fahrer
-- Erkl�rung: Mick Schumacher ist kein aktueller Fahrer. Die Geschichte zeigt, wie das Programm in diesem Fall funktioniert.
PRINT '';
PRINT '';

EXEC DriverStory 'Ayrton', 'Senna';
-- Normalfall mit nicht aktuellem, verstorbenem Fahrer
-- Output: Normale Fahrergeschichte, kein aktueller Fahrer, tot
-- Erkl�rung: Ayrton Senna ist kein aktueller Fahrer und ist leider gestorben. Die Geschichte zeigt nur seine Lebensereignisse.
PRINT '';
PRINT '';

EXEC DriverStory 'xyz', 'xyz';
-- Fahrer nicht gefunden
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erkl�rung: 'xyz' 'xyz' ist kein g�ltiger Fahrer, daher zeigt das Programm "Driver NOT found,...".
PRINT '';

EXEC DriverStory '', '';
-- Leere Felder
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erkl�rung: Beide Felder sind leer, daher wird "Driver NOT found,..." angezeigt.
PRINT '';

EXEC DriverStory '' ;
-- Fehlender Parameter
-- Output: Procedure or function 'DriverStory' expects parameter '@LastName', which was not supplied.
-- Erkl�rung: Die Prozedur erwartet zwei Parameter, den Vornamen und den Nachnamen eines Rennfahrers. Da ein fehlt, wird eine Fehlermeldung angezeigt.
PRINT '';

EXEC DriverStory NULL, NULL;
-- NULL-Werte f�r Vornamen und Nachnamen 
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erkl�rung: Beide Felder sind NULL, daher wird "Driver NOT found,..." angezeigt.
PRINT '';

EXEC DriverStory 2, 6;
-- Numerische Eingabe
-- Output: Driver NOT found, try writing the first name and last name in this format: 'FirstName' , 'LastName' or try writing it without spaces.
-- Erkl�rung: Numerische Eingaben werden nicht akzeptiert, daher wird "Driver NOT found,..." angezeigt.


--- select FirstName, LastName from Driver     
---  = um alle Fahrer anzuzeigen, die f�r diese gespeicherte Prozedur verwendet werden k�nnen
