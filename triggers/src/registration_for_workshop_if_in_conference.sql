CREATE TRIGGER registration_for_workshop_if_in_conference ON RegistrationsForWorkshops
FOR INSERT
AS
  BEGIN
    IF NOT EXISTS(
      SELECT *
      FROM inserted
      INNER JOIN Workshops
	  ON inserted.WorkshopID = Workshops.WorkshopID
      INNER JOIN Conferences
	  ON Workshops.ConferenceID = Conferences.ConferenceID
      INNER JOIN RegistrationsForConferences
	  ON inserted.ParticipantID = RegistrationsForConferences.ParticipantID AND Conferences.ConferenceID = RegistrationsForConferences.ConferenceID
    )
      BEGIN
        RAISERROR('Participant not registered for this conference day', 16, 1)
        ROLLBACK TRANSACTION
      END
  END
