CREATE DATABASE SMDB;

USE SMDB;


CREATE TABLE Grade(
	GradeID INT,
	StudentsEnrolled INT,
	PRIMARY KEY(GradeID)
);

CREATE TABLE StudyStream(
	StreamID VARCHAR(30),
	StreamName VARCHAR(30),
	StudentsEnrolled INT, 
    PRIMARY KEY(StreamID)
	);
	
CREATE TABLE Section(
	SectionID VARCHAR(30),
	GradeID INT,
	StreamID CHAR(30),
	StudentsEnrolled INT,
    PRIMARY KEY(SectionID, GradeID),
    FOREIGN KEY(GradeID) REFERENCES Grade(GradeID),
    FOREIGN KEY(StreamID) REFERENCES StudyStream(StreamID)
	);
	

CREATE TABLE Course(
	SubjectID VARCHAR(30) PRIMARY KEY,
	SubjectName VARCHAR(30),
	StreamID VARCHAR(30),
	ForGrade INT,
    FOREIGN KEY(StreamID) REFERENCES StudyStream(StreamID),
    FOREIGN KEY(ForGrade) REFERENCES Grade(GradeID)
	);

CREATE TABLE Student(
	StudentID int auto_increment primary key,
	FirstName VARCHAR(30),
	MiddleName VARCHAR(30),
	LastName VARCHAR(30),
	Sex VARCHAR(30),
	GradeID INT,
	SectionID VARCHAR(30),
	StreamID VARCHAR(30),
    FOREIGN KEY (GradeID) REFERENCES Grade(GradeID),
    FOREIGN KEY (SectionID) REFERENCES Section(SectionID),
    FOREIGN KEY (StreamID) REFERENCES StudyStream(StreamID)
    );
	

CREATE TABLE Roster(
	StudentID int,
	SubjectID VARCHAR(30),
	AcademicYear INT,
	ContAssesment1 INT CHECK(ContAssesment1 <= 10),
	ContAssesment2 INT CHECK(ContAssesment2 <= 10),
	Mid INT CHECK(Mid <= 30),
	Final INT CHECK(Final <= 50),
	Total INT CHECK(Total <= 100),
	PRIMARY KEY(StudentID, SubjectID, AcademicYear),
    FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
	FOREIGN KEY(SubjectID) REFERENCES Course(SubjectID)
     );

CREATE TABLE Teacher(
	TID VARCHAR(30),
	psswrd VARCHAR(30),
    PRIMARY KEY(TID)
	);

CREATE TABLE Registrar(
	RegistrarID VARCHAR(30),
	psswrd VARCHAR(30),
    PRIMARY KEY(RegistrarID)
	);
INSERT INTO Grade VALUES(9, 100);
INSERT INTO Grade VALUES(10, 100);
INSERT INTO StudyStream VALUES('U', 'Undefined', 200);
INSERT INTO Section VALUES('A', 9, 'U', 25);
INSERT INTO Course VALUES ('B9001', 'Biology', 'U', 9);
INSERT INTO COURSE VALUES ('C1001', 'Chemistry', 'U', 10);
select * from Roster;
SELECT * from Student;
SELECT * FROM Teacher;
SELECT * FROM Registrar;
UPDATE Roster
SET Total = ContAssesment1 + ContAssesment2 + Mid + Final
WHERE (ContAssesment1 IS NOT NULL AND ContAssesment2 IS NOT NULL AND Mid IS NOT NULL AND Final IS NOT NULL);

-- BELOW IS A VIEW THAT PRESENTS STUDENTS' TOTAL SCORE ADDED FROM EVERY RESULTS THEY GET IN EVERY SUBJECT THEY LEARN IN THE SCHOOL

SELECT * FROM Student WHERE GradeID = 10 AND SectionID = 'A';

CREATE VIEW ScoreBoard AS SELECT s.StudentID, SUM(r.Total) AS TOTAL_SCORE
FROM Student s, Roster r 
WHERE s.StudentID = r.StudentID
GROUP BY s.StudentID, s.GradeID;

SELECT s.FirstName, s.MiddleName, s.LastName, r.* FROM Student s, Roster r WHERE GradeID = 9 AND SectionID = 'A';

-- BELOW IS A VIEW THAT PRESENTS STUDENT'S AVERAGE SCORE IN A DESCENDING MANNER TO SHOW THE RANK OF THE STUDENTS

CREATE VIEW StudentAverage
AS SELECT TOP '50', s.StudentID, AVG(r.Total) AS AVG_SCORE
FROM Student s, Roster r 
WHERE s.StudentID = r.StudentID
GROUP BY s.StudentID, s.GradeID
ORDER BY AVG_SCORE DESC;

SELECT * FROM Registrar;
SELECT * FROM Teacher;
SELECT * FROM Student;
SELECT * FROM Roster;

SELECT  * FROM Roster r, Student s WHERE s.GradeID in (Select * from Student where GradeID = 9);

SELECT FirstName, MiddleName, LastName FROM Student WHERE StudentID ='20';

