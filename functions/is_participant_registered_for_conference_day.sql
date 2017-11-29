CREATE FUNCTION is_participant_registered_for_conference_day
  (@ParticipantID INT, @ConferenceID INT, @Date DATE)
  RETURNS BIT
AS
  BEGIN
    SET @RegistrationID = (
      SELECT RegistrationForConferenceID
      FROM RegistrationsForConferences
      WHERE ParticipantID = @ParticipantID AND ConferenceID = @ConferenceID
    )

    IF EXISTS(
      SELECT 1 FROM RegistrationDateRanges
      WHERE RegistrationForConferenceID = @RegistrationID AND @Date BETWEEN StartDate AND EndDate
    )
      BEGIN
        RETURN TRUE
      END

    RETURN FALSE
  END
