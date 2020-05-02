reate database MOVIE_database;
use MOVIE_database;

CREATE TABLE actor (
    act_id INT,
    act_name VARCHAR(30),
    act_gender VARCHAR(30),
    PRIMARY KEY (act_id)
);

CREATE TABLE director (
    dir_id INT,
    dir_name VARCHAR(30),
    phone REAL,
    PRIMARY KEY (dir_id)
);

CREATE TABLE movies (
    mov_id INT,
    title VARCHAR(30),
    year INT,
    lang VARCHAR(20),
    dir_id INT,
    PRIMARY KEY (mov_id),
    FOREIGN KEY (dir_id)
        REFERENCES director (dir_id)
        ON DELETE CASCADE
);

CREATE TABLE movie_cast (
    act_id INT,
    mov_id INT,
    role VARCHAR(30),
    PRIMARY KEY (act_id , mov_id),
    FOREIGN KEY (act_id)
        REFERENCES actor (act_id)
        ON DELETE CASCADE,
    FOREIGN KEY (mov_id)
        REFERENCES movies (mov_id)
        ON DELETE CASCADE
);

CREATE TABLE rating (
    mov_id INT,
    stars VARCHAR(20),
    PRIMARY KEY (mov_id),
    FOREIGN KEY (mov_id)
        REFERENCES movies (mov_id)
        ON DELETE CASCADE
);

insert into actor values(301,'anushka','f'),
(302,'prabhas','m'),
(303,'punith','m'),
(304,'jermy','m');

insert into director values(60,'rajamouli',8751611001),
(61,'hitchcock',7766138911),
(62,'faran',9986776531),
(63,'steven spielberg',8989776530);

insert into movies values(1001,'bahubali-2',2017,'telugu',60),
(1002,'bahubali-1',2015,'telugu',60),
(1003,'akash',2008,'kannada',61),
(1004,'war horse',2011,'english',63);

insert into rating values(1001,4),
(1002,2),
(1003,5),
(1004,4);

insert into movie_cast values(301,1002,'heroine'),
(301,1001,'heroine'),
(303,1003,'hero'),
(303,1002,'guest'),
(304,1004,'hero');

SELECT 
    *
FROM
    actor;
SELECT 
    *
FROM
    director;
SELECT 
    *
FROM
    movcast;
SELECT 
    *
FROM
    rating;
SELECT 
    *
FROM
    movies;

SELECT 
    m.title
FROM
    movies m,
    director d
WHERE
    m.dir_id = d.dir_id
        AND d.dir_name = 'hitchcock';

SELECT 
    title
FROM
    movies m,
    movie_cast mc
WHERE
    m.mov_id = mc.mov_id
        AND act_id IN (SELECT 
            act_id
        FROM
            movie_cast
        GROUP BY act_id
        HAVING COUNT(act_id) > 1)
GROUP BY title
HAVING COUNT(*) > 1;
                                            
SELECT 
    act_name, title, year
FROM
    actor a
        JOIN
    movie_cast c ON a.act_id = c.act_id
        JOIN
    movies m ON c.mov_id = m.mov_id
WHERE
    m.year NOT BETWEEN 2000 AND 2015;

SELECT 
    title, MAX(stars)
FROM
    movies
        INNER JOIN
    rating USING (mov_id)
GROUP BY title
HAVING MAX(stars) > 0
ORDER BY title;

UPDATE rating 
SET 
    stars = 5
WHERE
    mov_id IN (SELECT 
            mov_id
        FROM
            movies
        WHERE
            dir_id IN (SELECT 
                    dir_id
                FROM
                    director
                WHERE
                    dir_name = 'steven spielberg'));

SELECT 
    *
FROM
    rating;
