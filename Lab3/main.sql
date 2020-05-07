USE BREWERY
GO

ALTER PROCEDURE MAIN
	@newVersion varchar(30)
AS
BEGIN

	DECLARE @nextStep varchar(30)
	DECLARE @currentVersion INT
	SET @currentVersion = (SELECT version FROM Version)

	if ISNUMERIC(@newVersion) != 1
	BEGIN
		print('Not a number')
		return 1 
	END
	
	SET @newVersion = cast(@newVersion as INT)
	if @newVersion < 1 or @newVersion > 7
	BEGIN
		print('Invalid number')
		return 2 
	END

	while @currentVersion < @newVersion
	begin
		SET @currentVersion = @currentVersion + 1
		SET @nextStep = 'up_to_version_' + convert(varchar(3), @currentVersion)
		execute @nextStep
	end

	while @currentVersion > @newVersion
	begin
		SET @currentVersion = @currentVersion - 1
		SET @nextStep = 'reverse_version_' + convert(varchar(3), @currentVersion)
		execute @nextStep
	end
	UPDATE Version SET version = @newVersion

END

EXEC MAIN 5

SELECT * FROM Version