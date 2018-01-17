CREATE ROLE Employee

DENY DELETE, INSERT, UPDATE
  ON Clients
  TO Employee
DENY DELETE, INSERT, UPDATE
  ON Participants
  TO Employee
DENY DELETE, INSERT, UPDATE
  ON Conferences
  TO Employee
DENY DELETE, INSERT, UPDATE
  ON Workshops
  TO Employee
DENY DELETE, INSERT, UPDATE
  ON RegistrationDateRanges
  TO Employee
DENY DELETE, INSERT, UPDATE
  ON RegistrationsForConferences
  TO Employee
DENY DELETE, INSERT, UPDATE
  ON RegistrationsForWorkshops
  TO Employee
DENY DELETE, INSERT, UPDATE
  ON ConferencePriceThresholds
  TO Employee

GRANT SELECT ON
  dbo.ConferenceRegistrationsToCancelView
  TO Employee
GRANT SELECT ON
  dbo.ParticipantsWithInfoActionRequiredView
  TO Employee
GRANT EXECUTE ON
  dbo.CancelConferenceRegistration --TODO implement
  TO Employee
GRANT EXECUTE ON
  dbo.CancelWorkshopRegistration --TODO implement
  TO Employee
