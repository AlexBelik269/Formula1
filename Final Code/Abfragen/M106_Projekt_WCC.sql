----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------
USE Formula1
GO
----------------------------------------------------------------------
--                 Function - WCC - Test
----------------------------------------------------------------------

SELECT * FROM WCC()
ORDER BY Points DESC
-- Zeigt alle aktuelle Teams und ihre Team Punkte von höhsten Punktzahl bis niedrigsten Punktzahl


SELECT * FROM WCC()
ORDER BY Points ASC
-- Zeigt alle aktuelle Teams und ihre Team Punkte von niedrigsten Punktzahl bis höhsten Punktzahl

SELECT TOP 5 * FROM WCC()
ORDER BY Points DESC;
-- Zeigt die top 5 Teams

SELECT * FROM WCC()
WHERE Team = 'McLaren';
-- Zeigt nur Team Mclaren

SELECT * FROM WCC()
WHERE Points > 300
ORDER BY Points DESC;
-- Zeigt alle Teams die über 300 Punkte bekommen haben

SELECT COUNT(*) AS 'Total Teams' FROM WCC();
-- Zeigt wie viele Teams in diese Funktion berüksichtigt werden
