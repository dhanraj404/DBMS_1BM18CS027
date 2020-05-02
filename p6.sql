create database ORDER_processingDB;
use ORDER_processingDB;

CREATE TABLE salesman (
    salesman_id INT,
    name VARCHAR(20),
    city VARCHAR(20),
    commission VARCHAR(20),
    PRIMARY KEY (salesman_id)
);

CREATE TABLE customer (
    customer_id INT,
    cust_name VARCHAR(20),
    city VARCHAR(20),
    grade INT,
    salesman_id INT,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (salesman_id)
        REFERENCES salesman (salesman_id)
        ON DELETE SET NULL
);

CREATE TABLE orders (
    order_no INT,
    purchase INT,
    date DATE,
    customer_id INT,
    salesman_id INT,
    PRIMARY KEY (order_no),
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE,
    FOREIGN KEY (salesman_id)
        REFERENCES salesman (salesman_id)
        ON DELETE CASCADE
);

insert into salesman values(1000,'john','bangalore','25%'),
(2000,'ravi','bangalore','20%'),
(3000,'kumar','mysore','15%'),
(4000,'smith','delhi','30%'),
(5000,'harsha','hyderabad','15%');

insert into customer values(10,'preethi','bangalore',100,1000),
(11,'vivek','mangalore',300,1000),
(12,'bhaskar','chennai',400,2000),
(13,'chethan','bangalore',200,2000),
(14,'mamtha','bangalore',400,3000);

insert into orders values(50,5000,'04-05-17',10,1000),
(51,450,'20-01-17',10,2000),
(52,1000,'24-02-17',13,2000),
(53,3500,'13-04-17',14,3000),
(54,550,'09-03-17',12,2000);

SELECT 
    *
FROM
    salesman;
SELECT 
    *
FROM
    customer;
SELECT 
    *
FROM
    orders;

SELECT 
    grade, COUNT(DISTINCT customer_id)
FROM
    customer
GROUP BY grade
HAVING grade > (SELECT 
        AVG(grade)
    FROM
        customer
    WHERE
        city = 'bangalore');

SELECT 
    salesman_id, name
FROM
    salesman A
WHERE
    1 < (SELECT 
            COUNT(*)
        FROM
            customer
        WHERE
            salesman_id = A.salesman_id);

SELECT 
    salesman.salesman_id, name, cusT_name, commission
FROM
    salesman,
    customer
WHERE
    salesman.city = customer.city 
UNION SELECT 
    salesman_id, name, 'no match', commission
FROM
    salesman
WHERE
    NOT city = ANY (SELECT 
            city
        FROM
            customer)
ORDER BY 2 DESC;

CREATE VIEW elitesalesman AS
    SELECT 
        B.date, A.salesman_id, A.name
    FROM
        salesman A,
        orders B
    WHERE
        A.salesman_id = B.salesman_id
            AND B.purchase = (SELECT 
                MAX(purchase)
            FROM
                orders C
            WHERE
                C.date = B.date);

DELETE FROM salesman 
WHERE
    salesman_id = '1000';
SELECT 
    *
FROM
    salesman;