CREATE PROCEDURE dbo.change_number_of_seats_for_workshop
    @WorkshopID INT, @Seats INT
AS
  BEGIN
    DECLARE @CurrentNumberOfSeats INT, @SeatsLeft INT

    SET @SeatsLeft = dbo.get_seats_left_for_workshop(@WorkshopID)
    SELECT @CurrentNumberOfSeats = Workshops.NumberOfSeats FROM Workshops WHERE Workshops.WorkshopID = @WorkshopID

    IF (@CurrentNumberOfSeats - @SeatsLeft) > @Seats
      BEGIN
        RAISERROR('There are already more participants registered.', 16, 1)
      END
    UPDATE Workshops SET NumberOfSeats = @Seats WHERE WorkshopID = @WorkshopID
  END
