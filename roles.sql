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
  dbo.cancel_conference_registration
  TO Employee
GRANT EXECUTE ON
  dbo.cancel_workshop_registration
  TO Employee
