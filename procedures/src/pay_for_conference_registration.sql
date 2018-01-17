CREATE PROCEDURE dbo.pay_for_conference_registration
    @RegistrationForConferenceID INTEGER, @PaidAt DATE = GETDATE()
AS
  BEGIN
    UPDATE RegistrationsForConferences SET PaidAt = @PaidAt WHERE RegistrationForConferenceID = @RegistrationForConferenceID
  END

