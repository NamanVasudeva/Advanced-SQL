**Usage of CRUD operations**
Although the create and delete opetations are not used on a daily basis, they form an integral part of SQL.

C- Create
R- Read
U- Update
D- Delete

**Data Manipulation for time**
In workplace setting data is often not stationary, it is being refreshed on a daily basis. This makes it essential for one to understand what is the timezone for the data (to dive deep into the understanding of the data). Once we have the understanding we must have the know how to manipulate the data to gain the desired information and analytics.

**Data Storage**
Storage is finite and storing your data in the correct data type, without duplicates, maintaining the DB performance, having data in the correct format is essential for making use of the data. Learning about four data types

- Enum
- Array
- Range
- Index

**Window Functions**
Performing calculations on a set of table rows related to current selection. 

**SQL Joins**

**Over**- This creates a "window" for calculations. Unlike a regular aggregate that collapses rows, OVER lets you calculate things like running totals or rankings while still seeing every individual row in your result set. It defines how to group and order the data the function sees.<br>
**Cross Join**- This creates a "Cartesian Product" by matching every single row from one table with every single row of another. If you have 3 colors and 3 sizes, a CROSS JOIN gives you all 9 possible combinations. No matching "key" is required.<br>
**Lateral Join**- It allows a subquery to see and use data from the rows in the main table. This is powerful for applying a function or a complex calculation to each row individually.<br>
**Cross Join Lateral**- This is used to expand data. It takes a single row and "explodes" it into multiple rows by applying a lateral subquery to every record in the primary table.<br>
**Coalesce**- It looks at a list of values and returns the very first one that isn't null. It is most commonly used to replace empty or missing data with a default value, like "N/A" or 0.<br>
**Case**- This is the "If-Then" logic of SQL. It checks a series of conditions and returns a value when the first condition is met.<br>
**Concat**- Short for "concatenate," this function glues strings of text together. If you have a column for "First Name" and another for "Last Name," CONCAT merges them into one single "Full Name" string for your report.<br>
**Recursive CTE**- This is a query that calls itself. It is used to handle "parent-child" data, like an office hierarchy or a family tree. It starts with a base row and keeps digging deeper until it reaches the end of the chain.
