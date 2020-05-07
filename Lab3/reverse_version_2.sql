USE BREWERY
GO

-- removing the column dateOfHiring of type date to the table Employee

ALTER PROCEDURE reverse_version_2
AS
	ALTER TABLE Employee
	DROP COLUMN dateOfHiring
GO
