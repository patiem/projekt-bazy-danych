CREATE FUNCTION report_conference_participants (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN(
  SELECT
    FirstName,
    LastName,
    StartDate,
    EndDate
  FROM RegistrationsForConferences
    INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForConferences.ParticipantID
    INNER JOIN RegistrationDateRanges
      ON RegistrationDateRanges.RegistrationForConferenceID = RegistrationsForConferences.RegistrationForConferenceID
  WHERE ConferenceID = @ConferenceID
  )
