USE BREWERY
GO

-- e.add a candidate key;
-- making the field supplierName from the Table Suppliers UNIQUE

ALTER PROCEDURE up_to_version_5
AS
	ALTER TABLE Suppliers
	ADD CONSTRAINT uq_supplierName UNIQUE(supplierName)
GO

EXEC dbo.up_to_version_5