----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--         Stored Procedure - Team Story - Test
----------------------------------------------------------------------

EXEC TeamStory 'Red Bull';
-- Normalfall mit aktuellem Team 
-- Output: Normale Teamgeschichte
-- Erklärung: Die Prozedur wird mit dem aktuellen Rennteam "Red Bull" aufgerufen. Die Ausgabe zeigt die normale Teamgeschichte.
PRINT '';
PRINT '';

EXEC TeamStory 'Benetton';
-- Normalfall mit nicht aktuellem Team 
-- Output: Normale Teamgeschichte
-- Erklärung: Die Prozedur wird mit dem nicht aktuellen Rennteam "Benetton" aufgerufen. Die Ausgabe zeigt die normale Teamgeschichte ohne Fahrer Information.
PRINT '';
PRINT '';


EXEC TeamStory 'xyz';
-- Fahrer nicht gefunden
-- Output: Team NOT found, try to spell it correctly or try writing it without spaces.
-- Erklärung: 'xyz' ist kein gültiger Team Name, daher zeigt das Programm "Team NOT found,...".
PRINT '';

EXEC TeamStory '';
-- Leere Felder
-- Output: Team NOT found, try to spell it correctly or try writing it without spaces.
-- Erklärung: Der Felder ist leer, daher wird "Team NOT found,..." angezeigt.
PRINT '';

EXEC TeamStory NULL;
-- NULL-Wert für Namen
-- Output: Team NOT found, try to spell it correctly or try writing it without spaces.
-- Erklärung: Das Feld ist NULL, daher wird "Team NOT found,..." angezeigt.
PRINT '';

EXEC TeamStory 5;
-- Numerische Eingabe
-- Output: Team NOT found, try to spell it correctly or try writing it without spaces.
-- Erklärung: Numerische Eingaben werden nicht akzeptiert, daher wird "Team NOT found,..." angezeigt.

-- EXEC TeamStory;
-- Fehlender Parameter
-- Output: Procedure or function 'TeamStory' expects parameter '@TeamName', which was not supplied.
-- Erklärung: Die Prozedur erwartet ein Parameter, den Namen eines Rennteams. Da es fehlt, wird eine Fehlermeldung angezeigt.
PRINT '';


--- select TeamName from Team     
---  = um alle Teams anzuzeigen, die für diese gespeicherte Prozedur verwendet werden können
