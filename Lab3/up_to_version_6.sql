USE BREWERY
GO

-- f. add / remove a foreign key;
-- add forign key employeeID to table Suppliers

ALTER PROCEDURE addColumn
AS
	ALTER TABLE Suppliers
	ADD employeeID INT
GO

ALTER PROCEDURE up_to_version_6
AS
	ALTER TABLE Suppliers
	ADD CONSTRAINT fk_employeeID FOREIGN KEY(employeeID) REFERENCES Employee(employeeID) 
GO