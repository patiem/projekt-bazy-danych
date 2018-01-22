CREATE PROCEDURE dbo.batch_register_for_conference_for_client
    @ClientID INTEGER, @ConferenceID INTEGER, @StartDate DATE, @EndDate Date, @NumberOfRegistrations INTEGER
AS
  BEGIN
    WHILE @NumberOfRegistrations > 0
      BEGIN
        EXEC create_participant_for_client @ClientID
        DECLARE @ParticipantID INT = SCOPE_IDENTITY()
        EXEC register_for_conference @ConferenceID, @ParticipantID, @StartDate, @EndDate
        SET @NumberOfRegistrations = @NumberOfRegistrations - 1
      END
  END
GO

CREATE PROCEDURE dbo.create_client
    @ClientName VARCHAR(255), @Email VARCHAR(255), @IsCompany BIT = 0
AS
  BEGIN
    INSERT INTO Clients (ClientName, Email, IsCompany) VALUES (@ClientName, @Email, @IsCompany)
  END
GO

CREATE PROCEDURE dbo.create_conference
  @ConferenceName VARCHAR(255), @NumberOfSeats INTEGER , @StartDate DATE , @EndDate DATE
AS
  BEGIN
    INSERT INTO Conferences VALUES (@ConferenceName, @NumberOfSeats, @StartDate, @EndDate)
  END
GO

CREATE PROCEDURE dbo.create_participant_for_client
    @ClientID VARCHAR(255), @FirstName VARCHAR(255) = NULL, @LastName VARCHAR(255) = NULL, @Email VARCHAR(255) = NULL,
    @StudentID  VARCHAR(255) = NULL
AS
  BEGIN
    INSERT INTO Participants (ClientID, FirstName, LastName, Email, StudentID)
    VALUES (@ClientID, @FirstName, @LastName, @Email, @StudentID)
  END
GO

CREATE PROCEDURE dbo.create_price_threshold_for_conference
    @ConferenceID INT, @EndDate DATE, @Price INT, @StudentDiscount FLOAT
AS
  BEGIN
    INSERT INTO ConferencePriceThresholds (ConferenceID, EndDate, Price, Discount)
    VALUES (@ConferenceID, @EndDate, @Price, @StudentDiscount)
  END
GO

CREATE PROCEDURE dbo.create_workshop_for_conference
  @WorkshopName VARCHAR(255), @ConferenceID INTEGER, @NumberOfSeats INTEGER, @StartDateTime DATE, @EndDateTime DATE, @Price FLOAT, @LecturerID INT
AS
  BEGIN
    INSERT INTO Workshops VALUES (@WorkshopName, @ConferenceID, @NumberOfSeats, @StartDateTime, @EndDateTime, @Price, @LecturerID)
  END
GO

CREATE PROCEDURE dbo.pay_for_conference_registration
    @RegistrationForConferenceID INT, @PaidAt DATE
AS
  BEGIN
    UPDATE RegistrationsForConferences SET PaidAt = @PaidAt WHERE RegistrationForConferenceID = @RegistrationForConferenceID
  END
GO

CREATE PROCEDURE dbo.pay_for_workshop
    @WorkshopID INT, @PaidAt DATE
AS
  BEGIN
    UPDATE RegistrationsForWorkshops SET PaidAt = @PaidAt WHERE WorkshopID = @WorkshopID
  END
GO

CREATE PROCEDURE dbo.register_for_conference
	@ConferenceID INTEGER, @ParticipantID INTEGER, @StartDate DATE, @EndDate Date
AS
  BEGIN
    BEGIN TRANSACTION
      INSERT INTO RegistrationsForConferences (ConferenceID, ParticipantID)
        VALUES (@ConferenceID, @ParticipantID)
      INSERT INTO RegistrationDateRanges (RegistrationForConferenceID, StartDate, EndDate)
        VALUES ((SELECT SCOPE_IDENTITY()), @StartDate, @EndDate)
    COMMIT TRANSACTION
  END
GO

CREATE PROCEDURE dbo.register_for_workshop
	@WorkshopID INTEGER, @ParticipantID INTEGER
AS
  BEGIN
  	INSERT INTO RegistrationsForWorkshops(WorkshopID, ParticipantID) VALUES (@WorkshopID, @ParticipantID)
  END
GO

CREATE FUNCTION get_current_conference_price (@ConferenceID INTEGER, @ApplyStudentDiscount BIT)
  RETURNS MONEY
AS
  BEGIN
    DECLARE @CurrentPrice INTEGER, @StudentDiscount INTEGER;

    SELECT TOP 1 @CurrentPrice = p.Price, @StudentDiscount = p.Discount
    FROM ConferencePriceThresholds AS p
    WHERE p.ConferenceID = @ConferenceID AND p.EndDate > GETDATE()
    ORDER BY p.EndDate

    IF (@ApplyStudentDiscount = 1)
      BEGIN
        SET @CurrentPrice = @CurrentPrice * (1 - @StudentDiscount)
      END

    RETURN @CurrentPrice
  END
GO

CREATE FUNCTION get_seats_left_for_conference_at_date (@ConferenceID INT, @Date DATE)
  RETURNS INT
AS
  BEGIN
    DECLARE @NumberOfRegistrations INT = (
      SELECT Count(*)
      FROM RegistrationsForConferences
      JOIN RegistrationDateRanges
          ON RegistrationsForConferences.RegistrationForConferenceID = RegistrationDateRanges.RegistrationForConferenceID
      WHERE
        RegistrationsForConferences.ConferenceID = @ConferenceID AND
        @Date BETWEEN RegistrationDateRanges.StartDate AND RegistrationDateRanges.EndDate
    )

    DECLARE @NumberOfSeatsForConference INT = (
      SELECT Conferences.NumberOfSeats FROM Conferences WHERE Conferences.ConferenceID = @ConferenceID
    )

    DECLARE @SeatsLeft INT = @NumberOfSeatsForConference - @NumberOfRegistrations

    RETURN @SeatsLeft
  END
GO

CREATE FUNCTION get_seats_left_for_workshop (@WorkshopID INT)
  RETURNS INT
AS
  BEGIN
    DECLARE @NumberOfRegistrations INT = (
      SELECT Count(*) FROM RegistrationsForWorkshops WHERE RegistrationsForWorkshops.WorkshopID = @WorkshopID
    )
    DECLARE @NumberOfSeatsForWorkshop INT = (
      SELECT Workshops.NumberOfSeats FROM Workshops WHERE Workshops.WorkshopID = @WorkshopID
    )
    DECLARE @SeatsLeft INT = @NumberOfSeatsForWorkshop - @NumberOfRegistrations

    RETURN @SeatsLeft
  END
GO

CREATE FUNCTION is_participant_registered_for_conference_day
  (@ParticipantID INT, @ConferenceID INT, @Date DATE)
  RETURNS BIT
AS
  BEGIN
    DECLARE @RegistrationID INT = (
      SELECT RegistrationForConferenceID
      FROM RegistrationsForConferences
      WHERE ParticipantID = @ParticipantID AND ConferenceID = @ConferenceID
    )

    IF EXISTS(
      SELECT 1 FROM RegistrationDateRanges
      WHERE RegistrationForConferenceID = @RegistrationID AND @Date BETWEEN StartDate AND EndDate
    )
      BEGIN
        RETURN 1
      END

    RETURN 0
  END
GO

CREATE FUNCTION report_best_clients (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN (
      SELECT TOP 1000 FirstName, LastName, 'Conference days' as Type, count(*) as Times FROM RegistrationsForConferences
      INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForConferences.ParticipantID
      WHERE ConferenceID = @ConferenceID
      GROUP BY FirstName, LastName

UNION

SELECT TOP 1000 FirstName, LastName, 'Workshops' as Type, count(*) as Times FROM RegistrationsForWorkshops
      INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
      INNER JOIN Workshops ON RegistrationsForWorkshops.WorkshopID = Workshops.WorkshopID
      WHERE ConferenceID = @ConferenceID
      GROUP BY FirstName, LastName ORDER BY Times DESC
  )
GO

CREATE FUNCTION report_conference_participants (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN(
  SELECT
    FirstName,
    LastName,
    StartDate,
    EndDate
  FROM RegistrationsForConferences
    INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForConferences.ParticipantID
    INNER JOIN RegistrationDateRanges
      ON RegistrationDateRanges.RegistrationForConferenceID = RegistrationsForConferences.RegistrationForConferenceID
  WHERE ConferenceID = @ConferenceID
  )
GO

CREATE FUNCTION report_most_popular_workshop (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN (
      SELECT TOP 1 Workshops.WorkshopName, count(*) AS Attendees FROM Workshops
        INNER JOIN RegistrationsForWorkshops ON RegistrationsForWorkshops.WorkshopID = Workshops.WorkshopID
        INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
        WHERE Workshops.ConferenceID = @ConferenceID
	GROUP BY Workshops.WorkshopName ORDER BY Attendees
  )
GO

CREATE FUNCTION report_payments (@ConferenceID INT)
  RETURNS TABLE
AS
  RETURN(
  SELECT
    FirstName, LastName, 'Conference' as Type, PaidAt FROM RegistrationsForConferences
    INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForConferences.ParticipantID
  WHERE ConferenceID = @ConferenceID

UNION

  SELECT
    FirstName,LastName, CONVERT(varchar(255), Workshops.WorkshopID), PaidAt
  FROM RegistrationsForWorkshops
    INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
    INNER JOIN Workshops ON Workshops.WorkshopID = RegistrationsForWorkshops.WorkshopID
    INNER JOIN Conferences ON Workshops.ConferenceID = Conferences.ConferenceID
  WHERE Workshops.ConferenceID = @ConferenceID
  )
GO

CREATE FUNCTION report_workshops_participants (@WorkshopID INT)
  RETURNS TABLE
AS
  RETURN (
      SELECT Participants.FirstName, Participants.LastName FROM Workshops
        INNER JOIN RegistrationsForWorkshops ON RegistrationsForWorkshops.WorkshopID = Workshops.WorkshopID
        INNER JOIN Participants ON Participants.ParticipantID = RegistrationsForWorkshops.ParticipantID
        WHERE Workshops.WorkshopID = @WorkshopID
  )
GO

CREATE FUNCTION show_workshops (@WorkshopID INT)
  RETURNS TABLE
AS
  RETURN (
      SELECT WorkshopName, NumberOfSeats, StartDateTime, EndDateTime, FirstName, LastName FROM Workshops
      INNER JOIN Lecturers ON Workshops.LecturerID = Lecturers.LecturerID
      WHERE ConferenceID = @WorkshopID
  )
GO

CREATE TRIGGER participant_limit_conference
  ON RegistrationsForConferences
  FOR INSERT
AS
  BEGIN
    IF (SELECT Count(inserted.ConferenceID) FROM inserted) > 1
      BEGIN
        RAISERROR ('You cannot register for more than one conference at once', 16, 1)
        ROLLBACK TRANSACTION
      END

    IF (
         SELECT count(*)
         FROM inserted
       ) > (
         SELECT TOP 1 NumberOfSeats
         FROM inserted
       )
      BEGIN
        RAISERROR ('Registrations exceed conference capacity', 16, 1)
        ROLLBACK TRANSACTION
      END

  END
GO

CREATE TRIGGER participant_limit_workshop
  ON RegistrationsForWorkshops
  FOR INSERT
AS
  BEGIN
    IF (SELECT Count(inserted.WorkshopID) FROM inserted) > 1
      BEGIN
        RAISERROR ('You cannot register for more than one workshop at once', 16, 1)
        ROLLBACK TRANSACTION
      END
    IF (
         SELECT Count(*)
         FROM inserted
       ) > (
         SELECT TOP 1 NumberOfSeats
         FROM inserted
       )
      BEGIN
        RAISERROR ('Registrations exceed workshop capacity', 16, 1)
        ROLLBACK TRANSACTION
      END

  END
GO

CREATE TRIGGER registration_for_workshop_if_in_conference ON RegistrationsForWorkshops
FOR INSERT
AS
  BEGIN
    IF NOT (
      SELECT Count(RegistrationsForWorkshops.RegistrationForWorkshopID)
      FROM inserted
      INNER JOIN Workshops ON inserted.WorkshopID = Workshops.WorkshopID
      INNER JOIN Conferences ON Workshops.ConferenceID = Conferences.ConferenceID
      INNER JOIN RegistrationsForConferences
	      ON inserted.ParticipantID = RegistrationsForConferences.ParticipantID AND Conferences.ConferenceID = RegistrationsForConferences.ConferenceID
      INNER JOIN RegistrationDateRanges ON RegistrationsForConferences.RegistrationForConferenceID = RegistrationDateRanges.RegistrationForConferenceID
      WHERE Workshops.StartDateTime BETWEEN RegistrationDateRanges.StartDate AND RegistrationDateRanges.EndDate
    ) = (
      SELECT Count(RegistrationsForWorkshops.RegistrationForWorkshopID)
      FROM inserted
    )
      BEGIN
        RAISERROR('Each participant must be registered for the conference on that day', 16, 1)
        ROLLBACK TRANSACTION
      END
  END
GO

CREATE VIEW dbo.ConferenceRegistrationsToCancelView
  AS
    SELECT r.RegistrationForConferenceID
    FROM RegistrationsForConferences AS r
      INNER JOIN Conferences AS c ON c.ConferenceID = r.ConferenceID
    WHERE r.PaidAt IS NULL AND GETDATE() < DATEADD(WEEK, -1, c.StartDate)
GO

CREATE VIEW dbo.ParticipantsWithInfoActionRequiredView
  AS
    SELECT TOP 1000 p.ParticipantID, p.ClientID
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

CREATE PROCEDURE dbo.change_number_of_seats_for_conference
    @ConferenceID INT, @Seats INT
AS
  BEGIN
    DECLARE @CurrentNumberOfSeats INT, @MinSeatsLeft INT
    SET @MinSeatsLeft = 9999

    DECLARE @StartDate DATE
    DECLARE @EndDate DATE

    SELECT @StartDate = c.StartDate, @EndDate = c.EndDate
    FROM Conferences AS c
    WHERE c.ConferenceID = @ConferenceID

    WHILE (@StartDate < @EndDate)
      BEGIN
        IF dbo.get_seats_left_for_conference_at_date(@ConferenceID, @StartDate) < @MinSeatsLeft
          BEGIN
            SET @MinSeatsLeft = dbo.get_seats_left_for_conference_at_date(@ConferenceID, @StartDate)
          END

        SET @StartDate = DATEADD(DAY, 1, @StartDate);
      END

    SELECT @CurrentNumberOfSeats = c.NumberOfSeats FROM Conferences AS c WHERE c.ConferenceID = @ConferenceID

    IF @CurrentNumberOfSeats - @MinSeatsLeft > @Seats -- there are more registered than @Seats
      BEGIN
        RAISERROR('There are already more participants registered.', 16, 1)
      END
    UPDATE Conferences SET NumberOfSeats = @Seats WHERE ConferenceID = @ConferenceID
  END
GO

CREATE PROCEDURE dbo.change_number_of_seats_for_workshop
    @WorkshopID INT, @Seats INT
AS
  BEGIN
    DECLARE @CurrentNumberOfSeats INT, @SeatsLeft INT

    SET @SeatsLeft = dbo.get_seats_left_for_workshop(@WorkshopID)
    SELECT @CurrentNumberOfSeats = Workshops.NumberOfSeats FROM Workshops WHERE Workshops.WorkshopID = @WorkshopID

    IF (@CurrentNumberOfSeats - @SeatsLeft) > @Seats
      BEGIN
        RAISERROR('There are already more participants registered.', 16, 1)
      END
    UPDATE Workshops SET NumberOfSeats = @Seats WHERE WorkshopID = @WorkshopID
  END
GO

CREATE PROCEDURE dbo.change_workshop_price
    @WorkshopID INT, @NewPrice MONEY
AS
  BEGIN
    UPDATE Workshops SET Price = @NewPrice WHERE WorkshopID = @WorkshopID
  END
GO

CREATE PROCEDURE dbo.cancel_conference_registration
    @ConferenceID INT, @ParticipantID INT
AS
  BEGIN
    IF (
         SELECT c.StartDate FROM Conferences AS c WHERE c.ConferenceID = @ConferenceID
       ) > GETDATE()
      BEGIN
        RAISERROR('Cannot cancel registration for current/past conference', 16, 1)
      END

    DELETE
    FROM dbo.RegistrationsForConferences
    WHERE dbo.RegistrationsForConferences.ConferenceID = @ConferenceID AND
          dbo.RegistrationsForConferences.ParticipantID = @ParticipantID
  END
GO

CREATE PROCEDURE dbo.cancel_workshop_registration
    @WorkshopID INT, @ParticipantID INT
AS
  BEGIN
    IF (
      SELECT w.StartDateTime FROM Workshops AS w WHERE w.WorkshopID = @WorkshopID
    ) > GETDATE()
      BEGIN
        RAISERROR('Cannot cancel registration for current/past workshop', 16, 1)
      END

    DELETE FROM dbo.RegistrationsForWorkshops
    WHERE dbo.RegistrationsForWorkshops.WorkshopID = @WorkshopID AND
          dbo.RegistrationsForWorkshops.ParticipantID = @ParticipantID
  END
GO



