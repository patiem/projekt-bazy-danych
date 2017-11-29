CREATE FUNCTION seats_left_for_conference_at_date (@ConferenceID INT, @Date DATE)
  RETURNS INT
AS
  BEGIN
    SET @NumberOfRegistrations = (
      SELECT Count(*)
      FROM RegistrationsForConferences
      JOIN RegistrationDateRanges
          ON RegistrationsForConferences.RegistrationForConferenceID = RegistrationDateRanges.RegistrationForConferenceID
      WHERE
        RegistrationsForConferences.ConferenceID = @ConferenceID AND
        @Date BETWEEN RegistrationDateRanges.StartTime AND RegistrationDateRanges.EndTime
    )

    SET @NumberOfSeatsForConference = (
      SELECT Conferences.NumberOfSeats FROM Conferences WHERE Conferences.ConferenceID = @ConferenceID
    )

    SET @SeatsLeft = @NumberOfSeatsForConference - @NumberOfRegistrations

    RETURN @SeatsLeft
  END
