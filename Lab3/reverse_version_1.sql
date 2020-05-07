USE BREWERY
GO

-- modifying the expirationDate type back from varchar(10) to date

ALTER PROCEDURE reverse_version_1
AS
	ALTER TABLE Product
	ALTER COLUMN expirationDate DATE NOT NULL
GO

EXEC reverse_version_1