CREATE PROCEDURE dbo.pay_for_conference_registration
    @RegistrationForConferenceID INT, @PaidAt DATE
AS
  BEGIN
    UPDATE RegistrationsForConferences SET PaidAt = @PaidAt WHERE RegistrationForConferenceID = @RegistrationForConferenceID
  END
GO
