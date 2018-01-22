CREATE PROCEDURE dbo.change_number_of_seats_for_workshop
    @WorkshopID INT, @Seats INT
AS
  BEGIN
    DECLARE @CurrentNumberOfSeats INT, @SeatsLeft INT

    SET @SeatsLeft = dbo.get_seats_left_for_workshop(@WorkshopID)
    SELECT @CurrentNumberOfSeats = Workshop.NumberOfSeats FROM Workshop WHERE Workshop.WorkshopID = @WorkshopID

    IF (@CurrentNumberOfSeats - @SeatsLeft) > @Seats
      BEGIN
        RAISERROR('There are already more participants registered.', 16, 1)
      END
    UPDATE Workshop SET NumberOfSeats = @Seats WHERE WorkshopID = @WorkshopID
  END
