CREATE PROCEDURE dbo.create_account_company
    @ClientName VARCHAR(255), @Email VARCHAR(255)
AS
  BEGIN
    INSERT INTO Clients (ClientName, Email, IsCompany) VALUES (@ClientName, @Email, 1)
  END

