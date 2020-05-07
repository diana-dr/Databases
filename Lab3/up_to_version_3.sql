USE BREWERY
GO

-- c.add/remove a DEFAULT constraint;
-- set the default value for the field arrivalDate to '2019-25-11' in the table OrderDetails

CREATE PROCEDURE up_to_version_3
AS
	ALTER TABLE OrderDetails
	ADD CONSTRAINT df_arrivalDate DEFAULT '2019-25-11' FOR arrivalDate
GO

EXEC dbo.up_to_version_3 