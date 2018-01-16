CREATE PROCEDURE dbo.create_price_threshold_for_conference
    @ConferenceID INT, @StartDate DATE, @Price MONEY, @StudentDiscount FLOAT,
AS
  BEGIN
    INSERT INTO ConferencePriceThresholds (ConferenceID, StartDate, Price, StudentDiscount)
    VALUES (@ConferenceID, @StartDate, @Price, @StudentDiscount)
  END
