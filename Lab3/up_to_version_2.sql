USE BREWERY
GO

-- b.add/remove a column;
-- adding the column dateOfHiring of type date to the table Employee

ALTER PROCEDURE up_to_version_2
AS
	ALTER TABLE Employee
	ADD dateOfHiring DATE 
GO