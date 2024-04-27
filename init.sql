IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
BEGIN
    CREATE TABLE Users (
        UserID INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50),
        Email NVARCHAR(255),
        Password NVARCHAR(255),
        Rank INT,
        NumberOfGames INT
    );
END;