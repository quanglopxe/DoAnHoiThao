CREATE DATABASE QL_HOITHAO;
GO
USE QL_HOITHAO;

CREATE TABLE Users (
  user_id VARCHAR(30) PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  affiliation VARCHAR(100) NOT NULL,
  role VARCHAR(50) NOT NULL,
  CHECK (role IN ('Admin', 'User'))
);

CREATE TABLE Conference (
  conference_id VARCHAR(30) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  CHECK (end_date > start_date)
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
  conference_id VARCHAR(30),
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (author_id) REFERENCES Authors(author_id),
  FOREIGN KEY (conference_id) REFERENCES Conference(conference_id)
);

CREATE TABLE RegistrationForm (
  registration_id VARCHAR(30) PRIMARY KEY,
  conference_id VARCHAR(30),
  participant_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  affiliation VARCHAR(100) NOT NULL,
  registration_date DATE NOT NULL,
  FOREIGN KEY (conference_id) REFERENCES Conference(conference_id)
);

CREATE TABLE Schedule (
  schedule_id VARCHAR(30) PRIMARY KEY,
  conference_id VARCHAR(30),
  event_name VARCHAR(100) NOT NULL,
  event_description VARCHAR(255) NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  location VARCHAR(100) NOT NULL,
  FOREIGN KEY (conference_id) REFERENCES Conference(conference_id)
);

CREATE TABLE Review (
  review_id VARCHAR(30) PRIMARY KEY,
  paper_id VARCHAR(30),
  reviewer_id VARCHAR(30),
  rating DECIMAL(3, 2),
  comments TEXT,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (paper_id) REFERENCES Paper(paper_id),
  FOREIGN KEY (reviewer_id) REFERENCES Users(user_id)
);