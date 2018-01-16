CREATE FUNCTION report_most_popular_workshop (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN (
      SELECT TOP 1 Workshops.WorkshopName, count(*) AS Attendees FROM Workshops
        INNER JOIN RegistrationsForWorkshops ON RegistrationsForWorkshops.WorkshopID = Workshops.WorkshopID
        INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
        WHERE Workshops.ConferenceID = @ConferenceID
	GROUP BY Workshops.WorkshopName ORDER BY Attendees
  )
