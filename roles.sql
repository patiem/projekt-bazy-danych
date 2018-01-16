CREATE ROLE Owner
CREATE ROLE Employee

GRANT ALL
TO Owner

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
