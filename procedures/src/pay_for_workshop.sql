CREATE PROCEDURE OurDataBase.payForWorkshop
    @WorkshopID INTEGER, @ParticipantID INTEGER, @PaidAt DATE
AS
  BEGIN
    UPDATE RegistrationsForWorkshops SET PaidAt = @PaidAt WHERE ParticipantID = @ParticipantID AND WorkshopID = @WorkshopID
  END

