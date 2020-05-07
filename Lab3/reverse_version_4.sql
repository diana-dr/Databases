USE BREWERY
GO

-- remove the added primary key

ALTER PROCEDURE reverse_version_4
AS
	ALTER TABLE _Statistics_
	DROP CONSTRAINT pk_id
GO

EXEC reverse_version_4