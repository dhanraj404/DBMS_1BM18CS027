create database insurance;

use insurance;

CREATE TABLE person (
    driver_id VARCHAR(10),
    name VARCHAR(20),
    addresss VARCHAR(20),
    PRIMARY KEY (driver_id)
);


CREATE TABLE car (
    reg_num VARCHAR(10),
    model VARCHAR(20),
    year INT,
    PRIMARY KEY (reg_num)
);


CREATE TABLE accident (
    report_no INT,
    accident_date DATE,
    location VARCHAR(20),
    PRIMARY KEY (report_no)
);

CREATE TABLE owns (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id , reg_num),
    FOREIGN KEY (driver_id)
        REFERENCES person (driver_id),
    FOREIGN KEY (reg_num)
        REFERENCES car (reg_num)
);

CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id , reg_num , report_num),
    FOREIGN KEY (driver_id)
        REFERENCES person (driver_id),
    FOREIGN KEY (reg_num)
        REFERENCES car (reg_num),
    FOREIGN KEY (report_num)
        REFERENCES accident (report_num)
);

insert into person(
	driver_id,
    name,
    addresss 
)
values
('A01','Richard','Shrinavas Nagar'),
('A02','Pradeep','Rajaji Nagar'),
('A03','Smith','Ashok Nagar'),
('A04','Venu','N R Colony'),
('A05','Jhon','Hunmanth Nagar');

insert into car(
	reg_num,
    model,
    year 
)
values
('KA052250', 'Indica', 1990),
('KA031181','Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA04702', 'Audi', 2005);

