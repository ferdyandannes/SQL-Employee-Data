DROP TABLE IF EXISTS Employee2;
CREATE TABLE Employee2
(ID INTEGER NOT NULL primary key AUTOINCREMENT,
FirstName varchar NOT NULL,
LastName varchar NOT NULL,
HireDate date NOT NULL,
TerminationDate date NULL,
Salary int NOT NULL);

DROP TABLE IF EXISTS AnnualReviews;
CREATE TABLE AnnualReviews
(ID INTEGER NOT NULL PRIMARY KEY,
EmpID int NOT NULL,
ReviewDate date,
FOREIGN key (EmpID) REFERENCES Employee(ID));

insert into Employee (FirstName, LastName, HireDate, TerminationDate, Salary) VALUES ("Bob", "Smith", "2009-06-20", "2016-01-01", 10000)
insert into Employee (FirstName, LastName, HireDate, Salary) VALUES ("Joe", "Jarrod", "2010-02-12", 20000)
insert into Employee (FirstName, LastName, HireDate, Salary) VALUES ("Nancy", "Soley", "2012-03-14", 30000)
insert into Employee (FirstName, LastName, HireDate, TerminationDate, Salary) VALUES ("Keith", "Widjaja", "2013-09-10", "2014-01-01", 20000) 
insert into Employee (FirstName, LastName, HireDate, Salary) VALUES ("Kelly", "Smalls", "2013-09-10", 20000)
insert into Employee (FirstName, LastName, HireDate, TerminationDate, Salary) VALUES ("Frank", "Nguyen", "2015-04-10", "2015-05-01", 60000)

insert into AnnualReviews VALUES (10, 1, "2016-01-01")
insert into AnnualReviews VALUES (20, 2, "2016-04-12")
insert into AnnualReviews VALUES (30, 10, "2015-02-13")
insert into AnnualReviews VALUES (40, 22, "2010-10-12")
insert into AnnualReviews VALUES (50, 11, "2009-01-01")
insert into AnnualReviews VALUES (60, 12, "2009-03-03")
insert into AnnualReviews VALUES (70, 13, "2008-12-01")
insert into AnnualReviews VALUES (80, 1, "2003-04-12")
insert into AnnualReviews VALUES (90, 1, "2014-04-30")

SELECT * 
from Employee 
EXCEPT 
SELECT DISTINCT Employee.ID, Employee.FirstName, Employee.LastName, Employee.HireDate, Employee.TerminationDate, Employee.Salary 
From AnnualReviews, Employee 
WHERE AnnualReviews.EmpID = Employee.ID
ORDER by Employee.HireDate


SELECT MAX(number) - MIN(number)
from 
(
SELECT (julianday('now')-julianday(hiredate)) as number
FROM Employee
Where terminationdate is NULL)


SELECT julianday(timeline)-julianday(distance) as tempo 
  from (
    SELECT timeline, LAG(timeline,1,0) OVER (
      order by timeline
    ) distance
    from (
      select DISTINCT hiredate  as timeline
      from Employee
      UNION
      select terminationdate  
      from Employee
      where terminationdate is not null
    )
  )
  ORDER BY tempo DESC LIMIT 1 OFFSET 1



