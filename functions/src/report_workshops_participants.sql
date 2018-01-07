CREATE FUNCTION report_workshops_participants
AS
  BEGIN
  SELECT Workshops.WorkshopID, Participants.FirstName, Participants.LastName FROM Workshops INNER JOIN RegistrationsForWorkshops ON RegistrationsForWorkshops.WorkshopID = Workshops.WorkshopID INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID ORDER BY Workshops.WorkshopID
  END
