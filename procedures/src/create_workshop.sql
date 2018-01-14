CREATE PROCEDURE dbo.create_workshop
  @ConferenceID INTEGER, @NumberOFSeats INTEGER , @StartDate DATE , @EndDate DATE, @LecturerID INTEGER
AS
  BEGIN
    INSERT INTO Workshops VALUES (@ConferenceID, @NumberOFSeats, @StartDate, @EndDate, @LecturerID)
  END 
