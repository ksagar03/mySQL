
CREATE TABLE student(
roll_num INT PRIMARY KEY,
student_name VARCHAR(20),
stream VARCHAR(10)
);
DESCRIBE student;
-- to delete the table we use drop statement 
drop table student;
-- to alter the table ie to add new or drop col we use
alter table student add gender varchar(10);
-- inserting data into the table
select * from student; # this line will collect information from student 
insert into student value(2,'yash','pcmb','male');
-- if we don't know the value of that clo then we use 
insert into student(roll_num,student_name,gender) value(3,'ramu','male'); # here i removed stream
-- here we learn about NOT NULL and UNIQUE
-- NOT NULL-this command tells the database that the perticular col which is reprented with not null should not be left blank 
-- unique - this command tells the database that the col sholud have unique value for each row 
 
alter table student add adharnumber bigint unique;#each adharnumber will be unique to each row
alter table student modify stream varchar(20) default 'undecided';
#here i modified the datatype which i earlier defined in the table.
insert into student(roll_num,student_name,adharnumber) value(2,'yashh',653039682062);
-- here we are incerting data rol_num which is a primary key but it can be done automatically by using auto_incriment cammand 


CREATE TABLE student(
roll_num INT PRIMARY KEY auto_increment,
student_name VARCHAR(20),
stream VARCHAR(10)
);
alter table student add gender varchar(10);
alter table student add adharnumber bigint unique;#each adharnumber will be unique to each row
alter table student modify stream varchar(20) default 'undecided';
describe student;
insert into student(student_name,stream,gender,adharnumber) value('sagar','PCMC','male',653039682063);
select * from student;
insert into student(student_name,gender,adharnumber) value('jai','male',653039682064);
-- UPDATE & DELETE statement
update student set gender='M' where gender='male';# this command will change male to M
delete from student where roll_num=2;
-- where statement helps in providing a condition in such a that perticular data can be updated or deleted from the table
 insert into student(student_name,stream,gender,adharnumber) value('jagu','pacmb','male',6530396);
 insert into student(student_name,stream,gender,adharnumber) value('manish','pacmc','male',6530796);
  insert into student(student_name,gender,adharnumber) value('manish','male',6530723);
   insert into student(student_name,stream,gender,adharnumber) value('ramesh','pcmb','male',6530273);
   select * from student
   order by adharnumber ; # this command will order(increasing order by default).
   # to arrange the name in descending order we use desc after adharnumber (it can also be applied to char)
   select * from student
   order by student_name,stream; # in this command the table will get order by student name then by stream.
   select * from student
   limit 2;# this will print only two col
   update student set stream='pcmb' where stream='pacmb';
   select * from student
   order by adharnumber
   limit 2;
   # important 
   select * from student
   where stream='pcmc';
select * from student
   where adharnumber < 653039682063; # <>-> means not equalto , and ,or statement  
   select * from student
   where student_name in ('sagar','jagu','ramesh') and adharnumber < 653039682063 ;

-- to set primary key in the table





