USE BREWERY
GO

-- remove foreign key employeeID from table Suppliers

/*ALTER PROCEDURE addColumn
AS
	ALTER TABLE Suppliers
	ADD employeeID INT NOT NULL
GO*/

CREATE PROCEDURE reverse_version_6
AS
	ALTER TABLE Suppliers
	DROP CONSTRAINT fk_employeeID
GO

EXEC dbo.reverse_version_6