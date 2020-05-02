create database BOOK_DB;
use BOOK_DB;

CREATE TABLE publisher (
    name VARCHAR(20),
    phone REAL,
    address VARCHAR(20),
    PRIMARY KEY (name)
);
 
CREATE TABLE book (
    book_id INT,
    title VARCHAR(20),
    year VARCHAR(20),
    publisher_name VARCHAR(20),
    PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_name)
        REFERENCES publisher (name)
        ON DELETE CASCADE
);

CREATE TABLE authors (
    author_name VARCHAR(20),
    book_id INT,
    PRIMARY KEY (book_id , author_name),
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE
);

CREATE TABLE library_branch (
    branch_id INT,
    branch_name VARCHAR(20),
    address VARCHAR(20),
    PRIMARY KEY (branch_id)
);

CREATE TABLE book_copies (
    book_id INT,
    branch_id INT,
    no_copies INT,
    PRIMARY KEY (book_id , branch_id),
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE,
    FOREIGN KEY (branch_id)
        REFERENCES library_branch (branch_id)
        ON DELETE CASCADE
);

CREATE TABLE card (
    card_no INT,
    PRIMARY KEY (card_no)
);

CREATE TABLE book_lending (
    date_out DATE,
    due_date DATE,
    book_id INT,
    branch_id INT,
    card_no INT,
    PRIMARY KEY (book_id , branch_id , card_no),
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE,
    FOREIGN KEY (branch_id)
        REFERENCES library_branch (branch_id)
        ON DELETE CASCADE,
    FOREIGN KEY (card_no)
        REFERENCES card (card_no)
        ON DELETE CASCADE
);

insert into publisher values('mcgraw-hill',99890076587,'bangalore'),
('pearson',9889076565,'newdelhi'),
('random house',7455679345,'hyderabad'),
('hachette livre',8970862340,'chennai'),
('grupo planeta',7756120238,'bangalore');

insert into book values(1,'dbms','jan-2017','mcgraw-hill'),
(2,'adbms','jun-2016','mcgraw-hill'),
(3,'CN','sep-2016','pearson'),
(4,'CG','sep-2015','grupo planeta'),
(5,'OS','may-2016','pearson');

insert into authors values('navathe',1),
('navathe',2),
('tanenbaum',3),
('edward angel',4),
('galvin',5);

insert into library_branch values(10,'RR nagar','bangalore'),
(11,'RNSIT','bangalore'),
(12,'Rajaji nagar','bangalore'),
(13,'NITTE','mangalore'),
(14,'Manipal','udupi');

insert into book_copies values(1,10,10),
(1,11,5),(2,12,2),(2,13,5),(3,14,7),(5,10,1),(4,11,3);

insert into card values (100),(101),(102),(103),(104);

insert into book_lending values('01-01-17','01-06-17',1,10,101),
('11-01-17','11-03-17',3,14,101),
('21-02-17','21-04-17',2,13,101),
('15-03-17','15-07-17',4,11,101),
('12-04-17','12-05-17',1,11,104);

SELECT 
    *
FROM
    publisher;
SELECT 
    *
FROM
    book;
SELECT 
    *
FROM
    authors;
SELECT 
    *
FROM
    card;
SELECT 
    *
FROM
    library_branch;
SELECT 
    *
FROM
    book_copies;
SELECT 
    *
FROM
    book_lending;

SELECT 
    B.book_id,
    B.title,
    B.publisher_name,
    A.author_name,
    C.no_copies,
    L.branch_id
FROM
    book B,
    authors A,
    book_copies C,
    library_branch L
WHERE
    B.book_id = A.book_id
        AND B.book_id = C.book_id
        AND L.branch_id = C.branch_id;

SELECT 
    card_no
FROM
    book_lending
WHERE
    date_out BETWEEN 01 - 01 - 17 AND 01 - 07 - 17
GROUP BY card_no
HAVING COUNT(*) > 3;

DELETE FROM book 
WHERE
    book_id = 3;

SELECT 
    *
FROM
    book;

CREATE VIEW V_publication AS
    SELECT 
        year
    FROM
        book;

CREATE VIEW V_books AS
    SELECT 
        B.book_id, B.title, C.no_copies
    FROM
        book B,
        book_copies C,
        library_branch L
    WHERE
        B.book_id = C.book_id
            AND C.branch_id = L.branch_id;