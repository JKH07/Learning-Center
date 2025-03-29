--QUERY_1--
/*select all teachers who  have same wage and noofyearsteaching combo*/
SELECT TeacherID,Wage,NoYearsTeaching FROM Teacher WHERE (Wage,NoYearsTeaching)IN(
    SELECT Wage,NoYearsTeaching FROM Teacher
    GROUP BY Wage,NoYearsTeaching
    HAVING COUNT(*)>1
);

--QUERY_2--
/*get grade for each assignment and respective student*/
SELECT s.StudentID, g.AssignmentID,g.GradeValue
FROM (Student s JOIN Grade g ON s.StudentID = g.StudentID);
--QUERY_3--
/*Return highest paid teacher in every school*/
SELECT TeacherID,SchoolID,Wage From Teacher t WHERE Wage IN
(
    SELECT MAX(Wage) FROM Teacher
    WHERE SchoolID=t.SchoolID
)

--QUERY_4--
/*Get all failing students in a course*/
SELECT g.StudentID,CourseID,GradeValue 
FROM(Grade g Join Studentcourses s ON s.studentid=g.studentid)
WHERE GradeValue<11;
--QUERY 5--
/*CALCULATE AVG GRADE FOR all sTUDENTS */
SELECT AVG(GradeValue),studentid FROM Grade g WHERE StudentID IN(
    SELECT StudentID FROM StudentCourses
    WHERE StudentID=g.StudentID 
)GROUP BY StudentID

--QUERY_6--
/*get todo for each student*/
SELECT DISTINCT studentid,Assignment_Name 
FROM(studentcourses s JOIN assignment a ON a.CourseID=s.courseid);

--QUERY_7--
/*GET courses with more than one teacher*/
SELECT COUNT(a.TeacherID), b.CourseID 
FROM (Teacher a JOIN Course b ON a.CourseTeaching = b.CourseID)
GROUP BY courseid
HAVING COUNT(Teacherid)>1
;

--QUERY_8--
/*SELECT ALL SCHOOLS That involve Teacher named ='' either as a teacher or a principal*/
SELECT SchoolID FROM School s WHERE SchoolID IN(
    SELECT SchoolID FROM Teacher 
    WHERE fname='Teacher01' AND SchoolID=s.SchoolID
)OR SchoolID IN(
    SELECT SchoolID FROM Teacher 
    WHERE fname='Teacher01' AND SchoolID=s.SchoolID AND Principal=s.SchoolID
)

--QUERY_9--
/*Find top student */
SELECT MAX(avg_grade), studentid 
FROM ( SELECT StudentID, AVG(GradeValue) AS avg_grade 
FROM Grade GROUP BY StudentID ) AS StudentAvgGrades 
WHERE StudentID IN ( SELECT StudentID FROM StudentCourses );

--QUERY_10--
/*find number of students in each course*/
SELECT COUNT(StudentID),CourseID
FROM studentcourses
GROUP BY CourseID
HAVING CourseID=CourseID;