CREATE PROCEDURE dbo.cancel_workshop_registration
    @WorkshopID INT, @ParticipantID INT
AS
  BEGIN
    IF (
      SELECT w.StartDateTime FROM Workshops AS w WHERE w.WorkshopID = @WorkshopID
    ) > GETDATE()
      BEGIN
        RAISERROR('Cannot cancel registration for current/past workshop', 16, 1)
      END

    DELETE FROM dbo.RegistrationsForWorkshops
    WHERE dbo.RegistrationsForWorkshops.WorkshopID = @WorkshopID AND
          dbo.RegistrationsForWorkshops.ParticipantID = @ParticipantID
  END
