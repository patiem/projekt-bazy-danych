CREATE FUNCTION show_workshops (@WorkshopID INT)
  RETURNS TABLE
AS
  RETURN (
      SELECT WorkshopID, NumberOfSeats, StartDateTime, EndDateTime, FirstName, LastName FROM Workshops
      INNER JOIN Lecturers ON Workshops.LecturerID = Lecturers.LecturerID
    WHERE ConferenceID = @WorkshopID
  )
