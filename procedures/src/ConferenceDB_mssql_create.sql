CREATE TABLE [Workshops] (
	WorkshopID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	ConferenceID integer NOT NULL,
	NumberOfSeats integer NOT NULL,
	StartDateTime date NOT NULL,
	EndDateTime date NOT NULL,
	LecturerID integer NOT NULL,
)
GO
CREATE TABLE [Clients] (
	ClientID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	ClientName varchar(255) NOT NULL UNIQUE,
	Email varchar(255) NOT NULL UNIQUE,
	IsCompany binary NOT NULL,
)
GO
CREATE TABLE [Participants] (
	ParticipantID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	ClientID integer NOT NULL,
	FirstName varchar(255),
	LastName varchar(255),
	Email varchar(255) UNIQUE,
	StudentID varchar(255),
)
GO
CREATE TABLE [Conferences] (
	ConferenceID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	ConferenceName varchar(255) NOT NULL UNIQUE,
	NumberOfSeats integer NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
)
GO
CREATE TABLE [RegistrationDateRanges] (
	RegistrationForConferenceID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
)
GO
CREATE TABLE [RegistrationsForConferences] (
	RegistrationForConferenceID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	ConferenceID integer NOT NULL,
	ParticipantID integer NOT NULL,
	PaidAt date,
)
GO
CREATE TABLE [RegistrationsForWorkshops] (
	RegistrationForWorkshopID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	WorkshopID integer NOT NULL,
	ParticipantID integer NOT NULL,
	PaidAt date,
)
GO
CREATE TABLE [Lecturers] (
	LecturerID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
)
GO
CREATE TABLE [ConferencePriceThresholds] (
	ConferenceID integer NOT NULL UNIQUE IDENTITY(1,1) PRIMARY KEY,
	StartDate date NOT NULL,
	Price integer NOT NULL,
	Discount float NOT NULL,
)
GO
ALTER TABLE [Workshops] WITH CHECK ADD CONSTRAINT [Workshops_fk0] FOREIGN KEY ([ConferenceID]) REFERENCES [Conferences]([ConferenceID])
GO
ALTER TABLE [Workshops] CHECK CONSTRAINT [Workshops_fk0]
GO
ALTER TABLE [Workshops] WITH CHECK ADD CONSTRAINT [Workshops_fk1] FOREIGN KEY ([LecturerID]) REFERENCES [Lecturers]([LecturerID])
GO
ALTER TABLE [Workshops] CHECK CONSTRAINT [Workshops_fk1]
GO


ALTER TABLE [Participants] WITH CHECK ADD CONSTRAINT [Participants_fk0] FOREIGN KEY ([ClientID]) REFERENCES [Clients]([ClientID])
GO
ALTER TABLE [Participants] CHECK CONSTRAINT [Participants_fk0]
GO


ALTER TABLE [RegistrationDateRanges] WITH CHECK ADD CONSTRAINT [RegistrationDateRanges_fk0] FOREIGN KEY ([RegistrationForConferenceID]) REFERENCES [RegistrationsForConferences]([RegistrationForConferenceID])
GO
ALTER TABLE [RegistrationDateRanges] CHECK CONSTRAINT [RegistrationDateRanges_fk0]
GO

ALTER TABLE [RegistrationsForConferences] WITH CHECK ADD CONSTRAINT [RegistrationsForConferences_fk0] FOREIGN KEY ([ConferenceID]) REFERENCES [Conferences]([ConferenceID])
GO
ALTER TABLE [RegistrationsForConferences] CHECK CONSTRAINT [RegistrationsForConferences_fk0]
GO
ALTER TABLE [RegistrationsForConferences] WITH CHECK ADD CONSTRAINT [RegistrationsForConferences_fk1] FOREIGN KEY ([ParticipantID]) REFERENCES [Participants]([ParticipantID])
GO
ALTER TABLE [RegistrationsForConferences] CHECK CONSTRAINT [RegistrationsForConferences_fk1]
GO

ALTER TABLE [RegistrationsForWorkshops] WITH CHECK ADD CONSTRAINT [RegistrationsForWorkshops_fk0] FOREIGN KEY ([WorkshopID]) REFERENCES [Workshops]([WorkshopID])
GO
ALTER TABLE [RegistrationsForWorkshops] CHECK CONSTRAINT [RegistrationsForWorkshops_fk0]
GO
ALTER TABLE [RegistrationsForWorkshops] WITH CHECK ADD CONSTRAINT [RegistrationsForWorkshops_fk1] FOREIGN KEY ([ParticipantID]) REFERENCES [Participants]([ParticipantID])
GO
ALTER TABLE [RegistrationsForWorkshops] CHECK CONSTRAINT [RegistrationsForWorkshops_fk1]
GO


ALTER TABLE [ConferencePriceThresholds] WITH CHECK ADD CONSTRAINT [ConferencePriceThresholds_fk0] FOREIGN KEY ([ConferenceID]) REFERENCES [Conferences]([ConferenceID])
GO
ALTER TABLE [ConferencePriceThresholds] CHECK CONSTRAINT [ConferencePriceThresholds_fk0]
GO

