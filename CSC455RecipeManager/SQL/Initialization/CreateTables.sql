DROP TABLE IF EXISTS Conversions;
DROP TABLE IF EXISTS ShoppingLists;
DROP TABLE IF EXISTS Pantries;
DROP TABLE IF EXISTS RecipeLists;
DROP TABLE IF EXISTS RecipeParts;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS Measurements;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Users;


CREATE TABLE Users (UserId INT NOT NULL,
					Username VARCHAR(20) NOT NULL,
					PassHash VARCHAR(30) NOT NULL,
					Salt CHAR (60),
					PRIMARY KEY(UserId))
					ENGINE=INNODB;

							
CREATE TABLE Recipes (RecipeId INT NOT NULL,
					  RecipeName VARCHAR(50),
					  Description TEXT,
					  Instruction TEXT,
					  Yield VARCHAR(50),
					  DateCreated DATE,
					  Image BLOB,
					  Meal VARCHAR(15),
					  Culture VARCHAR(20),
					  PRIMARY KEY(RecipeId))
					  ENGINE=INNODB;
									  

CREATE TABLE Measurements (MeasureName CHAR(15) NOT NULL,
						MeasureAbbr VARCHAR(15),
						PRIMARY KEY(MeasureName))
						ENGINE=INNODB;

					  
CREATE TABLE Ingredients (IngName CHAR(50) NOT NULL,
						  PreferredMeasure CHAR(15),
						  PRIMARY KEY(IngName),
						  FOREIGN KEY(PreferredMeasure) REFERENCES Measurements(MeasureName))
						  ENGINE=INNODB;

									  
CREATE TABLE RecipeParts(RecipeId INT NOT NULL,
					  PartNo INT NOT NULL,
					  IngName CHAR(50) NOT NULL,
					  PartAmount DECIMAL(10,2),
					  MeasureName CHAR(15),
					  Text VARCHAR(50),
					  PRIMARY KEY (RecipeId, PartNo),
					  FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId),
					  FOREIGN KEY (IngName) REFERENCES Ingredients(IngName),
					  FOREIGN KEY (MeasureName) REFERENCES Measurements(MeasureName))
					  ENGINE=INNODB;


CREATE TABLE RecipeLists (UserId INT NOT NULL,  
							RecipeId  INT NOT NULL,
							PRIMARY KEY (UserId),
							FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId))
							ENGINE=INNODB;


CREATE TABLE Pantries( UserId INT NOT NULL,
						IngName CHAR(50) NOT NULL,
						PantryAmount INT,
						MeasureName CHAR(15),
						PRIMARY KEY(UserId), 
						FOREIGN KEY (IngName) REFERENCES Ingredients(IngName),
						FOREIGN KEY(MeasureName) REFERENCES Measurements(MeasureName))
						ENGINE=INNODB;


CREATE TABLE ShoppingLists(UserId INT NOT NULL,
						IngName CHAR(50) NOT NULL,
						PantryAmount INT,
						MeasureName CHAR(15),
						PRIMARY KEY(UserId),
						FOREIGN KEY(MeasureName)REFERENCES Measurements(MeasureName),
						FOREIGN KEY (IngName) REFERENCES Ingredients(IngName))
						ENGINE=INNODB;

						
CREATE TABLE Conversions(OldMeasure CHAR(15) NOT NULL,
						NewMeasure CHAR(15) NOT NULL,
						ConvRate INT,
						PRIMARY KEY(OldMeasure,NewMeasure),
						FOREIGN KEY(OldMeasure) REFERENCES Measurements(MeasureName),
						FOREIGN KEY(NewMeasure) REFERENCES Measurements(MeasureName))
						ENGINE=INNODB;