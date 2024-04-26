----------------------------------------------------------------------
--                         Formula 1 
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Stored Procedure - Race Info
----------------------------------------------------------------------
USE Formula1
GO

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


-- Example usage
EXEC RaceInfo 0;
