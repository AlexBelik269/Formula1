----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Stored Procedure - Driver Story
----------------------------------------------------------------------
USE Formula1
GO

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
		PRINT 'Driver NOT found, try writing the first name and last name in this format: ''FirstName'' , ''LastName'' or try writing it without spaces.';
	 END
	 
    PRINT N'This is the Story of ' + @DriverName + N':' + char(10) + char(13) + @Story;
END
GO


--- EXEC DriverStory 'Max', 'Verstappen';
--- EXEC DriverStory 'Lando', 'Norris';
--- EXEC DriverStory 'Fernando', 'Alonso';
--- EXEC DriverStory 'Carlos', 'Sainz';
--- EXEC DriverStory 'Sergio', 'Perez';
--- EXEC DriverStory 'Daniel', 'Ricciardo';
--- EXEC DriverStory 'Mick', 'Schumacher';
--- EXEC DriverStory 'Ayrton', 'Senna';
--- EXEC DriverStory 'Alain', 'Prost';
--- EXEC DriverStory 'Micky', 'Sch';
--- EXEC DriverStory 'Nyck', 'De Vries';
--- EXEC DriverStory '', '';
--- EXEC DriverStory '' ;
--- EXEC DriverStory NULL, NULL;
--- EXEC DriverStory 2, 6;
--- SELECT * from Driver



