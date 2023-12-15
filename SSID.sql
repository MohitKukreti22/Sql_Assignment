

--  CREATING DATABASE AND TABLES

CREATE DATABASE SISDB;

--  Use the "SISDB" database
USE SISDB;

--  Define the schema for the Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(15)
);


--  Define the schema for the Teacher table
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);



--  Define the schema for the Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- Define the schema for the Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


--  Define the schema for the Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);



-- INSERTING DATA INTO THESE TABLES

INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES
 (1, 'Raj', 'Kumar', '1988-05-10', 'raj.kumar@email.com', '456-789-0123'),
 (2, 'Priya', 'Sharma', '1992-11-28', 'priya.sharma@email.com', '789-012-3456'),
 (3, 'Amit', 'Patel', '1985-07-17', 'amit.patel@email.com', '234-567-8901'),
 (4, 'Deepika', 'Verma', '1993-03-05', 'deepika.verma@email.com', '890-123-4567'),
 (5, 'Sandeep', 'Singh', '1980-09-03', 'sandeep.singh@email.com', '567-890-1234'),
 (6, 'Ananya', 'Gupta', '1997-12-18', 'ananya.gupta@email.com', '123-456-7890'),
 (7, 'Rahul', 'Mishra', '1989-06-25', 'rahul.mishra@email.com', '987-654-3210'),
 (8, 'Pooja', 'Joshi', '1994-04-30', 'pooja.joshi@email.com', '456-789-0123'),
 (9, 'Vikram', 'Rajput', '1983-10-12', 'vikram.rajput@email.com', '789-012-3456'),
 (10,'Aishwarya', 'Gupta', '1994-12-18', 'aishwarya.gupta@email.com', '123-456-7890');

 INSERT INTO Teacher (teacher_id, first_name, last_name, email)
VALUES
  (1, 'Professor', 'Navin', 'prof.navin@email.com'),
  (2, 'Dr.', 'Shweta', 'dr.shweta@email.com'),
  (3, 'Mr.', 'Anoop', 'mr.anoop@email.com'),
  (4, 'Ms.', 'Rohan', 'ms.rohan@email.com');

INSERT INTO Courses (course_id, course_name, credits, teacher_id)
VALUES
  (101, 'Mathematics', 3, 1),
  (102, 'Physics', 4, 2),
  (103, 'Computer Science', 3, 3),
  (104, 'History', 3, 1),
  (105, 'English Literature', 4, 4),
  (106, 'Chemistry', 3, 2),
  (107, 'Economics', 3, 3),
  (108, 'Biology', 4, 2),
  (109, 'Psychology', 3, 4),
  (110, 'Sociology', 3, 1);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES
  (1, 1, 101, '2023-01-15'),
  (2, 2, 102, '2023-01-20'),
  (3, 3, 103, '2023-02-01'),
  (4, 4, 104, '2023-02-05'),
  (5, 5, 105, '2023-02-10'),
  (6, 6, 106, '2023-02-15'),
  (7, 7, 107, '2023-02-20'),
  (8, 8, 108, '2023-03-01'),
  (9, 9, 109, '2023-03-05'),
  (10, 10, 110, '2023-03-10');



INSERT INTO Payments (payment_id, student_id, amount, payment_date)
VALUES
  (1, 1, 500.00, '2023-02-01'),
  (2, 2, 600.00, '2023-02-05'),
  (3, 3, 550.00, '2023-02-10'),
  (4, 4, 700.00, '2023-02-15'),
  (5, 5, 800.00, '2023-02-20'),
  (6, 6, 450.00, '2023-03-01'),
  (7, 7, 600.00, '2023-03-05'),
  (8, 8, 700.00, '2023-03-10'),
  (9, 9, 550.00, '2023-03-15'),
  (10, 10, 750.00, '2023-03-20');




 

-- Insert a new student into the "Students" table
INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES (11, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');



-- Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.


INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES (11, 11, 105, '2023-11-28');
Select * from Enrollments;     


--- Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.


UPDATE Teacher SET email = 'navin.prof@example.com' WHERE teacher_id = 1;


--- Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on student and course.

DELETE FROM Enrollments
WHERE student_id = 11 AND course_id = 105;


--- Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.


UPDATE Courses SET teacher_id = 2 WHERE course_id = 101;


-- Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)VALUES (11, 11, 105, '2023-11-28');

DELETE FROM Enrollments WHERE student_id = 11;
    
DELETE FROM Students WHERE student_id = 11;


-- Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.

UPDATE Payments SET amount = 1200.00 WHERE payment_id = 1;





--- JOINS

---Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's

SELECT s.student_id, s.first_name, s.last_name, SUM(p.amount) AS total_payments FROM Students s
JOIN Payments p ON s.student_id = p.student_id WHERE s.student_id = 2
GROUP BY s.student_id, s.first_name, s.last_name;



--- Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.

SELECT c.course_id, c.course_name, COUNT(e.student_id) AS enrolled_students FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

SELECT c.course_id, c.course_name, COUNT(e.student_id) AS enrolled_students FROM Courses c
RIGHT JOIN  Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments

SELECT s.student_id, s.first_name, s.last_name FROM Students s LEFT JOIN Enrollments e ON s.student_id = e.student_id WHERE e.enrollment_id IS NULL;

INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES (11, 'Mohit', 'Kukreti', '2001-01-01', 'mohitkukreti@example.com', '1234567890');

INSERT INTO Payments (payment_id, student_id, amount, payment_date)
VALUES(11, 11, 4000, '2023-11-28');


--- Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.

SELECT s.first_name, s.last_name, c.course_name FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table

SELECT t.first_name AS teacher_first_name, t.last_name AS teacher_last_name, c.course_name FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id;

-- Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables.

SELECT s.first_name, s.last_name, e.enrollment_date FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_id = 101;

-- Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.

INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES (12, 'Sumit', 'Nawni', '1999-08-15', 'sumitnawa@gmail.com', '987654321');


SELECT s.first_name, s.last_name FROM Students s LEFT JOIN Payments p ON s.student_id = p.student_id WHERE p.payment_id IS NULL;


-- Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.

INSERT INTO Courses (course_id, course_name, credits, teacher_id)
VALUES(111, 'Physical Education', 3, 4);


SELECT c.course_id, c.course_name FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id WHERE e.enrollment_id IS NULL;

---- Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.*/

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES
  (11, 11, 101, '2023-05-01'),  
  (12, 11, 102, '2023-05-15'),  
  (13, 11, 103, '2023-06-01');  
 

SELECT DISTINCT s.student_id, s.first_name, s.last_name FROM Enrollments e1
JOIN Enrollments e2 ON e1.student_id = e2.student_id AND e1.enrollment_id <> e2.enrollment_id
JOIN Students s ON e1.student_id = s.student_id;

SELECT * FROM Enrollments;

--- Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.

INSERT INTO Teacher (teacher_id, first_name, last_name, email)
VALUES(5, 'subham', 'negi', 'negiji.sub@email.com');


SELECT t.teacher_id, t.first_name, t.last_name FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id WHERE c.course_id IS NULL;




--- AGGREGATE FUNCTIONS AND SUBQUERIES:

---Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.

SELECT c.course_id, c.course_name, AVG(enrollment_count) AS average_students_enrolled FROM Courses c JOIN (
SELECT course_id, COUNT(student_id) AS enrollment_count FROM Enrollments
GROUP BY course_id) e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.

SELECT s.student_id, s.first_name, s.last_name, p.amount AS highest_payment FROM Students s
JOIN Payments p ON s.student_id = p.student_id WHERE p.amount = (SELECT MAX(amount) FROM Payments);


-- Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count.


SELECT c.course_id, c.course_name, COUNT(e.student_id) AS enrollment_count FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id GROUP BY c.course_id, c.course_name HAVING COUNT(e.student_id) = (SELECT MAX(enrollment_count)
FROM (SELECT course_id, COUNT(student_id) AS enrollment_count FROM Enrollments GROUP BY course_id) AS course_enrollments
);

--- Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses.*/

SELECT t.teacher_id, t.first_name, t.last_name, SUM(p.amount) AS total_payments FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id
LEFT JOIN Enrollments e ON c.course_id = e.course_id
LEFT JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.teacher_id, t.first_name, t.last_name ORDER BY total_payments DESC;




--Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.
 
SELECT t.teacher_id, t.first_name, t.last_name FROM Teacher t WHERE t.teacher_id NOT IN (SELECT DISTINCT c.teacher_id FROM Courses c);


