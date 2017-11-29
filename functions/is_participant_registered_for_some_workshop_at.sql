CREATE FUNCTION is_participant_registered_for_some_workshop_at
  (@ParticipantID INT, @StartDateTime DATETIME, @EndDateTime DATETIME)
  RETURNS BIT
AS
  BEGIN
    IF EXISTS(
        SELECT 1 FROM RegistrationsForWorkshops
        WHERE ParticipantID = @ParticipantID AND (
          StartDateTime < @StartDateTime AND EndDateTime > @StartDateTime OR
          StartDateTime < @EndDateTime AND EndDateTime > @EndDateTime
        )
    )
      BEGIN
        RETURN TRUE
      END

    RETURN FALSE
  END
