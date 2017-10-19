CREATE DATABASE MelonDb;
GO

USE MelonDb;
GO

-- Create the customer and order tables
CREATE TABLE Song(
  SongID bigint NOT NULL PRIMARY KEY,
  SongName varchar(50) NOT NULL,
  Track# varchar(50) NOT NULL,
  SongLength time Not NULL,
  AlbumID bigint NOT NULL FOREIGN KEY,
  ArtistID bigint NOT NULL FOREIGN KEY);

CREATE TABLE Artist(
  ArtistID bigint NOT NULL PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  NameofAgency varchar(50) NOT NULL,
  SongID bigint NOT NULL FOREIGN KEY,
  AlbumID bigint NOT NULL FOREIGN KEY);

CREATE TABLE Album(
  AlbumID bigint NOT NULL PRIMARY KEY,
  AlbumName bigint NOT NULL,
  CourseID bigint NOT NULL,
  Grade float NOT NULL);

-- Create the relationship: the first FK in CourseEnrollment
ALTER TABLE CourseEnrollment ADD CONSTRAINT FK_CourseEnrollment_Student 
FOREIGN KEY (StudentId) REFERENCES Student(StudentID);
GO

-- We will use designer view to create another relationship: the second FK in CourseEnrollment


-- Add a few students
INSERT INTO Student (StudentID, FirstName, LastName) VALUES 
(1, 'Jason', 'Lee'),
(2, 'Evan', 'Lehrman'),
(3, 'Yating', 'Lu'),
(4, 'Erica', 'Fishberg'),
(5, 'Jamie', 'Traverso'),
(6, 'Kyle', 'Waldron'),
(7, 'Nadira', 'Zahiruddin'),
(8, 'Justin', 'Lee'),
(9, 'Christine', 'Lee'),
(10, 'Abbygail', 'Sardjono');


-- Add a few courses
INSERT INTO Course(CourseID, CourseTitle, Instuctor) VALUES 
(1, 'MIS3545-BUSINESS INTELLIGENCE AND DATA ANALYTICS', 'Zhi'),
(2, 'MIS3690-WEB TECHNOLOGIES', 'Shankar'),
(3, 'QTM3000-CASE STUDIES IN BUSINESS ANALYTICS', 'Nathan'),
(4, 'QTM3625-FINANCIAL SIMULATION', 'Dessi'),
(5, 'SME2012-MANAGING INFORMATION TECH AND SYSTEMS', 'Clare');
GO

-- Delete the SME course
DELETE FROM Course
WHERE CourseTitle like 'SME%';
GO 


-- We will use data view to add grade data

-- Some queries
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM CourseEnrollment;

SELECT FirstName, LastName, CourseID, Grade
FROM Students Join CourseEnrollment
on Student.StudentID = CourseEnrollment.StudentID
WHERE LastName = 'Lee'

-- Create a handy view summarizing students' grades
CREATE VIEW vwStudentGradeSummary WITH SCHEMABINDING AS
 SELECT
   s.StudentID, s.FirstName, s.LastName, 
   ISNULL(COUNT(ce.CourseID), 0) AS NumberOfCourses,
   ISNULL(SUM(ce.Grade), 0) AS TotalGrade
  FROM
   dbo.Student AS s
   LEFT OUTER JOIN dbo.CourseEnrollment AS ce ON s.StudentID = ce.StudentId
  GROUP BY
   s.StudentID, s.FirstName, s.LastName
GO


SELECT * FROM vwStudentGradeSummary;