USE BREWERY
GO

-- reversing the field supplierName from the Table Suppliers from UNIQUE

CREATE PROCEDURE reverse_version_5
AS
	ALTER TABLE Suppliers
	DROP CONSTRAINT uq_supplierName
GO

EXEC dbo.reverse_version_5