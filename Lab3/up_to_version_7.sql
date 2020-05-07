USE BREWERY
GO

-- g.create/remove a table.
-- adding a new table Locations to the database

ALTER PROCEDURE up_to_version_7
AS
	CREATE TABLE Locations (
	locationID INT PRIMARY KEY NOT NULL,
	customerID INT FOREIGN KEY REFERENCES Customers(customerID),
	locationDetails VARCHAR(200))
GO

EXEC up_to_version_7