CREATE PROCEDURE dbo.change_workshop_price
    @WorkshopID INT, @NewPrice MONEY
AS
  BEGIN
    UPDATE Workshop SET Price = @NewPrice WHERE WorkshopID = @WorkshopID
  END
