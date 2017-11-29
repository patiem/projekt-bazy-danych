CREATE FUNCTION current_conference_price (@ConferenceID INT, @ApplyStudentDiscount BIT = FALSE )
  RETURNS MONEY
AS
  BEGIN
    SELECT TOP 1 @CurrentPrice = ConferencePriceThresholds.Price, @StudentDiscount = ConferencePriceThresholds.StudentDiscount
    FROM ConferencePriceThresholds
    WHERE ConferencePriceThresholds.ConferenceID = @ConferenceID AND ConferencePriceThresholds.StartDate < GETDATE()
    ORDER BY ConferencePriceThresholds.StartDate

    IF (@ApplyStudentDiscount)
      BEGIN
        SET @CurrentPrice = @CurrentPrice * (1 - @StudentDiscount)
      END

    RETURN @CurrentPrice
  END
