CREATE PROCEDURE dbo.pay_for_workshop
    @WorkshopID INT, @PaidAt DATE
AS
  BEGIN
    UPDATE RegistrationsForWorkshops SET PaidAt = @PaidAt WHERE WorkshopID = @WorkshopID
  END
GO
