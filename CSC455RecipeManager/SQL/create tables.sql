DROP TABLE Conversions;
DROP TABLE ShoppingLists;
DROP TABLE Pantries;
DROP TABLE RecipeLists;
DROP TABLE RecipeParts;
DROP TABLE Ingredients;
DROP TABLE Measurements;
DROP TABLE Recipes;
DROP TABLE Users;


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
					  Image VARCHAR(50),
					  Meal VARCHAR(15),
					  Culture VARCHAR(20),
					  PRIMARY KEY(RecipeId))
					  ENGINE=INNODB;
									  

CREATE TABLE Measurements (MeasureId INT NOT NULL,
						MeasureAbbr CHAR(15),
						MeasureName Char(15),
						PRIMARY KEY(MeasureId))
						ENGINE=INNODB;

					  
CREATE TABLE Ingredients (IngName CHAR(50) NOT NULL,
						  PreferredMeasure INT,
						  PRIMARY KEY(IngName),
						  FOREIGN KEY(PreferredMeasure) REFERENCES Measurements(MeasureId))
						  ENGINE=INNODB;

									  
CREATE TABLE RecipeParts(RecipeId INT NOT NULL,
					  PartNo INT NOT NULL,
					  IngName CHAR(50) NOT NULL,
					  PartAmount DECIMAL(10,2),
					  MeasureId INT,
					  Text VARCHAR(50),
					  PRIMARY KEY (RecipeId, PartNo),
					  FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId),
					  FOREIGN KEY (IngName) REFERENCES Ingredients(IngName))
					  ENGINE=INNODB;


CREATE TABLE RecipeLists (UserId INT NOT NULL,  
							RecipeId  INT NOT NULL,
							PRIMARY KEY (UserId),
							FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId))
							ENGINE=INNODB;


CREATE TABLE Pantries( UserId INT NOT NULL,
						IngName CHAR(50) NOT NULL,
						PantryAmount INT,
						MeasureId INT,
						PRIMARY KEY(UserId), 
						FOREIGN KEY (IngName) REFERENCES Ingredients(IngName),
						FOREIGN KEY(MeasureId) REFERENCES Measurements(MeasureId))
						ENGINE=INNODB;


CREATE TABLE ShoppingLists(UserId INT NOT NULL,
						IngName CHAR(50) NOT NULL,
						PantryAmount INT,
						MeasureId INT,
						PRIMARY KEY(UserId),
						FOREIGN KEY(MeasureId)REFERENCES Measurements(MeasureId),
						FOREIGN KEY (IngName) REFERENCES Ingredients(IngName))
						ENGINE=INNODB;

						
CREATE TABLE Conversions(OldMeasure INT NOT NULL,
						NewMeasure INT NOT NULL,
						ConvRate INT,
						PRIMARY KEY(OldMeasure,NewMeasure),
						FOREIGN KEY(OldMeasure) REFERENCES Measurements(MeasureId),
						FOREIGN KEY(NewMeasure) REFERENCES Measurements(MeasureId))
						ENGINE=INNODB;