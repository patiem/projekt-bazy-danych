CREATE PROCEDURE dbo.create_client
    @ClientName VARCHAR(255), @Email VARCHAR(255), @IsCompany BIT = 0
AS
  BEGIN
    INSERT INTO Clients (ClientName, Email, IsCompany) VALUES (@ClientName, @Email, @IsCompany)
  END
