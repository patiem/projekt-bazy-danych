CREATE PROCEDURE dbo.create_price_threshold_for_conference
    @ConferenceID INT, @StartDate DATE, @Price INT, @StudentDiscount FLOAT
AS
  BEGIN
    INSERT INTO ConferencePriceThresholds (ConferenceID, StartDate, Price, Discount)
    VALUES (@ConferenceID, @StartDate, @Price, @StudentDiscount)
  END
GO
