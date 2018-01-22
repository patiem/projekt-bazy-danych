CREATE PROCEDURE dbo.cancel_workshop_registration
    @WorkshopID INT, @ParticipantID INT
AS
  BEGIN
    IF (
      SELECT w.StartDateTime FROM Workshop AS w WHERE w.WorkshopID = @WorkshopID
    ) > GETDATE()
      BEGIN
        RAISERROR('Cannot cancel registration for current/past workshop', 16, 1)
      END

    DELETE
    FROM RegistrationsForWorkshop AS r
    WHERE r.WorkshopID = @WorkshopID AND r.ParticipantID = @ParticipantID
  END
