CREATE FUNCTION get_seats_left_for_conference_at_date (@ConferenceID INT, @Date DATE)
  RETURNS INT
AS
  BEGIN
    DECLARE @NumberOfRegistrations INT = (
      SELECT Count(*)
      FROM RegistrationsForConferences
      JOIN RegistrationDateRanges
          ON RegistrationsForConferences.RegistrationForConferenceID = RegistrationDateRanges.RegistrationForConferenceID
      WHERE
        RegistrationsForConferences.ConferenceID = @ConferenceID AND
        @Date BETWEEN RegistrationDateRanges.StartDate AND RegistrationDateRanges.EndDate
    )

    DECLARE @NumberOfSeatsForConference INT = (
      SELECT Conferences.NumberOfSeats FROM Conferences WHERE Conferences.ConferenceID = @ConferenceID
    )

    DECLARE @SeatsLeft INT = @NumberOfSeatsForConference - @NumberOfRegistrations

    RETURN @SeatsLeft
  END
GO
