CREATE PROCEDURE dbo.book_workshop
	@WorkshopID INTEGER, @ParticipantID INTEGER, @PaidAt DATE
AS
  BEGIN
	INSERT INTO RegistrationsForWorkshops(WorkshopID, ParticipantID, PaidAt) VALUES (@WorkshopID, @ParticipantID, @PaidAt)
  END

