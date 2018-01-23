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
