--DOESN'T WORK

CREATE TRIGGER unique_registration_for_workshop ON RegistrationsForWorkshops
FOR INSERT, UPDATE
AS
  BEGIN
    IF EXISTS(
      SELECT *
      FROM RegistrationsForWorkshops
      INNER JOIN inserted
          ON inserted.WorkshopID = RegistrationsForWorkshops.WorkshopID AND
             inserted.ParticipantID = RegistrationsForWorkshops.ParticipantID
    )
      BEGIN
        RAISERROR('Some of the participants are already registered for this workshop', 16, 1)
        ROLLBACK TRANSACTION
      END
  END
