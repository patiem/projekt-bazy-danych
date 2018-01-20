CREATE FUNCTION get_current_conference_price (@ConferenceID INTEGER, @ApplyStudentDiscount BIT)
  RETURNS MONEY
AS
  BEGIN
    DECLARE @CurrentPrice INTEGER, @StudentDiscount INTEGER;

    SELECT TOP 1 @CurrentPrice = p.Price, @StudentDiscount = p.Discount
    FROM ConferencePriceThresholds AS p
    WHERE p.ConferenceID = @ConferenceID AND p.EndDate > GETDATE()
    ORDER BY p.EndDate

    IF (@ApplyStudentDiscount = 1)
      BEGIN
        SET @CurrentPrice = @CurrentPrice * (1 - @StudentDiscount)
      END

    RETURN @CurrentPrice
  END
