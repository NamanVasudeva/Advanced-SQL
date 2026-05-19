-- Window functions
-- On the fly analytics

-- Creating a table
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  order_total DECIMAL(10, 2) NOT NULL
);

-- Adding data to the table
INSERT INTO orders (customer_id, order_date, order_total)
VALUES
  (1, '2022-01-01', 100.00),
  (1, '2022-02-01', 50.00),
  (1, '2022-03-01', 75.00),
  (2, '2022-01-15', 200.00),
  (2, '2022-02-15', 150.00),
  (3, '2022-01-31', 75.00),
  (3, '2022-02-28', 100.00),
  (3, '2022-03-31', 50.00);

select * from orders;


select order_id, customer_id, order_date, order_total
from orders o;

--Selecting the running total based on order date
select order_id, customer_id, order_date, order_total,
sum (order_total) over (order by order_date) running_sum
from orders o;

--Selecting the running total based on order date and customer id
select order_id, customer_id, order_date, order_total,
sum (order_total) over (order by order_date) running_sum,
sum (order_total) over (partition by customer_id order by order_date) running_per_customer_sum
from orders o
order by customer_id, order_date;


-- Fitering maximum order per customer
with temp as (
select order_id, customer_id, order_date, order_total,
max (order_total) over (partition  by customer_id) max_order_per_cust
from orders o
)
select * from temp where 
order_total =max_order_per_cust;
