create database MOVIE_db;
use MOVIE_db;

create table actor(
act_id int,
act_name varchar(30),
act_gender varchar(30),
primary key (act_id));

create table director(
dir_id int,
dir_name varchar(30),
phone real,
primary key (dir_id));

create table movies(
mov_id int,
title varchar(30),
year int,
lang varchar(20),
dir_id int,
primary key (mov_id),
foreign key (dir_id) references director(dir_id) on delete cascade);

create table movie_cast(
act_id int, mov_id int, role varchar(30),
primary key (act_id,mov_id),
foreign key (act_id) references actor(act_id) on delete cascade,
foreign key (mov_id) references movies(mov_id) on delete cascade);

create table rating(
mov_id int, stars varchar(20),
primary key (mov_id),
foreign key (mov_id) references movies(mov_id) on delete cascade);

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

select * from actor;
select * from director;
select * from movcast;
select * from rating;
select * from movies;

select m.title from movies m, director d
where m.dir_id = d.dir_id AND d.dir_name = 'hitchcock';

select title from movies m, movie_cast mc
where m.mov_id = mc.mov_id and act_id in (
											select act_id from movie_cast group by act_id having count(act_id)>1)
                                            group by title having count(*) >1;
                                            
select act_name, title ,year 
from actor a 
JOIN movie_cast c on a.act_id = c.act_id 
JOIN movies m on c.mov_id = m.mov_id 
where m.year NOT BETWEEN 2000 and 2015;

select title, max(stars)
from movies
INNER JOIN rating using (mov_id)
group by title having max(stars)>0
order by title;

update rating set stars = 5 where mov_id IN (select mov_id from movies
											  where dir_id  IN
																(select dir_id from director 
                                                                where dir_name = 'steven spielberg'));

select * from rating;