create database INSURANCE;
use INSURANCE;
CREATE TABLE PERSON (
    driver_id VARCHAR(10),
    name VARCHAR(20),
    address VARCHAR(30),
    PRIMARY KEY (driver_id)
);
CREATE TABLE CAR (
    reg_num VARCHAR(10),
    model VARCHAR(20),
    year INT,
    PRIMARY KEY (reg_num)
);
CREATE TABLE ACCIDENT (
    report_num INT,
    accident_date DATE,
    location VARCHAR(20),
    PRIMARY KEY (report_num)
);
CREATE TABLE OWNS (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id , reg_num),
    FOREIGN KEY (driver_id)
        REFERENCES PERSON (driver_id),
    FOREIGN KEY (reg_num)
        REFERENCES CAR (reg_num)
);
CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount int,
    PRIMARY KEY (driver_id , reg_num , report_num),
    FOREIGN KEY (driver_id)
        REFERENCES PERSON (driver_id),
    FOREIGN KEY (reg_num)
        REFERENCES CAR (reg_num),
    FOREIGN KEY (report_num)
        REFERENCES ACCIDENT (report_num)
);

INSERT INTO PERSON      
values ('A01','Richard','Srinivas Nagar' ),
('A02','Pradeep','Rajaji nagar'),
('A03','Smith','Ashok Nagar'),
('A04','Venu','N R Colony'),
('A05','Jhon','Hanumanth Nagar');

INSERT into CAR
values('KA052250','Indica',1990),
('KA031181','Lancer',1957),
('KA095477','Toyota',1998),
('KA053408','Honda',2008),
('KA041702','Audi',2005);

insert into OWNS
values('A01','KA052250'),
('A02','KA053408'),
('A03','KA031181'),
('A04','KA095477'),
('A05','KA041702');

INSERT INTO ACCIDENT
values (11,'03/01/01','South end Circle'),
(12,'04/02/02','Mysore Road'),
(13,'03/01/21','Bull Temple Road'),
(14,'08/02/17','Mysore Road'),
(15,'05/03/04','Kanakpura Road');

insert into PARTICIPATED
values ('A01','KA052250',11,10000),
('A02','KA053408',12,50000),
('A03','KA095477',13,25000),
('A04','KA031181',14,3000),
('A05','KA041702',15,5000);


#Q1

UPDATE PARTICIPATED 
SET 
    damage_amount = 25000
WHERE
    reg_num = 'KA053408' AND report_num = 12;
    
select * from PARTICIPATED;

#Q2
insert into ACCIDENT values(16,'05/07/21','Domlur');
select * from ACCIDENT;

#Q3
SELECT 
    COUNT(DISTINCT driver_id) CNT
FROM
    PARTICIPATED,
    ACCIDENT
WHERE
    PARTICIPATED.report_num = ACCIDENT.report_num
        AND accident_date LIKE '2008%';	
        
#Q4
SELECT 
    COUNT(driver_id) COUNT
FROM
    PARTICIPATED,
    CAR
WHERE
    PARTICIPATED.reg_num = CAR.reg_num
        AND model = 'Indica';

#Q5
SELECT DISTINCT
    name
FROM
    PERSON,
    PARTICIPATED
WHERE
    damage_amount > (SELECT 
            AVG(damage_amount)
        FROM
            PARTICIPATED);