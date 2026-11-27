DROP TABLE IF EXISTS Votes;
DROP TABLE IF EXISTS Replies;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Bookmarks;
DROP TABLE IF EXISTS RecipeCategories;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;
DROP TYPE IF EXISTS vote;
DROP TYPE IF EXISTS role;

CREATE TYPE role AS ENUM ('admin', 'user')
CREATE TYPE vote AS ENUM ('upvote', 'downvote')

CREATE TABLE Users (
	ID SERIAL PRIMARY KEY,
	Username varchar(20) NOT NULL UNIQUE,
	Email varchar(30) NOT NULL UNIQUE,
	Fullname varchar(40) NOT NULL,
	Password varchar(20) NOT NULL,
	Role role NOT NULL
);

CREATE TABLE Categories (
	ID SERIAL PRIMARY KEY,
	Name varchar(20) UNIQUE
);

CREATE TABLE Recipes (
	ID SERIAL PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	ImagePath VARCHAR(100) NOT NULL,
	Description VARCHAR(700) NOT NULL,
	Ingredients VARCHAR(500) NOT NULL,
	Instructions VARCHAR(1000) NOT NULL,
	UserID REFERENCES Users (ID) NOT NULL,
	CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE RecipeCategories (
	RecipeID REFERENCES Recipes (ID) NOT NULL,
	CategoryID REFERENCES Categories (ID) NOT NULL
);

CREATE TABLE Bookmarks (
	UserID REFERENCES Users (ID) NOT NULL,
      RecipeID REFERENCES Recipes (ID) NOT NULL
);

CREATE TABLE Reviews (
      UserID REFERENCES Users (ID) NOT NULL,
      RecipeID REFERENCES Recipes (ID) NOT NULL,
      Comment varchar(250) NOT NULL
);

CREATE TABLE Replies (
     UserID REFERENCES Users (ID) NOT NULL,
     RecipeID REFERENCES Recipes (ID) NOT NULL,
     Comment varchar(250) NOT NULL
);

CREATE TABLE Votes (
     UserID REFERENCES Users (ID) NOT NULL NOT NULL,
     RecipeID REFERENCES Recipes (ID) NOT NULL,
     Vote vote NOT NULL
);




