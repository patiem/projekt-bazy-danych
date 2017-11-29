CREATE PROCEDURE OurDataBase.create_account_participant
    @ClientName VARCHAR(40), @FirstName VARCHAR(40), @LastName VARCHAR(40), @Email VARCHAR(40), @Company VARCHAR(40),
    @StudentID  VARCHAR(40)
AS
  BEGIN
    INSERT INTO Clients (ClientName, IsCompany) VALUES (@ClientName, FALSE)
    INSERT INTO Participants (ClientName, FirstName, LastName, Email, Company, StudentID)
    VALUES (@ClientName, @FirstName, @LastName,
            @Email, @Company, @StudentID)
  END

