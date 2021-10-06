-- Syntax: insert into table_name (col1, col2,...colN) values (val1,val2,...valN);
-- Note: You only have to designate those columns wherein you wish to insert data.
-- Note: You can technically omit the columns from the syntax. MySQL will assume that you're inserting a complete record, in the order listed in the table.
-- Select ten records from the “titles” table to get a better idea about its content.
select * from employees limit 10;
alter table employees add column title varchar(255);
insert into employees values (999903, '1977-09-14', 'Johnathan', 'Creek', 'M', '1999-01-01', 'Senior Engineer');
select * from employees order by emp_no desc limit 10;
-- Insert information about the individual with employee number 999903 into the “dept_emp” table. He/She is working for department number 5, and has started work on  October 1st, 1997; her/his contract is for an indefinite period of time.
-- Hint: Use the date ‘9999-01-01’ to designate the contract is for an indefinite period.
select * from dept_emp order by emp_no limit 5;
select * from employees where emp_no = '999903';
insert into dept_emp (emp_no, dept_no, from_date, to_date) values (999903, 'd005', '1997-10-01', '9999-01-01');

-- Note: You can use a SELECT-clause within an INSERT-block to select data to copy from a given table to a given table.
-- Create a new department called “Business Analysis”. Register it under number ‘d010’. Hint: To solve this exercise, use the “departments” table.
select * from departments order by dept_no desc;
insert into departments values ('d010', 'Business Analytics');


