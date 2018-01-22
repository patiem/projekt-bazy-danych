CREATE PROCEDURE dbo.change_number_of_seats_for_conference
    @ConferenceID INT, @Seats INT
AS
  BEGIN
    DECLARE @CurrentNumberOfSeats INT, @MinSeatsLeft INT
    SET @MinSeatsLeft = 9999

    DECLARE @StartDate DATE
    DECLARE @EndDate DATE

    SELECT @StartDate = c.StartDate, @EndDate = c.@EndDate
    FROM Conference AS c
    WHERE c.ConferenceID = @ConferenceID

    WHILE (@StartDate < @EndDate)
      BEGIN
        IF dbo.get_seats_left_for_conference_at_date(@ConferenceID, @StartDate) < @MinSeatsLeft
          BEGIN
            SET @MinSeatsLeft = dbo.get_seats_left_for_conference_at_date(@ConferenceID, @StartDate)
          END

        SET @StartDate = DATEADD(DAY, 1, @StartDate);
      END

    SELECT @CurrentNumberOfSeats = c.NumberOfSeats FROM Conference AS c WHERE c.ConferenceID = @ConferenceID

    IF @CurrentNumberOfSeats - @MinSeatsLeft > @Seats -- there are more registered than @Seats
      BEGIN
        RAISERROR('There are already more participants registered.', 16, 1)
      END
    UPDATE Conference SET NumberOfSeats = @Seats WHERE ConferenceID = @ConferenceID
  END
