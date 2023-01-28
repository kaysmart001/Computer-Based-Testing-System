-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2013 at 06:56 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7


CREATE DATABASE IF NOT EXISTS epiz_33070717_cbttest_db;
USE epiz_33070717_cbttest_db;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";



-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE Student;
-- DROP TABLE Administrator;
-- DROP TABLE Examiner;
-- DROP TABLE Course_Examiner;
-- DROP TABLE Course_Student;
-- DROP TABLE Course;
-- DROP TABLE Exam;
-- DROP TABLE Question;
-- DROP TABLE Student_Result;


-- Create the required tables

CREATE TABLE IF NOT EXISTS Student (
    username VARCHAR(15) PRIMARY KEY NOT NULL,
    firstName CHAR(100) NOT NULL,
    lastName CHAR(100) NOT NULL,
    imageUrl VARCHAR(255),
    gender VARCHAR(50),
    pw VARCHAR(255) NOT NULL -- password
);


CREATE TABLE IF NOT EXISTS Administrator (
    username VARCHAR(255) PRIMARY KEY NOT NULL DEFAULT "admin",
    firstName CHAR(100) NOT NULL DEFAULT "Admin",
    lastName CHAR(100) NOT NULL DEFAULT "Admin",
    imageUrl VARCHAR(255) DEFAULT "/images/admin.png",
    pw VARCHAR(255) NOT NULL DEFAULT "$2y$10$B9gGv1ohRO.KubkLY1gyGuwmc0.SNdBYMME8cYsuvVDpC6YdBwNny" -- password
);

CREATE TABLE IF NOT EXISTS Examiner (
    username VARCHAR(255) PRIMARY KEY NOT NULL,
    firstName CHAR(100) NOT NULL,
    lastName CHAR(100) NOT NULL,
    imageUrl VARCHAR(255),
    gender VARCHAR(50),
    pw VARCHAR(255) NOT NULL -- password

);


CREATE TABLE IF NOT EXISTS Course (
    courseId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    courseTitle VARCHAR(255) NOT NULL,
    courseCode VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Exam (
    examId INT PRIMARY KEY AUTO_INCREMENT,
    instruction VARCHAR(255),
    timeDuration TIME NOT NULL,
    activated BOOLEAN DEFAULT FALSE NOT NULL,
    createdAt DATETIME NOT NULL,
    lastModified DATETIME NOT NULL,
    courseId INT,
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
);


CREATE TABLE IF NOT EXISTS Question (
    questionId INT PRIMARY KEY AUTO_INCREMENT,
    question TEXT NOT NULL,
    option1 VARCHAR(255) NOT NULL,
    option2 VARCHAR(255) NOT NULL,
    option3 VARCHAR(255) NOT NULL,
    option4 VARCHAR(255) NOT NULL,
    option5 VARCHAR(255), -- optional 
    answer VARCHAR(255) NOT NULL,
    examId INT,
    FOREIGN KEY (examId) REFERENCES Exam(examId)
);


CREATE TABLE IF NOT EXISTS Student_Result (
    studentId VARCHAR(255) NOT NULL,
    examId INT NOT NULL,
    score INT NOT NULL,
    scoreOverall INT NOT NULL,
    submitTime DATETIME NOT NULL,
    FOREIGN KEY (studentId) REFERENCES Student(username),
    FOREIGN KEY (examId) REFERENCES Exam(examId),
    PRIMARY KEY (studentId, examId)
);



-- Intermediary table for Course and Student 
CREATE TABLE IF NOT EXISTS Course_Student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(15) ,
    courseId INT,
    FOREIGN KEY (username) REFERENCES Student(username),
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
);

-- Intermediary table for Course and Examiner 
CREATE TABLE IF NOT EXISTS Course_Examiner (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255),
    courseId INT,
    FOREIGN KEY (username) REFERENCES Examiner(username),
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
);

SHOW TABLES;

-- DESCRIBE Student;
-- DESCRIBE Administrator;
-- DESCRIBE Examiner;
-- DESCRIBE Course_Examiner;
-- DESCRIBE Course_Student;
-- DESCRIBE Course;
-- DESCRIBE Exam;
-- DESCRIBE Question;
-- DESCRIBE Student_Result;


-- Load Student Data from CSV file
LOAD DATA
LOCAL INFILE "/var/www/html/chi/models/students.csv"
INTO TABLE Student
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;

-- SELECT * FROM Student;
-- Load Examiner Data from CSV file
LOAD DATA
LOCAL INFILE "/var/www/html/chi/models/examiners.csv"
INTO TABLE Examiner
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;
-- SELECT * FROM Examiner;

INSERT INTO Administrator VALUES ();
-- SELECT * FROM Administrator;

-- Load Course Data from CSV file
LOAD DATA
LOCAL INFILE "/var/www/html/chi/models/courses.csv"
INTO TABLE Course
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(courseTitle, courseCode);
-- SELECT * FROM Course;

-- Load Exam Data from CSV file
LOAD DATA
LOCAL INFILE "/var/www/html/chi/models/examination.csv"
INTO TABLE Exam
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(instruction, timeDuration, activated, createdAt, lastModified, courseId)
;

-- SELECT * FROM Exam;
-- Load Question Data from CSV file
LOAD DATA
LOCAL INFILE "/var/www/html/chi/models/questions.csv"
INTO TABLE Question
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(question,option1,option2,option3,option4,option5,answer,examId);
-- SELECT * FROM Question;

LOAD DATA
LOCAL INFILE "/var/www/html/chi/models/course-examiner.csv"
INTO TABLE Course_Examiner
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(username, courseId );
-- SELECT * FROM Course_Examiner;

LOAD DATA
LOCAL INFILE "/var/www/html/chi/models/course-student.csv"
INTO TABLE Course_Student
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(username, courseId );

-- SELECT * FROM Course_Student;
-- The courses a student is offering
SELECT Course.courseCode, courseTitle, instruction, timeDuration, activated, createdAt, lastModified, Exam.courseId
FROM Course, Course_Student, Exam
WHERE Course.courseId =  Course_Student.id AND Course.courseId = Exam.courseId  ;
