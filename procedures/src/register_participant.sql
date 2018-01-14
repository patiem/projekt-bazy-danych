CREATE PROCEDURE dbo.register_participant
    @ClientID VARCHAR(255), @FirstName VARCHAR(255), @LastName VARCHAR(255), @Email VARCHAR(255), 
    @StudentID  VARCHAR(255)
AS
  BEGIN
    INSERT INTO Participants (ClientID, FirstName, LastName, Email, StudentID)
    VALUES (@ClientID, @FirstName, @LastName, @Email, @StudentID)
  END
