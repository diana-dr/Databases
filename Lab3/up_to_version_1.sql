USE BREWERY
GO

-- a. modify the type of a column;
-- modifying the expirationDate type from date to varchar(10)

ALTER PROCEDURE up_to_version_1
AS
	ALTER TABLE Product
	ALTER COLUMN expirationDate VARCHAR(10) NOT NULL
GO

-- EXEC dbo.up_to_version_1