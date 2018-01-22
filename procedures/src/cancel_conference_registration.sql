CREATE PROCEDURE dbo.cancel_conference_registration
    @ConferenceID INT, @ParticipantID INT
AS
  BEGIN
    IF (
         SELECT c.StartDate FROM Conferences AS c WHERE c.ConferenceID = @ConferenceID
       ) > GETDATE()
      BEGIN
        RAISERROR('Cannot cancel registration for current/past conference', 16, 1)
      END

    DELETE
    FROM dbo.RegistrationsForConferences
    WHERE dbo.RegistrationsForConferences.ConferenceID = @ConferenceID AND
          dbo.RegistrationsForConferences.ParticipantID = @ParticipantID
  END
