create database SupplierDB;
use SupplierDB;
CREATE TABLE Supplier (
    sid INT,
    sname VARCHAR(30),
    city VARCHAR(30),
    PRIMARY KEY (sid)
);
desc Supplier;
CREATE TABLE Parts (
    pid INT,
    pname VARCHAR(30),
    color VARCHAR(30),
    PRIMARY KEY (pid)
);
CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost INT,
    PRIMARY KEY (sid , pid),
    FOREIGN KEY (sid)
        REFERENCES Supplier (sid),
    FOREIGN KEY (pid)
        REFERENCES Parts (pid)
);
insert into Supplier values(10001,'Acme Widget','Bangalore'),(10002,'Johns','Kolkata'),(10003,'Vimal','Mumbai'),(10004,'Reliance','Delhi');
insert into Parts values(20001,'Book','Red'),(20002,'Pen','Red'),(20003,'pencil','Green'),(20004,'Mobile','Green'),(20005,'Charger','Black');
insert into Catalog values(10001,20001,10),(10001,20002,10),(10001,20003,30),(10001,20004,10),(10001,20005,10),(10002,20001,10),(10002,20002,20),(10003,20003,30),(10004,20003,40);
SELECT 
    *
FROM
    Supplier;
SELECT 
    *
FROM
    Parts;
SELECT 
    *
FROM
    Catalog;

SELECT DISTINCT
    pname
FROM
    Parts,
    Catalog
WHERE
    Parts.pid = Catalog.pid;

select sname 
from Supplier
where not exists( select pid from Parts
					except
                    select distinct pid 
                    from Catalog
                    where Catalog.sid=Supplier.sid);

select sname 
from Supplier
where not exists( select pid from Parts where color='Red'
					except
                    select distinct Catalog.pid 
                    from Catalog , Parts
                    where Parts.pid=Catalog.pid and Parts.color='Red' and  Catalog.sid=Supplier.sid);
                    

SELECT 
    pname
FROM
    Parts,
    Catalog,
    Supplier
WHERE
    Catalog.pid = Parts.pid
        AND Catalog.sid = Supplier.sid
        AND Supplier.sname = 'Acme Widget'
        AND Catalog.pid NOT IN (SELECT 
            c.pid
        FROM
            Catalog c,
            Supplier s
        WHERE
            s.sid = c.sid
                AND s.sname <> 'Acme Widget');


SELECT 
    sid
FROM
    Catalog c
WHERE
    c.cost > (SELECT 
            AVG(c1.cost)
        FROM
            Catalog c1
        WHERE
            c.pid = c1.pid);
                
                
SELECT 
    p.pid, s.sname
FROM
    Parts p,
    Supplier s,
    Catalog c
WHERE
    p.pid = c.pid AND s.sid = c.sid
        AND c.cost = (SELECT 
            MAX(c1.cost)
        FROM
            Catalog c1
        WHERE
            c1.pid = c.pid);