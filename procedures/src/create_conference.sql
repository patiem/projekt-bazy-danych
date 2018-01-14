CREATE PROCEDURE dbo.create_conference
  @ConferenceName VARCHAR(255), @NumberOFSeats INTEGER , @StartDate DATE , @EndDate DATE
AS
  BEGIN
    INSERT INTO Conferences VALUES (@ConferenceName, @NumberOFSeats, @StartDate, @EndDate)
  END 
