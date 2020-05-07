USE BREWERY
GO

-- table with a single column primary key and no foreign keys: ProductTypes
-- table with a single column primary key and at least one foreign key: Product
-- table with a multicolumn primary key: Locations

ALTER PROCEDURE insert_rows
		@table_name VARCHAR(50)
AS
BEGIN
	DECLARE @n INT
	DECLARE @NoOfRows INT

	SET @n = 1 -- first we have no row inserted
	SELECT TOP 1 @NoOfRows = NoOfRows FROM dbo.TestTables
	WHILE @n <= @NoOfRows
	BEGIN
		IF @table_name = 'Product'
		BEGIN
			DECLARE @name VARCHAR(50)
			DECLARE @price INT
			DECLARE @exp DATE
			DECLARE @type INT
			SELECT TOP (@n) @type = typeID FROM ProductTypes;

			SET @name = 'Product' + CONVERT(varchar(5), @n)
			SET @price = @n * 2;
			SET @exp = GETDATE()
			INSERT INTO Product(productID, productName, productPrice, expirationDate, typeID) 
							VALUES (@n, @name, @price, @exp, @type)
		END
	
		SET @n = @n+1
	END

END

exec insert_rows Product