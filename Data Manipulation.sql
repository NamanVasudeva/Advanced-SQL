create table tutorial.employees  (
	id numeric primary key,
	first_name varchar not null,
	last_name varchar not null,
	email varchar,
	hire_data date default current_date,
	department varchar default 'Unassigned'
);

select * from tutorial.employees;


#-- Alter table template
alter  [object] [object_name] [command];


#-- We can add a column
alter table tutorial.employees add column age int;


#-- We can delete a column
alter table tutorial.employees drop column age;


#-- We can set a default value
alter table tutorial.employees alter column department set default 'Reassigned';


#-- Insert data into a table Template
insert into table_name (col1, col2, col3....) values (val1, val2, val3);

#-- Inserting the data
insert into tutorial.employees (id, first_name, last_name,email)
values (1,'John','Doe','johndoe@example.com');

insert into tutorial.employees (id, first_name, last_name,email)
values (2,'Jane','Smith','janesmith@example.com'),
(3,'Bob','Johnson','bobjohnson@example.com'),
(4,'Alice','Williams','alicewilliams@example.com');


select * from tutorial.employees;


#-- Update data template
update table name 
	set column1=val1, column2=val2, columns3=val3....
where condition;


#-- Updating the data
update tutorial.employees
	set first_name = 'Jane',
	last_name ='Doe',
	email='janedoe@example.com' where id=2;


select * from tutorial.employees e;


#-- Deleting the data

delete from tutorial.employees where id=3;
delete from tutorial.employees where id in (1,4);
truncate table tutorial.employees;


#--Merging the data template


select * from tutorial.employees e;


merge into table1 as t1
using table2 as t2
on t1.id=t2.id
when matched then
	update set
		t1.title=t2.title
when not matched then
	insert (ID, title)
	values (t2.id,t2.title)
	
#-- Merging the data


alter table tutorial.employees 
add hire_date date default current_date;

CREATE TABLE tutorial.employees_two (
    id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    department VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO tutorial.employees_two (id, first_name, last_name, email, hire_date, department)
VALUES
    (1, 'John', 'Doe', 'johndoe@example.com', '2022-01-01', 'Sales'),
    (2, 'Jane', 'Doe', 'janedoe@example.com', '2022-01-02', 'Marketing'),
    (3, 'Bob', 'Smith', 'bobsmith@example.com', '2022-01-03', 'Human Resources'),
    (4, 'Alice', 'Jones', 'alicejones@example.com', '2022-01-04', 'Sales'),
    (6, 'Tom', 'Wilson', 'tomwilson@example.com', '2022-01-05', 'Marketing');



merge into tutorial.employees as e
using tutorial.employees_two as e2
on e.id=e2.id
when matched then
	update set
		first_name=e2.first_name,
		last_name=e2.last_name,
		email=e2.email,
		hire_date=e2.hire_date,
		department=e2.department
when not matched then
	insert (id,first_name, last_name, email, hire_date, department)
	values (e2.id, e2.first_name, e2.last_name, e2.email,e2.hire_date, e2.department);


select * from tutorial.employees e ;

