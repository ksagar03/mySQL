
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);
-- ON DELETE SET NULL-- when an employee id is deleted, this command will set the forign key which has been defined in the
-- another table to 'null'  
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL; 
-- this two command will set branch id and super_id as a forign key 
ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);
-- ON DELETE CASCADE- this command will delete entire row of the forign key where it has been defined has the primary key
-- in the table 
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


select birth_day,first_name from employee
order by birth_day;
select * from employee
order by sex,salary;
select * from employee
 order by sex,salary limit 6;
 select first_name as forename,last_name as surname from employee
order by sex,salary;
select distinct sex from employee; 
-- this command will show type of gender
--
-- using of function
-- count() - this function is used to provide total number of entry
select count(emp_id) from employee; -- output is -9- i.e 9 employees
-- to find number of employee born after year 1970
select count(emp_id) from employee
		where sex = 'F' and birth_day > '1970-01-02';
-- to find number of female employee who has salary 70000
select count(emp_id) from employee
		where sex = 'M' and salary > 70000;
-- to find average salary of the male -- avg()

select avg(salary) from employee
		where sex='m';
select sum(salary) from employee -- sum()
		where sex='m';
-- total numbers of male and female in the company
select count(sex),sex from employee
		group by sex;
-- to find total sales of each salesman
select * from works_with;
select sum(total_sales),emp_id from works_with
group by emp_id; 
-- to find aclient who are an LLC
select * from client
where client_name like '%LLC'; -- here like command will search for the client name which ends with LLC
-- %- it tells the DBMS to search for the client name which ends with LLC

-- find employee who has born in october month
select * from employee
	where birth_day like '%10%'; -- this command has some loophole's in it (dates also can have digit 10)
    -- therefore
select * from employee
	where birth_day like '____-10%'; -- in this command DBMS will search for the '____-10%' this pattern 
-- ***************************
-- 		union
-- ***************************
-- union command is used to combine result of select statement into a single result 
-- union has some condition - 1.we need to have same number of column in each select statement
-- 2. col needs to be have same no of data type 
 
select first_name from employee 
	union
select branch_name from branch;

-- ***************************
-- 		join
-- ***************************
-- join command is used to join two aor more table into single table based on the given conditon
select * from employee;
select * , branch.branch_name
		from employee
        join branch
        on employee.emp_id = branch.mgr_id;
-- left join and right join 
-- left join- this command will include all the rows from the left table i.e from employee table
-- right join- this command will include all the col from the right table i.e from branch table 
select * , branch.branch_name
		from employee
        left join branch
        on employee.emp_id = branch.mgr_id;
        
        select * , branch.branch_name
		from employee
        right join branch
        on employee.emp_id = branch.mgr_id;
-- ***************************
--       nested quries
-- ***************************
-- nested quries is used to combine two or more select statement

-- to find the names of all employee who has sold over 30000 to a single client 
select works_with.emp_id from works_with
where works_with.total_sales > 30000; 
select employee.emp_id, employee.first_name,employee.last_name from employee
where employee.emp_id in (
select works_with.emp_id from works_with
where works_with.total_sales > 30000
);
-- to find all the client who are handeled by michal scott manager(assuming that we know emp_id of michal scott)
select branch.branch_id,branch.branch_name from branch
where branch.mgr_id= 102;
select * from client
where client.branch_id in (
select branch.branch_id from branch
where branch.mgr_id= 102
);
-- ***************************
--       trigger
-- ***************************
-- trigger-this command will help you to exicute bunch of code which would be defining certain action 
CREATE TABLE emp (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);
delimiter $ -- this commnad will change the ';' symbol(the semi-colon is used to show the end of the cammand) to $
-- this command can't be used mysql workbench therefore we will run this command in mysql terminal window 

create trigger m before insert on emp for each row begin 
					insert into trigger_test values('entry has been done');
                    end$
-- here before inserting any data in the table we are doing some exicution(its done by trigger command)

delimiter ;
INSERT INTO emp VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
select * from m;
 -- 88************************************************************************************************************
 --     E R Diagram--useful for bulding a database schema
 -- **************************************************************************************************************
 -- 
