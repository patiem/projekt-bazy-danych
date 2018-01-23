IF EXISTS (SELECT * FROM sys.indexes  WHERE name='i1') DROP INDEX i1 ON RegistrationDateRanges
CREATE INDEX i1 ON RegistrationDateRanges (RegistrationForConferenceID)
IF EXISTS (SELECT * FROM sys.indexes  WHERE name='i2') DROP INDEX i2 ON RegistrationsForConferences
CREATE INDEX i2 ON RegistrationsForConferences (ParticipantID)
IF EXISTS (SELECT * FROM sys.indexes  WHERE name='i3') DROP INDEX i3 ON RegistrationsForConferences
CREATE INDEX i3 ON RegistrationsForConferences (ConferenceID)
IF EXISTS (SELECT * FROM sys.indexes  WHERE name='i4') DROP INDEX i4 ON RegistrationsForWorkshops
CREATE INDEX i4 ON RegistrationsForWorkshops (ParticipantID)

IF DATABASE_PRINCIPAL_ID('Employee') IS NOT NULL DROP ROLE Employee
CREATE ROLE Employee

GRANT SELECT ON
dbo.v_conference_registrations_to_cancel
TO Employee
GRANT SELECT ON
dbo.v_participants_with_info_action_required
TO Employee
GRANT EXECUTE ON
dbo.cancel_conference_registration
TO Employee
GRANT EXECUTE ON
dbo.cancel_workshop_registration
TO Employee
