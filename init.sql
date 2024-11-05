-- Check if the database exists, if not, create it
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'OverflowDB')
BEGIN
    CREATE DATABASE OverflowDB;
END;
GO

-- Switch to the OverflowDB
USE OverflowDB;
GO

-- Create Users table if it does not exist
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
BEGIN
    CREATE TABLE Users (
        UserID INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL,
        Email NVARCHAR(255),
        Password NVARCHAR(255) NOT NULL,
        Rank INT,
        NumberOfGames INT
    );
END;
GO

-- Create Friends table if it does not exist
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Friends')
BEGIN
    CREATE TABLE Friends (
        FriendId INT PRIMARY KEY IDENTITY,
        UserId INT,
        FriendUserId INT,
        Status INT CHECK (Status IN (0, 1, 2)), -- Using int values 0, 1, 2 for status
        FOREIGN KEY (UserId) REFERENCES Users(UserId),
        FOREIGN KEY (FriendUserId) REFERENCES Users(UserId)
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Versions')
BEGIN
    CREATE TABLE Versions (
        VersionID INT PRIMARY KEY IDENTITY,
        RequiredGameVerion NVARCHAR(255)
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'UserSessions')
BEGIN
    CREATE TABLE UserSessions (
    SessionId INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50) NOT NULL,
    SessionToken NVARCHAR(255) NOT NULL,
    DeviceId NVARCHAR(255) NULL,
    LastActiveTime DATETIME NOT NULL,
    IsActive BIT NOT NULL,
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BlockedUsers')
BEGIN
    CREATE TABLE BlockedUsers (
    Id INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50) NOT NULL,
    BlockedUsername NVARCHAR(255) NOT NULL,
);

END;
GO



-- Ensure Username column is case-sensitive (Latin1_General_BIN)
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
BEGIN
    ALTER TABLE Users
    ALTER COLUMN Username NVARCHAR(50) COLLATE Latin1_General_BIN;
END;
GO