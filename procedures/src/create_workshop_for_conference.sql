CREATE PROCEDURE dbo.create_workshop_for_conference
  @ConferenceID INTEGER, @NumberOFSeats INTEGER , @StartDateTime DATE , @EndDateTime DATE, @Price FLOAT
AS
  BEGIN
    INSERT INTO Workshops VALUES (@ConferenceID, @NumberOfSeats, @StartDateTime, @EndDateTime, @Price)
  END 
