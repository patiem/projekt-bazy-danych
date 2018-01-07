CREATE TABLE [Workshops] (
	WorkshopID integer NOT NULL UNIQUE IDENTITY(1,1),
	ConferenceID integer NOT NULL,
	NumberOfSeats integer NOT NULL,
	StartDateTime date NOT NULL,
	EndDateTime date NOT NULL,
	LecturerID integer NOT NULL,
  CONSTRAINT [PK_WORKSHOPS] PRIMARY KEY CLUSTERED
  (
  [WorkshopID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Clients] (
	ClientID integer NOT NULL UNIQUE IDENTITY(1,1),
	ClientName varchar(255) NOT NULL UNIQUE,
	Email varchar(255) NOT NULL UNIQUE,
	IsCompany binary NOT NULL,
  CONSTRAINT [PK_CLIENTS] PRIMARY KEY CLUSTERED
  (
  [ClientID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Participants] (
	ParticipantID integer NOT NULL UNIQUE IDENTITY(1,1),
	ClientID integer NOT NULL,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
	Email varchar(255) NOT NULL,
	StudentID varchar(255) NOT NULL,
  CONSTRAINT [PK_PARTICIPANTS] PRIMARY KEY CLUSTERED
  (
  [ClientID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Conferences] (
	ConferenceID integer NOT NULL UNIQUE IDENTITY(1,1),
	ConferenceName varchar(255) NOT NULL UNIQUE,
	NumberOfSeats integer NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
  CONSTRAINT [PK_CONFERENCES] PRIMARY KEY CLUSTERED
  (
  [ConferenceID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [RegistrationDateRanges] (
	RegistrationForConferenceID integer NOT NULL UNIQUE IDENTITY(1,1),
	StartDate date NOT NULL,
	EndDate date NOT NULL,
  CONSTRAINT [PK_REGISTRATIONDATERANGES] PRIMARY KEY CLUSTERED
  (
  [RegistrationForConferenceID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [RegistrationsForConferences] (
	RegistrationForConferenceID integer NOT NULL UNIQUE IDENTITY(1,1),
	ConferenceID integer NOT NULL,
	ParticipantID integer NOT NULL,
	PaidAt date NOT NULL,
  CONSTRAINT [PK_REGISTRATIONSFORCONFERENCES] PRIMARY KEY CLUSTERED
  (
  [RegistrationForConferenceID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [RegistrationsForWorkshops] (
	RegistrationForWorkshopID integer NOT NULL UNIQUE IDENTITY(1,1),
	WorkshopID integer NOT NULL,
	ParticipantID integer NOT NULL,
	PaidAt date NOT NULL,
  CONSTRAINT [PK_REGISTRATIONSFORWORKSHOPS] PRIMARY KEY CLUSTERED
  (
  [RegistrationForWorkshopID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Lecturers] (
	LecturerID integer NOT NULL UNIQUE IDENTITY(1,1),
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
  CONSTRAINT [PK_LECTURERS] PRIMARY KEY CLUSTERED
  (
  [LecturerID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [ConferencePriceThresholds] (
	ConferenceID integer NOT NULL UNIQUE IDENTITY(1,1),
	StartDate date NOT NULL,
	Price integer NOT NULL,
	Discount float NOT NULL,
  CONSTRAINT [PK_CONFERENCEPRICETHRESHOLDS] PRIMARY KEY CLUSTERED
  (
  [ConferenceID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

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

