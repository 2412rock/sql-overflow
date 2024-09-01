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
