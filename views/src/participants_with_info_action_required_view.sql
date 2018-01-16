CREATE VIEW dbo.ParticipantsWithInfoActionRequiredView
  AS
    SELECT p.ParticipantID, p.ClientID
    FROM Participants AS p
    WHERE (p.FirstName IS NULL OR p.LastName IS NULL OR p.Email IS NULL) AND EXISTS(
      SELECT *
      FROM RegistrationsForConferences AS r
        INNER JOIN Conferences AS c ON r.ConferenceID = c.ConferenceID
      WHERE r.ParticipantID = p.ParticipantID
            AND c.StartDate BETWEEN DATEADD(WEEK, -2, GETDATE()) AND DATEADD(WEEK, -1, GETDATE())
    )
    ORDER BY p.ClientID
GO
