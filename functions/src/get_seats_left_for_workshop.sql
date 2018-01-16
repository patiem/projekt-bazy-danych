CREATE FUNCTION get_seats_left_for_workshop (@WorkshopID INT)
  RETURNS INT
AS
  BEGIN
    SET @NumberOfRegistrations = (
      SELECT Count(*) FROM RegistrationsForWorkshops WHERE RegistrationsForWorkshops.WorkshopID = @WorkshopID
    )
    SET @NumberOfSeatsForWorkshop = (
      SELECT Workshops.NumberOfSeats FROM Workshops WHERE Workshops.WorkshopID = @WorkshopID
    )
    SET @SeatsLeft = @NumberOfSeatsForWorkshop - @NumberOfRegistrations

    RETURN @SeatsLeft
  END
