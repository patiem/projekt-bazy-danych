CREATE VIEW dbo.ConferenceRegistrationsToCancelView
  AS
    SELECT r.RegistrationForConferenceID
    FROM RegistrationsForConferences AS r
      INNER JOIN Conferences AS c ON c.ConferenceID = r.ConferenceID
    WHERE r.PaidAt IS NULL AND GETDATE() < DATEADD(WEEK, -1, c.StartDate)
GO
