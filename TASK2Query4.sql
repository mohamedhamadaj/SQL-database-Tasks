CREATE DATABASE TASK2
GO
USE TASK2
GO
--  1- Create a table named "Employees" with columns for ID (integer), Name (varchar), and Salary (decimal).
CREATE TABLE employees
(
emp_id INT,
emp_name VARCHAR,
emp_salary decimal
);



--Add a new column named "Department" to the "Employees" table with data type varchar(50).
ALTER TABLE employees
ADD Department VARCHAR(50);



--Remove the "Salary" column from the "Employees" table.
ALTER TABLE employees
DROP COLUMN emp_salary ;



--Rename the "Department" column in the "Employees" table to "DeptName".
EXEC sp_rename 'employees.Department', 'employees.DeptName','column'



--Create a new table called "Projects" with columns for ProjectID (integer) and ProjectName (varchar).
CREATE TABLE Projects
(
proj_id INT,
proj_name VARCHAR
);



--Add a primary key constraint to the "Employees" table for the "ID" column.
ALTER TABLE employees
ALTER COLUMN emp_id INT NOT NULL
ALTER TABLE employees
ADD PRIMARY KEY(emp_id)



--Add a unique constraint to the "Name" column in the "Employees" table.
ALTER TABLE employees
ADD CONSTRAINT uq_employees_name UNIQUE(emp_name)



--Create a table named "Customers" with columns for CustomerID (integer), FirstName (varchar), LastName (varchar), 
--and Email (varchar), and Status (varchar).
CREATE TABLE customers
(
cus_id INT,
cus_fname VARCHAR,
cus_lname VARCHAR,
cus_email VARCHAR,
cus_status VARCHAR
);



--Add a unique constraint to the combination of "FirstName" and "LastName" columns in the "Customers" table.
ALTER TABLE customers
ADD CONSTRAINT uq_cus_name UNIQUE(cus_fname,cus_lname)



--Create a table named "Orders" with columns for OrderID (integer), CustomerID (integer),
--OrderDate (datetime), and TotalAmount (decimal).
CREATE TABLE orders
(
order_id INT,
cus_id INT,
order_date DATETIME,
total_amount DECIMAL
);



--Add a check constraint to the "TotalAmount" column in the "Orders" table to ensure that it is greater than zero.
ALTER TABLE orders
ADD CONSTRAINT check_amount CHECK(total_amount > 0)



--Create a schema named "Sales" and move the "Orders" table into this schema.
go
CREATE SCHEMA sales
go
ALTER SCHEMA sales TRANSFER dbo.orders



--Rename the "Orders" table to "SalesOrders."
EXEC sp_rename 'orders','SalesOrders'