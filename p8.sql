create database STUDENT_enroll;
use STUDENT_enroll;

CREATE TABLE student (
    regno VARCHAR(30),
    name VARCHAR(30),
    major VARCHAR(30),
    bdate DATE,
    PRIMARY KEY (regno)
);

CREATE TABLE course (
    courseno INT,
    cname VARCHAR(30),
    dept VARCHAR(30),
    PRIMARY KEY (courseno)
);

CREATE TABLE enroll (
    regno VARCHAR(30),
    courseno INT,
    sem INT,
    marks INT,
    PRIMARY KEY (regno , courseno),
    FOREIGN KEY (regno)
        REFERENCES student (regno)
        ON DELETE CASCADE,
    FOREIGN KEY (courseno)
        REFERENCES course (courseno)
        ON DELETE CASCADE
);

CREATE TABLE text (
    book_isbn INT,
    title VARCHAR(30),
    publisher VARCHAR(30),
    author VARCHAR(30),
    PRIMARY KEY (book_isbn)
);

CREATE TABLE adoption (
    courseno INT,
    sem INT,
    book_isbn INT,
    PRIMARY KEY (courseno , book_isbn),
    FOREIGN KEY (courseno)
        REFERENCES course (courseno)
        ON DELETE CASCADE,
    FOREIGN KEY (book_isbn)
        REFERENCES text (book_isbn)
        ON DELETE CASCADE
);

insert into student values('1pe11cs002','b','sr','19930924'),
('1pe11cs003','c','sr','19931127'),
('1pe11cs004','d','sr','19930413'),
('1pe11cs005','e','jr','19940824');

insert into course values(111,'OS','CSE'),
(112,'EC','CSE'),
(113,'SS','ISE'),
(114,'DBMS','CSE'),
(115,'SIGNALS','ECE');

insert into text values(10,'database systems','pearson','schield'),
(900,'operating sys','pearson','leland'),
(901,'circuits','hall india','bob'),
(902,'system software','peterson','jacob'),
(903,'scheduling','pearson','patil'),
(904,'database systems','pearson','jacob'),
(905,'database manager','pearson','bob'),
(906,'signals','hall india','sumit');

insert into enroll values('1pe11cs002',115,3,100),
('1pe11cs002',114,5,100),
('1pe11cs003',113,5,100),
('1pe11cs004',111,5,100),
('1pe11cs005',112,3,100);

insert into adoption values(111,5,900),
(111,5,903),(111,5,904),(112,3,901),(113,3,10),(114,5,905),(113,5,902),(115,3,906);

SELECT 
    *
FROM
    adoption;
SELECT 
    *
FROM
    enroll;
SELECT 
    *
FROM
    student;
SELECT 
    *
FROM
    text;
SELECT 
    *
FROM
    course;

SELECT 
    C.courseno, T.book_isbn, T.title
FROM
    course C,
    adoption BA,
    text T
WHERE
    C.courseno = BA.courseno
        AND BA.book_isbn = T.book_isbn
        AND C.dept = 'CSE'
        AND 2 < (SELECT 
            COUNT(book_isbn)
        FROM
            adoption B
        WHERE
            C.courseno = B.courseno
        ORDER BY T.title);
                                                                                           
SELECT DISTINCT
    c.dept
FROM
    course c
WHERE
    c.dept IN (SELECT 
            c.dept
        FROM
            course c,
            adoption b,
            text t
        WHERE
            c.courseno = b.courseno
                AND t.book_isbn = b.book_isbn
                AND t.publisher = 'pearson')
        AND c.dept NOT IN (SELECT 
            c.dept
        FROM
            course c,
            adoption b,
            text t
        WHERE
            c.courseno = b.courseno
                AND t.book_isbn = b.book_isbn
                AND t.publisher <> 'pearson');
                    