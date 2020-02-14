drop database Bank;
create database BANK;
use BANK;

CREATE TABLE BRANCH (
    branch_name VARCHAR(20),
    branch_city VARCHAR(20),
    asset REAL
);
alter table BRANCH add primary key(branch_name);

CREATE TABLE BANKACCOUNT (
    acc_no INT,
    branch_name VARCHAR(20),
    balance REAL,
    PRIMARY KEY (acc_no),
    FOREIGN KEY (branch_name)
        REFERENCES BRANCH (branch_name)
);

CREATE TABLE LOAN (
    loan_number INT,
    branch_name VARCHAR(30),
    amount REAL,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name)
        REFERENCES BRANCH (branch_name)
);


CREATE TABLE DEPOSITER (
    customer_name VARCHAR(30),
    acc_no INT,
    PRIMARY KEY (customer_name),
    FOREIGN KEY (acc_no)
        REFERENCES BANKACCOUNT (acc_no)
);

CREATE TABLE BANKCUSTOMER (
    customer_name VARCHAR(30),
    customer_street VARCHAR(30),
    customer_city VARCHAR(30),
    FOREIGN KEY (customer_name)
        REFERENCES DEPOSITER (customer_name)
);

insert into BRANCH(
branch_name,
branch_city,
asset)
values
('SBI_CHAMRAJPET', 'BANGLORE', 50000),
('SBI_RESIDENCYROAD', 'BANGLORE', 10000),
('SBI_SHIVAJIROAD', 'BOMBAY', 20000),
('SBI_PARLIMENTROAD', 'DELHI', 10000),
('SBI_JANTARMANTAR', 'DELHI', 20000);
    
insert into BANKACCOUNT(
acc_no,
branch_name,
balance)
values
(1,'SBI_CHAMRAJPET', 2000),
(2,'SBI_RESIDENCYROAD', 5000),
(3,'SBI_RESIDENCYROAD', 6000),
(4,'SBI_SHIVAJIROAD', 9000),
(5,'SBI_PARLIMENTROAD', 8000),
(6,'SBI_JANTARMANTAR', 4000),
(8,'SBI_SHIVAJIROAD', 4000),
(9,'SBI_PARLIMENTROAD', 3000),
(10,'SBI_RESIDENCYROAD', 5000),
(11,'SBI_JANTARMANTAR', 2000);




