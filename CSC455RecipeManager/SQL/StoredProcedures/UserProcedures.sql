DROP FUNCTION IF EXISTS ValidateUser;
DROP PROCEDURE IF EXISTS CreateUser;

DELIMITER //

CREATE FUNCTION ValidateUser(
	u_name VARCHAR(40), pwd VARCHAR(100))
	RETURNS BOOL
BEGIN
	DECLARE storedId		INT;
	DECLARE storedSalt		VARCHAR(40);
	DECLARE thisHash		VARCHAR(40);
	DECLARE storedHash		VARCHAR(40);
	DECLARE result			BOOL			DEFAULT FALSE;

	SELECT UserId, PassHash, Salt INTO storedId, storedHash, storedSalt FROM Users WHERE Username = u_name;
	SET thisHash = SHA(CONCAT(pwd, storedSalt));
	IF thisHash = storedHash THEN
		SET result = TRUE;
		SET @currentUser = storedId;
	ELSE
		SET result = FALSE;
		SET @currentUser = NULL;
	END IF;
	RETURN result;
END; //

CREATE PROCEDURE CreateUser(
	IN u_name VARCHAR(40), IN pwd VARCHAR(100))
BEGIN
	DECLARE salt			VARCHAR(40);
	DECLARE passHash		VARCHAR(40);

	SET salt = SHA(RAND()); -- 40 random characters
	SET passHash = SHA(CONCAT(pwd, salt));
	INSERT INTO Users (
		Username,
		PassHash,
		Salt)
	VALUES (
		u_name,
		passHash,
		salt);
END; //

DELIMITER ;