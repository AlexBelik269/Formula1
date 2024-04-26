----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
--              Stored Procedure - Team Story
----------------------------------------------------------------------
USE Formula1
GO

DROP PROCEDURE IF EXISTS TeamStory
GO

CREATE PROCEDURE TeamStory(@TeamName VARCHAR(40))
AS BEGIN
    DECLARE @Story VARCHAR(MAX);

    DECLARE @OfficialName VARCHAR(90);
    DECLARE @YearOf1GP VARCHAR(4);
	DECLARE @TeamID VARCHAR(3);
    DECLARE @WCCwins VARCHAR(2);
    DECLARE @TeamExists BIT;
    DECLARE @Country VARCHAR(3);
    DECLARE @Founder VARCHAR(30);
    DECLARE @GPentered VARCHAR(4);
    DECLARE @TeamPrincipal VARCHAR(30);

    DECLARE @FirstName VARCHAR(30);
    DECLARE @LastName VARCHAR(30);
    DECLARE @Age VARCHAR(4);
    DECLARE @StartYear VARCHAR(4);
    DECLARE @NumberOfTeams VARCHAR(2);
    DECLARE @GPwins VARCHAR(3);
    DECLARE @GPwins2023 VARCHAR(2);
    DECLARE @Podiums2023 VARCHAR(3);

    DECLARE @Driver1 VARCHAR(70);
    DECLARE @D1Age VARCHAR(4);
    DECLARE @D1StartYear VARCHAR(4);
    DECLARE @D1NumberOfTeams VARCHAR(2);
    DECLARE @D1GPwins VARCHAR(3);
    DECLARE @D1GPwins2023 VARCHAR(2);
    DECLARE @D1Podiums2023 VARCHAR(3);

    DECLARE @Driver2 VARCHAR(70);
    DECLARE @D2Age VARCHAR(4);
    DECLARE @D2StartYear VARCHAR(4);
    DECLARE @D2NumberOfTeams VARCHAR(2);
    DECLARE @D2GPwins VARCHAR(3);
    DECLARE @D2GPwins2023 VARCHAR(2);
    DECLARE @D2Podiums2023 VARCHAR(3);



IF EXISTS (SELECT 1 FROM Team WHERE TeamName = @TeamName) 
BEGIN
    SELECT 
        @TeamID = T.TeamID,
		@TeamName = T.TeamName,
        @OfficialName = T.OfficialName,
        @Country = T.Country,
        @YearOf1GP = T.YearOf1GP,
        @TeamPrincipal = T.TeamPrincipal,
        @Founder = T.Founder,
        @GPentered = T.GPentered,
        @WCCwins = T.ConstructorsCSwin,
        @TeamExists = T.TeamExists
    FROM Team T  
    WHERE T.TeamName = @TeamName;
	SET @Founder = COALESCE(@Founder, 'Unknown Founder');

   IF @TeamExists = 1 AND EXISTS (SELECT 1 FROM Team WHERE TeamName = @TeamName)
	BEGIN
        
		-- Create a temporary table to store the results
		CREATE TABLE #LastDriverInTeam (
			DriverID INT,
			LastDriverInTeamID INT,
			TeamID INT);
		-- Insert the last DriverInTeamID for each current driver
		INSERT INTO #LastDriverInTeam (DriverID, LastDriverInTeamID, TeamID)
		SELECT TOP 20
			DIT.fk_DriverID AS DriverID,
			DIT.DriverInTeamID AS LastDriverInTeamID,
			DIT.fk_TeamID AS TeamID
		FROM ( SELECT		-- Rank the rows within each driver group based on DriverInTeamID
				fk_DriverID,
				DriverInTeamID,
				ROW_NUMBER() OVER (PARTITION BY fk_DriverID ORDER BY DriverInTeamID DESC) AS RowNum,
				fk_TeamID
				FROM DriverInTeam ) DIT
		WHERE DIT.RowNum = 1;  -- Include only the rows with the highest rank (last DriverInTeamID)
		-- Select the results from the temporary table
		-- SELECT * FROM #LastDriverInTeam;

		-- Select the two drivers for the specified team
		DECLARE @Driver1ID INT;
		DECLARE @Driver2ID INT;
		-- Set the values using SELECT TOP 1
		SET @Driver1ID = (SELECT TOP 1 DriverID FROM #LastDriverInTeam LDIT JOIN DriverInTeam DIT ON LDIT.DriverID = DIT.fk_DriverID WHERE LDIT.TeamID = @TeamID);
		SET @Driver2ID = (SELECT TOP 1 DriverID FROM #LastDriverInTeam LDIT JOIN DriverInTeam DIT ON LDIT.DriverID = DIT.fk_DriverID WHERE LDIT.TeamID = @TeamID AND LDIT.DriverID <> @Driver1ID);
		-- Set the names of the drivers
		SET @Driver1 = (SELECT D.FirstName + ' ' + D.LastName FROM Driver D WHERE D.DriverID = @Driver1ID);
		SET @Driver2 = (SELECT D.FirstName + ' ' + D.LastName FROM Driver D WHERE D.DriverID = @Driver2ID);

		-- Output the results
		--  SELECT
		--  @Driver1 AS Driver1,
		--  @Driver2 AS Driver2;
		-- Set the Driver 1 information
		SELECT
			@D1Age = D.Age,
			@D1StartYear = D.StartYear,
			@D1NumberOfTeams = (SELECT COUNT(DISTINCT fk_TeamID) FROM DriverInTeam WHERE fk_DriverID = @Driver1ID),
			@D1GPwins = D.GPwins,
			@D1GPwins2023 = (SELECT COUNT(*) FROM FirstPlace WHERE fk_DriverID = @Driver1ID),
			@D1Podiums2023 = (
				SELECT COUNT(*) AS PodiumCount
				FROM (
					SELECT fk_DriverID AS DriverID
					FROM FirstPlace
					WHERE fk_DriverID = @Driver1ID
					UNION ALL
					SELECT fk_DriverID
					FROM SecondPlace
					WHERE fk_DriverID = @Driver1ID
					UNION ALL
					SELECT fk_DriverID
					FROM ThirdPlace
					WHERE fk_DriverID = @Driver1ID
				) AS PodiumCounts)
		FROM Driver D
			JOIN DriverInTeam DIT ON D.DriverID = DIT.fk_DriverID
			JOIN Team T ON T.TeamID = DIT.fk_TeamID
			JOIN #LastDriverInTeam LDIT ON D.DriverID = DIT.fk_DriverID
		WHERE @Driver1ID = DIT.fk_DriverID

		-- Set the Driver 2 information
		SELECT
			@Driver2 = @Driver2,
			@D2Age = D.Age,
			@D2StartYear = D.StartYear,
			@D2NumberOfTeams = (SELECT COUNT(DISTINCT fk_TeamID) FROM DriverInTeam WHERE fk_DriverID = @Driver2ID),
			@D2GPwins = D.GPwins,
			@D2GPwins2023 = (SELECT COUNT(*) FROM FirstPlace WHERE fk_DriverID = @Driver2ID),
			@D2Podiums2023 = (
				SELECT COUNT(*) AS PodiumCount
				FROM (
					SELECT fk_DriverID AS DriverID
					FROM FirstPlace
					WHERE fk_DriverID = @Driver2ID
					UNION ALL
					SELECT fk_DriverID
					FROM SecondPlace
					WHERE fk_DriverID = @Driver2ID
					UNION ALL
					SELECT fk_DriverID
					FROM ThirdPlace
					WHERE fk_DriverID = @Driver2ID
				) AS PodiumCounts
			)
		FROM
			Driver D
			JOIN DriverInTeam DIT ON D.DriverID = DIT.fk_DriverID
			JOIN Team T ON T.TeamID = DIT.fk_TeamID
			JOIN #LastDriverInTeam LDIT ON D.DriverID = DIT.fk_DriverID
		WHERE @Driver2ID = DIT.fk_DriverID

	END




------------ @Story ------------ 

	IF @TeamID IS NOT NULL
	BEGIN
        SET @Story = 'This is the Story of ' + @TeamName + ':' + CHAR(10)+
		CASE 
			WHEN @YearOf1GP < '1975' THEN 'Immersed in the vibrant history of Formula 1, ' +  @TeamName +  ' stands as a legendary powerhouse that has shaped the very soul of motorsport since the beginning.' + CHAR(10)
			WHEN @YearOf1GP > '1975' AND @YearOf1GP < '1990' THEN @TeamName + ' is a stalwart in Formula 1, etching its legacy with a compelling narrative of resilience and racing prowess.' + CHAR(10)
			WHEN @YearOf1GP > '1990' THEN 'Born from the energy of innovation, ' +  @TeamName + ' recently entered the Formula 1, representing the vibrant fusion of technology and style.' + CHAR(10)
		END 
		+ 
		'Established in ' +  @YearOf1GP + ', the team, officially known as ' +  @OfficialName + ', hails from the racing heartland of ' + @Country + '.'  + CHAR(10)
		+
		CASE 
			WHEN @TeamExists = 1 THEN 'Pioneered by visionary ' +  @Founder + ', the team entered its first Grand Prix in ' + @YearOf1GP + ' with a bold spirit that continues to define its journey.'+ CHAR(10)
			WHEN @TeamExists = 0 THEN 'Pioneered by visionary ' +  @Founder + ', the team entered its first Grand Prix in ' + @YearOf1GP + ' with a bold spirit that defined its journey in ist existence.'+ CHAR(10)
			WHEN @Founder IS NULL THEN 'This Team doesn''t have a singular Founder. It was founded by an existing company or team.'+ CHAR(10)
			ELSE ''
		END +
		CASE 
			WHEN @WCCwins = 0 THEN @TeamName + ' swiftly got in the game of highest level of motorsport. '
			WHEN @WCCwins > 0 THEN @TeamName + ' swiftly ascended to greatness and pursuit of excellence. '
		END + 
		CASE 
			WHEN @WCCwins > 1 AND @TeamExists = 0 THEN 'During their existence ' + @TeamName + ' managed to win multiple World constructors championships.  ' + @WCCwins + ' to be exact.'+ CHAR(10)																	
			WHEN @TeamName = 'Ferrari' THEN @TeamName + ' managed to win unbelieveable ' +  @WCCwins + ' World constructors championships.'+ CHAR(10) +'Which is the world record. No other team has managed to get ' + @WCCwins + ' WCC wins in Formula 1 long history. '+ CHAR(10)	
			WHEN @WCCwins = 1 AND @TeamExists = 0 THEN @TeamName + ' has managed to win ' + @WCCwins + ' World constructors championship. '	+ CHAR(10)																													
			WHEN @WCCwins = 0 AND @TeamExists = 0 THEN @TeamName + ' sadly hasn''t won a World constructors championship in their existence. '	+ CHAR(10)																												
			WHEN @WCCwins = 1 AND @TeamExists = 1 THEN @TeamName + ' managed to win ' + @WCCwins + ' World constructors championship.'+ CHAR(10) +'Let''s see if they can get any more.' + CHAR(10)																					
			WHEN @WCCwins > 1 AND @TeamExists = 1 THEN @TeamName + ' managed to win ' + @WCCwins + ' World constructors championships.'+ CHAR(10) +'Let''s see if they can get any more. '	+ CHAR(10)																				
			WHEN @WCCwins = 0 AND @TeamExists = 1 THEN @TeamName + ' didn''t win a World constructors championship yet. But they will'+ CHAR(10) +'surelly compete for one in the fututre! '	+ CHAR(10)
			ELSE ''
		END +
		CASE
			WHEN @TeamExists = 1 THEN @TeamName + ' is among the ten F1 teams currently participating on the grid.' + CHAR(10)
			ELSE ''
		END 
		+ 
		'Guided by the insightful leadership of Team Principal ' + @TeamPrincipal + ', the team has emerged as a standout example of racing brilliance.' + CHAR(10)
		+
		CASE 
			WHEN @Gpentered > 199 THEN 'Having amassed an impressive number of ' + @GPentered + ' Grand Prix participations, they have firmly engraved their name in the chronicles of F1 history.'																				   + CHAR(10)
			WHEN @Gpentered < 199 AND @TeamExists = 1 THEN 'Despite their relatively brief existence, with a commendable ' + @GPentered + ' Grand Prix entries, this emerging team has already begun etching a promising legacy in the vibrant tapestry of F1 history.'			   + CHAR(10)
			WHEN @Gpentered < 199 AND @TeamExists = 0 THEN 'Even though their time on the racing circuit was relatively short-lived, boasting a commendable ' + @GPentered + ' Grand Prix entries, this now-retired team has left a lasting imprint on the pages of F1 history.'   + CHAR(10)
		END
		+ CHAR(10)+ 

		CASE 
		WHEN @TeamExists = 1 THEN
				'In the current season, the team proudly presents its accomplished drivers: ' + @Driver1  + ' and ' + @Driver2 + '.' + CHAR(10) + CHAR(10)
				+
				CASE
					WHEN @D1StartYear > 2020 THEN @Driver1+ ', age ' + @D1Age + '. ' 
					WHEN @D1StartYear < 2020 THEN @Driver1 + ', brings a wealth of experience at the age of ' + @D1Age + '. '
				END + 
				CASE
					WHEN @D1NumberOfTeams = 1 THEN 'Having been part of ' + @D1NumberOfTeams + ' team throughout his career, ' 
					WHEN @D1NumberOfTeams > 1 THEN 'Having been part of ' + @D1NumberOfTeams + ' teams throughout his career, '
				END + 
				CASE
					WHEN @D1GPwins >= 1  AND @D1GPwins2023 >= 1 AND @D1Podiums2023 >= 1 THEN @Driver1 + ' has' + CHAR(10)+ 'solidified an impressive track record,amassing triumphs with a total of '+ @D1GPwins + ' wins. Specifically in the 2023 season, he added to' + CHAR(10)+ 'his success with ' + @D1GPwins2023 + ' victories and ' + @D1Podiums2023 + ' podium finishes. '
					WHEN @D1GPwins >=  1 AND @D1GPwins2023 = 0  AND @D1Podiums2023 >= 1 THEN @Driver1 + ' has' + CHAR(10)+ 'built an impressive track record,showcasing a total of ' + @D1GPwins + ' victories throughout his career. However, the year 2023 saw no wins' + CHAR(10)+ 'but did include ' + @D1Podiums2023 + ' podium finishes for this accomplished driver. '		
					WHEN @D1GPwins = 0   AND @D1GPwins2023 = 0  AND @D1Podiums2023 >= 1 THEN @Driver1 + ' has' + CHAR(10)+ 'not secured a career win or achieved a victory in the 2023 season. However, noteworthy is the accomplishment of ' + @D1Podiums2023 + ' podiums' + CHAR(10)+ 'earned during the 2023 remarkable season.'															
					WHEN @D1GPwins >= 1  AND @D1GPwins2023 = 0  AND @D1Podiums2023 = 0  THEN @Driver1 + ' has' + CHAR(10)+ 'accumulated ' + @D1GPwins + ' career victories, yet faced a season devoid of both wins and podium finishes in 2023.'																																
					WHEN @D1GPwins = 0   AND @D1GPwins2023 = 0  AND @D1Podiums2023 = 0  THEN @Driver1 + ' has' + CHAR(10)+ 'not clinched a career win and remained without a win or podium in the 2023 season.' + CHAR(10) 																																							
				END + 
				CASE
					WHEN @D1Podiums2023 >= 2 THEN 'Known for his strategic prowess and podium consistency, ' + @Driver1 + ' is a' + CHAR(10)+ 'seasoned racer who continues to leave an indelible mark on the Formula 1 landscape.'
					WHEN @D1Podiums2023 <= 1 THEN 'Recognized for his strategic acumen and occasional podium success, ' + @Driver1 + ' stands' + CHAR(10)+ 'as a seasoned racer, leaving a lasting impact on the Formula 1 scene.'
				END  
				+ CHAR(10) + CHAR(10) +
				'On the other side of the cockpit, we have ' + @Driver2 + ', a dynamic driver at the age of ' + @D2Age + '. '  
				+
				CASE
					WHEN @D2NumberOfTeams = 1 THEN 'Having been a member of ' + @D2NumberOfTeams + ' team throughout his career,' + CHAR(10)
					WHEN @D2NumberOfTeams > 1 THEN 'Having been a member of ' + @D2NumberOfTeams + ' teams throughout his career,' + CHAR(10)
				END + 
				CASE
					WHEN @D2GPwins >= 1 AND @D2GPwins2023 >= 1 AND @D2Podiums2023 >= 1 THEN @Driver2 + ' has established a formidable track record, accumulating victories with a total of ' + @D2GPwins + ' wins. Notably, in the 2023 season, he' + CHAR(10) +'expanded on hisachievements with ' + @D2GPwins2023 + ' wins and secured ' + @D2Podiums2023 + ' podium finishes.'			 
					WHEN @D2GPwins >= 1 AND @D2GPwins2023 = 0  AND @D2Podiums2023 >= 1 THEN @Driver2 + ' has crafted an admirable track record, highlighting a cumulative total of ' + @D2GPwins + ' victories over the span of his career. ' + CHAR(10) +'Although the year 2023 didn''t bring any wins, it did feature ' + @D2Podiums2023 + ' podium finishes for this accomplished driver.'	
					WHEN @D2GPwins = 0  AND @D2GPwins2023 = 0  AND @D2Podiums2023 >= 1 THEN @Driver2 + ' has yet to secure a career win and has not achieved victory in the 2023 season. However, it is worth noting the accomplishment of ' + @D2Podiums2023 + ' podiums' + CHAR(10) +'earned during the remarkable 2023 season.'														
					WHEN @D2GPwins >= 1 AND @D2GPwins2023 = 0  AND @D2Podiums2023 = 0  THEN @Driver2 + ' has amassed career victories totaling ' + @D2GPwins + '. However, the 2023 season presented a challenge, with no wins or podium finishes for the accomplished driver.'	+ CHAR(10)																								
					WHEN @D2GPwins  = 0 AND @D2GPwins2023 = 0  AND @D2Podiums2023 = 0  THEN @Driver2 + ' has yet to secure a career win and continues to be without both a win and podium in the 2023 season.'	+ CHAR(10)																																								
				END + 
				CASE
					WHEN @D2Podiums2023 >= 2 THEN 'Renowned for their strategic acumen and consistent presence on the podium,' + CHAR(10) +'' + @Driver2 + ' stands as a seasoned racer, leaving an enduring mark on the Formula 1 landscape.'
					WHEN @D2Podiums2023 <= 1 THEN 'Recognized for their strategic acumen and occasional podium success,' + CHAR(10) + @Driver2 + ' stands as a seasoned racer, leaving a lasting impact on the Formula 1 scene.'
				END
				+ CHAR(10) + CHAR(10) +
				'Together, ' + @Driver1 + ' and ' + @Driver2 + ' form an impressive duo, combining their individual strengths and achievements to propel' + CHAR(10) +'the team towards success in the fiercely competitive realm of Formula 1.'+ CHAR(10)
				+ CHAR(10)
		WHEN @TeamExists = 0 THEN '' 
		END +
		CASE 
			WHEN @TeamExists = 1 THEN 'As a testament to their enduring legacy, ' + @TeamName + ' stands as a testament to the relentless pursuit of speed, precision, and a passion for motorsport.' + CHAR(10) +'With a rich variety of achievements, ' + @TeamName + ' continues to exist as a dynamic force, embodying the essence of Formula 1.'					+ CHAR(13)
			WHEN @TeamExists = 0 THEN 'While no longer competing in Formula 1, ' + @TeamName + '''s rich history and diverse achievements continue to resonate as a dynamic force that' + CHAR(10) +'once embodied the essence of the sport.'																															+ CHAR(13)
		END
END 
    PRINT @Story;
	DROP TABLE IF EXISTS #LastDriverInTeam;
END
    ELSE
	 BEGIN
		PRINT 'Team NOT found, try to spell it correctly or try writing it without spaces.';
	 END
END
GO

-- Execute the procedure
EXEC TeamStory 'Minardi';

---select * from Team
---select D.LastName from DriverInTeam 
---join Driver D on DriverID = fk_DriverID
---where fk_TeamID = 4




