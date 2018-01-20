CREATE PROCEDURE dbo.create_workshop_for_conference
  @WorkshopName VARCHAR(255), @ConferenceID INTEGER, @NumberOFSeats INTEGER, @StartDateTime DATE, @EndDateTime DATE, @Price FLOAT, @LecturerID INT
AS
  BEGIN
    INSERT INTO Workshops VALUES (@WorkshopName, @ConferenceID, @NumberOfSeats, @StartDateTime, @EndDateTime, @Price, @LecturerID)
  END 
