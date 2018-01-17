CREATE PROCEDURE dbo.batch_register_for_conference_for_client
    @ClientID INTEGER, @ConferenceID INTEGER, @StartDate DATE, @EndDate Date, @NumberOfRegistrations INTEGER
AS
  BEGIN
    WHILE @NumberOfRegistrations > 0
      BEGIN
        EXEC create_participant_for_client @ClientID
        DECLARE @ParticipantID INT = SCOPE_IDENTITY()
        EXEC register_for_conference @ConferenceID, @ParticipantID, @StartDate, @EndDate
        SET @NumberOfRegistrations = @NumberOfRegistrations - 1
      END
  END
