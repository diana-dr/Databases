USE BREWERY
GO

ALTER PROCEDURE select_view
	@view VARCHAR(100)
AS
BEGIN
	IF @view = 'View_1'
	BEGIN
		SELECT * FROM View_1
	END

	IF @view = 'View_2'
	BEGIN 
		SELECT * FROM View_2
	END

	IF @view = 'View_3'
	BEGIN
		SELECT * FROM View_3
	END
END