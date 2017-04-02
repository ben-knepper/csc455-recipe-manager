DROP PROCEDURE IF EXISTS CreateUserRecipeList;

DELIMITER //

CREATE PROCEDURE CreateUserTables()
BEGIN
	CALL CreateUserRecipesList();
END; //

CREATE PROCEDURE CreateUserRecipeList()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS UserRecipeList;
	
	CREATE TEMPORARY TABLE UserRecipeList AS
	SELECT RecipeId, RecipeName, Image
	FROM RecipeLists NATURAL JOIN Recipes
	WHERE UserId = @currentUser;
END; //

DELIMITER ;