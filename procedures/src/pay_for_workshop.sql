CREATE PROCEDURE OurDataBase.payForWorkshop
    @WorkshopID INTEGER, @PaidAt DATE = GETDATE()
AS
  BEGIN
    UPDATE RegistrationsForWorkshops SET PaidAt = @PaidAt WHERE WorkshopID = @WorkshopID
  END

