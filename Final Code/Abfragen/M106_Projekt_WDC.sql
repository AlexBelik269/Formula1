----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--                 Function - WDC - Test
----------------------------------------------------------------------

SELECT * FROM WDC()
ORDER BY Points DESC
-- Zeigt alle aktuelle Fahrer und ihre Punkte von h�hsten Punktzahl bis niedrigsten Punktzahl


SELECT * FROM WDC()
ORDER BY Points ASC
-- Zeigt alle aktuelle Fahrer und ihre Punkte von niedrigsten Punktzahl bis h�hsten Punktzahl

SELECT TOP 5 * FROM WDC()
ORDER BY Points DESC;
-- Zeigt die top 5 Fahrer

SELECT * FROM WDC()
WHERE Team = 'Red Bull';
-- Zeigt nur die Fahrer die im Team Redbull sind

SELECT * FROM WDC()
WHERE Points > 100
ORDER BY Points DESC;
-- Zeigt alle Fahrer die �ber 100 Punkte bekommen haben

SELECT COUNT(*) AS 'Total Drivers' FROM WDC();
-- Zeigt wie viele Fahrer in diese Funktion ber�ksichtigt werden

