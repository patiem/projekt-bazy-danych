CREATE PROCEDURE dbo.cancel_workshop_registration
    @ConferenceID INT, @ParticipantID INT
AS
  BEGIN
    IF (
         SELECT c.StartDate FROM Conference AS c WHERE c.ConferenceID = @ConferenceID
       ) > GETDATE()
      BEGIN
        RAISERROR('Cannot cancel registration for current/past conference', 16, 1)
      END

    DELETE
    FROM RegistrationsForConference AS r
    WHERE r.ConferenceID = @ConferenceID AND r.ParticipantID = @ParticipantID
  END
