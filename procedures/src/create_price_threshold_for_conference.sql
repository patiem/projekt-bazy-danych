CREATE PROCEDURE dbo.create_price_threshold_for_conference
    @ConferenceID INT, @EndDate DATE, @Price MONEY, @StudentDiscount FLOAT,
AS
  BEGIN
    INSERT INTO ConferencePriceThresholds (ConferenceID, EndDate, Price, StudentDiscount)
    VALUES (@ConferenceID, @EndDate, @Price, @StudentDiscount)
  END
