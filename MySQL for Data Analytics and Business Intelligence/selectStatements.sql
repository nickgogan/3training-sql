use employees;
select dept_no from departments;
select * from departments;

select first_name, last_name from employees
where first_name = 'Elvis';

select * from employees
where first_name = 'kellie' and gender = 'f';

-- Retrieve a list with all employees whose first name is either Kellie or Aruna.
select emp_no, first_name, last_name from employees
where first_name = 'Kellie' or first_name = 'Aruna'
group by first_name
order by first_name;

-- Note: AND is applied first and OR is applied second

-- Retrieve a list with all female employees whose first name is either Kellie or Aruna.
select * from employees
where gender = 'f' and (first_name='Kellie' or first_name='aruna');

-- Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.
select first_name, last_name from employees
where first_name in ('Denis','Elvis');
-- Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.
select * from employees
where first_name not in ('John','Mark','Jacob');

-- LIKE(). % means 0+ chars. _ means exactly 1 char.
-- Unlike Sinequa, % can be used for prefixes and suffixes.
-- Working with the “employees” table, use the LIKE operator to select the data about all individuals, whose first name starts with “Mark”; specify that the name can be succeeded by any sequence of characters.
select * from employees where first_name like('Mark%');

-- Retrieve a list with all employees who have been hired in the year 2000.
select first_name, last_name, hire_date from employees
where hire_date like('%2000%'); /* Note: LIKE seems to work regardess of column type. */

-- Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 
select * from employees where emp_no like('1000_');

-- Extract all individuals from the ‘employees’ table whose first name contains “Jack”.
select * from employees where first_name like('%jack%');
-- Once you have done that, extract another list containing the names of employees that do not contain “Jack”.
select * from employees where first_name not like('%jack%');

-- Note: BETWEEN...AND is inclusive ([a,b]) while NOT BETWEEN...AND is exclude ((a,b)).
-- Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.
select * from salaries where salary between '66000' and '70000';
-- Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.
select * from employees where emp_no not between '10004' and '10012';
-- Select the names of all departments with numbers between ‘d003’ and ‘d006’.
select * from departments where dept_no between 'd003' and 'd006';

-- Select the names of all departments whose department number value is not null.
select dept_name from departments where dept_no is not null;

-- Retrieve a list with data about all female employees who were hired in the year 2000 or after.
select * from employees where
gender = 'f' and hire_date >= '2000-01-01';
-- Extract a list with all employees’ salaries higher than $150,000 per annum.
select * from salaries where salary > '150000';

-- Obtain a list with all different “hire dates” from the “employees” table.
select distinct hire_date from employees;
-- Expand this list and click on “Limit to 1000 rows”. This way you will set the limit of output rows displayed back to the default of 1000.
-- In the next lecture, we will show you how to manipulate the limit rows count. 

-- Aggregate functions: Functions applied on a single column across multiple rows of a table that returns a single value.
-- Note: These ignore null values unless otherwise specified.
-- count(), sum(), min(), max(), avg().
-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
select count(emp_no) from salaries where salary >= 100000;
-- How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
select count(*) from dept_manager; select * from dept_manager;

-- Select all data from the “employees” table, ordering it by “hire date” in descending order.
select * from employees order by hire_date desc;

-- Note: DISTINCT and GROUP BY can look similar. However, GROUP BY is used with aggregate functions.
-- Note: GROUP BY is slower than DISTINCT.
-- Note: In the select-statement, always include the field on which you're doing the GROUP BY.
-- Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. Lastly, sort the output by the first column.
select salary, count(emp_no) as 'emps_with_same_salary', emp_no
from salaries where salary > 80000
group by salary
order by salary desc;

-- HAVING refines the output from records that don't meet a certain condition.
-- It's like WHERE-clause, but applied to the GROUPBY-block. It comes after the GROUPBY. 
-- Note: You can use HAVING like WHERE, but it's unusual.
-- Select all employees whose average salary is higher than $120,000 per annum.
select *, avg(salary) as 'average salary'
from salaries
group by emp_no
having avg(salary) > 120000
order by emp_no;
-- IMPORTANT: HAVING and GROUPBY go hand-on-hand.
-- 807 rows returned below vs 101 rows returned above. 
select *, avg(salary) as 'average salary'
from salaries
where salary > 120000
group by emp_no
order by emp_no;
-- When using WHERE instead of HAVING, the output is larger because in the output we include individual contracts higher than $120,000 per year. The output does not contain average salary values.
-- WHERE is applied before re-organizing into groups. 
-- Note: You cannot have an aggregaeted AND a non-aggregated condition in the same HAVING-clause in MySQL.
-- Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
select emp_no, count(from_date) as 'contracts signed'
from dept_emp
where from_date > '2000-01-01'
group by emp_no
having count(from_date) > 1
order by 'contracts signed' asc;

-- IMPORTANT: Be careful with using ORDERBY and LIMIT together - the column used in ORDERBY will affect the results!
-- Select the first 100 rows from the ‘dept_emp’ table. 
select * from dept_emp limit 100;