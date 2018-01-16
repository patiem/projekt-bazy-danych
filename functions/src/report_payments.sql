CREATE FUNCTION report_payments (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN(
  SELECT
    FirstName, LastName, 'Conference' as Type, PaidAt
  FROM RegistrationsForConferences
    INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForConferences.ParticipantID
  WHERE ConferenceID = @ConferenceID

UNION

  SELECT 
    FirstName,LastName, Workshops.WorkshopID, PaidAt
  FROM RegistrationsForWorkshops
    INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
    INNER JOIN Workshops ON Workshops.WorkshopID = RegistrationsForWorkshops.WorkshopID
    INNER JOIN Conferences ON Workshops.ConferenceID = Conferences.ConferenceID
  WHERE Workshops.ConferenceID = @ConferenceID
  )
