USE BREWERY
GO

-- remove the default value for the field arrivalDate

CREATE PROCEDURE reverse_version_3
AS
	ALTER TABLE OrderDetails
	DROP CONSTRAINT df_arrivalDate
GO

EXEC dbo.reverse_version_3 