<<<<<<< HEAD
Drop DATABASE QL_HOITHAO;
CREATE DATABASE QL_HOITHAO;
GO
USE QL_HOITHAO;
CREATE TABLE Users (
  user_id VARCHAR(30) PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  affiliation VARCHAR(100),
  country VARCHAR(100) ,
  role VARCHAR(50)  DEFAULT 'User',
  CHECK (role IN ('Admin', 'User'))
=======
CREATE DATABASE QL_HOITHAO;
GO
USE QL_HOITHAO;
use master
drop database QL_HOITHAO
CREATE TABLE Users (
  user_id VARCHAR(30) PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(200) NOT NULL,
  email VARCHAR(100) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  affiliation VARCHAR(100),
  country VARCHAR(100) NOT NULL,
  role VARCHAR(50),
  CHECK (role IN ('Admin', null))
>>>>>>> 13e90980de457b2b317f2eeb540216ceca657d05
);

CREATE TABLE Authors (
  author_id VARCHAR(30) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  affiliation VARCHAR(100) NOT NULL,
  CONSTRAINT UC_Authors_Email UNIQUE (email)
);

CREATE TABLE Paper (
  paper_id VARCHAR(30) PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  abstract TEXT NOT NULL,
  author_id VARCHAR(30),
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (author_id) REFERENCES Authors(author_id),
);


CREATE TABLE Review (
  review_id VARCHAR(30) PRIMARY KEY,
  paper_id VARCHAR(30),
  reviewer_id VARCHAR(30),
  rating INT CHECK (rating >= -3 AND rating <= 3),
  review_confident INT CHECK (review_confident >= 1 AND review_confident <= 5),
  comments TEXT,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (paper_id) REFERENCES Paper(paper_id),
  FOREIGN KEY (reviewer_id) REFERENCES Users(user_id)
);

<<<<<<< HEAD
INSERT INTO Users
VALUES
('1','quang','123','quang@gmail.com','duong thuan quang','DH CNTP','Viet Nam','Admin'),
('2','user','123','user@gmail.com','nguyen van a','DH CNTP','Viet Nam','User')
=======
>>>>>>> 13e90980de457b2b317f2eeb540216ceca657d05

select * from Users