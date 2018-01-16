CREATE FUNCTION report_workshops_participants (@WorkshopID INT)
  RETURNS TABLE
AS
  RETURN (
      SELECT Workshops.WorkshopName, Participants.FirstName, Participants.LastName FROM Workshops
        INNER JOIN RegistrationsForWorkshops ON RegistrationsForWorkshops.WorkshopID = Workshops.WorkshopID
        INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
        WHERE Workshops.WorkshopID = @WorkshopID
  )
