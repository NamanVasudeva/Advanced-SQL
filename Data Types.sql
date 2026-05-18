-- Complex data types

-- Enum Data Type
-- Enum is a case sensitive data type

-- Classifying weekdays as enum data type
create type weekday as enum ('Monday', 'Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- Creating a table for weekdays
create table enum_demo (
	id serial primary key,
	day_of_week weekday not null,
	random character varying);

-- Inserting records into created table
insert into enum_demo (day_of_week,random)
values
	('Monday','4'),
	('Tuesday','47'),
	('Wednesday','7'),
	('Saturday','5'),
	('Monday','8');

-- Selecting the table
-- The table values are displayed in the same order as the input is added into the enum data type
-- Additionally, the primary keys are populated automatically
select * from enum_demo
order by day_of_week;


-- Adding a column for wage and another day
alter table enum_demo
add column wage float check (wage>=0), -- Wage cannot be negative
-- Adding a check condition that another day should be in the weekdays
add column another_day varchar check (another_day in 
('Monday', 'Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'));

-- Adding data
insert into enum_demo(day_of_week, wage, another_day)
values 
	('Monday',5,'Monday'),
	('Saturday',5,'Saturday'),
	('Wednesday',5,'Wednesday');
	
-- Final output
select * from enum_demo
order by another_day;



-- Array data Type
-- Used to collapse data by allowing to store multiple values of the same data type in a single column

 
-- Creating a table
create table array_table (
id serial primary key,
myarray integer[]
);

select * from array_table;

-- Inseting array 1
insert into array_table(myarray)
values (array[1,2,3,4]);

select * from array_table;

-- Inserting array 2
insert into array_table(myarray)
values (array[1,4,3,4]);


-- Selecting both arrays
select * from array_table;

-- Selecting a particular array
select * from array_table
where 2 = any (myarray);

-- Inserting more data
insert into array_table (myarray)
values (array[9, 27, 43, 64]);

-- Selecting all arrays
select * from array_table;

-- Selecting the array based on data
select *
from array_table
where array [9,27,43,64]::integer[]=myarray;


-- Unnesting the data
select id, unnest(myarray) as unnested
from array_table;



-- Range data type

-- Creating a table

create table job_board (
	id serial primary key,
	job text,
	salary numeric,
	salary_numrange numrange,
	salary_intrange int4range
	);

-- Inserting data

insert into job_board (job, salary, salary_numrange, salary_intrange)
values
	('Engineer I', 120000, numrange(95000,130000), int4range(95000,130000)),
	('Engineer II', 150000, numrange(135000,170000), int4range(135000,170000)),
	('Engineer III', 210000, numrange(185000,250000), int4range(185000,250000));


-- Seleting the data
select * from job_board;

-- Selecting value where salary_numrange contains 95000
-- FYI numrange are numeric values and can contain decimals
select * from job_board
where salary_numrange @>95000::numeric;



-- Nested Data
-- Used to store amorphous data

-- Creating a table

create table customers (
	id serial primary key,
	name text,
	address jsonb);


-- Inserting data
insert into customers (name,address) values ('John Doe', '{"street":"123 Main St","city":"New York", "State": "NY","ZIP":"10001"}');

-- Selecting multiple columns and renaming the headers
select address ->> 'street' as street, address->>'city' as city, address->>'state' as state, address->>'zip' as zip
from customers 
where name='John Doe';

-- Indexing the data - Best practice on huge data sets to reduce query time
create index idx_customers_address_city on customers ((address->>'city'));


-- Selecting Name
select name
from customers c
where address->>'city'='New York';

-- Updating address and selecting the data
update customers c 
set address=jsonb_set(address, '{city}', '"Los Angeles"')
where name = 'John Doe';
select * from customers;

-- Removing the zip

update customers c 
set address =address-'zip'
where name ='John Doe';

--Selecting the data
select * from customers;