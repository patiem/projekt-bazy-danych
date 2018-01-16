CREATE FUNCTION report_best_clients (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN (
        SELECT TOP 1000 FirstName, LastName, 'Conference days' as Type, count(*) as Times FROM RegistrationsForConferences
      INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForConferences.ParticipantID
      WHERE ConferenceID = @ConferenceID
      GROUP BY FirstName, LastName

UNION

SELECT TOP 1000 FirstName, LastName, 'Workshops' as Type, count(*) as Times FROM RegistrationsForWorkshops
      INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
      INNER JOIN Workshops ON RegistrationsForWorkshops.WorkshopID = Workshops.WorkshopID
      WHERE ConferenceID = @ConferenceID
      GROUP BY FirstName, LastName ORDER BY Times DESC
  )
