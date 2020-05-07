USE BREWERY
GO

-- removing the table Locations from the database

CREATE PROCEDURE reverse_version_7
AS
	DROP TABLE Locations
GO

EXEC dbo.reverse_version_7