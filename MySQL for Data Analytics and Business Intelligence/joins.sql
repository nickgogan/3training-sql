use emplyees;

-- If you currently have the ‘departments_dup’ table set up, use DROP COLUMN to remove the ‘dept_manager’ column from the ‘departments_dup’ table.
alter table departments_dup
drop column dept_manager;
-- Then, use CHANGE COLUMN to change the ‘dept_no’ and ‘dept_name’ columns to NULL.
alter table departments_dup change column dept_no dept_no char(4) null;
alter table departments_dup change column dept_name dept_name varchar(40) null;
-- Then, insert a record whose department name is “Public Relations”.
insert into departments_dup values ('d011', 'Public Relations');
-- Delete the record(s) related to department number two.
select * from departments_dup order by dept_no desc;
delete from departments_dup where dept_no = 'd002';
-- Insert two new records in the “departments_dup” table. Let their values in the “dept_no” column be “d010” and “d011”.
insert into departments_dup values ('d010', null);
insert into departments_dup values ('d011', null);

-- Better to restart from scratch.
drop table if exists departments_dup;
create table departments_dup
(
	dept_no char(4) null,
    dept_name varchar(40) null
);
insert into departments_dup select * from departments; 
select * from departments_dup order by dept_no desc;
insert into departments_dup (dept_no, dept_name) values ('d011', 'Public Relations');
delete from departments_dup where dept_no = 'd002';
insert into departments_dup (dept_no) values ('d010'), ('d011');
update departments_dup set dept_no = null where dept_no = 'd011';

commit;

-- Create and fill in the ‘dept_manager_dup’ table, using the following code:
DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup 
(
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);
INSERT INTO dept_manager_dup select * from dept_manager;
INSERT INTO dept_manager_dup (emp_no, from_date) VALUES (999904, '2017-01-01'), (999905, '2017-01-01'), (999906, '2017-01-01'), (999907, '2017-01-01');
DELETE FROM dept_manager_dup WHERE dept_no = 'd001';
INSERT INTO departments_dup (dept_name) VALUES ('Public Relations');
DELETE FROM departments_dup WHERE dept_no = 'd002'; 

commit; 

select * from departments_dup;
delete from departments_dup where dept_no is null and dept_name is null;

-- Inner join syntax: select t1.col(s), t2.col(s) from table1 t1 join tabl2 t2 on t1.colName = t2.colName;
select m.dept_no, d.dept_no, d.dept_name
from departments m 
inner join departments_dup d 
on m.dept_no = d.dept_no
order by m.dept_no;

-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
select managers.dept_no, employees.emp_no, employees.first_name, employees.last_name, employees.hire_date
from employees
inner join dept_manager managers on employees.emp_no = managers.emp_no
order by managers.emp_no;

-- Important: It's a good idea to use GROUPBY when doing JOINS in order to eliminate extra rows coming from duplicate data. 
-- Important: The first column being select should always be coming from the table in the FROM-clause. It works otherwise, but the result is not intuitive and very likely not what you want. Same idea for the column in the ORDERBY-clause.

-- Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. See if the output contains a manager with that name. Hint: Create an output containing information corresponding to the following fields: ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.
select e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
from employees e
left join dept_manager d on e.emp_no = d.emp_no
where e.last_name = 'Markovitch'
order by d.dept_no desc, e.emp_no;

-- Note: A RIGHTJOIN's result set is the same as a LEFTJOIN's if the tables are inverted in the query.

-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. Use the old type of join syntax to obtain the result.
select d.emp_no, d.dept_no, e.first_name, e.last_name, e.hire_date
from dept_manager d
join employees e on d.emp_no = e.emp_no
order by d.dept_no;

select @@global.sql_mode;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

-- Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.
select e.emp_no, e.first_name, e.hire_date, t.title
from employees e
join titles t on e.emp_no = t.emp_no
where e.first_name = 'Margareta' and e.last_name = 'Markovitch'
order by e.emp_no;

-- INNER JOIN: Connects only on matching values, no nulls.
-- OUTER JOIN: Connects on all values, focusing on LEFT or RIGHT.
-- CROSS JOIN: Connects on all values. Represents the Cartesian product between two tables.

-- Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
select dmgr.*, d.*
from departments d
cross join dept_manager dmgr
where d.dept_no = 'd009';

-- Return a list with the first 10 employees with all the departments they can be assigned to. Hint: Don’t use LIMIT; use a WHERE clause.
SELECT e.*, d.* FROM employees e 
CROSS JOIN departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;


