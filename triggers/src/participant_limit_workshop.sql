CREATE TRIGGER participant_limit_workshop
  ON RegistrationsForWorkshops
  FOR INSERT
AS
  BEGIN
    IF (
         SELECT count(*)
         FROM inserted
           INNER JOIN RegistrationsForWorkshops ON RegistrationsForWorkshops.WorkshopID = inserted.WorkshopID
       ) = (
         SELECT sum(NumberOfSeats)
         FROM Workshops
           INNER JOIN inserted ON Workshops.WorkshopID = inserted.WorkshopID
       )
      BEGIN
        RAISERROR ('Workshop sold out', 16, 1)
        ROLLBACK TRANSACTION
      END

  END
