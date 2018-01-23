EXEC dbo.create_client 'SomeClient', 'dsadsa@example.com', 1
SELECT * FROM Clients

EXEC dbo.create_conference 'Some conference name', 100, '2018-02-02', '2018-02-05'
EXEC dbo.create_price_threshold_for_conference 1, '2018-01-20', 120
EXEC dbo.create_price_threshold_for_conference 1, '2018-01-28', 140
EXEC dbo.create_price_threshold_for_conference 1, '2018-02-02', 160

SELECT dbo.get_current_conference_price(1, DEFAULT)

EXEC dbo.create_participant_for_client 1, 'Mark', 'Brown', 'brown@example.com'

EXEC dbo.create_lecturer 'John', 'Doe'
EXEC dbo.create_workshop_for_conference 'Some workshop name', 1, 20, '2018-02-02 14:00', '2018-02-02 16:00', 40, 1


EXEC dbo.register_for_workshop 1, 1 -- should throw error

SELECT dbo.is_participant_registered_for_conference_day(1, 1, '2018-02-02')
EXEC dbo.register_for_conference 1, 1, '2018-02-02', '2018-02-04'
SELECT dbo.is_participant_registered_for_conference_day(1, 1, '2018-02-05')

SELECT dbo.is_participant_registered_for_some_workshop_at(1, '2018-02-02 13:00', '2018-02-02 17:00')
EXEC dbo.register_for_workshop 1, 1
SELECT dbo.is_participant_registered_for_some_workshop_at(1, '2018-02-02 13:00', '2018-02-02 17:00')
SELECT dbo.get_seats_left_for_workshop(1)

SELECT * FROM dbo.v_conference_registrations_to_cancel
EXEC dbo.pay_for_conference_registration 1
EXEC dbo.pay_for_workshop 1
SELECT * FROM dbo.v_conference_registrations_to_cancel

EXEC dbo.change_number_of_seats_for_conference 1, 0 -- should throw error
EXEC dbo.change_number_of_seats_for_conference 1, 2
EXEC dbo.change_number_of_seats_for_workshop 1, 0 -- should throw error
EXEC dbo.change_number_of_seats_for_conference 1, 2

SELECT * FROM dbo.report_payments (1)
SELECT * FROM dbo.show_workshops (1)
SELECT * FROM dbo.report_workshops_participants (1)
