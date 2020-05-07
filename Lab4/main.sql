USE BREWERY
GO

ALTER PROCEDURE test 
AS
BEGIN

	DECLARE @dstart DATETIME
	DECLARE @dend DATETIME

	SET @dstart = GETDATE()

	DECLARE @types_start_at DATETIME
	DECLARE @product_start_at DATETIME
	DECLARE @locations_start_at DATETIME

	DECLARE @types_end_at DATETIME
	DECLARE @product_end_at DATETIME
	DECLARE @locations_end_at DATETIME

	-- INSERT + DELETE IN/FROM ProductTypes table, 1 primary key, no foreign keys
	SET @types_start_at = GETDATE()
	execute delete_rows 'ProductTypes'
	execute insert_rows 'ProductTypes'
	SET @types_end_at = GETDATE()

	-- INSERT + DELETE IN/FROM Product table, 1 primary key, 1 foreign key
	SET @product_start_at = GETDATE()
	execute delete_rows 'Product'
	execute insert_rows 'Product'
	SET @product_end_at = GETDATE()

	-- INSERT + DELETE IN/FROM Locations table, 2 primary keys
	SET @locations_start_at = GETDATE()
	execute delete_rows 'Locations'
	execute insert_rows 'Locations'
	SET @locations_end_at = GETDATE()

	DECLARE @view1_start DATETIME
	DECLARE @view2_start DATETIME
	DECLARE @view3_start DATETIME

	DECLARE @view1_end DATETIME
	DECLARE @view2_end DATETIME
	DECLARE @view3_end DATETIME

	SET @view1_start = GETDATE()
	execute select_view 'View_1'
	SET @view1_end = GETDATE()

	SET @view2_start = GETDATE()
	execute select_view 'View_2'
	SET @view2_end = GETDATE()

	SET @view3_start = GETDATE()
	execute select_view 'View_3'
	SET @view3_end = GETDATE()

	SET @dend = GETDATE()

	DECLARE @description VARCHAR(500)
	DECLARE @NoOfRows INT
	SELECT TOP 1 @NoOfRows = NoOfRows FROM dbo.TestTables

	SET @description = 'Tested insert + delete' + STR(@NoOfRows) +' rows for all 3 tables, selected all views.'

	INSERT INTO TestRuns(Description, StartAt, EndAt) VALUES (@description, @dstart, @dend)

	DECLARE @lastTestRunID INT 
	SET @lastTestRunID = (SELECT MAX(TestRunID) FROM TestRuns);

	INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt) VALUES 
	(@lastTestRunID, 1, @types_start_at, @types_end_at),
	(@lastTestRunID, 2, @product_start_at, @product_end_at),
	(@lastTestRunID, 3, @locations_start_at, @locations_end_at);

	INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) VALUES
	(@lastTestRunID, 4, @view1_start, @view1_end),
	(@lastTestRunID, 5, @view2_start, @view2_end),
	(@lastTestRunID, 6, @view3_start, @view3_end);

END

EXECUTE test
SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews
UPDATE TestTables
SET NoOfRows = 100