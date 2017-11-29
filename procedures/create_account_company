CREATE PROCEDURE OurDataBase.create_account_company
 @ClientName VARCHAR(40), @CompanyName VARCHAR(40), @Email VARCHAR(40)
 AS
BEGIN
 INSERT INTO Clients (ClientName, IsCompany) VALUES (@ClientName, TRUE)
 INSERT INTO Companies (ClientName, CompanyName, Email) VALUES (@ClientName, @CompanyName, @Email)
END

