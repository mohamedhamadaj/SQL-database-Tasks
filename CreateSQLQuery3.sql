-- Create Database
CREATE DATABASE CompanyDB;
GO

-- Use the database
USE CompanyDB;
GO

-- Create Schema
CREATE SCHEMA Sales;
GO

-- Create Sequence for employee_id
CREATE SEQUENCE Sales.emp_seq
    START WITH 1
    INCREMENT BY 1;
GO

-- Create employees table
CREATE TABLE Sales.employees (
    employee_id INT PRIMARY KEY DEFAULT NEXT VALUE FOR Sales.emp_seq,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2)
);
GO

-- Alter table to add hire_date
ALTER TABLE Sales.employees
ADD hire_date DATE;
GO