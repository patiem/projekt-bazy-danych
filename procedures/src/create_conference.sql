CREATE PROCEDURE dbo.create_conference
  @ConferenceName VARCHAR(255), @NumberOfSeats INTEGER , @StartDate DATE , @EndDate DATE
AS
  BEGIN
    INSERT INTO Conferences VALUES (@ConferenceName, @NumberOfSeats, @StartDate, @EndDate)
  END 
