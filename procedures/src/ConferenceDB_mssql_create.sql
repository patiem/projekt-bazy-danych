IF OBJECT_ID('Workshops_fk0') IS NOT NULL ALTER TABLE Workshops DROP CONSTRAINT Workshops_fk0
IF OBJECT_ID('Workshops_fk1') IS NOT NULL ALTER TABLE Workshops DROP CONSTRAINT Workshops_fk1
IF OBJECT_ID('Participants_fk0') IS NOT NULL ALTER TABLE Participants DROP CONSTRAINT Participants_fk0
IF OBJECT_ID('RegistrationDateRanges_fk0') IS NOT NULL ALTER TABLE RegistrationDateRanges DROP CONSTRAINT RegistrationDateRanges_fk0
IF OBJECT_ID('RegistrationsForConferences_fk0') IS NOT NULL ALTER TABLE RegistrationsForConferences DROP CONSTRAINT RegistrationsForConferences_fk0
IF OBJECT_ID('RegistrationsForConferences_fk1') IS NOT NULL ALTER TABLE RegistrationsForConferences DROP CONSTRAINT RegistrationsForConferences_fk1
IF OBJECT_ID('RegistrationsForConferences_uq1') IS NOT NULL ALTER TABLE RegistrationsForConferences DROP CONSTRAINT RegistrationsForConferences_uq1
IF OBJECT_ID('RegistrationsForWorkshops_fk0') IS NOT NULL ALTER TABLE RegistrationsForWorkshops DROP CONSTRAINT RegistrationsForWorkshops_fk0
IF OBJECT_ID('RegistrationsForWorkshops_fk1') IS NOT NULL ALTER TABLE RegistrationsForWorkshops DROP CONSTRAINT RegistrationsForWorkshops_fk1
IF OBJECT_ID('RegistrationsForWorkshops_uq1') IS NOT NULL ALTER TABLE RegistrationsForWorkshops DROP CONSTRAINT RegistrationsForWorkshops_uq1
IF OBJECT_ID('ConferencePriceThresholds_fk0') IS NOT NULL ALTER TABLE ConferencePriceThresholds DROP CONSTRAINT ConferencePriceThresholds_fk0
GO

IF OBJECT_ID('Workshops') IS NOT NULL DROP TABLE Workshops
CREATE TABLE [Workshops] (
	WorkshopID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	WorkshopName varchar(255) NOT NULL,
	ConferenceID integer NOT NULL,
	NumberOfSeats integer NOT NULL,
	StartDateTime date NOT NULL,
	EndDateTime date NOT NULL,
	Price money NOT NULL,
	LecturerID integer NOT NULL,
)
GO
IF OBJECT_ID('Clients') IS NOT NULL DROP TABLE Clients
CREATE TABLE [Clients] (
	ClientID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ClientName varchar(255) NOT NULL,
	Email varchar(255) NOT NULL,
	IsCompany binary NOT NULL,
)
GO
IF OBJECT_ID('Participants') IS NOT NULL DROP TABLE Participants
CREATE TABLE [Participants] (
	ParticipantID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ClientID integer NOT NULL,
	FirstName varchar(255),
	LastName varchar(255),
	Email varchar(255),
	StudentID varchar(255),
)
GO
IF OBJECT_ID('Conferences') IS NOT NULL DROP TABLE Conferences
CREATE TABLE [Conferences] (
	ConferenceID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ConferenceName varchar(255) NOT NULL,
	NumberOfSeats integer NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
)
GO
IF OBJECT_ID('RegistrationDateRanges') IS NOT NULL DROP TABLE RegistrationDateRanges
CREATE TABLE [RegistrationDateRanges] (
	RegistrationDateRangeID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RegistrationForConferenceID integer NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
)
GO
IF OBJECT_ID('RegistrationsForConferences') IS NOT NULL DROP TABLE RegistrationsForConferences
CREATE TABLE [RegistrationsForConferences] (
	RegistrationForConferenceID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ConferenceID integer NOT NULL,
	ParticipantID integer NOT NULL,
	PaidAt date,
)
GO
IF OBJECT_ID('RegistrationsForWorkshops') IS NOT NULL DROP TABLE RegistrationsForWorkshops
CREATE TABLE [RegistrationsForWorkshops] (
	RegistrationForWorkshopID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	WorkshopID integer NOT NULL,
	ParticipantID integer NOT NULL,
	PaidAt date,
)
GO
IF OBJECT_ID('Lecturers') IS NOT NULL DROP TABLE Lecturers
CREATE TABLE [Lecturers] (
	LecturerID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
)
GO
IF OBJECT_ID('ConferencePriceThresholds') IS NOT NULL DROP TABLE ConferencePriceThresholds
CREATE TABLE [ConferencePriceThresholds] (
	ConferencePriceThresholdID integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ConferenceID integer NOT NULL,
	EndDate date NOT NULL,
	Price integer NOT NULL,
	Discount float NOT NULL,
)
GO

IF OBJECT_ID('Workshops_fk0') IS NOT NULL ALTER TABLE Workshops DROP CONSTRAINT Workshops_fk0
ALTER TABLE [Workshops] WITH CHECK ADD CONSTRAINT [Workshops_fk0] FOREIGN KEY ([ConferenceID]) REFERENCES [Conferences]([ConferenceID])
GO

IF OBJECT_ID('Workshops_fk1') IS NOT NULL ALTER TABLE Workshops DROP CONSTRAINT Workshops_fk1
ALTER TABLE [Workshops] WITH CHECK ADD CONSTRAINT [Workshops_fk1] FOREIGN KEY ([LecturerID]) REFERENCES [Lecturers]([LecturerID])
GO


IF OBJECT_ID('Participants_fk0') IS NOT NULL ALTER TABLE Participants DROP CONSTRAINT Participants_fk0
ALTER TABLE [Participants] WITH CHECK ADD CONSTRAINT [Participants_fk0] FOREIGN KEY ([ClientID]) REFERENCES [Clients]([ClientID])
GO


IF OBJECT_ID('RegistrationDateRanges_fk0') IS NOT NULL ALTER TABLE RegistrationDateRanges DROP CONSTRAINT RegistrationDateRanges_fk0
ALTER TABLE [RegistrationDateRanges] WITH CHECK ADD CONSTRAINT [RegistrationDateRanges_fk0] FOREIGN KEY ([RegistrationForConferenceID]) REFERENCES [RegistrationsForConferences]([RegistrationForConferenceID])
GO

IF OBJECT_ID('RegistrationsForConferences_fk0') IS NOT NULL ALTER TABLE RegistrationsForConferences DROP CONSTRAINT RegistrationsForConferences_fk0
ALTER TABLE [RegistrationsForConferences] WITH CHECK ADD CONSTRAINT [RegistrationsForConferences_fk0] FOREIGN KEY ([ConferenceID]) REFERENCES [Conferences]([ConferenceID])
GO
IF OBJECT_ID('RegistrationsForConferences_fk1') IS NOT NULL ALTER TABLE RegistrationsForConferences DROP CONSTRAINT RegistrationsForConferences_fk1
ALTER TABLE [RegistrationsForConferences] WITH CHECK ADD CONSTRAINT [RegistrationsForConferences_fk1] FOREIGN KEY ([ParticipantID]) REFERENCES [Participants]([ParticipantID])
GO
IF OBJECT_ID('RegistrationsForConferences_uq1') IS NOT NULL ALTER TABLE RegistrationsForConferences DROP CONSTRAINT RegistrationsForConferences_uq1
ALTER TABLE [RegistrationsForConferences] WITH CHECK ADD CONSTRAINT [RegistrationsForConferences_uq1] UNIQUE (ParticipantID, ConferenceID)
GO

IF OBJECT_ID('RegistrationsForWorkshops_fk0') IS NOT NULL ALTER TABLE RegistrationsForWorkshops DROP CONSTRAINT RegistrationsForWorkshops_fk0
ALTER TABLE [RegistrationsForWorkshops] WITH CHECK ADD CONSTRAINT [RegistrationsForWorkshops_fk0] FOREIGN KEY ([WorkshopID]) REFERENCES [Workshops]([WorkshopID])
GO
IF OBJECT_ID('RegistrationsForWorkshops_fk1') IS NOT NULL ALTER TABLE RegistrationsForWorkshops DROP CONSTRAINT RegistrationsForWorkshops_fk1
ALTER TABLE [RegistrationsForWorkshops] WITH CHECK ADD CONSTRAINT [RegistrationsForWorkshops_fk1] FOREIGN KEY ([ParticipantID]) REFERENCES [Participants]([ParticipantID])
GO
IF OBJECT_ID('RegistrationsForWorkshops_uq1') IS NOT NULL ALTER TABLE RegistrationsForWorkshops DROP CONSTRAINT RegistrationsForWorkshops_uq1
ALTER TABLE [RegistrationsForWorkshops] WITH CHECK ADD CONSTRAINT [RegistrationsForWorkshops_uq1] UNIQUE (ParticipantID, WorkshopID)
GO


IF OBJECT_ID('ConferencePriceThresholds_fk0') IS NOT NULL ALTER TABLE ConferencePriceThresholds DROP CONSTRAINT ConferencePriceThresholds_fk0
ALTER TABLE [ConferencePriceThresholds] WITH CHECK ADD CONSTRAINT [ConferencePriceThresholds_fk0] FOREIGN KEY ([ConferenceID]) REFERENCES [Conferences]([ConferenceID])
GO
