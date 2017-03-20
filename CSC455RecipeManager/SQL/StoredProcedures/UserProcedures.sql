DELIMITER //
CREATE FUNCTION ValidateUser(
	@Username VARCHAR(20),
	@Password VARCHAR(100)) AS
BEGIN
	--@Salt = SELECT Salt FROM Users WHERE Username = @Username;
	--@SaltedPassword = CONCAT(@Password, @Salt);
	@Hash = SHA(@Password);
	RETURN (SELECT PassHash = @Hash FROM Users WHERE Username = @Username);
END; //

CREATE PROCEDURE Createuser(
	@Username VARCHAR(20),
	@Password VARCHAR(100)) AS
BEGIN
	@Hash = SHA(@Password);
	INSERT INTO Users VALUES (
		RAND(100),
		@Username,
		@Hash,
		NULL)
END;
DELIMITER ;