-- Date and time related datatypes and calcualtions

select timestamp '2023-04-01T14:30:00';


select date '2023-04-01';
select date '04/01/2023';

select date 'April 1, 2023';

select date '1 April 2023';


select timestamp with time zone '2023-04-01 14:30:00-05';


select current_date;
select current_time;
select current_timestamp;

select date_trunc('month', date '2023-04-15');
select date_trunc('year', date '2023-04-15');
select date_trunc('hour', date '2023-04-15');

select age(timestamp '2023-04-01 14:30:00', timestamp '2022-03-01 12:30:00');
select age(date '2023-04-01', date '2022-03-01');
select age(date '2022-03-01', current_date);


-- Different Date time Types- Date, Time, Timestamp, Interval
select '2023-01-01'::date;
select '15:30:00'::time;
select '2023-01-01'::timestamp;

select '15:30:00'::time - '12:30:00'::time as interval_example,
pg_typeof('15:30:00'::time - '12:30:00'::time);


--Timezones

-- Checking the curent Timezone
select current_setting('timezone');


create table demo (
	tz_demo timestamptz,
	istz_demo timestamp 
	);

insert into	demo (tz_demo, istz_demo)
	values('2023-02-02 15:30:00 -0700',
			'2023-02-02 15:30:00');


select * from demo;


--Convert Timezone

select 
	-- Converts tz_demo to Asia/Kolkata timezone using AT TIME ZONE operator
	tz_demo at time zone 'Asia/Kolkata',
	-- Same conversion using timezone() function syntax -- equivalent to above
	timezone('Asia/Kolkata', tz_demo),
	-- Cast istz_demo to timestamptz, interpret it in Asia/Kolkata timezone,
	-- then convert the result to America/Denver timezone
	timezone('America/denver', istz_demo::timestamptz at time zone 'Asia/Kolkata')
from demo;



-- Different formats for date
select
	'current_date' as date_function,
	current_date::varchar
union all
select
	'current_time' as date_function,
	current_time::varchar
union all
select
	'current_timestamp' as date_function,
	current_timestamp::varchar
union all
select
	'now' as date_function,
	now()::varchar
union all
select
	'now_timezone_convert' as date_function,
	timezone('UTC', now())::timestamp::varchar
union all
select
	'localtime' as date_function,
	localtime::varchar
union all
select
	'localtimestamp',
	localtimestamp::varchar
union all
select
	'timeofday' as date_function,
	TIMEOFDAY()
;