CREATE FUNCTION current_conference_price (@ConferenceID INTEGER, @ApplyStudentDiscount BIT)
  RETURNS MONEY
AS
  BEGIN
    DECLARE @CurrentPrice INTEGER, @StudentDiscount INTEGER;

    SELECT TOP 1 @CurrentPrice = ConferencePriceThresholds.Price, @StudentDiscount = ConferencePriceThresholds.Discount
    FROM ConferencePriceThresholds
    WHERE ConferencePriceThresholds.ConferenceID = @ConferenceID AND ConferencePriceThresholds.StartDate < GETDATE()
    ORDER BY ConferencePriceThresholds.StartDate

    IF (@ApplyStudentDiscount = 1)
      BEGIN
        SET @CurrentPrice = @CurrentPrice * (1 - @StudentDiscount)
      END

    RETURN @CurrentPrice
  END
