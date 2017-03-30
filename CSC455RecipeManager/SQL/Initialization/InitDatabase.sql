SOURCE CreateTables.sql;
SOURCE CreateRecipeTriggers.sql;
SOURCE UserProcedures.sql;
SOURCE InsertMeasurements.sql;
SOURCE InsertRecipes.sql;
SOURCE InsertRecipeParts.sql;

CALL CreateUser("user", "password");