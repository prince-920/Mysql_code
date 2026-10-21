#----------------------creating and deleting of DB--------------------
/**
CREATE DATABASE temp1;

CREATE DATABASE temp2;

CREATE DATABASE college;

DROP DATABASE temp2;    

DROP DATABASE temp1;

*/
USE college;

#-----------------------2 - creating table-------------------------------

CREATE TABLE student(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT NOT NULL
);



#------------------------3-- inserting element-----------------------------
INSERT INTO student VALUES(1,"Aman",26);
INSERT INTO student VALUES( 2, " SHARADHA",24);

SELECT * FROM student;

INSERT INTO student
(id, name, age)
VALUES
(3,"SUMAN",25),
(4, "MANISH",23),
(5,"paranshu",24);

SELECT* FROM student;


# q1-------------

CREATE DATABASE XYZ;

USE XYZ;

CREATE TABLE employee(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT NOT NULL



);
ALTER TABLE employee
RENAME COLUMN age TO salary;

INSERT INTO employee
(id, name , salary)
VALUES
(1, "adam",25000),
(2,"bob",30000),
(3,"casey",40000);


SELECT* FROM employee;


#-----------------constraints------------------------

USE  college;

CREATE TABLE temp(
    id INT UNIQUE #----unique is a constraint here and will only accept unique SERIAL DEFAULT VALUE
);

INSERT INTO temp VALUES(101);
INSERT INTO temp VALUES(102);

SELECT * FROM temp;


#------------------foregin key------------------------

CREATE TABLE temp_fk(
    cust_id int,
    FOREIGN KEY (cust_id) REFERENCES student(id)
    
);

SHOW TABLES;
SELECT * FROM temp_fk;

INSERT INTO temp_fk
(cust_id)
VALUES
(1);

SELECT * FROM temp_fk;


#----------------CHECK--------------------

USE college;

CREATE TABLE city(
    id INT PRIMARY KEY ,
    city VARCHAR(50),
    age INT,

    #applying a constraint here CHECK 
    CONSTRAINT age_check CHECK (age>=18 AND city="Delhi")   # it is case sensitive so delhi != Delhi
);


INSERT INTO city
(id, city, age)
VALUES
#(1,"patna",32),
#(2,"Delhi",11),
#(3,"Delhi",11),
(4, "Delhi",33),
(3,"Delhi",33);

SHOW TABLES ;
SELECT * FROM city;


# q2 -- creating a sample db table student in db named college  and insert the data in this

CREATE DATABASE college2;

USE college2;

CREATE TABLE students(
    rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(40)


);

INSERT INTO students
(rollno, name, marks, grade,city)
VALUES
(101,"Anil",78,"C","Pune"),
(102,"Bhumika",93,"A","Mumbai"),
(106,"farah",82,"B","Pune");

INSERT INTO students VALUES(103,"Meghna",88,"B","Patna");
INSERT INTO students VALUES(104,"Manish",94,"A","Shimla");
INSERT INTO students VALUES(107,"Meghna",77,"C","Ranchi");
INSERT INTO students VALUES(105,"Meghna",67,"D","kochi");
INSERT INTO students VALUES(108,"Meghna",39,"G","kochi");
INSERT INTO students VALUES(109,"vikram",89,"B","vishakapatnam");
INSERT INTO students VALUES(110,"rancho",33,"G","kota");
INSERT INTO students VALUES(111,"michel",44,"F","kota");
INSERT INTO students VALUES(112,"mortor",33,"G","shangahi");





SELECT * FROM students;

#---------------Select in detail--------

SELECT name,grade FROM students;

#---------------DISTINCT KEYWORD_____________---
 
SELECT DISTINCT city, name FROM students;

#---------------WHERE clause-------------------

     #---operators---
SELECT * FROM students WHERE marks>80  And grade="B" AND rollno=103;   

SELECT * FROM students WHERE marks BETWEEN 80 and 90;

SELECT * FROM students WHERE marks%10=5;

SELECT * FROM students  WHERE  city IN  ( "Delhi","Mumbai");

#----LIMIT clause-----

SELECT * FROM students 
WHERE marks>50
LIMIT 3  ;   

#------- Order clause---------


SELECT* from students
ORDER BY marks DESC # ASC -- ascending ord , DESC -- descending ordr
LIMIT 4;   

#----------------Aggregate function---------------


SELECT COUNT(name)
from students;

SELECT MAX(rollno)
from students;

#------------------Group by clause------------------------

SELECT city, name ,avg(marks)
FROM students
GROUP BY name, city;

#q4--- write a query to find avg marks in each city in ascending order

SELECT city, AVG(marks)
FROM students
Group  BY city
ORDER BY city;

#q5 -- if order acc to acc order of avg marks 

SELECT city, AVG(marks) As avg_marks
FROM students
GROUP BY city
ORDER BY avg_marks ASC;
 

#q-5 for the given table , find the total payment according to each payement methods

-- customer_id | customer         | mode        | city
-- 101         | Olivia Barrett   | Netbanking  | Portland
-- 102         | Ethan Sinclair   | Credit Card | Miami
-- 103         | Maya Hernandez   | Credit Card | Seattle
-- 104         | Liam Donovan     | Netbanking  | Denver
-- 105         | Sophia Nguyen    | Credit Card | New Orleans
-- 106         | Caleb Foster     | Debit Card  | Minneapolis
-- 107         | Ava Patel        | Debit Card  | Phoenix
-- 108         | Lucas Carter     | Netbanking  | Boston
-- 109         | Isabella Martinez| Netbanking  | Nashville
-- 110         | Jackson Brooks   | Credit Card | Boston

CREATE DATABASE paymentInfo;
USE paymentInfo;

CREATE TABLE payment(
    customer_id INT UNIQUE,
    customer VARCHAR(50),
    mode VARCHAR(50),
    city VARCHAR(50)


);

INSERT INTO payment
(customer_id,customer,mode,city)
VALUES
(101,"olivia Barrett","Netbanking","Portland"),
(102,"Ethan Sinclair","Credit Card ","Miami"),
(103,"Maya Hernandez ","Credit Card","Seattle"),
(104,"Liam Donovan","Netbanking","Denver"),
(105,"Sophia Nguyen","Credit Card "," New Orleans"),
(106,"Caleb Foster","Debit Card ","Minneapolis"),
(107,"Ava Patel","Debit Card ","Phoenix"),
(108,"Lucas Carter ","Netbanking","Boston"),
(109,"Isabella Martinez","Netbanking","Nashville"),
(110,"Jackson Brooks ","Credit Card","Boston");




SHOW DATABASES;

SELECT mode ,count(customer) As Each_modeSum
FROM payment
GROUP BY mode
ORDER BY Each_modeSum ;

#-------------Having clause----------------
-- same as where but  where -->rows and having--->cols
USE college2;

-- q6 count no of students in each city where max marks cross 90

SELECT city, count(rollno)
FROM students
GROUP BY city
HAVING MAX(marks)>90;

#-----------Table related queries

# --------------1 UPDATE----------------

SELECT grade,name,rollno FROM students;

UPDATE students
SET grade ="o"
WHERE grade = "A";

SELECT grade,name,rollno FROM students;

-- -------------------safemode----------------

SET SQL_SAFE_UPDATES =0;  #0-->turn on safemode 1--->turn off safemode

UPDATE students
SET grade ="A"
WHERE grade = "o";

SELECT grade,name,rollno FROM students;

# --suppose if we want to incr marks of each student by 1 then

UPDATE students
SET marks= marks;

SELECT * FROM students;

#-------------2 DELETE------------------

DELETE FROM students
WHERE marks>93;


#----------------------FOREGIN KEY-------------------------


CREATE TABLE dept(
    id INT PRIMARY KEY,
    name VARCHAR(30)

);


CREATE TABLE teacher(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY(dept_id) REFERENCES dept(id)

    #-----------------CASCADING FK---------------------------------
ON DELETE CASCADE
ON UPDATE CASCADE


);

INSERT into dept
(id, name)
VALUES
(1, "mme"),
(2,"civil");

INSERT INTO teacher
(id, name, dept_id)
VALUES
(101,"dr gujjar",1),
(102,"Irfan samad wani",2);

UPDATE dept 
 SET id=3
where id=2;


SELECT id , name , dept_id FROM teacher;

SELECT * FROM dept;

#------------------------- 3 Alter--------------------------------
-- changes/add the table cols , aur modify any col in prexisting col in TABLE

-- adding age col in student TABLE
ALTER TABLE students
ADD COLUMN age int NOT NULL DEFAULT 19;

SELECT * FROM students;

--  dropping any col say age


-- - --

ALTER TABLE students
MODIFY age VARCHAR(5);


INSERT into students
(rollno , name , marks , grade , city , age)
VALUES
(113,"prema",99,"A","patna",101);


-- changing student table name to balak

ALTER TABLE stu
RENAME TO students;


# q6---------- in the students table change the name of col "name " to "full_name" 

ALTER TABLE students
CHANGE COLUMN name full_name  VARCHAR(60);

SELECT * FROM students;

#q7 ----- in the students table delete the students who have secured marks less the 80

DELETE FROM students
WHERE marks<80;

# q8 --- --- DELETE the col of grade

ALTER TABLE students
DROP COLUMN grade;



#--------------------------------JOINS-----------------------------------------

CREATE DATABASE joins;

use joins;

CREATE TABLE student3 
(
    student_id int NOT NULL,
    name VARCHAR(50)
);

CREATE TABLE course
(
    student_id INT not NULL,
    course VARCHAR(50)
);

INSERT INTO student3
(student_id , name)
VALUES
(101, "adam"),
(102, "bob"),
(103, "casey");

INSERT INTO course
(student_id, course)
VALUES
(102,"english"),
(105,"math"),
(103,"science"),
(107,"cs");

SELECT student_id, course FROM course;

#------------1 Inner joins--------------------
--  gives common data of both the tables
USE joins;

SELECT *
FROM student3 
INNER JOIN course AS c #-0-- here is c is a alis. 
ON student3.student_id=c.student_id;

  
#--------------2 left joins------------------------------

SELECT *
FROM student3 -- pahle left table ata h 
LEFT JOIN course -- ye right table h
ON student3.student_id=course.student_id;

#------------3 right joins-------------------

SELECT * 
FROM student3 
RIGHT JOIN course
ON student3.student_id=course.student_id;


#-----------------4 full join---------------------

-- left
-- union
-- right

SELECT * FROM student3
LEFT JOIN course
ON student3.student_id= course.student_id
UNION
SELECT * FROM student3
RIGHT JOIN course
ON student3.student_id= course.student_id;


#---------------5 exclusicely left joint-------------
-- only A
SELECT * 
FROM student3 AS A
LEFT JOIN course  AS B
on A.student_id= B.student_id
WHERE B.student_id IS null;




#---------------6 exclusicely right joint-------------

SELECT *
FROM student3
RIGHT JOIN course
on student3.student_id=course.student_id
WHERE student3.student_id IS NULL;

#--         7 full exclusive joins--------------

-- exclusicely left joint
-- union
-- exclusicely right joint

SELECT * 
FROM student3 AS A
LEFT JOIN course  AS B
on A.student_id= B.student_id
WHERE B.student_id IS null

UNION

SELECT *
FROM student3
RIGHT JOIN course
on student3.student_id=course.student_id
WHERE student3.student_id IS NULL;


#----------- 8 self join---------------

CREATE TABLE employee
(
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);


INSERT INTO employee
(id, name, manager_id)
VALUES
(101,"adam",103),
(102,"bob",104),
(103,"casey",NULL),
(104,"donald",103);

SELECT * FROM employee;

SELECT a.name as manager_name,b.name
FROM employee as a
JOIN employee as b
ON a.id=b.manager_id;


#------------------UNION----------------------

SELECT name FROM employee
UNION ALL
SELECT name FROM employee;

#----------------sql subqueries------------------

# q9 -- give the name of the students whose marks is more than the avg marks of the class;

-- m1
use college2;
SELECT * FROM students;

SELECT AVG(marks) AS avg_marks FROM students; -- 88.8


SELECT full_name , marks
FROM students
WHERE marks>88.8;

-- m2 using subqueries

SELECT full_name, marks
FROM students
WHERE marks>(
    SELECT AVG(marks)
    FROM students
);

#q10--- find the name of students with even roll no

SELECT full_name, rollno
FROM students
WHERE rollno%2=0;

SELECT full_name , rollno
FROM students
WHERE rollno IN (
    SELECT   rollno
    FROM students
    WHERE rollno %2=0
);


#q11 -- find the names of the students from delhi whose marks is max

-- using from  subqery -->


SELECT max(MARKS)
FROM(
    SELECT * FROM students
    WHERE city="Delhi" 
) AS temp;  -- > from subqery me hamesa ek alis jarur lagate h , like yaha temp lagaya h



#--------------MYsqlviews------------------------

-- creating a view table for teacher  having only name, rollno, marks only not city

CREATE VIEW view_teacher AS
SELECT rollno, full_name, marks FROM students;

SELECT * FROM view_teacher;

SELECT * FROM students;

-- ------------------- deleting a view-----------------

DROP VIEW view_teacher;





-- ------------------------- THE END OF THE COURSE----------------------

