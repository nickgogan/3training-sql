-- Syntax: DELETE FROM table_Name WHERE condition;

use employees;

commit;

select * from titles order by emp_no desc;
-- Delete employee 499999 from titles table.
delete from titles where emp_no = 499999;
select * from titles where emp_no = 499999;
rollback;
select * from titles where emp_no = 499999;

-- Remove the department number 10 record from the “departments” table.
delete from departments where dept_no = 'd010';
select * from departments order by dept_no desc;

-- DROP vs TRUNCATE vs DELETE
-- DROP: Deletes the table and everything about it (e.g. indexes, constraints, ...)
-- TRUNCATE: Removes all data, but leaves behind other things like indexes and constraints. AUTO_INCREMENT cols will be reset. 
-- DELETE: Removes records row-by-row, as specified by the optional WHERE-clause. Slower than TRUNCATE. AUTO_INCREMENT cols are NOT reset. 
