CREATE PROCEDURE dbo.book_conference_day
	@ConferenceID INTEGER, @ParticipantID INTEGER, @PaidAt DATE
AS
  BEGIN
	INSERT INTO RegistrationsForConferences (ConferenceID, ParticipantID, PaidAt) VALUES (@ConferenceID, @ParticipantID, @PaidAt)
  END

