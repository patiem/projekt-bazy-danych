CREATE PROCEDURE dbo.create_participant_for_client
    @ClientID VARCHAR(255), @FirstName VARCHAR(255) = NULL, @LastName VARCHAR(255) = NULL, @Email VARCHAR(255) = NULL,
    @StudentID  VARCHAR(255) = NULL
AS
  BEGIN
    INSERT INTO Participants (ClientID, FirstName, LastName, Email, StudentID)
    VALUES (@ClientID, @FirstName, @LastName, @Email, @StudentID)
  END
