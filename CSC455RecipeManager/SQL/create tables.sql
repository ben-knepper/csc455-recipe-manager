drop table IF EXISTS Conversion;
drop table IF EXISTS ShoppingLists;
drop table IF EXISTS Pantries;
drop table IF EXISTS RecipesLists;
drop table IF EXISTS RecipesParts;
drop table IF EXISTS Measurements;
drop table IF EXISTS Ingredients;
drop table IF EXISTS Recipes;
drop table IF EXISTS Users;


CREATE TABLE Users (UserId INT NOT NULL,
					Username VARCHAR(20) NOT NULL,
					PassHash VARCHAR(30) NOT NULL,
					Salt CHAR (60),
					PRIMARY KEY(UserId),
					INDEX(Username(20)) ENGINE=INNODB;

							
CREATE TABLE Recipes (RecipeId INT NOT NULL,
					  RecipeName VARCHAR(50),
					  Description TEXT,
					  Instruction TEXT,
					  Yield VARCHAR(50),
					  DateCreated DATE,
					  Image BLOB,
					  Meal VARCHAR(15),
					  Culture VARCHAR(20),
					  PRIMARY KEY(RecipeId),
					  INDEX(RecipeName(10)) ENGINE=INNODB;

					  
CREATE TABLE Ingredients (IngName CHAR(50) NOT NULL,
						  PreferredMeasure INT,
						  PRIMARY KEY(IngName),
						  FOREIGN KEY(PreferredMeasure) REFERENCES Recipes(RecipeId))ENGINE=INNODB;
									  

CREATE TABLE Measurements (MeasureId INT NOT NULL,
						MeasureAbbr CHAR(15),
						MeasureName Char(15),
						PRIMARY KEY(MeasureId))ENGINE=INNODB;

									  
CREATE TABLE RecipeParts(RecipeId INT NOT NULL,
					  PartNo INT,
					  IngName CHAR(50),
					  PartAmount DECIMAL(10,2),
					  MeasureId INT,
					  Text VARCHAR(50),
					  PRIMARY KEY (RecipeId, PartNo),
					  FOREIGN KEY (RecipeId) REFERENCES Receipes(RecipeId),
					  FOREIGN kEY (IngId) REFERENCES Receipes(IngId)) ENGINE=INNODB;


CREATE TABLE RecipesLists (UserId INT,  
							RecipeId  INT,
							PRIMARY KEY (UserId),
							FOREIGN kEY (RecipeId) REFERENCES Receipes(RecipeId))ENGINE=INNODB;


CREATE TABLE Pantries( UserId INT,
						IngName CHAR(50),
						PantryAmount INT,
						MeasureId INT,
						PRIMARY KEY(UserId), 
						FOREIGN KEY (IngId) REFERENCES Receipes(IngId),
						FOREIGN KEY(MeasureId)REFERENCES Measurements(MeasureId))ENGINE=INNODB;


CREATE TABLE ShoppingLists(UserId INT,
						IngName CHAR(50),
						PantryAmount INT,
						MeasureId INT,
						PRIMARY KEY(UserId),
						FOREIGN KEY(MeasureId)REFERENCES Measurements(MeasureId),
						FOREIGN KEY (IngId) REFERENCES Receipes(IngId))ENGINE=INNODB;

						
CREATE TABLE Conversions(OldMeasure INT,
						NewMeasure INT,
						ConvRate INT,
						PRIMARY KEY(OldMeasure,NewMeasure),
						FOREIGN KEY(OldMeasure) REFERENCES Measurements(MeasureId),
						FOREIGN KEY(NewMeasure) REFERENCES Measurements(MeasureId))ENGINE=INNODB;