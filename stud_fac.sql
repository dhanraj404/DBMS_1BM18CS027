create database Stud_fac;
use Stud_fac;

CREATE TABLE student (
    snum INT,
    sname VARCHAR(10),
    major VARCHAR(2),
    lvl VARCHAR(2),
    age INT,
    PRIMARY KEY (snum)
);

CREATE TABLE faculty (
    fid INT,
    fname VARCHAR(20),
    deptid INT,
    PRIMARY KEY (fid)
);
 
CREATE TABLE class (
    cname VARCHAR(20),
    meets_at TIMESTAMP,
    room VARCHAR(10),
    fid INT,
    PRIMARY KEY (cname),
    FOREIGN KEY (fid)
        REFERENCES faculty (fid)
);
 
CREATE TABLE enrolled (
    snum INT,
    cname VARCHAR(20),
    PRIMARY KEY (snum , cname),
    FOREIGN KEY (snum)
        REFERENCES student (snum),
    FOREIGN KEY (cname)
        REFERENCES class (cname)
);
 
 insert into student values(1,'john','cs','sr',19),(2,'smith','cs','jr',20),(3,'jacob','cv','sr',20),(4,'tom','cs','jr',20),(5,'rahul','cs','jr',20),(6,'rita','cs','sr',21);
 insert into faculty values(11,'harish',1000),(12,'mv',1000),(13,'mira',1001),(14,'shiva',1002),(15,'nupur',1000);
 insert into class values('class1','12/11/15 10:15:16','R1',14),('class10','12/11/15 10:15:16','R128',14),('class2','12/11/15 10:15:20','R2',12),('class3','12/11/15 10:15:25','R3',11),('class4','12/11/15 20:15:20','R4',14),('class5','12/11/15 20:15:20','R3',15),('class6','12/11/15 13:20:20','R2',14),('class7','12/11/15 10:10:10','R3',14);
 insert into enrolled values(1,'class1'),(2,'class1'),(3,'class3'),(4,'class3'),(5,'class4'),(1,'class5'),(2,'class5'),(3,'class5'),(4,'class5'),(5,'class5');
 
SELECT DISTINCT
    sname
FROM
    student,
    enrolled,
    class,
    faculty
WHERE
    faculty.fid = class.fid
        AND faculty.fname = 'harish'
        AND enrolled.cname = class.cname
        AND student.snum = enrolled.snum
        AND student.lvl = 'jr';
 
SELECT DISTINCT
    cname
FROM
    class
WHERE
    class.room = 'R128'
        OR cname IN (SELECT 
            cname
        FROM
            enrolled
        GROUP BY cname
        HAVING COUNT(*) >= 5);
 
SELECT DISTINCT
    sname
FROM
    student
WHERE
    student.snum IN (SELECT 
            e1.snum
        FROM
            enrolled e1,
            enrolled e2,
            class c1,
            class c2
        WHERE
            e1.snum = e2.snum
                AND e1.cname <> e2.cname
                AND e1.cname = c1.cname
                AND e2.cname = c2.cname
                AND c1.meets_at = c2.meets_at);
 
SELECT DISTINCT
    fname
FROM
    faculty,
    enrolled,
    class
WHERE
    5 > (SELECT 
            COUNT(enrolled.snum)
        FROM
            enrolled,
            class
        WHERE
            enrolled.cname = class.cname
                AND class.fid = faculty.fid);
 
SELECT DISTINCT
    sname
FROM
    student
WHERE
    snum NOT IN (SELECT DISTINCT
            snum
        FROM
            enrolled);
 
DROP database student_faculty;

SELECT 
    S.age, S.lvl
FROM
    student S
GROUP BY S.age , S.lvl
HAVING S.lvl IN (SELECT 
        S1.lvl
    FROM
        student S1
    WHERE
        S1.age = S.age
    GROUP BY S1.lvl , S1.age
    HAVING COUNT(*) >= ALL (SELECT 
            COUNT(*)
        FROM
            student S2
        WHERE
            s1.age = S2.age
        GROUP BY S2.lvl , S2.age));
 