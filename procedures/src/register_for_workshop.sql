CREATE PROCEDURE dbo.register_for_workshop
	@WorkshopID INTEGER, @ParticipantID INTEGER
AS
  BEGIN
  	INSERT INTO RegistrationsForWorkshops(WorkshopID, ParticipantID) VALUES (@WorkshopID, @ParticipantID)
  END
