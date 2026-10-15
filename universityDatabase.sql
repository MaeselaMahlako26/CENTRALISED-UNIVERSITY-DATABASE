DROP TABLE Enrolment cascade CONSTRAINTS;
DROP TABLE Teaching_Record CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Instructor CASCADE CONSTRAINTS;
DROP TABLE Subject CASCADE CONSTRAINTS;
DROP TABLE Class CASCADE CONSTRAINTS;
DROP TABLE Department CASCADE CONSTRAINTS;
-- 1. DEPARTMENT TABLE
CREATE TABLE Department (
    DepartmentID NUMBER PRIMARY KEY,
    DepartmentName VARCHAR2(100) NOT NULL
);

-- 2. CLASS TABLE
CREATE TABLE Class (
    ClassID NUMBER PRIMARY KEY,
    ClassName VARCHAR2(100) NOT NULL
);

-- 3. SUBJECT TABLE
CREATE TABLE Subject (
    SubjectID NUMBER PRIMARY KEY,
    SubjectName VARCHAR2(100) NOT NULL,
    DepartmentID NUMBER NOT NULL,
    CONSTRAINT fk_subject_department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

-- 4. INSTRUCTOR TABLE
CREATE TABLE Instructor (
    InstructorID NUMBER PRIMARY KEY,
    InstructorName VARCHAR2(100) NOT NULL,
    DepartmentID NUMBER NOT NULL,
    CONSTRAINT fk_instructor_department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

-- 5. STUDENT TABLE
CREATE TABLE Student (
    StudentID NUMBER PRIMARY KEY,
    StudentName VARCHAR2(100) NOT NULL,
    DepartmentID NUMBER NOT NULL,
    ClassID NUMBER NOT NULL,
    CONSTRAINT fk_student_department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID),
    CONSTRAINT fk_student_class
        FOREIGN KEY (ClassID)
        REFERENCES Class(ClassID)
);

-- 6. ENROLMENT TABLE
CREATE TABLE Enrolment (
    EnrolmentID NUMBER PRIMARY KEY,
    StudentID NUMBER NOT NULL,
    SubjectID NUMBER NOT NULL,
    CONSTRAINT fk_enrolment_student
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    CONSTRAINT fk_enrolment_subject
        FOREIGN KEY (SubjectID)
        REFERENCES Subject(SubjectID)
);

-- 7. TEACHING_RECORD TABLE
CREATE TABLE Teaching_Record (
    TeachingRecordID NUMBER PRIMARY KEY,
    InstructorID NUMBER NOT NULL,
    SubjectID NUMBER NOT NULL,
    CONSTRAINT fk_teaching_instructor
        FOREIGN KEY (InstructorID)
        REFERENCES Instructor(InstructorID),
    CONSTRAINT fk_teaching_subject
        FOREIGN KEY (SubjectID)
        REFERENCES Subject(SubjectID)
);
-- Insert departments
INSERT INTO Department
VALUES (1, 'Information Technology');

INSERT INTO Department
VALUES (2, 'Engineering');

-- Insert classes
INSERT INTO Class
VALUES (1, 'Group C1');

INSERT INTO Class
VALUES (2, 'Group C2');

-- Insert subjects
INSERT INTO Subject
VALUES (101, 'System Software', 1);

INSERT INTO Subject
VALUES (102, 'Programming', 1);

-- Insert instructors
INSERT INTO Instructor
VALUES (201, 'Mr Dlamini', 1);

INSERT INTO Instructor
VALUES (202, 'Ms Mokoena', 2);

-- Insert students
INSERT INTO Student
VALUES (301, 'Thandi Maseko', 1, 1);

INSERT INTO Student
VALUES (302, 'Lebo Nkosi', 1, 2);

-- Insert enrolments
INSERT INTO Enrolment
VALUES (401, 301, 101);

INSERT INTO Enrolment
VALUES (402, 302, 102);

-- Insert teaching records
INSERT INTO Teaching_Record
VALUES (501, 201, 101);

INSERT INTO Teaching_Record
VALUES (502, 202, 102);

COMMIT;
SELECT * FROM Department;
SELECT * FROM Class;
SELECT * FROM Subject;
SELECT * FROM Instructor;
SELECT * FROM Student;
SELECT * FROM Enrolment;
SELECT * FROM Teaching_Record;
SELECT
    s.StudentID,
    s.StudentName,
    d.DepartmentName,
    c.ClassName
FROM Student s
JOIN Department d
    ON s.DepartmentID = d.DepartmentID
JOIN Class c
    ON s.ClassID = c.ClassID;