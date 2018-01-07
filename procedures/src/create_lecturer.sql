CREATE PROCEDURE dbo.create_lecturer
	@FirstName VARCHAR(255), @LastName VARCHAR(255)
AS
  BEGIN
	INSERT INTO Lecturers (FirstName, LastName) VALUES (@FirstName, @LastName)
  END

