IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'OverflowDB')
BEGIN
    CREATE DATABASE OverflowDB;
END;

-- Switch to the newly created database
USE master;
GO
USE OverflowDB;

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