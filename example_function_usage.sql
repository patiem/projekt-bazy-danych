DECLARE @val1 INT;
SET @val1 = dbo.get_current_conference_price(3,1);
SELECT @val1

DECLARE @val1 INT;
SET @val1 = dbo.get_seats_left_for_workshop(5)
SELECT @val1

DECLARE @val1 INT;
SET @val1 = dbo.get_seats_left_for_conference_at_date(1, '2017-11-17')
SELECT @val1

SELECT * FROM report_best_clients(1)

SELECT * FROM report_conference_participants(1)

SELECT * FROM report_most_popular_workshop(2)

SELECT * FROM report_payments(1)

SELECT * FROM report_workshops_participants(1)

SELECT * FROM Conferences



