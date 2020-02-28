create database SUP;
use SUP;

create table Supplier(
	sid int unique not null,
    sname varchar(30),
    city varchar(30),
    primary key(sid)
    );

create table Parts(
	pid int unique not null,
    pname varchar(30),
    colour varchar(30),
    primary key(pid)
    );
create table Catlog(
	sid int Not NULL,
    pid int Not NULL,
    cost int,
    foreign key(sid) references Supplier(sid),
    foreign key(pid) references Parts(pid)
    );
    
    
insert into Supplier
values
(10001, 'Acme Widget', 'Banglore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');

insert into Parts
values
(20001, 'Book', 'red'),
(20002, 'Pen', 'red'),
(20003, 'Pencil', 'green'),
(20004, 'Mobile', 'green'),
(20005, 'charger', 'black');
insert into Catlog
values
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10001,20001,10),
(10002,20001,20),
(10003,20003,30),
(10004,20003,140);

select * from Catlog;
select * from Supplier;
select * from Parts;


#Q1

select distinct sid from catlog, parts where colour = 'red' or 'green';

#Q2

select distinct Supplier.sid from Catlog, Parts, Supplier where Supplier.sid = Catlog.sid and Catlog.pid = Parts.pid and Parts.colour = 'red' or Supplier.city = 'Bangore'; 

#Q3

select distinct c1.sid,c2.sid from Catlog c1, Catlog c2 where c1.cost>c2.cost and c1.sid != c2.sid and c1.pid=c2.pid;
