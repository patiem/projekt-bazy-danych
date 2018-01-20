CREATE FUNCTION get_seats_left_for_workshop (@WorkshopID INT)
  RETURNS INT
AS
  BEGIN
    DECLARE @NumberOfRegistrations INT = (
      SELECT Count(*) FROM RegistrationsForWorkshops WHERE RegistrationsForWorkshops.WorkshopID = @WorkshopID
    )
    DECLARE @NumberOfSeatsForWorkshop INT = (
      SELECT Workshops.NumberOfSeats FROM Workshops WHERE Workshops.WorkshopID = @WorkshopID
    )
    DECLARE @SeatsLeft INT = @NumberOfSeatsForWorkshop - @NumberOfRegistrations

    RETURN @SeatsLeft
  END
