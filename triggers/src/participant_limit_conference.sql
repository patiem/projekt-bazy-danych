CREATE TRIGGER participant_limit_conference
  ON RegistrationsForConferences
  FOR INSERT
AS
  BEGIN
    IF (
         SELECT count(*)
         FROM inserted
           INNER JOIN RegistrationsForConferences ON RegistrationsForConferences.ConferenceID = inserted.ConferenceID
       ) = (
         SELECT sum(NumberOfSeats)
         FROM Conferences
           INNER JOIN inserted ON Conferences.ConferenceID = inserted.ConferenceID
       )
      BEGIN
        RAISERROR ('Conference sold out', 16, 1)
        ROLLBACK TRANSACTION
      END

  END
