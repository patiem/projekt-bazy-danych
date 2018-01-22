CREATE PROCEDURE dbo.create_price_threshold_for_conference
    @ConferenceID INT, @EndDate DATE, @Price INT, @StudentDiscount FLOAT
AS
  BEGIN
    INSERT INTO ConferencePriceThresholds (ConferenceID, EndDate, Price, Discount)
    VALUES (@ConferenceID, @EndDate, @Price, @StudentDiscount)
  END
GO
