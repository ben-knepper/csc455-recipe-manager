drop table IF EXISTS Conversion;
drop table IF EXISTS ShoppingLists;
drop table IF EXISTS Pantries;
drop table IF EXISTS RecipesLists;
drop table IF EXISTS RecipesPart;
drop table IF EXISTS Measurements;
drop table IF EXISTS Ingredient;
drop table IF EXISTS Recipes;
drop table IF EXISTS Users;


CREATE TABLE Users (UserId INT NOT NULL,
					Username VARCHAR(20) NOT NULL,
					PassHash VARCHAR(30) NOT NULL,
					Salt CHAR (32)
					PRIMARY KEY(UserId)) ENGINE=INNODB;

							
CREATE TABLE Recipes (RecipeId INT NOT NULL,
					  RecipeName VARCHAR(20),
					  Servings INT,
					  Time TEXT,
					  Desciprtion TEXT,
					  Instruction TEXT,
					  DateCreated DATE,
					  Image BLOB,
					  Meal VARCHAR(15),
					  Culture VARCHAR(20),
					  PRIMARY KEY(RecipeId)) ENGINE=INNODB;


					  
CREATE TABLE Ingredients (IngId INT NOT NULL,
						  IngName VARCHAR(30),
						  PRIMARY KEY(IngId))ENGINE=INNODB;
									  

CREATE TABLE Measurements (MeasureId INT NOT NULL,
						MeasureAbbr CHAR(15),
						MeasureName Char(15),
						PRIMARY KEY(MeasureId))ENGINE=INNODB;

									  
CREATE TABLE RecipesParts(RecipeId INT NOT NULL,
					  PartNo INT,
					  IngId INT,
					  PartAmount DECIMAL(10,2),
					  MeasureId INT,
					  PRIMARY KEY (RecipeId,PartNo),
					  FOREIGN KEY (RecipeId) REFERENCES Receipes(RecipeId),
					  FOREIGN kEY (IngId) REFERENCES Receipes(IngId)) ENGINE=INNODB;


CREATE TABLE RecipesLists (UserId INT,  
							RecipeId  INT,
							PRIMARY KEY (UserId),
							FOREIGN kEY (RecipeId) REFERENCES Receipes(RecipeId))ENGINE=INNODB;

CREATE TABLE Pantries( UserId INT,
						IngId INT,
						PantryAmount INT,
						MeasureId INT,
						PRIMARY KEY(UserId), 
						FOREIGN KEY (IngId) REFERENCES Receipes(IngId),
						FOREIGN KEY(MeasureId)REFERENCES Measurements(MeasureId))ENGINE=INNODB;



CREATE TABLE ShoppingLists(UserId INT,
						IngId INT,
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