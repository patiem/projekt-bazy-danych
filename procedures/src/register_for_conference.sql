CREATE PROCEDURE dbo.register_for_conference
	@ConferenceID INTEGER, @ParticipantID INTEGER, @StartDate DATE, @EndDate Date
AS
  BEGIN
      INSERT INTO RegistrationsForConferences (ConferenceID, ParticipantID)
        VALUES (@ConferenceID, @ParticipantID)
      INSERT INTO RegistrationDateRanges (RegistrationForConferenceID, StartDate, EndDate)
        VALUES (SELECT SCOPE_IDENTITY(), @StartDate, @EndDate)
  END
