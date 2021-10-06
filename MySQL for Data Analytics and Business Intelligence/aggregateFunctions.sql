-- Gather data from multiple rows and returns a single value. Also called summarizing functions. 

use employees;

select * from salaries order by salary desc limit 10;
select count(salary) from salaries;
select count(distinct from_date) as 'dates hires' from salaries;

-- NOTE: COUNT(*) will return a total row count, nulls-included. Specifying a column returns only non-null rows. 

-- How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question.
select count(distinct dept_no) as 'department_count' from dept_emp;

select sum(salary) as 'total salaries' from salaries;
-- What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?
select sum(salary) from salaries where from_date > '1997-01-01';

-- Which is the lowest employee number in the database?
select min(salary) as 'lowest', max(salary) as 'highest' from salaries;

select avg(salary) from salaries;
-- What is the average annual salary paid to employees who started after the 1st of January 1997?
select avg(salary) from salaries where from_date > '1997-01-01';

select round(avg(salary)) from salaries;
select round(avg(salary), 2) from salaries;
-- Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents. 
select round(avg(salary), 2) from salaries;

select dept_no, ifnull(dept_name, 'Not provided') as dept_name from departments_dup;
-- COALESCE is the same as IFNULL, but with N-params instead of 2.
-- Use COALESCE to replace any nulls across the entire row. If there is a non-null value (read from left to right), then the null field will get that non-null value.
-- Select the department number and name from the ‘departments_dup’ table and add a third column where you name the department number (‘dept_no’) as ‘dept_info’. If ‘dept_no’ does not have a value, use ‘dept_name’.
select dept_no, dept_name, coalesce(dept_no, 'dept_info') as 'dept info'
from departments_dup;
-- Modify the code obtained from the previous exercise in the following way. Apply the IFNULL() function to the values from the first and second column, so that ‘N/A’ is displayed whenever a department number has no value, and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.
select ifnull(dept_no, 'N/A'), ifnull(dept_name, 'Department name not provided'), coalesce(dept_no, dept_name) as dept_info
from departments_dup;
