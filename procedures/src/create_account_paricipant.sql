CREATE PROCEDURE dbo.create_account_participant
    @ClientName VARCHAR(255), @FirstName VARCHAR(255), @LastName VARCHAR(255), @Email VARCHAR(255), @Company VARCHAR(255),
    @StudentID  VARCHAR(255)
AS
  BEGIN
    INSERT INTO Clients (ClientName, Email, IsCompany) VALUES (@ClientName, @Email, 0)
    INSERT INTO Participants (ClientID, FirstName, LastName, Email, Company, StudentID)
    VALUES ((SELECT SCOPE_IDENTITY()), @FirstName, @LastName,
            @Email, @Company, @StudentID)
  END

