--- Joins

-- Cross Joins

-- Create Table 1
create table class_unnormalized (
	student_id serial,
	advisor varchar,
	room varchar,
	class1 varchar,
	class2 varchar,
	class3 varchar
);

-- Insert Data
insert into class_unnormalized (
	advisor,
	room,
	class1,
	class2,
	class3
)

values
('Jones', 123, 'Biology', 'Chemistry', 'Physics'),
('Smith', 131, 'English', 'Math', 'Library Science');

-- Create Table 2
create table buildings (
	building_id serial,
	building_name varchar
);

-- Insert Data to the second table
insert into buildings (building_name)
values ('Rathskeller'), ('Amundsen'), ('JRC');

-- Viewing the tables
select * from class_unnormalized;
select * from buildings ;


-- Joining the data
-- Cross join will simply create a cartesian product for the data

select student_id, advisor, building_name
from class_unnormalized
cross join buildings b;



-- Lateral Join

-- Create a table

create table users (
  user_id serial primary key,
  username varchar(50) not null,
  email varchar(100) not null
);

-- Inserting dummy data into the table
insert into users (username, email) values
  ('alice', 'alice@example.com'),
  ('bob', 'bob@example.com'),
  ('charlie', 'charlie@example.com');

-- Creating a second table

create table orders (
  order_id serial primary key,
  user_id integer not null references users(user_id),
  order_date date not null,
  total_amount numeric(10,2) not null
);

-- Inserting the data
insert into orders (user_id, order_date, total_amount)
values
  (1, '2022-04-01', 50.00),
  (1, '2022-03-15', 25.00),
  (2, '2022-04-02', 100.00),
  (3, '2022-04-01', 75.00),
  (3, '2022-03-20', 30.00),
  (3, '2022-03-01', 20.00);


select * from orders;
select * from users;



-- Lateral Join

select u.username, o.order_id, o.order_date
from users u
left join lateral (
 select order_id,
order_date
from
orders 
where 
user_id=u.user_id
order by order_date desc
limit 1
) o on true;


-- Left Join using Subquery
select u.username, o.order_id, o.order_date
from users u
left join (
 select order_id,
order_date, user_id, total_amount
from 
(
select 
order_id,
user_id,
order_date,
total_amount,
row_number() over (partition by user_id
order by order_date desc) as row_num 
from orders) o where
o.row_num =1) o
on 
u.user_id=o.user_id;


-- Lateral Join using Window Function
select distinct
u.username,
first_value(o.order_id) over (partition by u.user_id order by o.order_date desc) as order_id,
first_value(o.order_date) over (partition by u.user_id order by o.order_date desc) as order_date
from users u
left join orders o on u.user_id=o.user_id;


-- Cross Join Lareral

select * from class_unnormalized;

-- Normalizing the data

select c.student_id, c.advisor, t.*
from class_unnormalized c
cross join lateral (
values
(c.class1, 'class1'),
(c.class2, 'class2'),
(c.class3, 'class3')
)
as t(subject, class_num)
order by student_id;


-- Coalesce
-- Creating a table
create table employees(
id serial primary key,
name varchar(250),
salary numeric(10,2),
department varchar(250),
bonus numeric)
;

-- Creating sample data
insert into employees (name, salary, department, bonus) values
('John Doe', 50000.00, 'IT',5000),
('Jane Doe', null, 'sales', 5000),
('Bob Smith', 55000.00, null, 5000);

select * from employees;

-- Using coalesce
-- Replaces data with the first non null value
select id, name, coalesce (salary, bonus) as tru_salary,
department
from employees;


-- Case statement
-- Adding more data to employees table

insert into employees (name, salary, department, bonus) values
('Rob Smith', 155000.00, null, 5000);

select * from employees;

-- Case Statement
-- Order of case statement will impact the output 

select name, salary, 
case 
when salary < 60000 then 'entry level'	
when salary < 100000 then 'mid'
when salary < 200000 and bonus > 0 then 'really big baller'
when salary < 200000 then 'big baller'
else 'uncaught exception'
end as salary_classification
from employees;


-- Concat: conbining varchar columns
-- Creating a table

create table employees_2 (
id serial primary key,
f_name varchar(255),
l_name varchar(255),
salary numeric,
department varchar(255),
bonus numeric
);

-- Inserting data

insert into employees_2 (f_name, l_name, salary, department, bonus) values
('John', 'Doe', 50000.00, 'IT',5000),
('Jane', 'Doe', null, 'Sales', 5000),
('Bob', 'Smith', 75000.00, null, 5000),
('Rob', 'Smith', 155000.00, null, 5000);

select * from employees_2;

select f_name, l_name,
concat (f_name, ' ', l_name) as full_name,
concat (f_name, ' ', l_name, ' - ', coalesce(department, 'No Dept')) as full_name_dept
from employees_2;


-- Recursive CTE 

with recursive date_table as (
select
'2023-01-01':: date da_date
union all
select 
da_date +1
from date_table
where
da_date < '2023-02-01':: date
)
select * from date_table;
)


-- Recursive CTE #2

-- Creating a table
create table employees_3 (title varchar,
employee_id integer,
manager_id integer);

-- Adding data
insert into employees_3 (title, employee_id, manager_id)
values ('The Boss', 1, null),
('Vice President Procurement', 10,1),
('Senior Manager Strategic Sourcing', 100,10),
('Vice President Engineering', 20,1),
('Data Science Engineer', 200,20),
('Software Engineer', 201,20),
('QA Engineer', 202,20);


select * from employees_3;


-- Recursive CTE
-- || denotes concatenation


with recursive managers
 as (select '' as hierarchy_lvl, employee_ID, manager_ID, title as employee_title
 from employees_3
 where title= 'The Boss'
 union all
 select hierarchy_lvl || '-',
 e.employee_ID, e.manager_ID, e.title
 from employees_3 e join managers m
 on e.manager_ID=m.employee_ID)
 select * from managers
 ;