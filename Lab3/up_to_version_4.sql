USE BREWERY
GO

-- d. add/remove a primary key;
-- add primary key for the new table Statistics

CREATE TABLE _Statistics_
(statisticsID INT NOT NULL,
details VARCHAR(100),
customerID INT FOREIGN KEY REFERENCES Customers(customerID))
GO

ALTER PROCEDURE up_to_version_4
AS
	ALTER TABLE _Statistics_
	ADD CONSTRAINT pk_id PRIMARY KEY (statisticsID)
GO

EXEC dbo.up_to_version_4