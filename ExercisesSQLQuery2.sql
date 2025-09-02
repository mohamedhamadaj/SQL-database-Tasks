USE CompanyDB
GO

--Select all columns from the "employees" table.

SELECT * 
FROM sales.employees;

--Retrieve only the "first_name" and "last_name" columns from the "employees" table.
SELECT first_name,last_name
FROM sales.employees;

--Retrieve "full name" as a one column from "first_name" and "last_name" 
--columns from the "employees" table.
SELECT first_name + ' ' + last_name AS full_name
FROM Sales.employees;

--Show the average salary of all employees. (Use AVG() function)
SELECT AVG(Salary) AS avg_salary
FROM Sales.employees;

--Select employees whose salary is greater than 50000.

SELECT *
FROM Sales.employees
WHERE salary > 5000;

--Retrieve employees hired in the year 2020.
SELECT hire_date
FROM Sales.employees
WHERE YEAR(hire_date)= 2020;

--List employees whose last names start with 'S'.
SELECT *
FROM Sales.employees
WHERE last_name like 's%'

--Display the top 10 highest-paid employees.
SELECT TOP 10 * 
FROM Sales.employees 
ORDER BY salary DESC;

--Find employees with salaries between 40000 and 60000.
SELECT *
FROM Sales.employees
WHERE salary > 40000 AND salary<60000 ;

--Show employees with names containing the substring 'man'.
SELECT * 
FROM Sales.employees 
WHERE first_name LIKE '%man%' OR last_name LIKE '%man%';

--Display employees with a NULL value in the "hire_date" column.
SELECT * 
FROM Sales.employees 
WHERE hire_date IS NULL;

--Select employees with a salary in the set (40000, 45000, 50000).
SELECT *
FROM Sales.employees
WHERE salary IN(40000,45000,50000)

--Retrieve employees hired between '2020-01-01' and '2021-01-01'.
SELECT*
FROM Sales.employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-01-01'

--List employees with salaries in descending order.
SELECT* 
FROM Sales.employees 
ORDER BY salary DESC;

--Show the first 5 employees ordered by "last_name" in ascending order.
SELECT TOP 5 * 
FROM Sales.employees 
ORDER BY last_name DESC;

--Display employees with a salary greater than 55000 and hired in 2020.
SELECT*
FROM Sales.employees
WHERE salary>55000 AND YEAR (hire_date) = 2020;

--Select employees whose first name is 'John' or 'Jane'.
SELECT*
FROM Sales.employees
WHERE first_name IN('Jhon' , 'Jane')

--List employees with a salary ? 55000 and a hire date after '2022-01-01'.
SELECT *
FROM Sales.employees
WHERE salary <= 55000 AND hire_date > '2022-01-01';

--Retrieve employees with a salary greater than the average salary.
SELECT * 
FROM Sales.employees
WHERE salary > (SELECT AVG(salary) FROM Sales.employees);

--Display the 3rd to 7th highest-paid employees. (Use OFFSET and FETCH)
SELECT * 
FROM Sales.employees
ORDER BY salary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

--List employees hired after '2021-01-01' in alphabetical order.
SELECT * 
FROM Sales.employees
WHERE hire_date > '2021-01-01'
ORDER BY first_name ASC;

--Retrieve employees with a salary > 50000 and last name not starting with 'A'.
SELECT * 
FROM Sales.employees
WHERE salary > 50000 AND last_name NOT LIKE 'A%';

--Display employees with a salary that is not NULL.
SELECT * 
FROM Sales.employees 
WHERE salary IS NOT NULL;

--Show employees with names containing 'e' or 'i' and a salary > 45000.
SELECT * 
FROM Sales.employees
WHERE (first_name LIKE '%e%' OR first_name LIKE '%i%' 
    OR last_name LIKE '%e%' OR last_name LIKE '%i%')
AND salary > 45000;

--JOIN-RELATED EXERCISES

-- Create departments table
CREATE TABLE Sales.departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id INT REFERENCES Sales.employees(employee_id)
);
GO

-- Add department_id column to employees
ALTER TABLE Sales.employees
ADD department_id INT;

-- Add FK
ALTER TABLE Sales.employees
ADD CONSTRAINT FK_emp_dept FOREIGN KEY (department_id)
REFERENCES Sales.departments(department_id);
GO

-- Insert some departments
INSERT INTO Sales.departments (department_id, department_name, manager_id)
VALUES
(1, 'HR', 1),
(2, 'IT', 3),
(3, 'Finance', 2);

-- Update employees with departments
UPDATE Sales.employees SET department_id = 1 WHERE employee_id IN (1,2);
UPDATE Sales.employees SET department_id = 2 WHERE employee_id IN (3,4);
UPDATE Sales.employees SET department_id = 3 WHERE employee_id IN (5);

-- 1. Employees with department names
SELECT e.first_name, e.last_name, d.department_name
FROM Sales.employees e
INNER JOIN Sales.departments d ON e.department_id = d.department_id;

-- 2. Employees with no department
SELECT e.*
FROM Sales.employees e
LEFT JOIN Sales.departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- 3. All departments with employee count
SELECT d.department_name, COUNT(e.employee_id) AS emp_count
FROM Sales.departments d
LEFT JOIN Sales.employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 4. Highest-paid employee in each department
SELECT d.department_name, e.first_name, e.last_name, e.salary
FROM Sales.departments d
INNER JOIN Sales.employees e ON d.department_id = e.department_id
WHERE e.salary = (
    SELECT MAX(salary) 
    FROM Sales.employees 
    WHERE department_id = d.department_id
);
