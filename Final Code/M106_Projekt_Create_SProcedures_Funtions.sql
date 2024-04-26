----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

USE Formula1
GO

----------------------------------------------------------------------
--             Stored Procedure - Driver Story
----------------------------------------------------------------------

DROP PROCEDURE IF EXISTS DriverStory;
GO

CREATE PROCEDURE DriverStory 
    @FirstName VARCHAR(30), 
    @LastName VARCHAR(30)
AS BEGIN
    DECLARE @DriverName VARCHAR(70) = @FirstName + ' ' + @LastName;
    DECLARE @Story VARCHAR(MAX);
    DECLARE @Birthday VARCHAR(30);
	DECLARE @Nationality VARCHAR(3);
	DECLARE @Age VARCHAR(3);
	DECLARE @YearOf1GP VARCHAR(4);
	DECLARE @AgeOf1GP VARCHAR(3);
	DECLARE @FirstTeam VARCHAR(40);
	DECLARE @LastTeam VARCHAR(40);
	DECLARE @CareerPoints VARCHAR(6);
	DECLARE @GPwins VARCHAR(3);
	DECLARE @GPentered VARCHAR(4);
	DECLARE @PointsIn2023 VARCHAR(5);
	DECLARE @Podium VARCHAR(max);
	DECLARE @Wins2023 VARCHAR(max);
	DECLARE @FirstPlaceCount VARCHAR(max);
	DECLARE @AllFirstPlaceRaces VARCHAR(MAX);
	DECLARE @SecondPlaceCount VARCHAR(max);
	DECLARE @AllSecondPlaceRaces VARCHAR(MAX);
	DECLARE @ThirdPlaceCount  VARCHAR(max);
	DECLARE @AllThirdPlaceRaces VARCHAR(MAX);
	DECLARE @WDC VARCHAR(2);
	DECLARE @CurrentDriver BIT;
    DECLARE @TeamPrincipal VARCHAR(40);

IF EXISTS (SELECT 1 FROM Driver WHERE @FirstName = FirstName AND @LastName = LastName) 
BEGIN
     SELECT @Birthday = CAST(D.BirthDate AS VARCHAR(12)),
			@Nationality = D.Nationality,
			@Yearof1GP = CAST(D.StartYear AS VARCHAR(12)),
			@Age = CAST(D.Age AS VARCHAR(3)),
			@YearOf1GP = CAST(D.StartYear AS VARCHAR(5)),
			@GPwins = CAST(D.GPwins AS VARCHAR(3)),
			@CareerPoints =CAST( D.CareerPoints AS VARCHAR(6)),
			@PointsIn2023 = CAST(D.PointsIn2023 AS VARCHAR(6)),
			@CurrentDriver = CAST(D.CurrentDriver AS VARCHAR(4)),
			@WDC =CAST( D.WDC AS VARCHAR(2)),
			@GPentered= CAST(D.GPentered AS VARCHAR(4))
		FROM Driver D   
		JOIN DriverInTeam DT on DriverID = fk_DriverID
		JOIN Team T on T.TeamID = DT.fk_TeamID
		WHERE D.FirstName = @FirstName AND D.LastName = @LastName;

		SELECT TOP 1 @FirstTeam = T.TeamName
		FROM DriverInTeam DT  
		JOIN Driver D ON DT.fk_DriverID = D.DriverID
		JOIN Team T ON T.TeamID = DT.fk_TeamID
		WHERE D.FirstName = @FirstName AND D.LastName = @LastName
		ORDER BY DT.DriverInTeamID;

		SELECT TOP 1 @LastTeam = T.TeamName 
		FROM DriverInTeam DT  
		JOIN Driver D ON DT.fk_DriverID = D.DriverID
		JOIN Team T ON T.TeamID = DT.fk_TeamID
		WHERE D.FirstName = @FirstName AND D.LastName = @LastName
		ORDER BY DT.DriverInTeamID DESC;

		SELECT @TeamPrincipal = T.TeamPrincipal
		FROM Team T
		WHERE T.TeamName = @LastTeam;

        SET @DriverName = @FirstName + ' ' + @LastName;
		SET @AgeOf1GP = @YearOf1GP - YEAR(@Birthday) - 1;
			
  IF @CurrentDriver = 1
	BEGIN
		SET @Podium = (SELECT COUNT(*) AS PodiumCount
			FROM (
				SELECT fk_DriverID AS DriverID
				FROM FirstPlace
				WHERE fk_DriverID IN (
					SELECT DriverID
					FROM Driver
					WHERE FirstName = @FirstName AND LastName = @LastName
				)
				UNION ALL
				SELECT fk_DriverID
				FROM SecondPlace
				WHERE fk_DriverID IN (
					SELECT DriverID
					FROM Driver
					WHERE FirstName = @FirstName AND LastName = @LastName
				)
				UNION ALL
				SELECT fk_DriverID
				FROM ThirdPlace
				WHERE fk_DriverID IN (
					SELECT DriverID
					FROM Driver
					WHERE FirstName = @FirstName AND LastName = @LastName
				)
			) AS PodiumCounts);
		
		SET @Wins2023 = ( SELECT COUNT(*)
			FROM FirstPlace FP
				JOIN Driver D ON FP.fk_DriverID = D.DriverID
			WHERE D.FirstName = @FirstName AND D.LastName = @LastName);

		SET @FirstPlaceCount = ( SELECT COUNT(*)
			FROM FirstPlace FP
				JOIN Driver D ON FP.fk_DriverID = D.DriverID
			WHERE D.FirstName = @FirstName AND D.LastName = @LastName);

		SET @SecondPlaceCount = (
			SELECT COUNT(*)
			FROM SecondPlace SP
			JOIN Driver D ON SP.fk_DriverID = D.DriverID
			WHERE D.FirstName = @FirstName AND D.LastName = @LastName );

		SET @ThirdPlaceCount = (
			SELECT COUNT(*)
			FROM ThirdPlace TP
			JOIN Driver D ON TP.fk_DriverID = D.DriverID
			WHERE D.FirstName = @FirstName AND D.LastName = @LastName );

		SET @AllFirstPlaceRaces = (SELECT STRING_AGG(R.CircuitName, ', ')
			FROM FirstPlace FP
				JOIN Driver D ON FP.fk_DriverID = D.DriverID
				JOIN Race R ON FP.fk_RaceID = R.RaceID
			WHERE D.FirstName = @FirstName AND D.LastName = @LastName);

		SET @AllSecondPlaceRaces = (SELECT STRING_AGG(R.CircuitName, ', ')
		FROM SecondPlace SP
		JOIN Driver D ON SP.fk_DriverID = D.DriverID
		JOIN Race R ON SP.fk_RaceID = R.RaceID
		WHERE D.FirstName = @FirstName AND D.LastName = @LastName);

		SET @AllThirdPlaceRaces = (SELECT STRING_AGG(R.CircuitName, ', ')
			FROM ThirdPlace TP
			JOIN Driver D ON TP.fk_DriverID = D.DriverID
			JOIN Race R ON TP.fk_RaceID = R.RaceID
			WHERE D.FirstName = @FirstName AND D.LastName = @LastName);
   END

	--- Main Part ---
        SET @Story ='Introducing the exceptional talent of ' + @DriverName + ', a driving force in the world of Formula 1.' + char(10)+
                 'Born on ' + @Birthday + ', from ' + @Nationality + 
				CASE 
                    WHEN @Age IS NOT NULL THEN ' currently ' + @Age +' years old. '
                    WHEN @Age IS NULL THEN ' but unfortunately  died. '
                END 
				+
				'His journey began in karting, and by ' + @YearOf1GP + ',' + char(10) + 'at the age of ' + @AgeOf1GP + ', he joined ' + @FirstTeam 
				+
				CASE
					WHEN @FirstTeam = @LastTeam THEN ' with ' + @TeamPrincipal + ' as Team Principal.' + char(10) 
					WHEN @CurrentDriver = 0 THEN ' and ended his career in ' + @LastTeam + '. '
					ELSE ' and is now in ' + @LastTeam + ' with ' + @TeamPrincipal + ' as Team Principal.' + char(10)
				END +
				CASE
					WHEN @GPwins > 1 THEN 'During his whole career he managed to get ' + @CareerPoints + ' points and ' + @GPwins + ' Grand Prix wins.' 
					WHEN @GPwins = 0 THEN 'During his whole career he managed to get ' + @CareerPoints + ' points but unfortunatualy didn''t get any wins yet.' 
					WHEN @GPwins = 0 AND @CurrentDriver = 0 THEN 'During his whole career he managed to get ' + @CareerPoints + ' points but no Grand Prix wins unfortunatualy.'     
				END 
				+ char(10) +   @DriverName + ' has entered ' + @GPentered + ' Grand Prix. ' 
				
		IF @CurrentDriver = 1
		BEGIN
			SET @Story = @Story +
				CASE 
				   WHEN @Podium > 1  AND @Wins2023 > 1 THEN 'In the 2023 season he got ' + @PointsIn2023 + ' points,' + ' had ' + @Podium + ' podiums and ' + @Wins2023 + ' Grand Prix wins.'+ char(10)
				   WHEN @Podium > 1  AND @Wins2023 = 1 THEN 'In the 2023 season he got ' + @PointsIn2023 + ' points,' + ' had ' + @Podium + ' podiums and ' + @Wins2023 + ' Grand Prix win. ' + char(10)
				   WHEN @Podium > 1  AND @Wins2023 = 0 THEN 'In the 2023 season he got ' + @PointsIn2023 + ' points,' + ' had ' + @Podium + ' podiums but got no Grand Prix wins. '+ char(10)
				   WHEN @Podium = 1  AND @Wins2023 = 0 THEN 'In the 2023 season he got ' + @PointsIn2023 + ' points,' + ' had ' + @Podium + ' podium but got no Grand Prix wins. ' + char(10)
				   WHEN @Podium = 0  AND @Wins2023 = 0 THEN 'In the 2023 season he got ' + @PointsIn2023 + ' points,' + ' but had no podiums or Grand Prix wins. ' + char(10)
				END
				+
				CASE 
					WHEN @FirstPlaceCount > 1 THEN 'He finished in first place ' +  @FirstPlaceCount + ' times, in ' + @AllFirstPlaceRaces + '. ' + char(10)
					WHEN @FirstPlaceCount = 1 THEN 'He finished in first place ' +  @FirstPlaceCount + ' time, in ' + @AllFirstPlaceRaces + '. '  + char(10)
					WHEN @FirstPlaceCount = 0 THEN 'He didn''t finish in first place in this season. '+ char(10)
				END +
				CASE 
					WHEN @SecondPlaceCount > 1 THEN 'Took second place ' +  @SecondPlaceCount + ' times, in ' + @AllSecondPlaceRaces + '. ' + char(10)
					WHEN @SecondPlaceCount = 1 THEN 'Took second place ' +  @SecondPlaceCount + ' time, in ' + @AllSecondPlaceRaces + '. '  + char(10)
					WHEN @SecondPlaceCount = 0 THEN 'He didn''t finish second in this season. '+ char(10)
				END +
				CASE 
					WHEN @ThirdPlaceCount > 1 THEN 'And took third place ' + @ThirdPlaceCount + ' times, in ' + @AllThirdPlaceRaces + '. ' + char(10)
					WHEN @ThirdPlaceCount = 1 THEN 'And took third place ' + @ThirdPlaceCount + ' time, in ' + @AllThirdPlaceRaces + '. '  + char(10)
					WHEN @ThirdPlaceCount = 0 THEN 'He didn''t finish in third place in this season. ' + char(10)
				END
		  END
		ELSE
		BEGIN
			SET @Story = @Story + 'But he didn''t race in the 2023 season.' + char(10)
		END; 
		 

	SET @Story = @Story +
				CASE
					WHEN @WDC = 1 THEN 'Apon other records, ' + @DriverName + ' has won 1 Formula One World Drivers Championship.' 
					WHEN @WDC > 1 THEN 'Apon many other records, ' + @DriverName + ' has won ' + @WDC + ' Formula One World Drivers Championships.'  
					WHEN @CurrentDriver = 1 AND @WDC = 0 THEN  @DriverName + ' hasn''t won a Formula One World Drivers Championship yet. Lets see what the future brings!' 
					WHEN @CurrentDriver = 0 AND @WDC = 0 THEN  @DriverName + ' hasn''t won a Formula One World Drivers Championship in his career.'  
				END;
  END
    ELSE
	 BEGIN
		DECLARE @ErrorMessage NVARCHAR(150) = 'Driver NOT found, try writing the first name and last name in this format: ''FirstName'' , ''LastName'' or try writing it without spaces.';
		raiserror(@ErrorMessage, 16, 1);
	 END;
	 
    PRINT N'This is the Story of ' + @DriverName + N':' + char(10) + char(13) + @Story;
END
GO






----------------------------------------------------------------------
--             Stored Procedure - Team Story
----------------------------------------------------------------------
use Formula1 
go

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

	DECLARE @DriversProTeam VARCHAR(MAX);

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

	SELECT @DriversProTeam = COALESCE(@DriversProTeam + ', ', '') + D.FirstName + ' ' + D.LastName
	FROM Driver D
	JOIN DriverInTeam DT ON D.DriverID = DT.fk_DriverID
	WHERE DT.fk_TeamID = @TeamID
		  AND D.CurrentDriver = 0;

   IF @TeamExists = 1 AND EXISTS (SELECT 1 FROM Team WHERE TeamName = @TeamName)
	BEGIN
		CREATE TABLE #LastDriverInTeam (   -- Create a temporary table to store the results
			DriverID INT,
			LastDriverInTeamID INT,
			TeamID INT);
		INSERT INTO #LastDriverInTeam (DriverID, LastDriverInTeamID, TeamID)  -- Insert the last DriverInTeamID for each current driver
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

		DECLARE @Driver1ID INT;
		DECLARE @Driver2ID INT;
		SET @Driver1ID = (SELECT TOP 1 DriverID FROM #LastDriverInTeam LDIT JOIN DriverInTeam DIT ON LDIT.DriverID = DIT.fk_DriverID WHERE LDIT.TeamID = @TeamID);
		SET @Driver2ID = (SELECT TOP 1 DriverID FROM #LastDriverInTeam LDIT JOIN DriverInTeam DIT ON LDIT.DriverID = DIT.fk_DriverID WHERE LDIT.TeamID = @TeamID AND LDIT.DriverID <> @Driver1ID);
		SET @Driver1 = (SELECT D.FirstName + ' ' + D.LastName FROM Driver D WHERE D.DriverID = @Driver1ID);
		SET @Driver2 = (SELECT D.FirstName + ' ' + D.LastName FROM Driver D WHERE D.DriverID = @Driver2ID);

		-- Set Driver 1 information
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

		-- Set Driver 2 information
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

	--- Main Part ---
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
			WHEN @TeamExists = 0 THEN 'The most prominent Drivers for this Team were ' + @DriversProTeam + '. While no longer competing in Formula 1, ' + @TeamName + '''s rich history' + CHAR(10) +'and diverse achievements continue to resonate as a dynamic force that once embodied the essence of the sport.'																															+ CHAR(13)
		END
END 
    PRINT @Story;
	DROP TABLE IF EXISTS #LastDriverInTeam;
END
    ELSE
	 BEGIN
		DECLARE @ErrorMessage NVARCHAR(150) = 'Team NOT found, try to spell it correctly or try writing it without spaces.';
	    raiserror(@ErrorMessage, 16, 1);
	 END
END
GO





----------------------------------------------------------------------
--             Stored Procedure - Race Info
----------------------------------------------------------------------

DROP PROCEDURE IF EXISTS RaceInfo
GO

CREATE PROCEDURE RaceInfo(@RaceID INT)
AS 
BEGIN
    BEGIN TRY
        DECLARE @Info VARCHAR(MAX);
        DECLARE @DriverNameFP VARCHAR(60);
        DECLARE @DriverNameSP VARCHAR(60);
        DECLARE @DriverNameTP VARCHAR(60);

        IF EXISTS (SELECT 1 FROM Race WHERE @RaceID = RaceID) 
        BEGIN
            SET @DriverNameFP = (
                SELECT D.FirstName + ' ' + D.LastName 
                FROM Driver D 
                JOIN FirstPlace FP ON D.DriverID = FP.fk_DriverID
                JOIN Race R ON FP.fk_RaceID = R.RaceID
                WHERE R.RaceID = @RaceID
            );

            SET @DriverNameSP = (
                SELECT D.FirstName + ' ' + D.LastName 
                FROM Driver D 
                JOIN SecondPlace SP ON D.DriverID = SP.fk_DriverID
                JOIN Race R ON SP.fk_RaceID = R.RaceID
                WHERE R.RaceID = @RaceID
            );

            SET @DriverNameTP = (
                SELECT D.FirstName + ' ' + D.LastName 
                FROM Driver D 
                JOIN ThirdPlace TP ON D.DriverID = TP.fk_DriverID
                JOIN Race R ON TP.fk_RaceID = R.RaceID
                WHERE R.RaceID = @RaceID
            );

            SELECT @Info = 'The ' + CAST(R.RaceID AS VARCHAR) + ' race of the 2023 Season unfolded on ' + CAST(R.RaceDate AS VARCHAR) + ', at the picturesque ' + R.RaceLocation + ' in ' + R.Country + '. The spotlight was on the much-anticipated ' + R.RaceName + ',' + CHAR(10) + 
                'held on the challenging ' + R.CircuitName + '. This renowned circuit stretches across a substantial ' +  CAST(R.CircuitLengthKM AS VARCHAR)  + ' kilometers, with each race covering an impressive distance' + CHAR(10) + 
                'of ' + CAST(R.RaceDistanceKM AS VARCHAR)  + '. ' + 'Distinguished by its ' + CAST(R.NumberOfLaps AS VARCHAR) + ' laps and strategically placed ' + CAST(R.NumberOfCorners  AS VARCHAR) + ' corners the ' +  R.CircuitName + ' has become a cornerstone in the world of racing.' + CHAR(10) + 
                'Since its inception in ' + CAST(R.YearOf1GP AS VARCHAR)  +  ', it has hosted exhilarating races, attracting both seasoned drivers and avid fans.' + 
                + CHAR(10) + CHAR(10) +
                CASE 
                    WHEN FP.fk_DriverID IS NOT NULL THEN 'As the 2023 race unfolded on the famed ' + R.CircuitName + ', the competition was fierce. Notably, ' + @DriverNameFP + ' displayed a remarkable performance,' + CHAR(10) + 
                        'securing an impressive First Place and earning ' + CAST(FP.Points AS VARCHAR) + ' points. Following closely behind, '  + @DriverNameSP + ' claimed the second position, accruing ' + CAST(SP.Points AS VARCHAR) + ' points.' + CHAR(10) + 
                        'The podium was completed with a commendable third-place finish by ' + @DriverNameTP + ', who garnered ' + CAST(TP.Points AS VARCHAR) + ' points. '
                    WHEN FP.fk_DriverID IS NULL THEN 'The race faced a disappointing cancellation due to severe and unprecedented weather conditions. The decision prioritized the safety of participants and spectators,' + CHAR(10) + 
                        'acknowledging the challenges posed by extreme precipitation and high winds. Despite the disappointment, the organizers are hopeful for an entertaining race next season.'
                END + CHAR(10) +
                'This event marked another thrilling chapter in the storied history of races at ' + R.CircuitName + ', showcasing the skill and determination of the participants.' + CHAR(10) + 
                'The legacy of this iconic circuit continues to unfold, providing racing enthusiasts with unforgettable moments on the track.'
            FROM Race R 
            JOIN FirstPlace FP ON R.RaceID = FP.fk_RaceID
            JOIN SecondPlace SP ON R.RaceID = SP.fk_RaceID
            JOIN ThirdPlace TP ON R.RaceID = TP.fk_RaceID
            WHERE @RaceID = R.RaceID;
            
            PRINT @Info;
        END
        ELSE
        BEGIN
            raiserror('Race not found.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END
GO






----------------------------------------------------------------------
--                  Function - Driver Status
----------------------------------------------------------------------

DROP FUNCTION IF EXISTS DriverStatus;
GO

CREATE FUNCTION DriverStatus (@FirstName VARCHAR(30), @LastName VARCHAR(30))
RETURNS VARCHAR(MAX)
AS 
BEGIN
    DECLARE @Status VARCHAR(MAX);
	    
		IF @FirstName IS NULL OR @LastName IS NULL OR LEN(@FirstName) = 0 OR LEN(@LastName) = 0
    BEGIN
        SET @Status = 'Invalid input parameters. Please provide valid First Name and Last Name.';
        RETURN @Status;
    END

        SELECT @Status = CONCAT(
        'Driver: ', D.FirstName, ' ', D.LastName, CHAR(13) + CHAR(10),
        'Driver Number: ', CAST(D.DriverNumber AS VARCHAR), CHAR(13) + CHAR(10),
        'Age: ' ,
			CASE 
				WHEN D.Age IS NULL THEN 'dead'
				ELSE CAST(D.Age AS VARCHAR)
			END , CHAR(13) + CHAR(10),
        'Nationality: ', D.Nationality, CHAR(13) + CHAR(10),
		'Career start: ', CAST(D.StartYear AS VARCHAR) , CHAR(13) + CHAR(10),
        'Total Wins: ', CAST(D.GPwins AS VARCHAR), CHAR(13) + CHAR(10),
        'Total Races Entered: ', CAST(D.GPentered AS VARCHAR), CHAR(13) + CHAR(10),
        'Percentage of Wins in 2023: ',
        CAST(CASE
                WHEN D.GPentered > 0 THEN
                    CAST(FORMAT((SELECT COUNT(*) FROM FirstPlace WHERE DriverID = fk_DriverID) * 100.0 / 22, '0.00') AS VARCHAR)
                ELSE
                    CAST('N/A' AS VARCHAR)
            END AS VARCHAR) + '%', CHAR(13) + CHAR(10),
        'Career Points: ', CAST(D.CareerPoints AS VARCHAR), CHAR(13) + CHAR(10),
        'Points in 2023: ', CAST(D.PointsIn2023 AS VARCHAR), CHAR(13) + CHAR(10),
        'World Driver Championships: ', CAST(D.WDC AS VARCHAR), CHAR(13) + CHAR(10),
		'Current Driver: ', 
        CASE
            WHEN D.CurrentDriver = 1 THEN 'Yes'
            WHEN D.CurrentDriver = 0 THEN 'No'
            ELSE 'Unknown'
        END, CHAR(13) + CHAR(10),
		'First Team: ', (SELECT TOP 1 T.TeamName
            FROM DriverInTeam DT 
            JOIN Team T ON T.TeamID = DT.fk_TeamID
            WHERE D.DriverID = DT.fk_DriverID
            ORDER BY DT.DriverInTeamID),      CHAR(13) + CHAR(10)+
		CONCAT(CASE
				WHEN D.CurrentDriver = 0 THEN 'Last Team: '
				ELSE 'Current Team: '
			END,
			(SELECT TOP 1 T.TeamName
				FROM DriverInTeam DT 
				JOIN Team T ON T.TeamID = DT.fk_TeamID
				WHERE D.DriverID = DT.fk_DriverID
				ORDER BY DT.DriverInTeamID DESC))
    )

    FROM Driver D
	JOIN DriverInTeam DT on DriverID = fk_DriverID
	JOIN Team T on TeamID = fk_TeamID
    WHERE D.FirstName = @FirstName AND D.LastName = @LastName;

	    IF @@ROWCOUNT = 0
    BEGIN
        SET @Status = 'Driver not found.';
   
   END

        RETURN @Status;
END;
GO






----------------------------------------------------------------------
--                      Function - WDC
----------------------------------------------------------------------

DROP FUNCTION IF EXISTS WDC;
GO

CREATE FUNCTION WDC()
RETURNS TABLE
AS
RETURN
(SELECT
        CONCAT(D.FirstName, ' ', D.LastName) AS Driver,
        LATEST_TEAM.TeamName AS Team,
        SUM(D.PointsIn2023) AS Points
    FROM Driver D
    JOIN
        (SELECT
                DT.fk_DriverID,
                T.TeamName,
                ROW_NUMBER() OVER (PARTITION BY DT.fk_DriverID ORDER BY DT.DriverInTeamID DESC) AS RowNum
            FROM DriverInTeam DT
            JOIN Team T ON T.TeamID = DT.fk_TeamID
        ) LATEST_TEAM ON D.DriverID = LATEST_TEAM.fk_DriverID AND LATEST_TEAM.RowNum = 1
    WHERE D.CurrentDriver = 1
    GROUP BY D.FirstName, D.LastName, LATEST_TEAM.TeamName
);
GO






----------------------------------------------------------------------
--                     Function - WCC
----------------------------------------------------------------------

DROP FUNCTION IF EXISTS WCC;
GO

CREATE FUNCTION WCC()
RETURNS TABLE
AS RETURN
(SELECT
        T.TeamName AS Team,
        SUM(CDP.PointsIn2023) AS Points
    FROM Team T
    JOIN (SELECT  
            DIT.fk_TeamID,
            D.PointsIn2023,
            ROW_NUMBER() OVER (PARTITION BY DIT.fk_DriverID ORDER BY DIT.DriverInTeamID DESC) AS RowNum
        FROM DriverInTeam DIT
        JOIN Driver D ON DIT.fk_DriverID = D.DriverID
        WHERE D.CurrentDriver = 1
     ) AS CDP ON T.TeamID = CDP.fk_TeamID
    WHERE T.TeamExists = 1
          AND CDP.RowNum = 1
	GROUP BY T.TeamName
);
GO







----------------------------------------------------------------------
--             Stored Procedure : Best From Team
----------------------------------------------------------------------

drop procedure if exists GetBestDriverFromEachTeam
go
create procedure GetBestDriverFromEachTeam
as
begin
    select
        Team.TeamName,
        isnull(Driver.FirstName + ' ' + Driver.LastName, 'Kein Fahrer vorhanden') as BestDriver,
        isnull(Driver.CareerPoints, 0) as CareerPoints
    from
        Team
    left join
        DriverInTeam on Team.TeamID = DriverInTeam.fk_TeamID
    left join
        Driver on DriverInTeam.fk_DriverID = Driver.DriverID
    where
        Driver.CareerPoints = (
            select max(CareerPoints)
            from Driver
            where DriverID in (select fk_DriverID from DriverInTeam where fk_TeamID = Team.TeamID)
        )
    order by
        Team.TeamName;
end;
go



----------------------------------------------------------------------
--                Function 1., 2. & 3. Platz
----------------------------------------------------------------------

drop function if exists GetSecondAndThirdPlaceDrivers
go
create function GetSecondAndThirdPlaceDrivers()
returns table
as
return (
    select Driver.FirstName + ' ' + Driver.LastName as DriverName, Race.RaceID, 'Second Place' as RacePosition
    from SecondPlace
    join Race on SecondPlace.fk_RaceID = Race.RaceID
    join Driver on SecondPlace.fk_DriverID = Driver.DriverID

    union all

    select Driver.FirstName + ' ' + Driver.LastName as DriverName, Race.RaceID, 'Third Place' as RacePosition
    from ThirdPlace
    join Race on ThirdPlace.fk_RaceID = Race.RaceID
    join Driver on ThirdPlace.fk_DriverID = Driver.DriverID
);
go




----------------------------------------------------------------------
--                    Function AVG Driver
----------------------------------------------------------------------

drop function if exists GetDriverAveragePoints
go
create function GetDriverAveragePoints(@DriverID int)
returns decimal(6, 2)
as begin    
    declare @AveragePoints decimal(6, 2);

    select @AveragePoints = AVG(Points) 
    from (
        select Points
        from FirstPlace
        where fk_DriverID = @DriverID
        union ALL
        select Points
        from SecondPlace
        where fk_DriverID = @DriverID
        union ALL
        select Points
        from ThirdPlace
        where fk_DriverID = @DriverID
    ) as DriverPoints;

    return isnull(@AveragePoints, 0);
end;
go