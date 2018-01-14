CREATE PROCEDURE dbo.pay_for_conference_day
    @ConferenceID INTEGER, @ParticipantID INTEGER, @PaidAt DATE
AS
  BEGIN
    UPDATE RegistrationsForConferences SET PaidAt = @PaidAt WHERE ParticipantID = @ParticipantID AND ConferenceID = @ConferenceID
  END

