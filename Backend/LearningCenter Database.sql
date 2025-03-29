CREATE DATABASE Center;
USE Center;

CREATE TABLE School(
    SchoolID INT AUTO_INCREMENT PRIMARY KEY,
    SchoolName CHAR(50) NOT NULL UNIQUE,
    address VARCHAR(255),
    contact VARCHAR(20) 
);

CREATE TABLE Course(
    CourseID CHAR(15) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CourseLevel INT NOT NULL
);


CREATE TABLE Teacher(
    TeacherID CHAR(10) PRIMARY KEY,
    fname CHAR(20) NOT NULL,
    lname CHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    password CHAR(20) NOT NULL, /* should encrypt for security */
    CourseTeaching CHAR(15),
    Wage INT,
    NoYearsTeaching INT NOT NULL,
    contact VARCHAR(20) NOT NULL,
    SchoolID INT,
    Principal INT,
    FOREIGN KEY (Principal) REFERENCES School(SchoolID),
    FOREIGN KEY (CourseTeaching) REFERENCES Course(CourseID),
    FOREIGN KEY (SchoolID) REFERENCES School(SchoolID)
);
CREATE TABLE Student(
    StudentID CHAR(8) PRIMARY KEY,
    Email VARCHAR(255) NOT NULL,
    password CHAR(20) NOT NULL, 
    fname CHAR(10) NOT NULL,
    lname CHAR(10) NOT NULL,
    ParentID CHAR(10),
    GradeLVL INT NOT NULL,
    SchoolID INT,
    SiblingID CHAR(8),
    FOREIGN KEY (ParentID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (SchoolID) REFERENCES School(SchoolID),
    FOREIGN KEY (SiblingID) REFERENCES Student(StudentID)
);


CREATE TABLE Assignment(
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    Assignment_Name CHAR(20) UNIQUE,
    CourseID CHAR(15),
    TeacherID CHAR(10),
    Due_date DATE,
    Graded BOOLEAN NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE,
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID)
);

CREATE TABLE StudentCourses(
    StudentID CHAR(8),
    CourseID CHAR(15),
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Grade(
    GradeValue FLOAT,
    StudentID CHAR(8),
    AssignmentID INT,
    PRIMARY KEY (StudentID, AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID) ON DELETE CASCADE
);

INSERT INTO School(SchoolName)
VALUES('School01'),('School02');

INSERT INTO Course(CourseID,CourseName,CourseLevel)
VALUES('Database_001','Database Systems',2),
('DataStruct_002','Data Structures',1),
('Linear_001','Linear Algebra',3),
('Discrete_001','Discrete Maths',1);

INSERT INTO Teacher(TeacherID,fname,Email,password,CourseTeaching,Wage,NoYearsTeaching,contact,SchoolID)
VALUES('2024tea001','Teacher01','24teach01@mail.com','teach001','Database_001',200,2,'01-111-111',1),
('2024tea002','Teacher02','24teach02@mail.com','teach002','Database_001',2000,10,'02-222-222',2),
('2024tea003','Teacher03','24teach03@mail.com','teach003','DataStruct_002',100,1,'01-743-237',1),
('2024tea004','Teacher04','24teach04@mail.com','teach004','Linear_001',700,7,'01-732-287',1),
('2024tea005','Teacher05','24teach05@mail.com','teach005','Discrete_001',700,2,'01-737-353',2),
('2024tea006','Teacher06','24teach06@mail.com','teach006','Discrete_001',200,2,'01-737-453',2);

INSERT INTO Student(StudentID,Email,password,fname,lname,ParentID,GradeLVL,SchoolID)
VALUES('24stud01','24stud01@mail.com','123','stud01','lname01','2024tea001',11,1),
('24stud02','24stud02@mail.com','123','stud02','lname02','2024tea002',10,1),
('24stud03','24stud03@mail.com','123','stud03','lname03',NULL,10,2),
('24stud04','24stud04@mail.com','123','stud04','lname04',NULL,10,2),
('24stud05','24stud05@mail.com','123','stud05','lname05',NULL,12,2),
('24stud06','24stud06@mail.com','123','stud06','lname06','2024tea001',10,1);

INSERT INTO Assignment(
    Assignment_Name,
    CourseID,
    TeacherID ,
    Due_date,
    Graded)
VALUES('HW Database','Database_001','2024tea001','11/11/24',TRUE),
('HW Linear','Linear_001','2024tea004','11/11/24',TRUE);
INSERT INTO StudentCourses(StudentID,CourseID)
VALUES('24stud01','Database_001'),
('24stud02','Database_001'),
('24stud04','Database_001'),
('24stud01','Linear_001'),
('24stud03','Linear_001');
INSERT INTO GRADE(GradeValue,StudentID,AssignmentID)
VALUES(12,'24stud01',1),
(13,'24stud01',2),
(16,'24stud02',1),
(13,'24stud03',2),
(10,'24stud04',1);

