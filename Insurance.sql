create database INSURANCE;
use INSURANCE;
create table PERSON(driver_id varchar(100),name varchar(100),address varchar(100));
alter table PERSON add primary key(driver_id);
create table CAR(reg_num varchar(100),model varchar(100),year int, primary key(reg_num));
create table OWNS(driver_id varchar(100),reg_num varchar(100),primary key(driver_id,reg_num),foreign key(driver_id) references PERSON(driver_id),foreign key(reg_num) references CAR(reg_num));
create table ACCIDENT(report_num int,accident_date date,location varchar(100),PRIMARY KEY(report_num));
create table PARTICIPATED(driver_id varchar(100),reg_num varchar(100),report_num int,damage_amount int);
alter table PARTICIPATED add foreign key(driver_id) references PERSON(driver_id);
alter table PARTICIPATED add foreign key(reg_num) references CAR(reg_num);
alter table PARTICIPATED add foreign key(report_num) references ACCIDENT(report_num);
alter table PARTICIPATED add primary key(driver_id,reg_num,report_num);
desc PARTICIPATED;
insert into PERSON values('A01','Richard','Srinivas nagar'),('A02','Pradeep','Rajaji nagar'),('A03','Smith','Ashok nagar'),
('A04','Venu','NR colony'),('A05','Jhon','Hanumanth nagar');
insert into CAR values('KA052250','Indica',1990),('KA031181','Lancer',1957),('KA095477','Toyota',1998),
('KA053408','Honda',2008),('KA041702','Audi',2005);
insert into OWNS values('A01','KA052250'),('A02','KA053408'),('A03','KA031181'),
('A04','KA095477'),('A05','KA041702');
insert into ACCIDENT values(11,'2003-01-01','Mysore Road');
insert into ACCIDENT values(12,'2004-02-02','South end circle');
insert into ACCIDENT values(13,'2003-01-21','Bull temple road');
insert into ACCIDENT values(14,'2017-02-17','Mysore Road');
insert into ACCIDENT values(15,'2005-03-04','Kanakapura Road');
insert into PARTICIPATED values('A01','KA052250',11,10000),('A02','KA053408',12,50000),('A03','KA095477',13,25000),
('A04','KA031181',14,3000),('A05','KA041702',15,5000);
update ACCIDENT set accident_date='2008-02-17' where report_num=14;
select * from PARTICIPATED;


update PARTICIPATED set damage_amount='25000' where reg_num='KA053408' and report_num=12;
insert into ACCIDENT values(16,'2010-05,22','Hebbal');
select * from ACCIDENT;

select count(distinct driver_id) CNT from PARTICIPATED,ACCIDENT where PARTICIPATED.report_num=ACCIDENT.report_num and accident_date like '2008%';
select count(PARTICIPATED.reg_num) count from PARTICIPATED,CAR,ACCIDENT where PARTICIPATED.report_num=ACCIDENT.report_num and CAR.reg_num=PARTICIPATED.reg_num and model='Audi';


