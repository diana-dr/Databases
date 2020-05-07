USE BREWERY
GO 

ALTER PROCEDURE delete_rows
	@tableName VARCHAR(50)
AS
BEGIN
	DECLARE @row INT
	DECLARE @NoOfRows INT

	SELECT TOP 1 @NoOfRows = NoOfRows FROM dbo.TestTables
	IF @tableName = 'ProductTypes'
	BEGIN
		SET @row = (SELECT MAX(typeID) FROM ProductTypes) - @NoOfRows

		DELETE FROM Product
		DELETE FROM ProductTypes
		WHERE typeID > @row
	END

	IF @tableName = 'Product'
	BEGIN
		SET @row = (SELECT MAX(typeID) FROM Product) - @NoOfRows

		DELETE FROM Customers
		DELETE FROM Order_
		DELETE FROM OrderDetails
		DELETE FROM product_ingredients

		DELETE FROM Product
		WHERE productID > @row
	END

	IF @tableName = 'Locations'
	BEGIN
		DELETE FROM Locations
	END
END
